class Button {
  PVector posRec, sizeRec;
  PVector posRec1, posRec2;
  PVector sizeRec2, sizeRec1;
  int buttonFunction;
  String sD;

  Button(float RecX, float RecY, float sizeX, float sizeY, int btFc) {
    posRec = new PVector(RecX, RecY);
    sizeRec = new PVector(sizeX, sizeY);
    posRec1 = new PVector(posRec.x + (4*sizeRec.x)/5, posRec.y);
    posRec2 = new PVector(posRec.x + (4*sizeRec.x)/5, posRec.y + sizeRec.y/2);
    sizeRec1 = new PVector(sizeRec.x/5, sizeRec.y/2);
    sizeRec2 = new PVector(sizeRec.x/5, sizeRec.y/2);
    buttonFunction = btFc;
    sD = "";
  }

  Button(float RecX, float RecY, float sizeX, float sizeY, int btFc, String text) {
    posRec = new PVector(RecX, RecY);
    sizeRec = new PVector(sizeX, sizeY);
    posRec1 = new PVector(posRec.x + (4*sizeRec.x)/5, posRec.y);
    posRec2 = new PVector(posRec.x + (4*sizeRec.x)/5, posRec.y + sizeRec.y/2);
    sizeRec1 = new PVector(sizeRec.x/5, sizeRec.y/2);
    sizeRec2 = new PVector(sizeRec.x/5, sizeRec.y/2);
    buttonFunction = btFc;
    sD = text;
  }

  void function(String btType) {
    if (buttonFunction == 1) {
    } else if (buttonFunction == 2) {
      if (mouseX >= posRec.x && mouseY >= posRec.y && mouseX <= (posRec.x + sizeRec.x) && mouseY <= (posRec.y + sizeRec.y)) {
        if (btType == "Add") {
          btStateHPAdd = 1;
        } else if (btType == "SPCh") {
          btStateSPCh = 1;
        } else if ( btType == "RPChR") {
          btStateRPCh = 1;
        }
        println("CHECK");
      }
    }
  }

  void function(int btID) {
    if (buttonFunction == 1) {
    } else if ( buttonFunction == 2) {
      if (mouseX >= posRec.x && mouseY >= posRec.y && mouseX <= (posRec.x + sizeRec.x) && mouseY <= (posRec.y + sizeRec.y)) {
        println("CHECK" + str(btID));
        currentButtonChoice = btID;
        btStateHPCCat = 1;
      }
    }
  }

  //Age, Weight and activity button
  void function(int fc, float num) {
    if (buttonFunction == 1) {
      if (fc == 1) {
        if (mouseX >= posRec1.x && mouseY >= posRec1.y && mouseX <= (posRec1.x + sizeRec1.x) && mouseY <= (posRec1.y + sizeRec1.y)) {
          noFill();
          rect(posRec.x, posRec.y, sizeRec.x - sizeRec1.x, sizeRec.y);
          println();
          println("pressUP");
          ageTemp += num;
        } else if (mouseX >= posRec2.x && mouseY >= posRec2.y && mouseX <= (posRec2.x + sizeRec2.x) && mouseY <= (posRec2.y + sizeRec2.y)) {
          noFill();
          rect(posRec.x, posRec.y, sizeRec.x - sizeRec1.x, sizeRec.y);
          println();
          println("pressDOWN");
          ageTemp -= num;
        }
        if (ageTemp < 0) {
          ageTemp = 0;
        }
      } else if (fc == 2) {
        if (mouseX >= posRec1.x && mouseY >= posRec1.y && mouseX <= (posRec1.x + sizeRec1.x) && mouseY <= (posRec1.y + sizeRec1.y)) {
          noFill();
          rect(posRec.x, posRec.y, sizeRec.x - sizeRec1.x, sizeRec.y);
          println();
          println("pressUP");
          weightTemp += num;
        } else if (mouseX >= posRec2.x && mouseY >= posRec2.y && mouseX <= (posRec2.x + sizeRec2.x) && mouseY <= (posRec2.y + sizeRec2.y)) {
          noFill();
          rect(posRec.x, posRec.y, sizeRec.x - sizeRec1.x, sizeRec.y);
          println();
          println("pressDOWN");
          weightTemp -= num;
        } 
        if (weightTemp < 0) {
          weightTemp = 0;
        }
      } else if (fc == 3) {
        if (mouseX >= posRec1.x && mouseY >= posRec1.y && mouseX <= (posRec1.x + sizeRec1.x) && mouseY <= (posRec1.y + sizeRec1.y)) {
          noFill();
          rect(posRec.x, posRec.y, sizeRec.x - sizeRec1.x, sizeRec.y);
          println();
          println("pressUP");
          activityTemp += num;
        } else if (mouseX >= posRec2.x && mouseY >= posRec2.y && mouseX <= (posRec2.x + sizeRec2.x) && mouseY <= (posRec2.y + sizeRec2.y)) {
          noFill();
          rect(posRec.x, posRec.y, sizeRec.x - sizeRec1.x, sizeRec.y);
          println();
          println("pressDOWN");
          activityTemp -= num;
        }
        if (activityTemp < 0) {
          activityTemp = 1;
        } else if (activityTemp > 1) {
          activityTemp = 0;
        }
      } else if (buttonFunction == 2) {
      }
    }
  }

  void render() {
    if (buttonFunction == 1) {
      noFill();
      stroke(0);
      rect(posRec.x, posRec.y, sizeRec.x, sizeRec.y);
      rect(posRec1.x, posRec1.y, sizeRec1.x, sizeRec1.y);//boutton haut
      rect(posRec2.x, posRec2.y, sizeRec2.x, sizeRec2.y);//boutton bas
      textSize(30);
      fill(255, 0, 0);
      text(ageTemp, posRec.x + (sizeRec.x)/6, posRec.y + (sizeRec.y)/1.5);
    } else if (buttonFunction == 2) {
      noFill();
      rect(posRec.x, posRec.y, sizeRec.x, sizeRec.y);
      fill(0);
      text(sD, posRec.x + sizeRec.x/2, posRec.y + (sizeRec.y - 7));
    }
  }

  void render(String textD) {
    if (buttonFunction == 1) {
      noFill();
      stroke(0);
      rect(posRec.x, posRec.y, sizeRec.x, sizeRec.y);
      rect(posRec1.x, posRec1.y, sizeRec1.x, sizeRec1.y);//boutton haut
      rect(posRec2.x, posRec2.y, sizeRec2.x, sizeRec2.y);//boutton bas
      fill(#4DBD33);
      textSize(48);
      text("+", posRec1.x + 6, posRec1.y + 30);
      text("-", posRec2.x + 6, posRec2.y + 30);
      textSize(30);
      text(textD, posRec.x + (sizeRec.x)/6, posRec.y + (sizeRec.y)/1.5);
    } else if (buttonFunction == 2) {
    }
  }
}