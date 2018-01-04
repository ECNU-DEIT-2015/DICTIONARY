// Copyright (c) 2012, the Dart project authors.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:http/browser_client.dart';
InputElement toDoInput;
UListElement toDoList;
ButtonElement deleteAll;
ButtonElement addnewword;
UListElement wordlist1;
UListElement l1;
ButtonElement A;

var wordList;
var firstpage=document.getElementById("firstpage");


main() async {
  

  querySelector('#search_word').onClick.listen(makePostRequest);
  querySelector('#search_word').onClick.listen(makeRequest);
  wordList = querySelector('#wordList');
  wordlist1 = querySelector('#lista');
  toDoList = querySelector('#sample_list_id');  
 toDoList.onChange.listen(addToDoItem);
 addnewword= querySelector('#add-newword'); 
 addnewword.onClick.listen(addToDoItem);
 deleteAll= querySelector('#delete-all'); 
 deleteAll.onClick.listen(deleteAllElements);
 A=querySelector('#Index');
 A.onClick.listen(CHANGE);
 querySelector('#Index').onClick.listen(CHANGE);


  var path = 'http://localhost:90/day1/';

    processListString(await HttpRequest.getString(path));
  
}


void CHANGE(Event e){
 l1=querySelector('#a');
 l1.text='qqq';
 
  firstpage.style.display='none';

}
void addToDoItem(Event e){
 var nextToDo = new LIElement();
nextToDo.text= querySelector('#response').text;
toDoList.children.add(nextToDo); 
}
void deleteAllElements(Event e) {
  toDoList.children.clear();
}


void handleError(Object error) {
  wordList.children.add(new LIElement()..text = 'Request failed.');
}

Future makeRequest(Event e) async {
  var path = 'http://localhost:90/data/';
  try {
    processString(await HttpRequest.getString(path));
  } catch (e) {
    print('Couldn\'t open $path');
    handleError(e);
  }
}

void processString(String jsonString) {
  List<String> portmanteaux = JSON.decode(jsonString ) as List<String>;
  //List<String> a=JSON.getData()
  for (int i = 0; i < portmanteaux.length; i++) {
    wordList.children.add(new LIElement()..text = portmanteaux[i]);
  }
}

void processListString(String jsonString) {
   List<String> portmanteaux = JSON.decode(jsonString ) as List<String>;
 // var word = new LIElement();
    //  word.text=portmanteaux;
   // wordlist1.children.add(word);
    wordlist1.children.add(new LIElement()..text = portmanteaux.toString());
  
}


Future makePostRequest(Event e) async {
  
  toDoInput=querySelector('#search');
  String element=toDoInput.value;
  var url = 'http://localhost:90/data/addword';
  HttpRequest
      .request(url, method: 'POST', sendData:element )
      .then((HttpRequest resp) {
    // Do something with the response.
    querySelector('#response').text = resp.responseText;
  });
}

