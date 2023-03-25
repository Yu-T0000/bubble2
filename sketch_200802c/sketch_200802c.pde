/*
ゆらゆら揺れる泡が画面下から上へ動いていく
カーソルのy座標に合わせて泡の色が変化
クリックしている間、カーソル付近の泡が効果音とともに消える
Aキーを押すと泡が昇るスピードが上がる
BGM:魔王魂(https://maoudamashii.jokersounds.com)より「海辺の音」
背景、効果音は自作
*/


import ddf.minim.*;

Minim minim;
AudioSample A;
AudioPlayer bgm;

int box = 350;
boolean flg;
float [] x = new float[box];
float [] y = new float[box];
float [] s = new float[box];
float [] c = new float[box];
float [] C = new float[box];
PImage back;

void setup(){
size( 1300,800);
minim = new Minim(this);
A = minim.loadSample("音１.wav");
bgm = minim.loadFile("bgm_maoudamashii_acoustic45.mp3");
bgm.loop();
for(int i = 0;i<box;i++){
x[i]=random(width);
y[i]=800+random(5500);
s[i]=random(20,110);
c[i] = 30;
C[i]=random(100,255);
}
back = loadImage("haikei.png");
}

void draw(){
  image(back,0,0,width,800);
  fill(255,noise(millis()*0.001)*40);
   noStroke();
  rect(0,0,width,height);
  for(int i = 0;i<box;i++){
  stroke((C[i]-130)+random(-noise(millis()*0.001)*10,noise(millis()*0.001)*10),noise(millis()*0.001)*C[i],255,200);
  if((y[i]+80>mouseY)&&(y[i]-80<mouseY)){
stroke(255,random(100),random(255),180);
}
x[i] = x[i]+random(-noise(millis()*0.001)*7,noise(millis()*0.001)*7);
y[i] = y[i]-7;
c[i] = c[i]+random((-noise(millis()*0.001)*5),(noise(millis()*0.001)*5)); 
fill(255,c[i]);
ellipse(x[i],y[i],s[i],s[i]);
if(y[i]<0){
y[i]=800+random(5500);
c[i] = 20;
C[i]=random(100,255);
}
if(c[i]<5){
c[i] = 5;
}else if(c[i]>30){
c[i]=30;
}
if((mousePressed)&&(y[i]+80>mouseY)&&(y[i]-80<mouseY)&&(x[i]+80>mouseX)&&(x[i]-80<mouseX)){
   y[i]=850+random(7000);
   c[i] = 20;
   A.trigger();
   C[i]=random(100,255);
    }
    if(flg==true){
    y[i] = y[i]-40;
    }
}

}

void keyPressed()
{
  if ( key == 'a' ) {
   flg = true;
  }
}
void keyReleased()//離された瞬間
{
  flg  = false;
}


void stop(){
A.close();
minim.stop();
}
