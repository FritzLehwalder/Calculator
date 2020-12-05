import java.util.regex.Pattern;
import java.awt.Toolkit;
import java.awt.datatransfer.*;
import java.lang.*;
Button[] buttons = new Button[10];
Button[] opButtons = new Button[14];
Clipboard cb = Toolkit.getDefaultToolkit().getSystemClipboard();
Button debug;
Button full;
Button paste;
Button copy;
boolean ctrl;
boolean debugB;
boolean fullB;
PFont MyriadPro;
String dVal;
String op;
boolean left;
float r;
float l;
float result;
String history;
float notchVel;
float notchH;
float notchW;
float notchX;
boolean notchFull;
float fullH;
float fullV;
boolean fullReopen;
int secondTimer;
void setup() {
  size(800, 1000);
  buttonSet();
  MyriadPro = createFont("MYRIADPRO-REGULAR.OTF", 1000);
  debug = new Button(width/2-(width*0.14375), height*0.0075, width*0.05, height*0.013, 0, "DEBUG", width*0.01625, "NA");
  debug.textColor(#23272A);
  debug.setColor(#23272A, #23272A);
  full = new Button(width/2-(width/0.2), height*0.265, width*0.4, height*0.005, 50, "", 50, "NA");
  copy = new Button(width-95, 258, width*0.05, height*0.013, 50, "COPY", width*0.01625, "NA");
  paste = new Button(width-45, 258, width*0.05, height*0.013, 50, "PASTE", width*0.01625, "NA");
  dVal = "0";
  op = "";
  left = true;
  r = 0.0;
  l = 0.0;
  result = 0.0;
  history = "";
  notchFull = false;
  notchVel = 45;
  notchH = 50;
  notchW = 300;
  notchX = width/2-150;
  fullH = 265;
  fullV = 15;
  fullReopen = false;
  secondTimer = 0;
}
void draw() {
  background(#23272A);
  if (fullB) {
    if (fullH < 405) fullH+=fullV;
    if (fullH <= 405) {
      full.setPos(width/2-160, fullH);
      paste.setPos(width-45, fullH-7);
      copy.setPos(width-95, fullH-7);
      backgroundCall(fullH+15);
    } else {
      full.setPos(width/2-160, 405);
      paste.setPos(width-45, 398);
      copy.setPos(width-95, 398);
      backgroundCall(420);
      textFont(MyriadPro, 20);
      textAlign(RIGHT, CENTER);
      fill(255);
      if (history.length() < 14) {
        textSize(100);
      } else if (history.length() < 17) {
        textSize(90);
      } else if (history.length() < 20) {
        textSize(75);
      } else if (history.length() < 23) {
        textSize(65);
      } else {
        textSize(50);
      }
      text(history, width-(width*0.05), height*0.400);
    }
  } else {
    for (int i = 0; i < buttons.length; i++) {
      buttons[i].display(false);
      buttons[i].update(mouseX, mouseY);
    }
    for (int i = 0; i < opButtons.length; i++) {
      opButtons[i].display(false);
      opButtons[i].update(mouseX, mouseY);
    }
    if (fullH > 265) fullH-=fullV;
    if (fullH <= 265) {
      full.setPos(width/2-160, 265);
      paste.setPos(width-45, 258);
      copy.setPos(width-95, 258);
      backgroundCall(280);
    } else {
      full.setPos(width/2-160, fullH);
      paste.setPos(width-45, fullH-7);
      copy.setPos(width-95, fullH-7);
      backgroundCall(fullH+15);
    }
  }
  if (left) {
    l = float(dVal);
  } else {
    r = float(dVal);
  }
  if (dVal.length() == 0) dVal = "0";
  notch();
  debug();
}
void notch() {
  /*  notchV = -20;
   notchH = 300;
   notchW = width+50;
   notchX = width/2-(notchW/2);*/
  fill(#23272A);
  if (notchFull) {
    if (fullReopen == false && fullB == true) {
      fullReopen = true;
    }
    fullB = false;
    if (notchH <= 300) notchH+=notchVel;
    if (notchW <= width+50) notchW+=notchVel*2;
    notchX = width/2-(notchW/2);
    stroke(#2C2F33);
    strokeWeight(3);
  } else {
    if (fullReopen == true) {
      fullB = true;
      fullReopen = false;
    }
    //rect(width/2-150, -20, 300, 50, 35);
    if (notchW >= 300) notchW-=notchVel*2;
    if (notchH >= -20) notchH-=notchVel;
    notchX = width/2-(notchW/2);
  }
  if (notchW >= 300) {
    if (notchH >= 300) {
      rect(notchX, -20, notchW, 300, 35);
    } else {
      rect(notchX, -20, notchW, notchH, 35);
    }
  } else {
    rect(width/2-150, -20, 300, 50, 35);
  }
  textFont(MyriadPro, 20);
  textAlign(CENTER, CENTER);
  fill(255);
  text(getTime(), width/2, 12.5);
  if (dVal.length() >= 25) {
    fill(#ff0000);
    text("MAX", width/2+75, 12.5);
    fill(255);
  }
  fill(255);
  text(op, width/2+105, 12.5);
  debug.display(debugB);
  //if(notchFull && notchH)
}
void backgroundCall(float displaySize) {
  noStroke();
  fill(#2C2F33);
  rect(0, 0, width, displaySize);
  textFont(MyriadPro, 20);
  textAlign(CENTER, CENTER);
  fill(255);
  if (!notchFull && !fullReopen) {
    full.display(false);
  }
  full.update(mouseX, mouseY);
  full.setColor(133, 255);
  paste.display(false);
  paste.update(mouseX, mouseY);
  copy.display(false);
  copy.update(mouseX, mouseY);
  paste.setColor(255, #2C2F33);
  copy.setColor(255, #2C2F33);
  updateDisplay();
}
void updateDisplay() {
  fill(255);
  textFont(MyriadPro, 100);
  if (dVal.length() < 14) {
    textSize(100);
  } else if (dVal.length() < 17) {
    textSize(90);
  } else if (dVal.length() < 20) {
    textSize(75);
  } else if (dVal.length() < 23) {
    textSize(65);
  } else {
    textSize(57);
  }
  textAlign(RIGHT);
  text(dVal, width-40, 175);
  if (dVal.equals("268413975")) {
    delay(1500);
    dVal = "Woops :-(";
  }
}
void buttonSet() {
  buttons[0] = new Button(0, 280, 133, 180, 0, "1", 100, "1");
  buttons[1] = new Button(133, 280, 133, 180, 0, "2", 100, "2");
  buttons[2] = new Button(266, 280, 133, 180, 0, "3", 100, "3");
  buttons[3] = new Button(0, 460, 133, 180, 0, "4", 100, "4");
  buttons[4] = new Button(133, 460, 133, 180, 0, "5", 100, "5");
  buttons[5] = new Button(266, 460, 133, 180, 0, "6", 100, "6");
  buttons[6] = new Button(0, 640, 133, 180, 0, "7", 100, "7");
  buttons[7] = new Button(133, 640, 133, 180, 0, "8", 100, "8");
  buttons[8] = new Button(266, 640, 133, 180, 0, "9", 100, "9");
  buttons[9] = new Button(0, 820, 133, 180, 0, "0", 100, "0");
  opButtons[10] = new Button(655, 280, 133, 180, 0, "CLR", 50, "CLR");
  opButtons[11] = new Button(133, 820, 133, 180, 0, ".", 50, ".");
  opButtons[0] = new Button(399, 280, 133, 180, 0, "÷", 100, "/");
  opButtons[1] = new Button(532, 280, 133, 180, 0, "×", 100, "*");
  opButtons[2] = new Button(399, 460, 133, 180, 0, "±", 100, "+-");
  opButtons[3] = new Button(532, 460, 133, 180, 0, "-", 100, "-");
  opButtons[4] = new Button(655, 460, 133, 180, 0, "+", 100, "+");
  opButtons[5] = new Button(399, 640, 133, 180, 0, "x²", 50, "x2");
  opButtons[6] = new Button(532, 640, 133, 180, 0, "%", 100, "%");
  opButtons[7] = new Button(655, 640, 133, 180, 0, "√", 100, "√");
  opButtons[8] = new Button(399, 820, 133, 180, 0, "log", 50, "log");
  opButtons[9] = new Button(532, 820, 133, 180, 0, "^", 50, "^");
  opButtons[12] = new Button(655, 820, 133, 180, 0, "<", 80, "BKSPC");
  opButtons[13] = new Button(266, 820, 133, 180, 0, "=", 100, "=");
}
String getTime() {
  String TIME;
  String sec;
  String min;
  String hour;
  String AMPM = "AM";
  if (hour() > 12) {
    hour = str(hour()-12);
    AMPM = "PM";
  } else {
    hour = str(hour());
  }
  if (second() < 10) {
    sec = (String) ("0" + second());
  } else {
    sec = str(second());
  }
  if (minute() < 10) {
    min = (String) ("0" + minute());
  } else {
    min = str(minute());
  }
  TIME = hour + ":" + min + ":" + sec + AMPM;
  return TIME;
}
void mouseReleased() {  
  if (debug.active) {
    debug.display(true);
    if (debugB) {
      debugB = false;
      debug.textColor(#2C2F33);
    } else {
      debugB = true;
      debug.textColor(#ff0000);
    }
  }
  if (mouseX > 356 && mouseX < 445 && mouseY > 8 && mouseY < 23) {
    if (notchFull) {
      notchFull = false;
    } else {
      notchFull = true;
    }
  }
  if (!notchFull) {
    for (int i=0; i<buttons.length; i++) {
      if (buttons[i].active) {
        buttons[i].display(true);
        numBut(buttons[i].num);
        if (dVal.equals("Err")) dVal = "0";
      }
      if (dVal.endsWith(".0")) dVal = dVal.substring(0, dVal.length()-2);
    }
    if (full.active) {
      if (!notchFull && !fullReopen) {
        full.display(true);
      }
      if (fullB) {
        fullB = false;
      } else {
        fullB = true;
      }
    }
    if (paste.active) {
      paste.display(true);
      paste();
    }
    if(copy.active){
      copy.display(true);
      copycb();
    }
    for (int i=0; i<opButtons.length; i++) {
      if (opButtons[i].active) {
        // opButtons[i].num
        opBut(opButtons[i].num);
      }
    }
  }
}
void performCalc() {
  println("performCalc");
  if (op.equals("+")) {
    result = l + r;
  } else if (op.equals("*")) {
    result = l * r;
  } else if (op.equals("/")) {
    result = l / r;
  } else if (op.equals("-")) {
    result = l - r;
  } else if (op.equals("^")) {
    result = pow(int(l), int(r));
  } else if (op.equals("%")) {
    result = l % r;
  } 
  Boolean test = true;
  String[] Vals = dVal.split(" ");
  for(int i = 0; i < Vals.length; i++){
    println(Vals[i]);
    if(Vals[i].toLowerCase().equals("pi")){
      dVal = String.valueOf(PI);
      test = false;
    } else if(Vals[i].toLowerCase().equals("nolan")){
      dVal = "traitor";
      test = false;
    } else if(Vals[i].contains("log(")) {
      Vals[i].replace("log("," ");
      Vals[i].replace(")"," ");
      println(Vals[i]);
      result = log(float(Vals[i]));
    }
  }
  if(test){
    dVal = str(result);
  }
  if (history.length() > 1) history="";
  String str = l + " " + op + " " + r + " = " + dVal + "\n";
  history+=str;
  l = result;
  left = true;
  op = "";
  if (result >= Float.MAX_VALUE) {
    clr();
    dVal = "Err";
  }
  if (dVal.endsWith(".0")) dVal = dVal.substring(0, dVal.length()-2);
}
void debug() {
  debug.display(false);
  debug.update(mouseX, mouseY);
  if (debugB) {
    String str = dVal + "; " + l + ":" + r + "; " + result + "; " + left + "; " + history.length();
    str+= ", " + notchFull + "\n" + mouseX + ", " + mouseY + "\nW:" + notchW + " H:" + notchH + " V:" + notchVel;
    textAlign(LEFT);
    fill(255);
    textFont(MyriadPro, 12);
    text(str, 15, 250);
  }
}
String getClipboard() {
  String str = "";
  Transferable cbData = cb.getContents(cb);
  if (cbData != null) {
    try {
      if (cbData.isDataFlavorSupported(DataFlavor.stringFlavor)) str = String.valueOf(cbData.getTransferData(DataFlavor.stringFlavor));
    }
    catch (UnsupportedFlavorException un) {
      println(un);
    } 
    catch (IOException io) {
      println(io);
    }
  }
  return str;
}
void clr() {
  dVal = "0";
  result = 0;
  left = true;
  r = 0.0;
  l = 0.0;
  op = "";
}
void opBut(String num) {
  if (num.equals("CLR") || num.equals("12") || num.equals("127")) {
    clr();
  } else if (num.equals("+") || num.equals("107")) {
    op = "+";
    left = false;
    dVal = "0";
  } else if (num.equals("=") || num.equals("RETURN") || num.equals("ENTER") || num.equals("10") || num.equals("61") || num.equals("13") || num.equals("187")) {
    if (!left || !Pattern.matches("[a-zA-Z]", dVal)) {
      performCalc();
    }
  } else if (num.equals("*") || num.equals("106")) {
    op = "*";
    left = false;
    dVal = "0";
  } else if (num.equals("/") || num.equals("111") || num.equals("47") || num.equals("92")) {
    op = "/";
    left = false;
    dVal = "0";
  } else if (num.equals("-") || num.equals("109") || num.equals("45")) {
    op = "-";
    left = false;
    dVal = "0";
  } else if (num.equals("^")) {
    op = "^";
    left = false;
    dVal = "0";
  } else if (num.equals("x2")) {
    if (dVal.length() >= 1) dVal = str(float(dVal)*float(dVal));
    if (left) {
      l = float(dVal);
    } else {
      r = float(dVal);
    }
  } else if (num.equals("BKSPC") || num.equals("8")) {
    if (!dVal.contains("E") && dVal.length() >= 1) {
      dVal = dVal.substring(0, dVal.length()-1);
      if (left) {
        l = float(dVal);
      } else {
        r = float(dVal);
      }
    }
  } else if (num.equals("+-")) {
    dVal = str(float(dVal)*-1);
    if (left) {
      l = float(dVal);
    } else {
      r = float(dVal);
    }
  } else if (num.equals(".") || num.equals("46") || num.equals("110")) {
    if (!dVal.contains(".")) dVal+=".";
    if (left) {
      l = float(dVal);
    } else {
      r = float(dVal);
    }
  } else if (num.equals("√")) {
    dVal = str(pow(int(l), 0.5));
    if (left) {
      l = float(dVal);
    } else {
      r = float(dVal);
    }
  } else if (num.equals("%")) {
    op = "%";
    left = false;
    dVal = "0";
  } else if (num.equals("log")) {
    dVal = String.valueOf(log(float(dVal)));  
    if (left) {
      l = float(dVal);
    } else {
      r = float(dVal);
    }
  }
  if (l >= Float.MAX_VALUE) {
    clr();
    dVal = "Err";
  }
  if (dVal.endsWith(".0")) dVal = dVal.substring(0, dVal.length()-2);
}
void numBut(String num) {
  if (dVal.length() < 25) {
    if (left) {
      if (dVal.equals("0")) {
        dVal = str(int(num));
        l = float(dVal);
      } else {
        dVal += str(int(num));
        l = float(dVal);
      }
    } else {
      if (dVal.equals("0")) {
        dVal = str(int(num));
        r = float(dVal);
      } else {
        dVal += str(int(num));
        r = float(dVal);
      }
    }
  }
}
void keyPressed() {
  if(Pattern.matches("[a-zA-Z]",str(key)) || keyCode == 32 || keyCode == 48 || keyCode == 57){
    if(Pattern.matches("[0-9]*", dVal)) dVal = "";
    if(keyCode == 32) dVal+=" ";
    dVal+=str(key);
  }
  if (keyCode == 27) {
    key = 12;
    opBut("12");
  }
  opBut(str(keyCode));
  if (Pattern.matches("[0-9]{1}", str(key))) numBut(str(key));
  switch (keyCode) {
  case 33:
    fullB = false;
    break;
  case 34:
    fullB = true;
    break;
  case 36:
    if (notchFull) {
      notchFull = false;
    } else {
      notchFull = true;
    }
    break;
  case 45:
    paste();
    break;
  case 0:
    paste();
    break;
  }
  if (keyCode == 17 || keyCode == 157) {
    ctrl = true;
  }
  if (keyCode == 86 && ctrl) {
    paste();
  }
  if(keyCode == 67 && ctrl){
    copycb();
  }
  println(str(key));
  println(str(keyCode));
}
void paste() {
  String str = getClipboard();
  if (Pattern.matches("[0-9]*.?[0-9]+", str)) dVal = str;
}
void copycb(){
  StringSelection str = new StringSelection(dVal);
  cb.setContents(str, null);
}
void keyReleased() {
  if (keyCode == 17 || keyCode == 157) {
    ctrl = false;
  }
}
//268413975
