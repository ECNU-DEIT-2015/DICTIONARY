import 'package:redstone/redstone.dart' as app;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;
import 'package:sqljocky5/sqljocky.dart';
import 'package:sqljocky5/utils.dart';
import 'dart:async';
import 'dart:convert';
String data;

@app.Route("/data/")
helloWorld() {
  return getDataFromDB();
}

@app.Route("/day1/")
helloIelts() {
  return getIeltsFromDB();
}

@app.Route("/data/add", methods: const [app.POST])
addUser(@app.Body(app.TEXT) String userData) {
   data = userData;
  return data;
}

@app.Route("/data/addword", methods: const [app.POST])
addword(@app.Body(app.TEXT) String userData) {
   data = userData;
  return getWordFromDB(data);
}

Future<String> getWordFromDB(String data) async {
  var pool = new ConnectionPool(
      host: 'www.muedu.org',
      port: 3306,
      user: 'deit-2015',
      password: 'deit@2015!',
      db: 'project_2015_1',
      max: 5);
  var results = await pool.query("select words.word, means.means from words,means where word='" + data + "' and words.ID=means.wordID ");
  //todo get data from db.
  String response;
  await results.forEach((row) { 
     response =JSON.encode([" ${row[0]}"," ${row[1]}"]);
  }); 
  return response;
}

Future<String> getDataFromDB() async {
  var pool = new ConnectionPool(
      host: 'www.muedu.org',
      port: 3306,
      user: 'deit-2015',
      password: 'deit@2015!',
      db: 'project_2015_1',
      max: 5);
  var results = await pool.query("select words.word, means.means from words,means where word='" + data + "' and words.ID=means.wordID ");
  String response;
  await results.forEach((row) { 

     response =JSON.encode([" ${row[0]}"," ${row[1]}"]);
    //  response=JSON.encode("\u8d44\u6599\uff0c\u6750\u6599");
  }); 
  return response;
}

Future<String> getIeltsFromDB() async {
  var pool = new ConnectionPool(
      host: 'www.muedu.org',
      port: 3306,
      user: 'deit-2015',
      password: 'deit@2015!',
      db: 'project_2015_1',
      max: 5);
for(int i=1;i<=10;i++)
 {
    String j=i.toString();
    var results = await pool.query("select Ielts.word, Ielts.means from Ielts where id='  "+ j +"  ' ");
     String response;
     await results.forEach((row) { 
     response =JSON.encode([" ${row[0]}"," ${row[1]}"]);
    //  response=JSON.encode("\u8d44\u6599\uff0c\u6750\u6599");
  }); 
  return response;
 }
}

@app.Route("/register/")
register() => "you are now a member";
main() {
  Map corsHeaders1 = {
    "Access-Control-Allow-Methods": "POST",
    "Access-Control-Allow-Origin": "*",
  };
  shelf.Middleware middleware =
      shelf_cors.createCorsHeadersMiddleware(corsHeaders: corsHeaders1);
  app.setupConsoleLog();
  app.addShelfMiddleware(middleware);
  app.start(port: 90);
  print("fefef");
}
