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


var firstpage=document.getElementById("firstpage");
//var cet4page=document.getElementById("cet4wordspage");
//var cet6page=document.getElementById("cet6page");
var ieltspage=document.getElementById("wordspage");
var firstlist_button=document.getElementById("firstlist_button");
var firstlist_label=document.getElementById("firstlist_label");
var mean_div=document.getElementById("mean_div");
var searchedword_div=document.getElementById("searchedword_div");
var newwordpage=document.getElementById("newwordpage");
String responseText;
var newword=new Map();
int countNewWord=0;
String b;
String element;


  

main() async {
  

  querySelector('#search_word').onClick.listen(makePostRequest);
  querySelector('#search_word').onClick.listen(makeRequest);
  querySelector('#search_word1').onClick.listen(makePostRequest1);
  querySelector('#search1').onChange.listen((e)=>mean_div.style.display='none');
  querySelector('#search').onChange.listen((e)=>mean_div.style.display='none');
  querySelector('#search_word1').onClick.listen(makeRequest);
  querySelector('#add-newword').onClick.listen(addToDoItem); 
  querySelector('#delete-all').onClick.listen(deleteAllElements);
  querySelector('#Index').onClick.listen(firstpageduang);
  querySelector('#Ielts').onClick.listen(ieltspageduang);
  querySelector('#Cet4').onClick.listen(cet6pageduang);
  querySelector('#Cet6').onClick.listen(cet4pageduang);
  querySelector('#NewWord').onClick.listen(newwordpageduang);
  querySelector('#search_word').onClick.listen(searchedwordpageduang);
  querySelector('#search_word1').onClick.listen(searchedwordpageduang);
  querySelector('#firstbutton').onClick.listen(firstclickedbutton);
  querySelector('#secondbutton').onClick.listen(secondclickedbutton);
  querySelector('#thirdbutton').onClick.listen(thirdclickedbutton);
  querySelector('#fourthbutton').onClick.listen(fourthclickedbutton);


  var path = 'http://localhost:90/day1/';
   listString(await HttpRequest.getString(path));


    firstpage.style.display='block';
  
}



void firstpageduang(Event e){
 ieltspage.style.display='none';
 firstpage.style.display='block';
 //cet6page.style.display='none';
 //cet4page.style.display='none';
 newwordpage.style.display='none';
 searchedword_div.style.display='none';
 mean_div.style.display='none';
}

void ieltspageduang(Event e){
 firstpage.style.display='none';
 ieltspage.style.display='block';
 //cet6page.style.display='none';
//cet4page.style.display='none';
newwordpage.style.display='none';
mean_div.style.display='none';
searchedword_div.style.display='block';
}

void cet6pageduang(Event e){
 ieltspage.style.display='none';
 firstpage.style.display='none';
 //cet4page.style.display='none';
 newwordpage.style.display='none';
 mean_div.style.display='none';
 searchedword_div.style.display='block';
}

void cet4pageduang(Event e){
 ieltspage.style.display='none';
// cet6page.style.display='none';
 firstpage.style.display='none';
 newwordpage.style.display='none';
 mean_div.style.display='none';
 searchedword_div.style.display='block';
}

void newwordpageduang(Event e){
 ieltspage.style.display='none';
// cet6page.style.display='none';
 firstpage.style.display='none';
 newwordpage.style.display='block';
 mean_div.style.display='none';
 searchedword_div.style.display='block';

}

void searchedwordpageduang(Event e){
 ieltspage.style.display='none';
// cet6page.style.display='none';
 firstpage.style.display='none';
 newwordpage.style.display='none';
mean_div.style.display='block';
searchedword_div.style.display='block';
 
}

void addToDoItem(Event e){ 
  int i;
  var nextToDo = new LIElement();
  if(countNewWord==0)
  {
  newword[countNewWord++]=responseText;
  nextToDo.text=  responseText;
  querySelector('#sample_list_id').children.add(nextToDo); 
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
       querySelector('#sample_list_id').children.add(nextToDo);        
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
  querySelector('#sample_list_id').children.clear();
}

void firstclickedbutton(Event e) {
  firstlist_button.style.display='none';
  firstlist_label.style.display='block';
}

void secondclickedbutton(Event e) {
  firstlist_button.style.display='none';
  
}

void thirdclickedbutton(Event e) {
  toDoList.children.clear();
}

void fourthclickedbutton(Event e) {
  toDoList.children.clear();
}

void handleError(Object error) {
  querySelector('#meanList').children.add(new LIElement()..text = 'Request failed.');
}

Future makeRequest(Event e) async {
  var path = 'http://localhost:90/data/';
  try {
    processString(await HttpRequest.getString(path));
  } catch (e) {
    print('Couldn\'t open $path');
    handleError(e);
  }
mean_div.style.display='block';
}

void processString(String jsonString) {
  List<String> portmanteaux = JSON.decode(jsonString ) as List<String>;
  //List<String> a=JSON.getData()
  querySelector('#meanList').children.clear();
  querySelector('#searchedword').children.clear();
  querySelector('#searchedword').children.add(new LIElement()..text = element);
  for (int i = 0; i < portmanteaux.length; i++) {
    querySelector('#meanList').children.add(new LIElement()..text = portmanteaux[i]);
  }
}

void listString(String jsonString) {
   List<String> portmanteaux = JSON.decode(jsonString ) as List<String>;
     for (int i = 0; i < 10; i++) {
    querySelector('#firstlist').children.add(new LIElement()..text = portmanteaux[i]);
  }
       for (int i = 10; i < 20; i++) {
   querySelector('#secondlist').children.add(new LIElement()..text = portmanteaux[i]);
  }
    for (int i = 20; i < 30; i++) {
    querySelector('#thirdlist').children.add(new LIElement()..text = portmanteaux[i]);
  }
    for (int i = 30; i < portmanteaux.length; i++) {
     querySelector('#fourthlist').children.add(new LIElement()..text = portmanteaux[i]);
  }
  
}


Future makePostRequest(Event e) async {
  
  toDoInput=querySelector('#search');
  element=toDoInput.value;
  var url = 'http://localhost:90/data/addword';
  HttpRequest
      .request(url, method: 'POST', sendData:element )
      .then((HttpRequest resp) {
    // Do something with the response.
     responseText = resp.responseText;
  });
}

Future makePostRequest1(Event e) async {
  
  toDoInput=querySelector('#search1');
  element=toDoInput.value;
  var url = 'http://localhost:90/data/addword';
  HttpRequest
      .request(url, method: 'POST', sendData:element )
      .then((HttpRequest resp) {
    // Do something with the response.
     responseText = resp.responseText;
  });
}
