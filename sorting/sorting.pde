import java.util.*;
public enum mode {QUICK, MERGE, SELECTION, INSERTION};

String in = "1,2,3,4,5";
boolean deleting = false;
ArrayList<Integer> list = new ArrayList();
int roof = 900;
int maxInList = 5;
mode m;

void setup(){
  size(1500, 1000, FX2D);
  fill(255);
  
  list.add(5);
  list.add(3);
  list.add(2);
  list.add(1);
  list.add(4);
  
  m = mode.SELECTION;
}



void draw(){
  background(0);
  rect(0, 10, 800, 40);
  
  //stop deleting if the length of the string is <= 0
  if(in.length()>0){
    in = deleting?in.substring(0, in.length()-1):in;
  }
  push();
  fill(255, 0, 255);
  text(in, 0, 10, 800, 45); 
  pop();
  
  push();
  translate(0, height);
  float rectWidth = width/list.size();
  float xoff = 0;
  
  for(int x: list){
    float rectHeight = map(x, 0, maxInList, 0, roof);
    rect(xoff, -rectHeight , rectWidth, rectHeight);
    fill(255, 0, 255);
    textSize(rectWidth/5);
    text(x, (rectWidth/2) + xoff , -rectHeight/2);
    fill(255);
    xoff+=rectWidth;
  }
  
  
  pop();
}

void sort(){
  switch(m){
    case INSERTION:
      for(int i = 0; i < list.size(); i++){
        int elm = list.get(i);
        int index = i-1;
        while(index >= 0 && elm < list.get(index)){
          list.set(index+1, list.get(index));
          list.set(index, elm);
          index--;
        }
      }
      break;
    case SELECTION:
      for(int i = 0; i < list.size(); i++){
        int min_index = i;
        for(int j = i; j < list.size(); j++){
          if(list.get(min_index) > list.get(j)){
            min_index = j;
          }
        }
        int min = list.get(min_index);
        list.set(min_index, list.get(i));
        list.set(i, min);
      }
      
      break;
    case QUICK:
    
      
      break;
    case MERGE:
    
    
      break;
  }
}


void parse(String numbers){
  String[] elms = numbers.split(",");
  for(String s: elms){
    if(!s.equals("")){
      int newElm = Integer.parseInt(s);
      if(maxInList < newElm){
        maxInList = newElm;
      }
      list.add(newElm);
    }
  }
}


void keyPressed(){
  if((keyCode >= '0' && keyCode <= '9') || keyCode == ','){
    in += (char)keyCode;
  }
  
  if(key == 's' || key == 'S'){
    sort();
    println(m + " sorting");
  }
  
  //delete on backspace
  if(keyCode == 8){
    deleting = true;
  }
  
  if(keyCode == '\n'){
    parse(in);
    in = "";
  }
}

void keyReleased(){  
  if(keyCode == 8){
    deleting = false;
  }
}
