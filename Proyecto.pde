import processing.sound.*;

SoundFile music;
PImage running[]= new PImage[12];
PImage boss[]= new PImage[7];
PImage background1, background2, heart, heartEnemy, box, bala, bala1, precaucion, escudo, botiquin;
int frame, scorec=0, health=3, healthEnemy=6, level=0, inmunity=0, inmunityEnemy=0, inmunityEscudo=0, speedboss=1, healthEnemyX=850, muestraEnemigo=20000;
float x=20, y=500, xf=0, xf2=799, speed=1, xobs1=1500, xobs2=2300, yobs1=500, yobs2=600, xboss=1181, yboss=360, escudoX=1100, escudoY=500, enemyBulletX=360, enemyBulletY=0, DisparoX=110, DisparoY=500;
boolean teclas[];
boolean balaPegadaEnemy=true, BossAppear=true, balaPegada=true, moveBala=false, Escudo=false, Damage=true;

void setup() {
  size(1080, 720, P2D);
  if (level==0) {
    music= new SoundFile(this, "song.mp3");
    music.play();
    music.loop();
  }

  for (int i=0; i<11; i++) running[i]=loadImage("0_Golem_Running_"+i+".png");    //Carga de imágenes y personajes
  for (int i=0; i<7; i++) boss[i]=loadImage("RUN_00"+i+".png");
  background1=loadImage("NarutoForest.jpg"); background2=loadImage("NarutoForest.jpg"); heart=loadImage("heart.png"); heartEnemy=loadImage("heart.png"); box=loadImage("box.png");
  menu=loadImage("Screen.jpg"); bala=loadImage("bala.png"); bala1=loadImage("bala1.png"); precaucion=loadImage("precaucion.png"); escudo=loadImage("escudo.png"); botiquin=loadImage("botiquin.png");
  letters=loadFont("Cambria-Bold-48.vlw");
  teclas=new boolean[255];
}

void draw() {
  frame=millis()/60;                                   //Timer

  if (level==0) principal();                           //Start screen
  if (level==-1) finalscreen();                        //Final screen
  if (level==1) {
    image(background1, xf, 0, 1100, height);          //Draw the sprites
    image(background2, xf2, 0, 1100, height);
    image(heart, 110, 20, 33, 30);
    image(box, xobs1, yobs1, 50, 50);
    image(box, xobs2, yobs2, 50, 50);
    image(bala1, DisparoX, DisparoY, 30, 30);

    xf=xf-speed;                                     //Background move
    xf2=xf2-speed;                          
    if (xf<-20) xf2=xf+1080;
    if (xf2<-20) xf=xf2+1080;

    if (xobs1<-30) {                                //Obstacle generation
      xobs1=xobs1+random(1080, 2000);
      yobs1=random(440, 650);
    }
    xobs1=xobs1-speed;
    if (xobs2<-30) {
      xobs2=xobs2+random(1080, 2000);
      yobs2=random(440, 650);
    }
    xobs2=xobs2-speed;

    textSize(20);                                        //Game constants
    text("Score: "+scorec, 20, 20);                      //Score
    text("Health: "+health, 20, 40);                     //Character life
    text("FPS: "+frameRate, 1010, 20);                   //Frame counter
                                      
      if (((dist(x+120, y+180, xobs1, yobs1+50)<40) && millis()>=inmunity || (dist(x+120, y+180, xobs2, yobs2+50)<40) && millis()>=inmunity || (dist(x+120, y+180, enemyBulletX, enemyBulletY+80)<40) && millis()>=inmunity) && Damage==true) {  //Daño con cajas
        health=health-1;
        inmunity=millis()+2000;
        Escudo=false;
      }
                                         
      if (((dist(xboss+120, yboss+180, DisparoX, DisparoY+50)<40) && millis()>=inmunityEnemy)) {   //Enemy damage and player damage
        healthEnemy=healthEnemy-1;                       
        inmunityEnemy=millis()+1000;
      }

      if ((dist(x+120, y+180, escudoX, escudoY+50)<40) && millis()>=inmunityEscudo) {    //Shield
        inmunityEscudo=millis()+9000;
        Escudo=true;  Damage=false;  escudoY=-100;
      }

    if (balaPegada==true) {     //If the bullet is in the player
      DisparoY=y+100; DisparoX=x+100;
    }
    
    if (keyPressed && key==' ') {      // Spacebar action
      moveBala=true; balaPegada=false;
    }

    if (moveBala==true) {          //Move bullet
      DisparoX=DisparoX+10;
    }

    if (DisparoX>1080) {
      DisparoX=0;                  //If the bullet reaches the end of the screen if returns to the player
      DisparoY=y+100;DisparoX=x+100;
      balaPegada=true;  moveBala=false;
    }

    if (health>0) {
      if (Damage && millis()<inmunity) tint(255, 0, 0);    // Damage color
      if (Escudo && millis()<inmunityEscudo) tint(3, 67, 255); 
      if (Escudo && millis()>inmunityEscudo){        //Shield timer ends
          Escudo=false;
          Damage=true;
        }
      image(running[frame%11], x, y, 200, 220);       //Character animation
      noTint();
    } else {                                                //Character dead
      speed=0; level=-1;
    }

    if (scorec>1000 && millis()>muestraEnemigo) {     //Boss behaviour
      if (millis()>muestraEnemigo+ 20000) {
        image(escudo, escudoX, escudoY, 50, 50);      //Shields generation
        escudoX=escudoX-(speed*1.1);
      }

      textSize(20);
      text("Health Enemy: "+healthEnemy, healthEnemyX, 40);
      image(heartEnemy, 1005, 19, 33, 30);                         //Boss life

      if (healthEnemy>0) {
        if (millis()<inmunityEnemy) tint(255, 0, 0);         //Damage tint
        image(boss[frame%6], xboss, yboss, 380, 320);      //Boss animation
        noTint();
      }
      
      if (balaPegadaEnemy==true) {
      enemyBulletX=xboss+90; 
      enemyBulletY=yboss+190;
      }

      if (BossAppear){                             //Boss appearance
        balaPegadaEnemy=true; 
        if(xboss>750){
          xboss-=1;
          textSize(50);
          text("The Boss is coming...", 275, 120);
          tint(abs(sin(alpha))*255);
          image(precaucion, 455, 150, 100, 100);    //Caution image
          alpha=alpha+0.1;
          noTint();
          }
        if(xboss<=750) yboss+=speedboss;
        if(yboss + 60 > y) speedboss= -1;
        if(yboss + 60 < y) speedboss= 1;
      }

      if (xboss<=750){
        image(bala, enemyBulletX, enemyBulletY, 50, 50);
        balaPegadaEnemy=false;
        enemyBulletX=enemyBulletX-(speed*2);   //Enemy bullet speed

        if (enemyBulletX<=0) {        //Return the bullet to the boss position
          balaPegadaEnemy=true;
        }
      }
    }                                  

    if (healthEnemy<=0) {        //  Boss death
      muestraEnemigo=millis()+16000; 
      enemyBulletX=360; xboss=1181; healthEnemy=6;                     //Restart game variables
      escudoY=random(440, 650); escudoX=random(1110, 1800);
      balaPegadaEnemy=true; BossAppear=true;
    }
    speed=speed+0.001;                                        //Acceleration
    scorec=scorec+int(speed-1);                               //Score increment
  }

  if (keyPressed) {                                            //Character movement
    if (teclas['W'] || teclas['w'] && y>320) y-=4;
    if (teclas['S'] || teclas['s'] && y<516) y+=4;
  }
}

void keyPressed() {
  if (key!=CODED) {
    teclas[key]=true;
  }
}

void keyReleased() {
  if (key!=CODED) {
    teclas[key]=false;
  }
}
