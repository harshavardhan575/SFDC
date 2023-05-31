public class DistanceAndTimeMatrixWrapper{
  public String[] destination_addresses;
  public String[] origin_addresses;
  public cls_rows[] rows;
  public String status;  //OK

  public class cls_rows {
    public cls_elements[] elements;
  }
  public class cls_elements {
    public cls_distance distance;
    public cls_duration duration;
    public String status;  //OK
  }
  public class cls_distance {
    public String text;  //82.5 mi
    public Decimal value;  //132839
  }
  public class cls_duration {
    public String text;  //1 day 3 hours
    public Decimal value;  //97396
  }
  public static DistanceAndTimeMatrixWrapper parse(String json){
    return (DistanceAndTimeMatrixWrapper) System.JSON.deserialize(json, DistanceAndTimeMatrixWrapper.class);
  }
    /*
  static testMethod void testParse() {
    String json=    '{'+
    '   "destination_addresses" : [ "Thane, Maharashtra, India" ],'+
    '   "origin_addresses" : [ "Wakad, Pimpri-Chinchwad, Maharashtra, India" ],'+
    '   "rows" : ['+
    '      {'+
    '         "elements" : ['+
    '            {'+
    '               "distance" : {'+
    '                  "text" : "82.5 mi",'+
    '                  "value" : 132839'+
    '               },'+
    '               "duration" : {'+
    '                  "text" : "1 day 3 hours",'+
    '                  "value" : 97396'+
    '               },'+
    '               "status" : "OK"'+
    '            }'+
    '         ]'+
    '      }'+
    '   ],'+
    '   "status" : "OK"'+
    '}';
    DistanceAndTimeMatrixWrapper obj = parse(json);
    System.assert(obj != null);
  }*/
}