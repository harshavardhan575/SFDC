/*
 Author : Achyutha Harsha Choudavaram
 Created : 05/30/2023
 Description : Test class to cover APIs with mock call out
*/
@isTest
public class GoogleMapsAPITest {
    @TestSetup static void setupCS() {
        MapsAPIKey__c APIKey = new MapsAPIKey__c();
        APIKey.Name = 'API_KEY';
		APIKey.Key__c = 'bdeceswdegvvnj';
        insert APIKey;
	}
    
    @isTest
    static void testSearchAPI(){
        String seachAPI = '{"candidates":[{"formatted_address":"1201 Beaver Creek Commons Dr, Apex, NC 27502, USA","name":"1201 Beaver Creek Commons Dr"}],"status":"OK"}';
        String searchString = '1201 Beaver Creek Commons Dr';
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GoogleSearchAPIResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock); 
        Test.startTest();
        String result = GoogleMapsAPI.searchPlace(searchString);
		String vhash = GoogleMapsAPI.vHash;        
        System.assertEquals(seachAPI, result);
        System.assertEquals('QWNoeXV0aGEgSGFyc2hhIENob3VkYXZhcmFt', vhash);
        Test.stopTest();
    }
    
    @isTest
    static void testDistanceAPI(){
        //String distanceAPIResponse = '{"destination_addresses":["3151 Apex Peakway, Apex, NC 27502, USA"],"origin_addresses":["1201 Beaver Creek Commons Dr, Apex, NC 27502, USA"],"rows":[{"elements":[{"distance":{"text":"3.4 mi","value":5419},"duration":{"text":"10 mins","value":615},"duration_in_traffic":{"text":"12 mins","value":748},"status":"OK"}]}],"status":"OK"}';
    	String sourceAddress = '1201 Beaver Creek Commons Dr, Apex, NC 27502, USA';
        String destinationAddress = '3151 Apex Peakway, Apex, NC 27502, USA';
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GoogleDistanceAPIResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        GoogleMapsAPI.MatrixWrapper GMAPI = new GoogleMapsAPI.MatrixWrapper();        
        Test.startTest();
        GMAPI = GoogleMapsAPI.getDistanceAndTimeMatrix(sourceAddress, destinationAddress);
        System.assertEquals('3.4 mi',GMAPI.distance);
        System.assertEquals('10 mins',GMAPI.duration);        
        Test.stopTest();
    
    }
    
    
}