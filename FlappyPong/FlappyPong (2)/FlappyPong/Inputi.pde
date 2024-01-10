/********* INPUTI *********/

public void mousePressed() {
    // ako smo na početnom zaslonu ili na zaslonu s instrukcijama, nakon klika prebaci na zaslon za igru 1
    if (zaslon == 0 || zaslon == 3) {
      loptica1=new Loptica(100,300);      
      zaslon = 1;
    }
    
    // ako smo na zaslonu za kraj igre, postavi varijable na početno i ponovno pokreni igru 1
    else if (zaslon == 2){
      //Da bi pjesmica krenula ispočetka u novoj igri
      loptica_zvuk.pause();
      loptica_zvuk.rewind(); 
      
      rezultat = 0;
      zivot = maxZivot;
      loptica1=new Loptica(100,100);
      loptica2=new Loptica(100,500);      
      zadnjeVrijemeDodavanja = 0;
      zidovi.clear();
      zaslon = 1;
   }
}

void keyPressed() {
    if( key == 's' && zaslon == 1){
      looping=false;
      noLoop();
    }
    
    else if( key == 'x' && (zaslon == 1 || zaslon == 4 || zaslon == 5)){
      loptica1=new Loptica(100,300);      
      zaslon = 0;
    }
    
    else if( key == 'p' && looping == false && zaslon == 1){
      looping = true;
      loop();
    }
    // ako stisnemo pauzu u 2. ili 3. igri moramo ignorirati vrijeme koje prođe dok traje pauza
    else if( key == 's' && (zaslon == 4 || zaslon == 5)){
      looping=false;
      noLoop();
      meduvrijemePocetak = millis();
    }
    // vrijeme u pauzi ne zbrajamo u ukupno vrijeme tako da pomaknemo statVrijeme za taj iznos vremena
    else if( key == 'p' && looping == false && (zaslon == 4 || zaslon == 5)){
      if(zaslon == 4) startVrijeme += millis() - meduvrijemePocetak;
      else if(zaslon == 5) startVrijeme2 += millis() - meduvrijemePocetak; 
      looping = true;
      loop();
    }
    else if( key == 'i' && zaslon == 0){
      zaslon = 3;
    }
    else if (key == ENTER ) {
      korisnikIme = upisano;
      upisano = "";
    } 
    else {
      upisano = upisano + key; 
    }
}
