import 'dart:convert';

import 'package:api_integeration/Models/WorldStateData.dart';
import 'package:api_integeration/uri/world_state_uri.dart';
import 'package:http/http.dart'as http;
class ApiServices{
   Future<WorldStateData> worldStateFutureData()async{
     final response=await http.get(Uri.parse(WorldStateUri.worldStateApi));
   if(response.statusCode==200 || response.statusCode==201){
     var data=jsonDecode(response.body.toString());
     print("the data in this is $data");
   return WorldStateData.fromJson(data);
   }
   else{
     throw Exception("Error while getting the data and the status code is ${response.statusCode}");
   }
   }
   Future<List<dynamic>> countryDetail()async{
     final response=await http.get(Uri.parse(WorldStateUri.countryList));
     var data;
     if(response.statusCode==200){
        data=jsonDecode(response.body.toString());
       return data;
     }
     else{
       throw Exception("Error while getting the data and the status code is ${response.statusCode}");
     }
   }
}