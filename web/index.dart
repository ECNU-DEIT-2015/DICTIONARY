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

main() async {
  

  querySelector('#search_word').onClick.listen(makePostRequest);

  wordList = querySelector('#wordList');
  toDoList = querySelector('#sample_list_id');  
 toDoList.onChange.listen(addToDoItem);
 addnewword= querySelector('#add-newword'); 
 addnewword.onClick.listen(addToDoItem);
 deleteAll= querySelector('#delete-all'); 
 deleteAll.onClick.listen(deleteAllElements);
}

void addToDoItem(Event e){
 var nextToDo = new LIElement();
nextToDo.text= querySelector('#response').text;
toDoList.children.add(nextToDo); 
}
void deleteAllElements(Event e) {
  toDoList.children.clear();
}
var wordList;

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

Future makeSearchRequest(Event e) async {
  var path = 'http://localhost:90/data/';
  try {
    processSearchString(await HttpRequest.getString(path));
  } catch (e) {
    print('Couldn\'t open $path');
    handleError(e);
  }
}

void processSearchString(String jsonString) {
  List<String> portmanteaux = JSON.decode(jsonString ) as List<String>;
  //List<String> a=JSON.getData()
  for (int i = 0; i < portmanteaux.length; i++) {
    wordList.children.add(new LIElement()..text = portmanteaux[i]);
  }
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
     try {
    processSearchString(await HttpRequest.getString(url));
  } catch (e) {
    print('Couldn\'t open $url');
    handleError(e);
  }
}
