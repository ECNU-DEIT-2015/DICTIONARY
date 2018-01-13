import 'package:redstone/redstone.dart' as app;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_cors/shelf_cors.dart' as shelf_cors;
import 'package:sqljocky5/sqljocky.dart';
import 'package:sqljocky5/utils.dart';
import 'dart:async';
import 'dart:convert';
//import 'dart:html';
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
     response =''' ${row[0]}   ${row[1]}''';
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

    String response;
    var WLIST = new Map();
    
    int i=1;
    //var results = await pool.query("select Ielts.word, Ielts.means from Ielts where id='  "+ j +"  ' ");
    var results = await pool.query("select Ielts.word, Ielts.means from Ielts where id<41");
       
     await results.forEach((row) { 
 
    // response = JSON.encode([response,"${row[0]} , ${row[1]}"]);
    response='''${row[0]} , ${row[1]}''';
    WLIST[i]=response;
    i++;
    
    // response=JSON.encode("\u8d44\u6599\uff0c\u6750\u6599");
    
    
   }); 
    response = JSON.encode([WLIST[1],WLIST[2],WLIST[3],WLIST[4],WLIST[5],WLIST[6],WLIST[7],WLIST[8],WLIST[9],WLIST[10],
                           WLIST[11],WLIST[12],WLIST[13],WLIST[14],WLIST[15],WLIST[16],WLIST[17],WLIST[18],WLIST[19],WLIST[20],
                           WLIST[21],WLIST[22],WLIST[23],WLIST[24],WLIST[25],WLIST[26],WLIST[27],WLIST[28],WLIST[29],WLIST[30],
                           WLIST[31],WLIST[32],WLIST[33],WLIST[34],WLIST[35],WLIST[36],WLIST[37],WLIST[38],WLIST[39],WLIST[40]]);
    print(response); 
    return response;
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