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
UListElement DoList;
ButtonElement deleteAll;
ButtonElement addnewword;
UListElement firstlist;
UListElement secondlist;
UListElement thirdlist;
UListElement fourthlist;
ButtonElement firstpage_button;
ButtonElement firstbutton;
ButtonElement secondbutton;
ButtonElement thirdbutton;
ButtonElement fourthbutton;


var meanList;
var searchedword;
var firstpage=document.getElementById("firstpage");
var firstbutton1=document.getElementById("test");
var f2=document.getElementById("test2");
String responseText;
var newword=new Map();
int countNewWord=0;
String b;

//ButtonElement a,b;
//var firstpage=document.getElementById("firstpage");
var cet4page=document.getElementById("wordspage");
  

main() async {
  

  querySelector('#search_word').onClick.listen(makePostRequest);
  querySelector('#search_word').onClick.listen(makeRequest);
  meanList = querySelector('#meanList');
  searchedword = querySelector('#searchedword');
  firstlist = querySelector('#firstlist');
  secondlist = querySelector('#secondlist');
  thirdlist = querySelector('#thirdlist');
  fourthlist = querySelector('#fourthlist');
  toDoList = querySelector('#sample_list_id');  
 toDoList.onChange.listen(addToDoItem);
 // toDoList.onClick.listen(removeItem);
 addnewword= querySelector('#add-newword'); 
 addnewword.onClick.listen(addToDoItem);
 deleteAll= querySelector('#delete-all'); 
 deleteAll.onClick.listen(deleteAllElements);
 firstpage_button=querySelector('#Index');
 firstpage_button.onClick.listen(CHANGE);
 querySelector('#Index').onClick.listen(CHANGE);
 firstbutton = querySelector('#firstbutton');
 firstbutton.onClick.listen(firstclickedbutton);
 secondbutton = querySelector('#secondbutton');
 secondbutton.onClick.listen(secondclickedbutton);
 thirdbutton = querySelector('#thirdbutton');
 thirdbutton.onClick.listen(thirdclickedbutton);
 fourthbutton = querySelector('#fourthbutton');
fourthbutton.onClick.listen(fourthclickedbutton);

  var path = 'http://localhost:90/day1/';
   listString(await HttpRequest.getString(path));
  
}



void CHANGE(Event e){
 firstpage.style.display='none';
}

void addToDoItem(Event e){ 
  int i;
  var nextToDo = new LIElement();
  if(countNewWord==0)
  {
  newword[countNewWord++]=responseText;
  nextToDo.text=  responseText;
  toDoList.children.add(nextToDo); 
    }
  else 
  {
    for( i=0;i<countNewWord;i++)
    {
      if(newword[i]==responseText){
      querySelector('#attention').text="您已添加该词";
      break;
      }
    }
    if (i==countNewWord)
    {
       newword[countNewWord++]=responseText;      
       nextToDo.text=  responseText;
       toDoList.children.add(nextToDo);        
    }
  }
  nextToDo.onClick.listen((e)=>nextToDo.remove());
  nextToDo.onClick.listen((e)=>b=nextToDo.text);
  nextToDo.onClick.listen(deletedata);
 
}

void deletedata(Event e)
{
  for(int i=0;i<countNewWord;i++)
  {
    if(b==newword[i])
    {
      for(int j=i;j<countNewWord;j++)newword[j]=newword[j+1];
      break;
    }
  }
}

void deleteAllElements(Event e) {
  toDoList.children.clear();
}

void firstclickedbutton(Event e) {
  firstbutton1.style.display='none';
  f2.style.display='block';
}

void secondclickedbutton(Event e) {
  firstbutton1.style.display='none';
  
}

void thirdclickedbutton(Event e) {
  toDoList.children.clear();
}

void fourthclickedbutton(Event e) {
  toDoList.children.clear();
}

void handleError(Object error) {
  meanList.children.add(new LIElement()..text = 'Request failed.');
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
  meanList.children.clear();
  searchedword.children.clear();
  searchedword.children.add(new LIElement()..text = portmanteaux[0]);
  for (int i = 1; i < portmanteaux.length; i++) {
    meanList.children.add(new LIElement()..text = portmanteaux[i]);
  }
}

void listString(String jsonString) {
   List<String> portmanteaux = JSON.decode(jsonString ) as List<String>;
     for (int i = 0; i < 10; i++) {
    firstlist.children.add(new LIElement()..text = portmanteaux[i]);
  }
       for (int i = 10; i < 20; i++) {
   secondlist.children.add(new LIElement()..text = portmanteaux[i]);
  }
    for (int i = 20; i < 30; i++) {
    thirdlist.children.add(new LIElement()..text = portmanteaux[i]);
  }
    for (int i = 30; i < portmanteaux.length; i++) {
    fourthlist.children.add(new LIElement()..text = portmanteaux[i]);
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
     responseText = resp.responseText;
  });
}

