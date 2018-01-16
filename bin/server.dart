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

@app.Route("/sent/")
hellosent() {
  return getsentFromDB();
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
  var results = await pool.query("select pos.name, means.means from words,means,pos where word='" + data + "' and words.ID=means.wordID and means.posID=pos.ID");
  //todo get data from db.
  String response=data;
   var meanLIST = new Map();
  meanLIST[0]=null;
  meanLIST[1]=null;
  meanLIST[2]=null;
  meanLIST[3]=null;
  int i=0;
  await results.forEach((row) { 
     meanLIST[i] =''' ${row[0]}   ${row[1]} ''';
     
     i++;
  }); 
  for(i=0;i<meanLIST.length;i++){
    if(meanLIST[i]!=null)
    {
        response=response+' '+' '+meanLIST[i];        
    }
    if(meanLIST[i]==null)break;
     
  }
 
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
  var results = await pool.query("select  pos.name, means.means from words,means,pos where word='" + data + "' and words.ID=means.wordID and means.posID=pos.ID");
  String response;
  var meanLIST = new Map();
  meanLIST[0]=null;
  meanLIST[1]=null;
  meanLIST[2]=null;
  meanLIST[3]=null;
  int i=0;
  await results.forEach((row) { 

     response =''' ${row[0]}  ${row[1]}''';
     meanLIST[i]=response;
     i++;
    //  response=JSON.encode("\u8d44\u6599\uff0c\u6750\u6599");
  }); 
  response=JSON.encode([meanLIST[0],meanLIST[1],meanLIST[2],meanLIST[3]]);
  return response;
}

Future<String> getsentFromDB() async {
  var pool = new ConnectionPool(
      host: 'www.muedu.org',
      port: 3306,
      user: 'deit-2015',
      password: 'deit@2015!',
      db: 'project_2015_1',
      max: 5);
  var results = await pool.query("select  means.Esent,means.Csent from words,means,pos where word='" + data + "' and words.ID=means.wordID and means.posID=pos.ID");
  String response;
  var meanLIST = new Map();
  meanLIST[0]=null;
  meanLIST[1]=null;
  meanLIST[2]=null;
  meanLIST[3]=null;
  int i=0;
  await results.forEach((row) { 

     response =''' ${row[0]}. --- ${row[1]}''';
     meanLIST[i]=response;
     i++;
    //  response=JSON.encode("\u8d44\u6599\uff0c\u6750\u6599");
  }); 
  response=JSON.encode([meanLIST[0],meanLIST[1],meanLIST[2],meanLIST[3]]);
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
    var results = await pool.query("select Ielts.word, Ielts.means from Ielts where id<121");
       
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
                           WLIST[31],WLIST[32],WLIST[33],WLIST[34],WLIST[35],WLIST[36],WLIST[37],WLIST[38],WLIST[39],WLIST[40],
                           WLIST[41],WLIST[42],WLIST[43],WLIST[44],WLIST[45],WLIST[46],WLIST[47],WLIST[48],WLIST[49],WLIST[50],
                           WLIST[51],WLIST[52],WLIST[53],WLIST[54],WLIST[55],WLIST[56],WLIST[57],WLIST[58],WLIST[59],WLIST[60],
                           WLIST[61],WLIST[62],WLIST[63],WLIST[64],WLIST[65],WLIST[66],WLIST[67],WLIST[68],WLIST[69],WLIST[70],
                           WLIST[71],WLIST[72],WLIST[73],WLIST[74],WLIST[75],WLIST[76],WLIST[77],WLIST[78],WLIST[79],WLIST[80],
                           WLIST[81],WLIST[82],WLIST[83],WLIST[84],WLIST[85],WLIST[86],WLIST[87],WLIST[88],WLIST[89],WLIST[90],
                           WLIST[91],WLIST[92],WLIST[93],WLIST[94],WLIST[95],WLIST[96],WLIST[97],WLIST[98],WLIST[99],WLIST[100],
                           WLIST[101],WLIST[102],WLIST[103],WLIST[104],WLIST[105],WLIST[106],WLIST[107],WLIST[108],WLIST[109],WLIST[110],
                           WLIST[111],WLIST[112],WLIST[113],WLIST[114],WLIST[115],WLIST[116],WLIST[117],WLIST[118],WLIST[119],WLIST[120]]);
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