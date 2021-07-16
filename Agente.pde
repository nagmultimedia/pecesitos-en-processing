int porcentajeDeDepredadores = 4 ;
int porcentajeDeVegetacion = 99 ; 
int porcentajeDePresas = 15 ;
float distanciaDePercepcion = 100 ;
int distanciaDePercepcionDepredadores = 70 ;
float distanciaDeContacto = 20 ;
float t = 20/3;

int reproduccionAlgas = 300;

int reproduccionPresa = 13500;

int reproduccionDepredador = 13600;


float energiaInicialDepredador = 600 ;
float energiaInicialPresa = 1000 ;
float decrementoEnergia = 0.25 ;
int energiaPorComer = 30 ;
float aumentoDeTamanioPorComer = 0.03;


PImage  depredador_muerto;

//-----------------------MMM crecer

float valueToScale = 0.5 ;
float aumentoTamanio = 0.00002 ;
//------------------------



boolean vivo ;

int contMuertoDepredador;

class Agente {

  float x, y;
  float vel, dir;

  float variacionAngular = radians(1);



  float nuevaDireccion;

  int turno;

  String especie ; 
  boolean vivo ;

  int distanciaMinimaDepredador; // distancia minima del borde de la pecera
  int distanciaMinimaPresa ;

  boolean escondido = false ;
  float energia ;
  float valor ;


  //--------------------------------------

  Agente() { // inicializa al agente

      String esteEspecie = "";
    if (random(100) <= porcentajeDeDepredadores) {
      esteEspecie = "depredador";
      energia = energiaInicialDepredador;
      valor = valueToScale ;
    } else if (random(100) > porcentajeDePresas ) { 
      esteEspecie = "vegetacion" ;
      energia=100000000; //pseudo infinita xD
    } else {
      esteEspecie = "presa" ;
      energia = energiaInicialPresa;
      valor = valueToScale ;
    }




    iniciar( random( t*2, width-t*2), random( t*2, height-t*2 ), random( TWO_PI ), esteEspecie);
  }
  //--------------------------------------
  Agente(String esteEspecie) {

    iniciar( random( distanciaMinimaPresa*2, width-t*2), random( t*2, height-t*2 ), random( TWO_PI ), esteEspecie);
  }

  //---- llama al iniciar siguiente 
  void iniciar( float x_, float y_, float direccion, String especie_ ) {
    x = x_;
    y = y_;
    vel = random( 0.5, 1.5 );

    dir = direccion ;
    nuevaDireccion = dir;

    distanciaMinimaDepredador = 100 ;
    distanciaMinimaPresa = 20 ;

    vivo = true ;

    especie = especie_;
    if (especie.equals("depredador")) {
      energia = energiaInicialDepredador ;
      valor = valueToScale;
    } else if (especie.equals("presa"))
    {
      energia = energiaInicialPresa;
      valor=valueToScale;
    }

    if (especie.equals("vegetacion"))
    {
      vel = 0;
    }
  }  
  //--------------------------------------

  void dibujar() {
    //----------------------------------dibujar si estan vivos
    if ( vivo == true ) 
    {
      if (especie.equals("vegetacion"))

      {
        // vegetacion esta escondida dentro de cueva , no se ve ni la linea ni el relleno, 
        if (x > ecosistema.x2 && y > ecosistema.y2 || ecosistema.x-t/2 <= x && 
          ecosistema.x+200+t/2 >= x && ecosistema.y-t/2 <= y && ecosistema.y+100+t/2 >= y)
        { 
          noStroke();
          noFill();
        } else {

          //fill(123, 193, 96);
          //ellipse( x, y, t, t );

          pushMatrix();
          translate(x, y);
          rotate(dir+PI);
          image (plantasImg, 0, 0);
          popMatrix();
        }
      }
      if (especie.equals("depredador"))
      {
        if (escondido) {// especie depredador esta escondido no se ve 
          pushMatrix();
          translate(x, y);
          rotate(dir+PI);
          scale(valor);
          

          //image (depredador, 0, 0); // comentar para ocultar
          popMatrix();
        } else {

          pushMatrix();
          translate(x, y);
          rotate(dir+PI);
          scale(valor);
          
          image (depredador, 0, 0);
          popMatrix();
        }
      }      
      if (especie.equals("presa"))
      {
        if (escondido) { // especie presa esta escondida no se ve 
          pushMatrix();
          translate(x, y);
          rotate(dir+PI);
          scale(valor);
          
          //image (pez, 0, 0); //cometar para ocultar
          popMatrix();
        } else if (!escondido) {
          //stroke(1);
          //fill(69, 83, 196);
          pushMatrix();
          translate(x, y);
          rotate(dir+PI);
          scale(valor);
          
          image (pez, 0, 0);
          popMatrix();
        }
      }
    } 
    /*  else if (vivo == false && especie.equals("depredador")) {
     
     if (contMuertoDepredador <=5) // Si el contador es menor a 50 y "aprete la tecla a" , corre la animacion 
     {
     pushMatrix();
     translate(x, y);
     rotate(dir+PI);
     scale(valor);
     animation4.display(x, y);
     popMatrix();
     contMuertoDepredador ++;
     } 
     else if (contMuertoDepredador > 5 && contMuertoDepredador <=50) {
     contMuertoDepredador ++;
     pushMatrix();
     translate(x, y);
     rotate(dir+PI);
     scale(valor);
     image (depredador_muerto, contMuerto, 0);
     popMatrix();
     
     
     }
     }*/
  }

  //---------------------------------------------

  //--------------------------------------

  void mover() {

    if ( vivo ) {

      energia -= decrementoEnergia;

      valor += aumentoTamanio ;




      if (energia < 0)
      {
        morir() ;
        contMuertoDepredador = 0;
      }
      if (valor>1) {
        valor=1;
      }


      if (especie == "depredador") { // para que se escondan (moviendo escondidos)

        if (x>=width-distanciaMinimaDepredador || x<=distanciaMinimaDepredador ||
          y>=height-distanciaMinimaDepredador || y<=distanciaMinimaDepredador )
        {
          esconder (ecosistema.x3, ecosistema.y2) ; // 150 y 200
        }
      }     

      if (especie == "presa" ) {// para que se escondan (moviendo escondidos)


        if (x>=width-distanciaMinimaPresa || x<=distanciaMinimaPresa ||
          y>=height-distanciaMinimaPresa || y<=distanciaMinimaPresa )
        {
          esconder(ecosistema.x, ecosistema.y);
        }
      }

      float diferencia = menorDistAngulos( dir, nuevaDireccion );
      float f = 0.5;

      dir += diferencia * f;
      dir += random( -variacionAngular, variacionAngular );

      float dx = vel * cos( dir );
      float dy = vel * sin( dir );

      x += dx;
      y += dy;
    }
  }

  //--------------------------------------




  void reproduccion () {

    reproduccionAlgas -- ;

    if (reproduccionAlgas==0)
    {
      for ( int i=a.size ()-1; i>=0; i-- )
      {
        a.add ( new Agente ("vegetacion") );
      }

      reproduccionAlgas = 300;
    }
  }

  //--------------------------------------

  void esconderDetras ( Agente otro)
  {
    if (especie == "presa") {
      if (ecosistema.x-t/4 <= otro.x && ecosistema.x+200+t/4 >= otro.x &&
        ecosistema.y-t/4 <= otro.y && ecosistema.y+100+t/4 >= otro.y)
      {

        escondido = true ;
      } else {
        escondido=false;
      }
    }
    if (especie == "depredador") {
      if (ecosistema.x2-t/2 <= otro.x && ecosistema.x2+200+t/2 >= otro.x &&
        ecosistema.y2-t/2 <= otro.y && ecosistema.y2+200+t/2 >= otro.y)
      {
        escondido = true ;
      } else {
        escondido=false;
      }
    }
  }
  void esconder ( float xE, float yE )
  {
    float angulo = atan2 (yE - y, xE - x ) ;
    nuevaDireccion = angulo ;
  }

  void perseguir (Agente otro ) 
  {
    perseguir (otro.x, otro.y) ;
  }

  void perseguir (float xt, float yt) {
    float angulo = atan2 (yt - y, xt - x ) ;
    nuevaDireccion = angulo ;
  }
  void huir(Agente otro ) 
  {
    huir(otro.x, otro.y);
  }

  void huir (float xt, float yt) {

    float angulo = atan2 (yt - y, xt - x ) ;
    nuevaDireccion = angulo + PI ;
  }

  void esquivar(Agente otro) {
    float angulo = atan2 (otro.y - y, otro.x - x ) ;
    nuevaDireccion = angulo + HALF_PI  ;
  }

  void comer (Agente otro) {
    otro.morir() ;
    energia += energiaPorComer ;
    valor += aumentoDeTamanioPorComer ;
  }

  void morir() {
    vivo = false ;
  } 





  //-----------------------------------------------------




  void morirAgentesCarnivoros(Agente elFuturoCadaver) 
  {

    if (especie=="depredador")
    {
      vivo = false ;
      morir() ;
      contMuertoDepredador = 0;
    }
  }



  void morirAgentesPresas(Agente elFuturoCadaver) 
  {

    if (especie=="presa")
    {
      vivo = false ;
      morir() ;
    }
  }





  //-----------------------------------------------------

  void moverLugar(Agente alga) {
    alga.x=int (random(40, width-40));
    alga.y=int(random(40, height-40));
  }

  //----------------------------------------------------


  void vincular(Agente otro) {
    if (vivo && otro.vivo ) {
      float distancia = dist ( x, y, otro.x, otro.y ) ;

      if (distancia <= distanciaDeContacto)
      {     
        if (especie.equals("presa"))
        {  
          if (otro.especie.equals("presa"))
          {
            //presa yo y presa el otro
            esquivar ( otro ) ;
          } else if (otro.especie.equals("vegetacion"))
          {
            //presa yo vegetacion el otro
            moverLugar ( otro ) ;
            energia += energiaPorComer;
            valor+=aumentoDeTamanioPorComer ;
          } else if (otro.especie.equals("depredador"))
          {
            //presa yo depredador el otro
            huir ( otro ) ;
          }
        } else if (especie.equals("depredador"))
        {
          if (otro.especie.equals("presa")) {
            //depredador yo presa el otro
            comer ( otro ) ;
          } else if (otro.especie.equals("vegetacion"))
          {
            //depredador yo vegetacion el otro
            //esquivar (otro ) ;
          } else if (otro.especie.equals("depredador"))
          {
            //depredador yo depredador el otro
            esquivar (otro ) ;
          }
        }
      } else if (distancia <= distanciaDePercepcion) {
        if (especie.equals("presa"))
        {  
          esconderDetras(this) ;
          if (otro.especie.equals("presa"))
          {
            //presa yo presa el otro
          } else if (otro.especie.equals("depredador"))
          {
            //presa yo depredador el otro
            huir(otro);
          } else if (otro.especie.equals("vegetacion"))
          {
            //presa yo vegetacion el otro
            perseguir(otro);
          }
        } else if (especie.equals("depredador"))
        {
          if (distancia<=distanciaDePercepcionDepredadores)
          {
            esconderDetras(this) ;
            if (otro.especie.equals("presa"))
            {
              //depredador yo presa el otro
              perseguir ( otro ) ;
            } else if (otro.especie.equals("depredador"))
            {
              //depredador yo depredador el otro
            }
          }
        }
      }
    }
  }
}

