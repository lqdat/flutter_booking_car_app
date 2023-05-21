

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_application/main.dart';
var token = getToken().then((value) => value);
const URl= "http://enderg14-001-site1.gtempurl.com/";
Map<String,String> headers = {
    'Content-Type':'application/json',
    'authorization':'Bearer ${token}   '
};

Future<String?> getToken() async => 
  await storage.read(key: 'jwt'
  
  );