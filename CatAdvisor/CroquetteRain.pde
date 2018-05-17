class Croquette { // l'objectif de cette classe est de mettre la même image à des positions diférentes
  PImage croqRain;
  PVector croqPos;  // crée un vecteur : un point dans l'espace 
  PVector croqSpeed;
  PVector croqAcc;
  int tailleImgCroq;

  Croquette() {
    croqRain = loadImage("data/picture/croqRain.png"); //Charger image Croq 
    croqPos = new PVector(random(width), random(-200, -25));     //déclare la postion de l'image(vecteur) au début 
    croqSpeed = new PVector(0, 1);                            // déclare au début une vitesse de 1 pixel par frame 
    croqAcc = new PVector(0, random(0.005, 0.05));              // déclare une accélération en Y différente pour chaque croquette
    tailleImgCroq = 15;//Taille de l'image croquette
  }


  void move() {   // fonction qui permt de déplacer les objets dans l'image
    croqPos.add(croqSpeed);  // vient ajouter au vecteur  position une vitesse
    croqSpeed.add(croqAcc);    // vient ajouter au vecteur vitesse une acceleration 
  }

  void display() {  // afficher 
    image(croqRain, croqPos.x, croqPos.y, tailleImgCroq, tailleImgCroq); // l'image hérite des coordonéees des vecteurs
  }
}