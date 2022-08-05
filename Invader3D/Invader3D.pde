float x, y, z, aX, aY, aZ;
float zz=-5000;
float invX[]=new float[5];
float invY[]=new float[5];
float invZ[]=new float[5];
boolean henka, curve, shoot, knuckle, fork, rise, debug;
boolean[] hit=new boolean[5];
int score;
boolean touchStarted, touchEnded;
float debugX, debugY;
void setup() {
  size(1200, 600, P3D);
  for (int i=0; i<5; i++) {
    invX[i]=random(55, 1865);
    invY[i]=random(0, height-40);
    invZ[i]=-8000;
  }
}
void draw() {
  background(0);
  pushMatrix();
  fill(0, 255, 0);
  translate(x, y, z);
  noStroke();
  sphere(50);
  popMatrix();
  x+=aX;
  y+=aY;
  z+=aZ;
  if (mousePressed) {
    x=mouseX;
    y=mouseY;
    z=100;
    if (mouseY>=0&mouseY<=70) {
      fill(50);
      if (mouseX>=0&&mouseX<370) {
        rect(0, 0, 370, 70);
      }
      if (mouseX>=370&&mouseX<740) {
        rect(370, 0, 370, 70);
      }
      if (mouseX>=740&&mouseX<1110) {
        rect(740, 0, 370, 70);
      }
      if (mouseX>=1110&&mouseX<=1480) {
        rect(1110, 0, 370, 70);
      }
    }
    debugX=mouseX;
    debugY=mouseY;
  } else {
    if (y>=height-50/*||y<=100*/) {
      if (!(debug)) {
        aY*=-0.7;

        if (y>=height-50) {
          y=height-50;
          if (!(z>=-50)) {
            curve=false;
            shoot=false;
            knuckle=false;
            fork=false;
            rise=false;
          }
        }
      } else {
        y=mouseY;
      } /*else if (y<=100) {
       y=100;
       }*/
    }
    /*if (x>=1400||x<=100) {
     aX*=-0.7;
     if (x>=1400) {
     x=1400;
     } else if (x<=100) {
     x=100;
     }
     }
     if (z<=-7500||z>=-100) {
     aZ*=-0.7;
     if (z<=-7500) {
     z=-7500;
     } else if (z>=-100) {
     z=-100;
     }
     }*/
  }
  aY+=4;
  for (int i=0; i<5; i++) {
    pushMatrix();
    translate(0, 0, invZ[i]);
    drawInvader(invX[i], invY[i], hit[i]);
    invZ[i]+=random(-10, 30);
    popMatrix();
    if (invZ[i]>=0) {
      invZ[i]=-8000;
      invX[i]=random(55, 1865);
      invY[i]=random(0, height-40);
    }
    if (frameCount%60==0) {
      invX[i]+=or(-50, 50);
      invY[i]+=or(-50, 50);
    }
    if (dist(invX[i], invY[i], invZ[i], x, y, z)<=110) {
      invZ[i]=-8000;
      invX[i]=random(55, 1865);
      invY[i]=random(0, height-40);
      score+=100;
    }
  }
  if (curve) {
    aX-=abs(aZ)*0.015;
  } else if (shoot) {
    aX+=abs(aZ)*0.015;
  } else if (knuckle) {
    aX+=abs(aZ)*random(-0.05, 0.05);
  } else if (fork) {
    aY+=abs(aZ)*0.015;
  } else if (rise) {
    aY-=1;
    aZ*=1.1;
  }
  stroke(255);
  textSize(50);
  textAlign(RIGHT, TOP);
  text("SCORE："+score, width, 0);
  textAlign(LEFT, TOP);
  text("カーブ", 110, 10);
  text("シュート", 370+85, 10);
  text("フォーク", 370*2+85, 10);
  text("ナックル", 370*3+85, 10);
}
void touchStarted() {
  touchStarted=true;
  touchEnded=false;
}
void mouseReleased() {
  touchStarted=false;
  touchEnded=true;
  if (!(debug)) {
    aX=mouseX-pmouseX;
    aY=(mouseY-pmouseY)/3;
    aZ=-abs((mouseY-pmouseY));
  } else {
    x=debugX;
    y=debugY;
    aZ=-100;
  }
  if (mouseY>=0&mouseY<=70) {
    if (mouseX>=0&&mouseX<370) {
      curve=true;
      shoot=false;
      knuckle=false;
      fork=false;
      rise=false;
    }
    if (mouseX>=370&&mouseX<740) {
      curve=false;
      shoot=true;
      knuckle=false;
      fork=false;
      rise=false;
    }
    if (mouseX>=740&&mouseX<1110) {
      curve=false;
      shoot=false;
      knuckle=false;
      fork=true;
      rise=false;
    }
    if (mouseX>=1110&&mouseX<=1480) {
      curve=false;
      shoot=false;
      knuckle=true;
      fork=false;
      rise=false;
    }
  }
  if (mouseX>=width-100&&mouseX<=width&&mouseY>=height-100&&mouseY<=height) {
    debug=true;
  }
}
void drawInvader(float x, float y, boolean h) {
  int[] a={0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 
    0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 
    0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 
    0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
    1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 
    1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 
    0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0};
  for (int i=0; i<=87; i++) {
    if (a[i]==1) {
      if (h) {
        fill(255, 0, 0);
      } else {
        fill(255);
      }
      rect((x-55)+i%11*10, (y-40)+i/11*10, 10, 10);
    }
  }
}
void keyPressed() {
  switch(key) {
  case 'c':
    curve=true;
    shoot=false;
    knuckle=false;
    fork=false;
    rise=false;
    break;
  case 's':
    curve=false;
    shoot=true;
    knuckle=false;
    fork=false;
    rise=false;
    break;
  case 'k':
    curve=false;
    shoot=false;
    knuckle=true;
    fork=false;
    rise=false;
    break;
  case 'f':
    curve=false;
    shoot=false;
    knuckle=false;
    fork=true;
    rise=false;
    break;
  case 'r':
    curve=false;
    shoot=false;
    knuckle=false;
    fork=false;
    rise=true;
    break;
  }
}
int or(int a, int b) {
  float ran=random(2);
  if (ran<1) {
    return a;
  } else {
    return b;
  }
}
float or(float a, float b) {
  float ran=random(2);
  if (ran<1) {
    return a;
  } else {
    return b;
  }
}
