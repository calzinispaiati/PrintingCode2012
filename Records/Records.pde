import geomerative.*;

//setup Canvas
//---------------------------------------
PGraphics canvas;
int canvas_width = 4200;
int canvas_height = 2100;

//Colors---------------------------------
color color1, color2, color3, color4;
color[] colors = {
  0, 0, 0
};

//Fonts-----------------------------------
PFont font2;
RPoint[] pnts1;
RPoint[] pnts2;

//Particles-------------------------------

ArrayList<Particle> particles = new ArrayList();
ArrayList<PVector> points = new ArrayList();
ArrayList<Square> squares = new ArrayList();


//Positions------------------------------

PVector track1, track2, track3;

boolean seek;

void setup() 
{
  //Setup Window------------------------------
  size(1280, 800, P3D);

  smooth();
  seek = true;

  //Setup Colors--------------------------------
  colorMode(HSB, 360, 100, 100);

  float h = random(0, 360);
  float s = random(50, 100);
  float b = random(50, 100);

  color1 = color(h+60, s, b);
  color2 = color((h-60)%360, s, b);
  color3 = color((h)%360, s, b);
  color4 = color((h+180)%360, s, b);

  colors[0] = color1;
  colors[1] = color2;
  colors[2] = color3;



  //Setup Fonts-----------------------------------------
  font2 = createFont("Audiowide-Regular.ttf", 50);

  int fontSize = 400;
  RG.init(this);
  RFont font = new RFont("Audiowide-Regular.ttf", fontSize, RFont.LEFT);
  // tell library we want 11px between each point on the font path
  RCommand.setSegmentLength(25);


  RGroup grp1;
  grp1 = font.toGroup("CLINTON");
  grp1 = grp1.toPolygonGroup();
  pnts1 = grp1.getPoints();


  RGroup grp2;
  grp2 = font.toGroup("GORE");
  grp2 = grp2.toPolygonGroup();
  pnts2 = grp2.getPoints();

  //Create canvas-------------------------------------------
  canvas = createGraphics(canvas_width, canvas_height, P3D);  

  //canvas.beginDraw(); 


  //Particles
  for (int i=0; i<2000; i++) {

    Particle particle = new Particle(new PVector(random(2100, 4200), int(random(0, canvas_height))), 5.0, 0.7, colors[2]); 
    particles.add(particle);
  }

  //Points

  for (int i = 0; i < pnts1.length; i++ ) 
  {
    points.add(new PVector(canvas_width/2+50+pnts1[i].x, 700+pnts1[i].y));
  }

  for (int i = 0; i < pnts2.length; i++ ) 
  {
    points.add(new PVector(canvas_width/2+350+pnts2[i].x, 1400+pnts2[i].y));
  }



  

  //Squares
  //----------------------------------------------------
/*
  for (int i=0; i < 250; i++) {

    Square square = new Square(new PVector(random(0, canvas_width/2-200), random(0, canvas_height)), colors[int(random(0, 3))], new PVector(random(0, 200), random(0, 200)));
    squares.add(square);
  }
*/



  //Liner notes positions

  track1 = new PVector(int(random(0, 800)), int(random(50, canvas_height/3-200)));
  track2 = new PVector(int(random(0, 800)), int(random(canvas_height/3, 2*canvas_height/3-200)));
  track3 = new PVector(int(random(0, 800)), int(random(2*canvas_height/3, canvas_height-200)));


 canvas.beginDraw();
}



void draw() {

 

  background(150);

 

  canvas.textFont(font2, 60);
  canvas.background(color4);




  //Squares
  /*
  for (int i=0; i < squares.size(); i++) {

    Square s = squares.get(i); 
    s.display();
  }
  */


  //Main title----------------------------------------------



  for (int i=0; i < points.size(); i++) {

    PVector pnt = points.get(i);
    Particle p = particles.get(i);
    //if (p.loc.x > pnt.x-100 && p.loc.x < pnt.x+100 && p.loc.y > pnt.y-100 && p.loc.y < pnt.y+100) {
   
    if(seek){
    p.arrive(pnt);
    p.run();
    }

   else {

    p.wander();
    p.run();

    }
  } 
  
  for(int i=691; i < particles.size(); i++){
   Particle p = particles.get(i);
  p.wander();
 p.run(); 
  }


  //Liner Notes----------------------------------------------
  canvas.stroke(0);
  canvas.strokeWeight(5);


  //Track 1
  canvas.pushMatrix();
  canvas.translate(track1.x, track1.y);
  canvas.fill(colors[2]);
  canvas.text("SIDE A - I NEED A STAR", 0, 0);
  canvas.text("DRUMS & SYNTH - CHRIS CRAWFORD", 0, 50);
  canvas.text("GUITARS - ROLAND CURTIS", 0, 100);
  canvas.text("VOX - SIERRA FROST", 0, 150);
  canvas.popMatrix();


  //Track 2  
  canvas.pushMatrix();
  canvas.translate(track2.x, track2.y);
  canvas.fill(colors[2]);
  canvas.text("SIDE B - YOU'RE SO BAD", 0, 0);
  canvas.text("ORIGINAL SONG BY TOM PETTY", 0, 50);
  canvas.text("DRUMS & SYNTH - CHRIS CRAWFORD", 0, 100);
  canvas.text("VOX - SIERRA FROST", 0, 150);
  canvas.popMatrix();




  //Credits
  canvas.pushMatrix();
  canvas.translate(track3.x, track3.y);
  canvas.fill(colors[2]);
  canvas.text("RECORDED AND MIXED AT", 0, 0);
  canvas.text("DEATH BY AUDIO", 0, 50);
  canvas.text("BROOKLYN, NY", 0, 100);
  canvas.popMatrix();


  //Fold along this line
  canvas.stroke(10);
  canvas.line(canvas.width/2, 0, canvas.width/2, canvas.height);

  canvas.endDraw();


  //Display image
  image(canvas, 0, 0, canvas.width*0.3, canvas.height*0.3);


}


void keyPressed()
{
  switch(key) {

  case 's':  
    println("Saving Image");
    canvas.save("clintongore" + year() + "_" + month()+ "_" + day() + "_" + hour() + "_" + minute() + "_" + second() + ".tiff");
    println("Saved Image");
    break;

  case 'c':
    float h = random(0, 360);
    float s = random(50, 100);
    float b = random(50, 100);

    color1 = color(h+60, s, b);
    color2 = color((h-60)%360, s, b);
    color3 = color((h)%360, s, b);
    color4 = color((h+180)%360, s, b);

    colors[0] = color1;
    colors[1] = color2;
    colors[2] = color3;
    
    for(int i=0; i< particles.size(); i++){
      
     Particle p = particles.get(i);
    p.col = color3; 
    }
    
    break;
    
   case 'p':
   
   seek = !seek;
   
   break;
    
  case 't':
    
  track1 = new PVector(int(random(0, 800)), int(random(50, canvas.height/3-200)));
  track2 = new PVector(int(random(0, 800)), int(random(canvas.height/3, 2*canvas.height/3-200)));
  track3 = new PVector(int(random(0, 800)), int(random(2*canvas.height/3, canvas.height-200)));
  break;  

}
}








