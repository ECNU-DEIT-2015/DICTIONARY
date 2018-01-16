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
var mean_div=document.getElementById("mean_div");
var searchedword_div=document.getElementById("searchedword_div");
var add_div=document.getElementById("add_div");
var newwordpage=document.getElementById("newwordpage");
String responseText;
var newword=new Map();
int countNewWord=0;
String b;
String element;

var firstday=document.getElementById("1day");
var secondday=document.getElementById("2day");
var thirdday=document.getElementById("3day");
var firstlist_label1=document.getElementById("firstlist_label1");
var firstlist_button1=document.getElementById("firstlist_button1");
var secondlist_label1=document.getElementById("secondlist_label1");
var secondlist_button1=document.getElementById("secondlist_button1");
var thirdlist_label1=document.getElementById("thirdlist_label1");
var thirdlist_button1=document.getElementById("thirdlist_button1");
var fourthlist_label1=document.getElementById("fourthlist_label1");
var fourthlist_button1=document.getElementById("fourthlist_button1");//第一天
var firstlist_label2=document.getElementById("firstlist_label2");
var firstlist_button2=document.getElementById("firstlist_button2");
var secondlist_label2=document.getElementById("secondlist_label2");
var secondlist_button2=document.getElementById("secondlist_button2");
var thirdlist_label2=document.getElementById("thirdlist_label2");
var thirdlist_button2=document.getElementById("thirdlist_button2");
var fourthlist_label2=document.getElementById("fourthlist_label2");
var fourthlist_button2=document.getElementById("fourthlist_button2");//第二天
var firstlist_label3=document.getElementById("firstlist_label3");
var firstlist_button3=document.getElementById("firstlist_button3");
var secondlist_label3=document.getElementById("secondlist_label3");
var secondlist_button3=document.getElementById("secondlist_button3");
var thirdlist_label3=document.getElementById("thirdlist_label3");
var thirdlist_button3=document.getElementById("thirdlist_button3");
var fourthlist_label3=document.getElementById("fourthlist_label3");
var fourthlist_button3=document.getElementById("fourthlist_button3");//第三天
var day1red=document.getElementById("day1red");
var day1white=document.getElementById("day1white");
var day2red=document.getElementById("day2red");
var day2white=document.getElementById("day2white");
var day3red=document.getElementById("day3red");
var day3white=document.getElementById("day3white");




main() async {
  

  querySelector('#search_word').onClick.listen(makePostRequest);
  querySelector('#search_word').onClick.listen(makeRequest);
  querySelector('#search_word').onClick.listen(makesentRequest);
  querySelector('#search_word1').onClick.listen(makePostRequest1);
  querySelector('#search1').onChange.listen((e)=>mean_div.style.display='none');
  querySelector('#search').onChange.listen((e)=>mean_div.style.display='none');
  querySelector('#search_word1').onClick.listen(makeRequest);
  querySelector('#search_word1').onClick.listen(makesentRequest);
  querySelector('#add-newword').onClick.listen(addToDoItem); 
  querySelector('#delete-all').onClick.listen(deleteAllElements);
  querySelector('#Index').onClick.listen(firstpageduang);
  querySelector('#Ielts').onClick.listen(ieltspageduang);
  querySelector('#NewWord').onClick.listen(newwordpageduang);
  querySelector('#search_word').onClick.listen(searchedwordpageduang);
  querySelector('#search_word1').onClick.listen(searchedwordpageduang);
  

  querySelector('#day1red-button').onClick.listen(day1click);
  querySelector('#day1white-button').onClick.listen(day1click);
  querySelector('#day2red-button').onClick.listen(day2click);
  querySelector('#day2white-button').onClick.listen(day2click);
  querySelector('#day3red-button').onClick.listen(day3click);
  querySelector('#day3white-button').onClick.listen(day3click);//三天转换
  querySelector('#firstbutton1').onClick.listen(firstclickedbutton1);
  querySelector('#secondbutton1').onClick.listen(secondclickedbutton1);
  querySelector('#thirdbutton1').onClick.listen(thirdclickedbutton1);
  querySelector('#fourthbutton1').onClick.listen(fourthclickedbutton1);//第一天完成情况
  querySelector('#firstbutton2').onClick.listen(firstclickedbutton2);
  querySelector('#secondbutton2').onClick.listen(secondclickedbutton2);
  querySelector('#thirdbutton2').onClick.listen(thirdclickedbutton2);
  querySelector('#fourthbutton2').onClick.listen(fourthclickedbutton2);//第二天完成情况
  querySelector('#firstbutton3').onClick.listen(firstclickedbutton3);
  querySelector('#secondbutton3').onClick.listen(secondclickedbutton3);
  querySelector('#thirdbutton3').onClick.listen(thirdclickedbutton3);
  querySelector('#fourthbutton3').onClick.listen(fourthclickedbutton3);//第三天完成情况


  var path = 'http://localhost:90/day1/';
   listString(await HttpRequest.getString(path));


    firstpage.style.display='block';

  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}

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
   add_div.style.display='block';
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
      add_div.style.display='block'; 
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
 add_div.style.display='none';
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

Future makesentRequest(Event e) async {
  var path = 'http://localhost:90/sent/';
  try {
    sentString(await HttpRequest.getString(path));
  } catch (e) {
    print('Couldn\'t open $path');
    handleError(e);
  }
mean_div.style.display='block';
}

void sentString(String jsonString) {
  List<String> portmanteaux = JSON.decode(jsonString ) as List<String>;
  //List<String> a=JSON.getData()
  querySelector('#searchedsent').children.clear();
  querySelector('#searchedsent').children.add(new LIElement()..text = "例句：");
  querySelector('#sentList').children.clear();
  for (int i = 0; i < portmanteaux.length; i++) {
    querySelector('#sentList').children.add(new LIElement()..text = portmanteaux[i]);
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
    for (int i = 30; i < 40; i++) {
     querySelector('#fourthlist').children.add(new LIElement()..text = portmanteaux[i]);
  }
       for (int i = 40; i <50; i++) {
    querySelector('#firstlist2').children.add(new LIElement()..text = portmanteaux[i]);
  }
       for (int i = 50; i < 60; i++) {
   querySelector('#secondlist2').children.add(new LIElement()..text = portmanteaux[i]);
  }
    for (int i = 60; i < 70; i++) {
    querySelector('#thirdlist2').children.add(new LIElement()..text = portmanteaux[i]);
  }
    for (int i = 70; i < 80; i++) {
     querySelector('#fourthlist2').children.add(new LIElement()..text = portmanteaux[i]);
  }
         for (int i = 80; i <90; i++) {
    querySelector('#firstlist3').children.add(new LIElement()..text = portmanteaux[i]);
  }
       for (int i = 90; i < 100; i++) {
   querySelector('#secondlist3').children.add(new LIElement()..text = portmanteaux[i]);
  }
    for (int i = 100; i < 110; i++) {
    querySelector('#thirdlist3').children.add(new LIElement()..text = portmanteaux[i]);
  }
    for (int i = 110; i < portmanteaux.length; i++) {
     querySelector('#fourthlist3').children.add(new LIElement()..text = portmanteaux[i]);
  }
  
}

void day1click(Event e){
 firstday.style.display='block';
 secondday.style.display='none';
 thirdday.style.display='none'; 
}
void day2click(Event e){
 firstday.style.display='none';
 secondday.style.display='block';
 thirdday.style.display='none'; 
}
void day3click(Event e){
 firstday.style.display='none';
 secondday.style.display='none';
 thirdday.style.display='block'; 
}

void firstclickedbutton1(Event e) {
  firstlist_button1.style.display='none';
  firstlist_label1.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void secondclickedbutton1(Event e) {
  secondlist_button1.style.display='none';
  secondlist_label1.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void thirdclickedbutton1(Event e) {
  thirdlist_button1.style.display='none';
  thirdlist_label1.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void fourthclickedbutton1(Event e) {
  fourthlist_button1.style.display='none';
  fourthlist_label1.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}//第一天


void firstclickedbutton2(Event e) {
  firstlist_button2.style.display='none';
  firstlist_label2.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void secondclickedbutton2(Event e) {
  secondlist_button2.style.display='none';
  secondlist_label2.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void thirdclickedbutton2(Event e) {
  thirdlist_button2.style.display='none';
  thirdlist_label2.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void fourthclickedbutton2(Event e) {
  fourthlist_button2.style.display='none';
  fourthlist_label2.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}//第二天


void firstclickedbutton3(Event e) {
  firstlist_button3.style.display='none';
  firstlist_label3.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void secondclickedbutton3(Event e) {
  secondlist_button3.style.display='none';
  secondlist_label3.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void thirdclickedbutton3(Event e) {
  thirdlist_button3.style.display='none';
  thirdlist_label3.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}
void fourthclickedbutton3(Event e) {
  fourthlist_button3.style.display='none';
  fourthlist_label3.style.display='block';
  if(firstlist_label1.style.display=='block'&&secondlist_label1.style.display=='block'&&thirdlist_label1.style.display=='block'&&fourthlist_label1.style.display=='block')
  {day1red.style.display='none';day1white.style.display='block';}
  if(firstlist_label2.style.display=='block'&&secondlist_label2.style.display=='block'&&thirdlist_label2.style.display=='block'&&fourthlist_label2.style.display=='block')
  {day2red.style.display='none';day2white.style.display='block';}
  if(firstlist_label3.style.display=='block'&&secondlist_label3.style.display=='block'&&thirdlist_label3.style.display=='block'&&fourthlist_label3.style.display=='block')
  {day3red.style.display='none';day3white.style.display='block';}
}//第三天