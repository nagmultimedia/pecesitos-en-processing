class Ecosistema {

  int x, y, diametro ; //cajita para esconderse Presas
  int x2, y2 ; // cajita para esconderse Depredadores
  int x3 ; // un punto intermedio dentro de la cueva para que vayan los depredadores
  int y3 ;
  Ecosistema () {


    x = 690 ;
    y = 300 ;
    diametro = 100 ;

    x2 = 0 ;
    y2 = 370 ;
    y3 = 360;
    x3 = 350;
  }
  void dibujar() { 
    fill (108, 188, 183);
    //rect(x, y, diametro*2, diametro);
    fill (142, 110, 84);
   // rect(x2, y2, diametro*2, diametro*2);
  }

  void cajaPresas() { 
    fill (108, 188, 183);
    rect(x, y, diametro*2, diametro);
  }
  void cajaDepredadores()
  {
    fill (142, 110, 84);
    rect(x3, y3, diametro*2, diametro*2);
  }




  /*  int cantidadOrganismos = 100 ;
   
   void nacer_Organismo( String especie, float x, float y) {
   
   for (int i=0;i<cantOrganismos;i++) {
   //se recorre cada animal y :
   
   if ( ! a[i].vive() ) {
   //solo si esta muerto lo
   // usa para nacer uno nuevo
   
   a[i].nacer( especie, x, y ); //dibuja cada animal
   break;
   }
   }
   }
   */
}

