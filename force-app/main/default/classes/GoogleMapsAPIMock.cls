@isTest
global class GoogleMapsAPIMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request) {
        //Hardcoded values for responses
        String seachAPI = '{'+
                          '"candidates" : ['+
                                  '{'+
                                     '"formatted_address" : "155 Texas Ave, Lawrence Township, NJ 08648, USA",'+
                                     '"name" : "155 Texas Ave"'+
                                  '}'+
                               '],'+
                               '"status" : "OK"'+
                        	'}';
        String mapsAPI = '{'+
                           '"destination_addresses" : [ "2318 Green Landing Dr, Cary, NC 27519, USA" ],'+
                           '"origin_addresses" : [ "155 N Harbor Dr, Chicago, IL 60601, USA" ],'+
                           '"rows" : ['+
                              '{'+
                                 '"elements" : ['+
                                    '{'+
                                       '"distance" : {'+
                                          '"text" : "797 mi",'+
                                          '"value" : 1283071'+
                                       '},'+
                                       '"duration" : {'+
                                          '"text" : "12 hours 23 mins",'+
                                          '"value" : 44562'+
                                       '},'+
                                       '"duration_in_traffic" : {'+
                                          '"text" : "12 hours 42 mins",'+
                                          '"value" : 45744'+
                                       '},'+
                                       '"status" : "OK"'+
                                    '}'+
                                 ']'+
                              '}'+
                           '],'+
                           '"status" : "OK"'+
                        '}';
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        if (request.getEndpoint().contains('https://maps.googleapis.com/maps/api/place/')) {
            response.setBody(seachAPI);
        }else {
            response.setBody(mapsAPI);
        }        
        response.setStatusCode(200);
        return response; 
    }

}