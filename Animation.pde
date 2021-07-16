class Animation {
  PImage[] images;
  int imageCount;
  int frame;

  Animation(String imagePrefix, int count) { // recibe el prefijo y la cantidad de imagenes
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 5) + ".png"; // el numero 5 significa cuantos numeros tiene la imagen ej : "Calor1_A_Frio1_00010.png"
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) { // para mostrarla
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
    
  }
}

