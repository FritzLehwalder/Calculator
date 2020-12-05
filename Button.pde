class Button {
  PFont MyriadPro = createFont("MYRIADPRO-REGULAR.OTF", 1000);
  float x,y,w,h,r,ts;
  public boolean active;
  String text,num;
  color textColor = #ffffff;
  color actColor = #2C2F33;
  color defColor = #23272A;
  Button(float x, float y, float w, float h, float r, String t, float ts, String num){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.text = t;
    this.ts = ts;
    this.num = num;
  }
  void update(float tx, float ty){
    active = tx>x && tx<x+w && ty>y && ty<y+h;
  }
  void display(boolean t){
    if(t){
      fill(actColor);
    } else {
      fill(defColor);
    }
    noStroke();
    rect(x, y, w, h, r);
    fill(textColor);
    textAlign(CENTER,CENTER);
    textFont(MyriadPro, ts);
    text(text,x+w/2,y+h/2);
  }
  void setValue(String num){
    this.num = num;
  }
  void textColor(color text){
    this.textColor = text;
  }
  void setColor(color t1, color t2){
    this.actColor = t1;
    this.defColor = t2;
  }
  void setPos(float x, float y){
    this.x = x;
    this.y = y;
  }
}
