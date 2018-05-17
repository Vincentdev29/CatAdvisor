Table userFile, catDatabase;
PFont BrainFlowerFt;

StringList raceDataList, robeDataList, activiteDataList;//List of strings from the static catDatabase (use for button's name,...)

StringList catNameList, catActivityList;//List from the fileUser so we can read and write depending on the cat profile
IntList catId, catAgeList, dayOfbirth, monthOfBirth, yearOfBirth, settedCatList;
FloatList catWeightList, catFoodQtyList;

PImage picStartPage, picHomePage, picSettingPage, picResultPage, picMaintPage; //Background page
PImage catFall, catMiaou;//Image for the setting page
PImage catSlide;//Image for result page

PVector posCatFall, posCatMiaou, sISpeed, sIAcc;//Vector for the movement of the picture

boolean startPageD, homePageD, settingPageD, resultPageD;

int catNumber, movement;
int currentButtonChoice;
int btStateHPAdd, btStateHPCCat, btStateSPCh, btStateRPCh;
int ageTemp, activityTemp;
float weightTemp, qtCTemp, ageTempCat;

//Buttons of the home page (HP)
Button [] btHPCCat;
Button btHPAdd;
//Buttons of the setting page (SP)
Button btSPAge, btSPWeight, btSPActivity, btSPCheck;
//Button of the result page (RP)
Button btRPCheckR;

Croquette [] croquette = new Croquette[70]; 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void setup() {
  size(326, 491);
  //Load the font
  fontLoader();
  //Load all the pictures, for the background of the app
  imageLoader();
  //Load the table
  userFile = loadTable("data/dataBase/userFile.csv", "header");
  catDatabase = loadTable("data/dataBase/catDatabase.csv", "header");
  //Test adding a new cat
  //addCatFunction();
  //Initalise to 0 the database
  listInitialyser();
  //Load the database in the lists
  dataBaseLoader();
  //Create the buttons
  catNumber = catNameList.size();
  buttonCreator();
  //Initialise the vector for the settingPage
  SPvecLoader();
  //Load objects inheriting from the Croquetterain class for the resultPage
  cLoader();
  //Initiate the boolean value controlling the display of the page
  toggleInitialiser();
  startPage();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void draw() {
  smooth();
  screenDisplay();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void mousePressed() {
  buttonFunction();
}

void buttonFunction() {
  if (startPageD == false && homePageD == false && settingPageD == false && resultPageD == false) {//startPage
    if (mousePressed) {
      if (mouseX >= 0 && mouseX <= width && mouseY >= 0 && mouseY <= height) { 
        startPageD = true;
        homePageD = true;
      }
    }
  } else if (startPageD == true && homePageD == true && settingPageD == false && resultPageD ==false) {//homePage
    if (mousePressed) {
      for (int i = 0; i < btHPCCat.length; i++) {
        btHPCCat[i].function(i);
      }
      println("Current button = " + currentButtonChoice + ", cat name : " + catNameList.get(currentButtonChoice));
      println();
      btHPAdd.function("Add");
      if (btStateHPAdd == 1) {
        addCatFunction();
        currentButtonChoice = catNameList.size()-1;
        println("Cat added");
        homePageD = false;
        settingPageD = true;
        btStateHPAdd = 0;
      } else if (btStateHPCCat == 1 && settedCatList.get(currentButtonChoice) == 0) {
        homePageD = false;
        settingPageD = true;
        btStateHPCCat = 0;
      } else if (btStateHPCCat == 1 && settedCatList.get(currentButtonChoice) == 1) {
        homePageD = false;
        settingPageD = false;
        resultPageD = true;
        btStateHPCCat = 0;
      }
    }
  } else if (startPageD == true && homePageD == false && settingPageD == true && resultPageD == false) {//settingPage
    if (mousePressed) {
      btSPAge.function(1, 1);
      btSPWeight.function(2, 0.1);
      btSPActivity.function(3, 1);
      btSPCheck.function("SPCh");
      if (btStateSPCh == 1) {
        settingPageD = false;
        resultPageD = true;
        btStateSPCh = 0;
        ///////////////////
        userFile.setInt(currentButtonChoice, "age", ageTemp);
        userFile.setFloat(currentButtonChoice, "poids", weightTemp);
        userFile.setString(currentButtonChoice, "activite", activiteDataList.get(activityTemp));
        foodCalculator();
        userFile.setFloat(currentButtonChoice, "qtenourriture", qtCTemp);
        userFile.setInt(currentButtonChoice, "calculated", 1);
        userFileSaver();
        reloadUser();
        initialyseUser();
        loadUserData();
        ageTemp = 0;
        weightTemp =0;
        activityTemp = 0;
        qtCTemp = 0;
      }
    }
  } else if (startPageD == true && homePageD == false && settingPageD == false && resultPageD == true) {//resultPage
    if (mousePressed) {
      btRPCheckR.function("RPChR");
      if (btStateRPCh == 1) {
        resultPageD = false;
        homePageD = true;
        btStateRPCh = 0;
        initialyseUser();
        loadUserData();
        catNumber = catNameList.size();
        btHPCCatInitialize();
        currentButtonChoice = 0;
      }
    }
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void keyPressed() {
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
void toggleInitialiser() {
  startPageD = false;
  homePageD = false;
  settingPageD = false;
  resultPageD= false;
}

void screenDisplay() {
  if (startPageD == false && homePageD == false && settingPageD == false && resultPageD == false) {
    startPage();
  } else if (startPageD == true && homePageD == true && settingPageD == false && resultPageD ==false) {
    homePage();
  } else if (startPageD == true && homePageD == false && settingPageD == true && resultPageD == false) {
    settingPage();
  } else if (startPageD == true && homePageD == false && settingPageD == false && resultPageD == true) {
    resultPage();
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////
void fontLoader() {
  BrainFlowerFt = createFont("data/font/Brain Flower Euro.ttf", 60);
}

void imageLoader() {
  //Background page
  picStartPage = loadImage("data/picture/startPage.jpg");
  picHomePage = loadImage("data/picture/homePage.jpg");
  picSettingPage = loadImage("data/picture/settingsCatPage.jpg");
  picResultPage = loadImage("data/picture/resultCatPage.jpg" );
  picMaintPage = loadImage("data/picture/blue.jpg");
  //Setting page
  catFall = loadImage("data/picture/catFall.png");
  catMiaou = loadImage("data/picture/catMiaou.png");
  //Result page
  catSlide = loadImage("data/picture/catSlide.png");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
void listInitialyser() {
  initialyseUser();
  initalyseCat();
}

void initialyseUser() {
  catId = new IntList();
  catNameList = new StringList();
  catAgeList = new IntList();
  catWeightList = new FloatList();
  dayOfbirth = new IntList();
  monthOfBirth = new IntList();
  yearOfBirth = new IntList();
  catFoodQtyList = new FloatList();
  catActivityList = new StringList();
  settedCatList = new IntList();
}

void initalyseCat() {
  raceDataList = new StringList();
  robeDataList = new StringList();
  activiteDataList = new StringList();
}

void dataBaseLoader() {
  //Load the user database
  loadUserData();
  printListUser();
  //Load the "static" database
  loadCatData();
  printListCatdata();
}

void loadUserData() {
  //Read/Load the user database
  for (TableRow row : userFile.rows ()) {
    int catIdRow = row.getInt("id");
    catId.append(catIdRow);
    String catNameRow = row.getString("name");
    catNameList.append(catNameRow);
    int catAgeRow = row.getInt("age");
    catAgeList.append(catAgeRow);
    float catWeightRow = row.getInt("poids");
    catWeightList.append(catWeightRow);
    int DOBrow = row.getInt("jour");
    dayOfbirth.append(DOBrow);
    int MOBrow = row.getInt("mois");
    monthOfBirth.append(MOBrow);
    int YOBrow = row.getInt("annee");
    yearOfBirth.append(YOBrow);
    float qtFoodRow =  row.getFloat("qtenourriture");
    catFoodQtyList.append(qtFoodRow);
    String catActivityRow = row.getString("activite");
    catActivityList.append(catActivityRow);
    int settedCatRow = row.getInt("calculated");
    settedCatList.append(settedCatRow);
  }
}

void printListUser() {
  //Print the list of the userFile
  println("USER FILE");
  println("Cat ID : " + catId);
  println("Cat Name : " + catNameList);
  println("Cat Age : " + catAgeList);
  println("Cat Weight : " + catWeightList);
  println("Cat DOB : " + dayOfbirth);
  println("Cat MOB : " + monthOfBirth);
  println("Cat YOB : " + yearOfBirth);
  println("Cat food qty : " + catFoodQtyList);
  println("Cat Activity : " + catActivityList);
  println("Cat Setted : " + settedCatList);
  println();
}

void loadCatData() {
  //Read/Load the cat database
  for (TableRow row : catDatabase.rows ()) {
    String raceRow = row.getString("race");
    raceDataList.append(raceRow);
    String robeRow = row.getString("robe");
    robeDataList.append(robeRow);
    String activiteRow = row.getString("activite");
    activiteDataList.append(activiteRow);
  }
}

void printListCatdata() {
  //Print the list of the catDataBase
  println("CAT DATABASE");
  println("Race List : " + raceDataList);
  println("Robe List : " + robeDataList);
  println("Activite List : " + activiteDataList);
  println();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void reloadUser() {
  userFile = loadTable("data/dataBase/userFile.csv", "header");
}

void userFileSaver() {
  saveTable(userFile, "data/dataBase/userFile.csv");
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void buttonCreator() {
  //Home Page
  btHPCCatInitialize();
  btHPAdd = new Button(253, 14, 59, 59, 2);
  //Setting Page
  btSPAge = new Button(140, 140, 160, 40, 1);
  btSPWeight = new Button(145, 225, 110, 40, 1);
  btSPActivity = new Button(155, 320, 130, 40, 1);
  btSPCheck = new Button(254, 419.5, 59, 59, 2);
  //Result Page
  btRPCheckR = new Button(247, 421, 58, 58, 2);
}

void btHPCCatInitialize() {
  btHPCCat = new Button[catNumber];
  int btXStart = 20;
  int btYStart = 60;
  int YSize = 35;
  int spBtwBt = YSize + 17;//Space between buttons
  for (int i = 0; i < catNumber; i++) {
    String name = catNameList.get(i);
    btHPCCat[i] = new Button(btXStart, btYStart, 100, YSize, 2, name);
    btYStart += spBtwBt;
  }
}

void addCatFunction() {
  userFile.addRow();
  userFile.setInt(userFile.getRowCount()-1, "id", userFile.getRowCount()-1);
  userFile.setString(userFile.getRowCount()-1, "name", "Chat " + str(userFile.getRowCount()-1));
  userFile.setInt(userFile.getRowCount()-1, "calculated", 0);
  userFileSaver();
  reloadUser();
  initialyseUser();
  loadUserData();
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void  startPage() {
  translate(0, 0);
  background(picStartPage);
  textFont(BrainFlowerFt);
  textSize(32);
  //textAlign(CENTER);
  text("Click to start !", 100, 415);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void homePage() {
  translate(0, 0);
  background(picHomePage);
  noStroke();//"Erase" the contour of the button
  btHPAdd.render();
  for (int i = 0; i < btHPCCat.length; i++) {
    btHPCCat[i].render();
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void SPvecLoader() {
  posCatFall = new PVector(20, random(-100));
  posCatMiaou = new PVector(60, posCatFall.y);
  sISpeed = new PVector(0, 1);
  sIAcc = new PVector();
}

void SPpicMover() {
  if (posCatFall.y + 80 <= 489) {
    posCatFall.add(sISpeed);
    posCatMiaou.add(sISpeed);
    //sISpeed.add(sIAcc);
  } else {
  }
}

void settingPage() {//Carmen part
  translate(0, 0);
  background(picSettingPage);
  textFont(BrainFlowerFt);
  //Name of the cat
  textSize(40);
  fill(255);
  text(catNameList.get(currentButtonChoice), 250, 45);
  //Button
  noStroke();
  btSPAge.render(str(ageTemp));
  btSPWeight.render(str(weightTemp));
  btSPActivity.render(activiteDataList.get(activityTemp));
  //stroke(0);
  btSPCheck.render();
  //Cat image
  SPpicMover();
  fill(255);
  rect(posCatFall.x, posCatFall.y, 100, 80);
  image(catFall, posCatFall.x, posCatFall.y, 100, 80);
  image(catMiaou, posCatMiaou.x, posCatMiaou.y, 55, 26);
}

void foodCalculator() {
  ageTempCat = (4.3539 * ageTemp) + 11.671;
  if (ageTempCat < 1) {
    qtCTemp = 0.07 * weightTemp;
  } else if (ageTempCat >= 1 || ageTempCat < 9) {
    qtCTemp = 0.05 * weightTemp;
  } else if (ageTempCat >= 9) {
    qtCTemp = 0.03 * weightTemp;
  }
  if (activiteDataList.get(activityTemp) == "actif") { 
    qtCTemp = qtCTemp * 1.2;
  } else if (qtCTemp == 0) {
  }
  qtCTemp = qtCTemp * 1000;
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void cLoader() {
  //Initialize every objects for the resultPage
  for (int i = 0; i < croquette.length; i++) {
    croquette[i] = new Croquette();
  }
}

void resultPage() {//Guillaume part
  translate(0, 0);
  background(picResultPage);
  //Button
  noStroke();
  btRPCheckR.render();
  //Makes the cat food goes down
  for (int i = 0; i < croquette.length; i++) { //affichage
    croquette[i].move();  // on fait appele au move du croquetterain
    croquette[i].display();   // on fait appelle au display de croquette rain
  }
  //Display the cat slide
  image(catSlide, movement, 450, 40, 40);//image of a cat sliding
  if (movement >=width) { // si la valeur de la variable mouvement 
    movement =-45; // pour que l'image apparaisse avant X=0
  } else {//mouvement 
    movement += 1; // ajoute +1 à la variable mouvement afin que la photo du chat avance
  }
  //Text display zone
  noFill();
  //stroke(0);
  noStroke();
  //fill(#5D9B9B);
  rect(130, 210, 150, 40);
  noFill();
  rect(130, 150, 150, 40);
  rect(90, 380, 160, 40);
  fill(0);
  text(catAgeList.get(currentButtonChoice), 150, 245);
  text(catWeightList.get(currentButtonChoice), 150, 185);
  text(catFoodQtyList.get(currentButtonChoice), 135, 415);
  //rect(170, 20, 130, 40);
  //Name of the cat
  textSize(40);
  fill(255);
  text(catNameList.get(currentButtonChoice), 250, 45);
}