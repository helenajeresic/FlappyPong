/********* FUNKCIJE 2. IGRE *********/ 

void NacrtajReket2(){
    fill(reketBoja);
    rectMode(CENTER);
    rect(mouseX,height - 20 , reketSirina, reketDuzina);
}
  
 void OdbijanjeLopticeOdReketa2(Loptica l) {
    // pomak misa u novom u odnosu na prethodni frame
    float pomakMisa = mouseX - pmouseX;  
    // ako se loptica nalazi unutar širine reketa
    if ((l.lopticaX + l.lopticaVelicina/2 > mouseX- reketSirina/2) && (l.lopticaX - l.lopticaVelicina/2 < mouseX + reketSirina/2)) {
      // ako je udaljenost središta loptice i središta reketa manja od pola veličine loptice i pomaka miša
      // tj. ako je došlo do sudara loptice i reketa 
      if (dist(l.lopticaX, l.lopticaY, l.lopticaX, height - 50) <= l.lopticaVelicina/2 + abs(pomakMisa)) {
          OdbijOdDna2(height - 20,l);       
          // povećaj brzinu i položaj loptice u odnosu na jačinu udara
          if (pomakMisa < 0) {
            l.lopticaX += (l.lopticaX - mouseX)/10;
            l.lopticaBrzinaVert += pomakMisa;
          }        
          //ide li loptica lijevo ili desno ovisi o točki reketa na koju je pala
          l.lopticaBrzinaHorizon = pomakMisa;// 1/10 vrijednosti najprirodnije
      }
    }
}

  void OdbijOdDna2(float podloga,Loptica l) {
    // najdonju točku loptice postavi na dno podloge, promijeni smjer brzine (pomonoži s -1) 
    // smanji brzinu za otpor podloge
    l.lopticaY = podloga - l.lopticaVelicina/2;
    l.lopticaBrzinaVert -= (l.lopticaBrzinaVert * otporPodlogeVert);
    l.lopticaBrzinaVert *= -0.5;
}

void OdrediCiglice(){    
    // ciglice ćemo pamtiti u listu 
    // sve će biti iste širine (50) i dužine (10)
    for(int i = 0; i < 12; i++)
      for(int j = 0; j < 10; j++){
        // prvi clan niza je pocetak cigle x koordinata, zatim pocetak cigle
        // y koordinata, i boja koju ćemo random odabrati izmedu njih 5
        // boje: 0 - crvena, 1 - žuta, 2 - plava, 3 - zelena, 4 - narančasta
        int boja = round(random(0,4));
        int[] novaCiglica = {i*50, j*20 + 50, boja}; 
        ciglice.add(novaCiglica);
      }  
}

void OdrediCiglice2(){    
    // ciglice ćemo pamtiti u listu 
    // sve će biti iste širine (50) i dužine (10)
    for(int i = 0; i < 12; i++)
      for(int j = 0; j < 8; j++){
        // prvi clan niza je pocetak cigle x koordinata, zatim pocetak cigle
        // y koordinata, i boja koju ćemo random odabrati izmedu njih 5
        // boje: 0 - crvena, 1 - žuta, 2 - plava, 3 - zelena, 4 - narančasta
        int boja = round(random(0,4));
        int[] novaCiglica = {i*50, j*20 + 50, boja}; 
        ciglice.add(novaCiglica);
      }  
}

void NacrtajCiglice(){
    rectMode(CORNER);
    stroke(0);
    for(int i = 0; i < ciglice.size(); i++){
        // boje: 0 - crvena, 1 - žuta, 2 - plava, 3 - zelena, 4 - narančasta
        int[] ciglica = ciglice.get(i);
        if(ciglica[2] == 0) fill(255,0,0);
        else if(ciglica[2] == 1) fill(255,255,0);
        else if(ciglica[2] == 2) fill(30,144,255);
        else if(ciglica[2] == 3) fill(50,205,50);
        else fill(255,140,0);
        rect(ciglica[0], ciglica[1], ciglaSirina, ciglaDuzina);
    }
}

void SudaranjeSaCiglicama(Loptica l) {
  for(int i = ciglice.size() - 1; i >= 0; i-- ){
    int[] ciglica = ciglice.get(i);  
    // ako se sudari s ciglicom
    if ((l.lopticaX + l.lopticaVelicina/2 > ciglica[0]) &&
        (l.lopticaX - l.lopticaVelicina/2 < ciglica[0] + ciglaSirina) &&
        (l.lopticaY + l.lopticaVelicina/2 > ciglica[1]) && 
        (l.lopticaY - l.lopticaVelicina/2 < ciglica[1] + ciglaDuzina)) 
        { 
            //OdbijOdStropa(ciglica[1]);
            l.lopticaBrzinaVert -= (l.lopticaBrzinaVert * otporPodlogeVert);
            l.lopticaBrzinaVert *= -1;
            ciglice.remove(i);
            break;
        }
  }
}

void IspisiVrijeme(int startVrijeme){
    fill(255,140,0);
    textSize(50);
    textAlign(CENTER);
    text(str((millis()-startVrijeme)/1000), height/2 , 30);
}

void IspisiUkupniRezultatNakonPrveIgre(){
  fill(255,140,0);
    textSize(20);
    textAlign(CENTER);
    text("Ukupni bodovi nakon prve igre:" + rezultat, height/2, height-10);
}

void IspisiUkupniRezultatNakonDrugeIgre(){
  fill(255,140,0);
    textSize(20);
    textAlign(CENTER);
    text("Ukupni bodovi nakon druge igre:" + rezultat, height/2, height-10);
}
