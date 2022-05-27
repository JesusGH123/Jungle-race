void finalscreen(){
    background(0);
    textSize(100);
    text("You lose", 275, 200);
    text("Your score: "+scorec, 100, 400);                  //Pantalla que aparece despues de morir
    textSize(50);                                           //Mostrar score
    text("Mouse click to play again ", 200, 600);
    if (mousePressed){                                      //Reinicio de variables
      level=0;
      scorec=0; 
      healthEnemy=6;  
      inmunity=0;
      inmunityEnemy=0; 
      speedboss=1; 
      healthEnemyX=850;                                    
      balaPegadaEnemy=true;
      BossAppear=true;
      balaPegada=true;
      moveBala=false;
      Escudo=false;
      Damage=true;
      DisparoX=110;
      DisparoY=500;
      muestraEnemigo=20000;
      x=20; 
      y=500; 
      xf=0; 
      xf2=799; 
      speed=1; 
      xobs1=1500; 
      xobs2=2300; 
      yobs1=500; 
      yobs2=600; 
      xboss=1181; 
      yboss=360;
      health=3;
      enemyBulletX=360;
      enemyBulletY=0;
    } 
}
