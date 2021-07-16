import processing.video.*;
ArrayList <Agente> a;
Ecosistema ecosistema ;
Capture video;
Animation animation1, animation2, animation3, animation4, animation5;


int contadorNuevos;
int calibracion; // es el modulo. Cuanto mayor es el numero, más despacio agrega peces con respecto a tarjetas
int cantidad;
int ancho = 320;
int alto = 240;
int contA;
int contD;
int contS;
int contAf;

int contMuerto;

color trackR, trackB, trackG; 
color trackC, trackM, trackK; 

Boolean hayRojo=false;
Boolean hayAzul=false;
Boolean hayVerde=false;
boolean aguasTurbias_ = false;
boolean tempBaja_ =  false;
boolean tempAlta_ = false;
boolean depredadores_ = false;
boolean carnivoros_ = false;
boolean presas_ =  false;
boolean vegetacion_ = false;
Boolean valueA = false;
Boolean valueD = false;
Boolean valueS = false;
boolean valueAf = false;


PImage pez;
PImage depredador;
PImage fondo;
PImage Calor2_A_Turbio1_;
PImage Calor1_A_Frio1_;
PImage Calor1_A_Calor2_;
PImage Frio_y_Turbio_;
PImage plantasImg ;

import ddf.minim.*;
Minim minim;
AudioPlayer player;


void setup() {

  size(ancho*3 + 30, alto*3-40);  
  smooth();  

  video = new Capture(this, ancho, alto);
  video.start();

  trackR = #D6361C;
  trackB = #7CE3FE;
  trackG = #087C43;

  trackC = #FF9FDE; //turbio
  trackM = #FFF200; //sol
  trackK = #2966D6; //frio

  frameRate(30) ;
  cantidad  = 100;


  //inicializo el arreglo dandole dimension
  a = new ArrayList <Agente> (); // [ cantidad ];
  for ( int i=0; i<cantidad; i++ ) {
    //a[i] = new ArrayList  <Agente>();
    a.add(new Agente());
  }

  ecosistema = new Ecosistema () ;

  pez =  loadImage ("pes1.png") ;
  depredador =  loadImage ("depredador2.png");
  fondo = loadImage("Calor1_A_Calor2_00000.png");
  plantasImg = loadImage ("planta.png");
  Calor2_A_Turbio1_ = loadImage("Calor1_A_Turbio1_00023.png");
  Calor1_A_Frio1_ = loadImage("Calor1_A_Frio1_00023.png");
  Calor1_A_Calor2_ = loadImage("Calor1_A_Calor2_00009.png");
  Frio_y_Turbio_ = loadImage ("Frio_Y_Turbio_00023.png");



  imageMode(CENTER);
  int contadorNuevos = 0;

  contA = 0;
  contD = 0;
  contS = 0;
  contAf = 0;

  animation1 = new Animation("Calor1_A_Turbio1_", 23); //Le pongo el prefijo del nombre las imagenes, y le digo cuantas quiero cargar.
  animation2 = new Animation("Calor1_A_Frio1_", 23); //Le pongo el prefijo del nombre las imagenes, y le digo cuantas quiero cargar.
  animation3 = new Animation("Calor1_A_Calor2_", 10); //Le pongo el prefijo del nombre las imagenes, y le digo cuantas quiero cargar.
  animation5 = new Animation("Frio_Y_Turbio_", 23); //Le pongo el prefijo del nombre las imagenes, y le digo cuantas quiero cargar.
  animation4 = new Animation("depredador_muerto", 16); //Le pongo el prefijo del nombre las imagenes, y le digo cuantas quiero cargar.
  depredador_muerto = loadImage("depredador_muerto00016.png");

  minim = new Minim(this);
  player = minim.loadFile("agua1.mp3");

  contMuerto = 0;
}//<----FIN DEL SETUP

//---------------------------------------

void captureEvent(Capture video) {
  video.read();
} 

//--------------------------------------- 

void draw() {

  contMuerto --;


  if ( !player.isPlaying()) {
    player.pause();
    player.rewind();
  }

  player.play();

  //  video.loadPixels();

  float worldR = 500; //rojo
  float worldG = 500; //azul
  float worldB = 500; //verde

  float worldC = 500; //amarillo
  float worldM = 500; //violeta
  float worldK = 500; //marrón

  int rX = 0;
  int rY = 0;

  int bX = 0;
  int bY = 0;

  int gX = 0;
  int gY = 0;

  int cX = 0;
  int cY = 0;

  int mX = 0;
  int mY = 0;

  int kX = 0;
  int kY = 0;

  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;

      color currentR = video.pixels[loc];
      float rR1 = red(currentR);
      float gR1 = green(currentR);
      float bR1 = blue(currentR);
      float rR2 = red(trackR);
      float gR2 = green(trackR);
      float bR2 = blue(trackR);

      color currentB = video.pixels[loc];
      float rB1 = red(currentB);
      float gB1 = green(currentB);
      float bB1 = blue(currentB);
      float rB2 = red(trackB);
      float gB2 = green(trackB);
      float bB2 = blue(trackB);

      color currentG = video.pixels[loc];
      float rG1 = red(currentG);
      float gG1 = green(currentG);
      float bG1 = blue(currentG);
      float rG2 = red(trackG);
      float gG2 = green(trackG);
      float bG2 = blue(trackG);

      color currentC = video.pixels[loc];
      float rC1 = red(currentC);
      float gC1 = green(currentC);
      float bC1 = blue(currentC);
      float rC2 = red(trackC);
      float gC2 = green(trackC);
      float bC2 = blue(trackC);

      color currentM = video.pixels[loc];
      float rM1 = red(currentM);
      float gM1 = green(currentM);
      float bM1 = blue(currentM);
      float rM2 = red(trackM);
      float gM2 = green(trackM);
      float bM2 = blue(trackM);

      color currentK = video.pixels[loc];
      float rK1 = red(currentK);
      float gK1 = green(currentK);
      float bK1 = blue(currentK);
      float rK2 = red(trackK);
      float gK2 = green(trackK);
      float bK2 = blue(trackK);


      float dR = dist(rR1, gR1, bR1, rR2, gR2, bR2); 
      float dB = dist(rB1, gB1, bB1, rB2, gB2, bB2); 
      float dG = dist(rG1, gG1, bG1, rG2, gG2, bG2); 

      float dC = dist(rC1, gC1, bC1, rC2, gC2, bC2);    
      float dM = dist(rM1, gM1, bM1, rM2, gM2, bM2); 
      float dK = dist(rK1, gK1, bK1, rK2, gK2, bK2);       


      // If current color is more similar to tracked color than
      // closest color, save current location and current difference
      if (dR < worldR) {
        worldR = dR;
        rX = x;
        rY = y;
      }

      if (dB < worldB) {
        worldB = dB;
        bX = x;
        bY = y;
      }

      if (dG < worldG) {
        worldG = dG;
        gX = x;
        gY = y;
      }

      if (dC < worldC) {
        worldC = dC;
        cX = x;
        cY = y;
      }

      if (dM < worldM) {
        worldM = dM;
        mX = x;
        mY = y;
      }

      if (dK < worldK) {
        worldK = dK;
        kX = x;
        kY = y;
      }
    }
  }

  //------------------------------

  if (worldR < 10) { 
    contMuertoDepredador = 0;
    depredadores_ = true;
    nuevoCarnivoro(depredadores_);
  } else {
    depredadores_=false;
  }

  //-------------------------------

  if (worldB < 10) { 
    presas_ = true;
    nuevaPresa (presas_);
  } else {
    presas_=false;
  }


  //--------------------------------
  /*
  if (worldG < 10) { 
   vegetacion_ = true;
   nuevaVegetacion(vegetacion_);
   } else {
   vegetacion_=false;
   }
   
   */
  //--------------------------------

  if (worldC < 10) { 
    valueA = true;
    valueS = false;
    valueD = false;
    valueAf = false;

    contS = 0;
    contD = 0;

    aguasTurbias_ = true;
    aguasTurbias (aguasTurbias_);

    for ( int i=a.size ()-1; i>=0; i-- ) {
      Agente aS = a.get(i);
      aS.morirAgentesCarnivoros(aS);
    }
  } 

  //--------------------------------

  if (worldM < 10) { 
    valueA = false;
    valueS = true;
    valueD = false;
    valueAf = false;

    contA = 0;
    contD = 0;

    tempAlta_ = true;
    tempAlta (tempAlta_);

    tempBaja_=false ;
    aguasTurbias_=false;
  } else {
    tempAlta_=false;
  }

  //--------------------------------

  if (worldK < 10) { 

    valueA = false;
    valueS = false;
    valueD = true;
    valueAf = false;

    contA = 0;
    contS = 0;

    tempBaja_ = true;
    tempBaja (tempBaja_);
  }

  //--------------------------------


  contadorNuevos ++ ;
  if (contadorNuevos>=1000000)
  {
    contadorNuevos=0;
  }


  pushStyle();
  fill(255);
  noStroke();
  rect(  0, 0, width, height );
  popStyle();

  image( fondo, width/2, height /2) ;  

  //----------------------

  if (contA <=5 && valueA == true && valueAf == false) // Si el contador es menor a 50 y "aprete la tecla a" , corre la animacion 
  {   

    animation1.display(width/2, height /2);
    contA ++;
  } else if (contA >5 && valueA == true && valueAf == false) {

    image( Calor2_A_Turbio1_, width/2, height /2) ;
  }

  //----------------------

  if (contD <=5 && valueD == true && valueAf == false) // Si el contador es menor a 50 y "aprete la tecla a" , corre la animacion 
  {   

    animation2.display(width/2, height /2);
    contD ++;
  } else if (contD >5 && valueD == true && valueAf == false) {

    image( Calor1_A_Frio1_, width/2, height /2) ;
  }

  //----------------------

  if (contS <=5 && valueS == true) // Si el contador es menor a 50 y "aprete la tecla a" , corre la animacion 
  {   
    animation3.display(width/2, height /2);
    contS ++;
  } else if (contS >5 && valueS == true ) {

    image( Calor1_A_Calor2_, width/2, height /2) ;
  }

  //----------------------

  if (contAf <=5 && valueAf == true) // Si el contador es menor a 50 y "aprete la tecla a" , corre la animacion 
  {   
    animation5.display(width/2, height /2);
    contAf ++;
  } else if (contAf >5 && valueAf == true) {

    image( Frio_y_Turbio_, width/2, height /2) ;
  }



  ecosistema.dibujar();

  for ( int i=a.size ()-1; i>=0; i-- ) {
    Agente aS = a.get(i);
    aS.dibujar();
    aS.mover();
    //a[i].reproduccion();
  }
  for ( int i=a.size ()-1; i>=0; i-- ) {
    for ( int j=a.size ()-1; j>=0; j-- ) {
      if ( i != j )
      {
        Agente aS = a.get(i);
        Agente aS1= a.get(j);
        aS.vincular(aS1);
      }
    }
  }
  //--------------------------ULTIMO ESTADO DE AGUA FRIA Y TURBIAAAAAA!!!!!!! <3!!
}

//--------------------------------------- 
/*
void keyPressed()
 {
 
 if (key == 'f')
 {
 contMuertoDepredador = 0;
 depredadores_ = true;
 nuevoCarnivoro(depredadores_);
 } else {
 depredadores_=false;
 }
 
 
 calibracion ++ ;
 if (key == 'g')
 {
 presas_ = true;
 nuevaPresa (presas_);
 } else {
 presas_=false;
 }
 
 
 
 if (key == 'a')
 {
 valueA = true;
 valueS = false;
 valueD = false;
 valueAf = false;
 
 contS = 0;
 contD = 0;
 
 aguasTurbias_ = true;
 aguasTurbias (aguasTurbias_);
 
 for ( int i=a.size ()-1; i>=0; i-- ) {
 Agente aS = a.get(i);
 aS.morirAgentesCarnivoros(aS);
 }
 } 
 
 
 
 if (key == 's')
 {
 valueA = false;
 valueS = true;
 valueD = false;
 valueAf = false;
 
 contA = 0;
 contD = 0;
 
 tempAlta_ = true;
 tempAlta (tempAlta_);
 
 tempBaja_=false ;
 aguasTurbias_=false;
 } else {
 tempAlta_=false;
 }
 
 
 
 if (key == 'd')
 {
 valueA = false;
 valueS = false;
 valueD = true;
 valueAf = false;
 
 contA = 0;
 contS = 0;
 
 tempBaja_ = true;
 tempBaja (tempBaja_);
 }
 }
 */
//------------------------------------------

void aguasTurbias (boolean aguasTurbias_) {

  if (aguasTurbias_ == true) {

    decrementoEnergia = 0.75;
    energiaInicialPresa = 800;
    energiaInicialDepredador = 300 ;   
    distanciaDePercepcion = 50 ; 

    pez =  loadImage ("pez1-Turbio.png") ;
    depredador =  loadImage ("depredador2-Turbio.png");
    plantasImg = loadImage ("planta-Turbio.png");



    /* NORMAL =  
     energiaInicialDepredador = 300 ;
     energiaInicialPresa = 1000;
     decrementoEnergia = 0.25 ;
     */
  }
  if (aguasTurbias_==true && tempBaja_==true)
  {    
    valueAf = true;
    for ( int i=a.size ()-1; i>=0; i-- ) {
      Agente aS = a.get(i);
      aS.morirAgentesPresas(aS);
    }
  }
}

//------------------------------------------

void tempAlta (boolean tempAlta_) {

  if (tempAlta_ == true) {
    energiaInicialDepredador = 450 ;
    energiaInicialPresa = 1200 ;
    decrementoEnergia = 0.25 ;

    distanciaDePercepcion = 100 ;
    pez =  loadImage ("pes1.png") ;
    depredador =  loadImage ("depredador2.png");
    plantasImg = loadImage ("planta.png");
  }
}

//------------------------------------------

void tempBaja (boolean tempBaja_) {

  if (tempBaja_ == true) {
    energiaInicialPresa = 1000 ;
    decrementoEnergia = 1.5 ;
    energiaInicialDepredador = 200 ;
    distanciaDePercepcion = 100 ;

    pez =  loadImage ("pez1-Frio.png") ;
    depredador =  loadImage ("depredador2-Frio.png");
    plantasImg = loadImage ("planta-Frio.png");
  }

  if (aguasTurbias_==true && tempBaja_==true)
  {    
    valueAf = true;
    // decrementoEnergia = 0.25 ; // elemento a cambiar
    // distanciaDePercepcion = 50 ;
    for ( int i=a.size ()-1; i>=0; i-- ) {
      Agente aS = a.get(i);
      aS.morirAgentesPresas(aS);
    }
  }
}

//------------------------------------------

void nuevoCarnivoro(boolean carnivoros_) {

  if (carnivoros_) {
    if (calibracion%3000==0)
    {

      for ( int i=0; i<1; i++ )
      {

        a.add(new Agente ("depredador"));
        depredadores_=false;
      }
    }
  }
}

//------------------------------------------

void nuevaPresa(boolean presas_) {
  if (presas_) {
    if (calibracion%3000==0)
    {

      for ( int i=0; i<1; i++ )
      {

        a.add(new Agente ("presa"));
        presas_=false;
      }
    }
  }
}

//------------------------------------------

void nuevaVegetacion(boolean vegetacion_) {
  if (vegetacion_) { 
    /*
    for ( int i=0; i<1; i++ )
     {
     a.add (new Agente ("vegetacion"));
     vegetacion_=false;
     }
     */
  }
}

