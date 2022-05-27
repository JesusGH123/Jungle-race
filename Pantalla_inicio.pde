PFont letters;
PImage menu;
float alpha=0;

void principal(){
    tint(abs(sin(alpha))*255);
    image(menu, 0, 0, width, height);
    alpha=alpha+0.05;
    noTint();
    fill(255);
    textFont(letters, 170);
    text("Jungle race", 110, 160);
    image(running[frame%11], x, y, 200, 220);
    if(keyPressed){ 
    if(key=='P' || key=='p') level=1;
    }
}
