/********* ZASLONI *********/

void pocetniZaslon() {     
    background(255);
    fill(0,128,255);
    textSize(60);
    textAlign(CENTER);
    text("Flappy Pong", height/2, width/2);
    
    fill(46, 204, 113);
    textSize(20);
    text("Klikni za start!", height/2, width/2 + 50);
    
    fill(255,140,0);
    text("Pritisni tipku 'i' za prikaz instrukcija", height/2, width/2 + 80);
    
    pjesmica.play();
    
    NacrtajPticicu();
    NacrtajLopticu(loptica1);
    PrimijeniGravitaciju(loptica1);
    ZadrziLopticuNaZaslonu(loptica1);
}

void ZaslonIgre1() {
    pjesmica.play();  
    PImage slikaPozadine = loadImage("background.jpg");
    background(slikaPozadine);
    //background(110,193,248);
    
    NacrtajLopticu(loptica1); 
    PrimijeniGravitaciju(loptica1);
    ZadrziLopticuNaZaslonu(loptica1);
    NacrtajReket();
    OdbijanjeLopticeOdReketa(loptica1);  
    PrimijeniHorizontalnuBrzinu(loptica1);
    DodavanjeZidova();
    for (int i = 0; i < zidovi.size(); i++) {
        IzbrisiZid(i);
        PomakniZid(i);
        CrtajZid(i);
        SudaranjeSaZidom(i,loptica1);
    }
    IscrtajLinijuZivota(loptica1);  
    ispisiRezultat();
    
    // inicijaliziraj varijable na pocetno
    PrintTop5 = 1;
    trazeni = 5;
    korisnikIme = "";
    odrediCiglice = 1;
}

void ZaslonKrajIgre() {
    //Da bi pjesmica krenula ispočetka u novoj igri
    pjesmica.pause();
    pjesmica.rewind();   
    loptica_zvuk.play();
    
    background(255);
    textAlign(CENTER);
    fill(0,128,255);
    textSize(40);
    text("Igra je gotova", height/2, width/3 - 20);
    
    ispisiRezultat(); 
            
    if(PrintTop5 == 1){
      PronadiTop5();
      PrintTop5 = 0;
    }
    
    fill(77,0,75);
    textSize(18);
    if(trazeni != 5)
       UpisiKorisnickoIme();
    else text("Nisi u top 5. :(",  height/2, width/3 + 40);
   
   // ne radi unutar if, mora ovdje
   imena[trazeni] = korisnikIme;
   
   IspisiTop5();
   
   fill(46, 204, 113);
   textSize(20);
   text("Klikni za opet", height/2, width/3 + 250);
}

void ZaslonIgre2(){
    PImage slikaPozadine = loadImage("background.jpg");
    background(slikaPozadine);
    IspisiVrijeme(startVrijeme);
    //samo jednom želimo odrediti boje ciglica    
    if(odrediCiglice == 1){
      OdrediCiglice();
      odrediCiglice = 0;
    }
    NacrtajCiglice();
    NacrtajLopticu(loptica1);   
    NacrtajReket();
    PrimijeniGravitaciju(loptica1);
    ZadrziLopticuNaZaslonu(loptica1);
    OdbijanjeLopticeOdReketa(loptica1);  
    PrimijeniHorizontalnuBrzinu(loptica1);
    SudaranjeSaCiglicama(loptica1);
    IspisiUkupniRezultatNakonPrveIgre();
    // kraj igre
    if( ciglice.size() == 0 ){       
        krajVrijeme = millis();
        ukupnoVrijemeSec = (krajVrijeme - startVrijeme)/1000;
        // ukupnom rezultatu dodajemo broj obrnuto proporacionalan vremenu potrebnom za pogađanje svih ciglica 
        rezultat += round(150 - 2 * ukupnoVrijemeSec); 
        //****************
        zaslon = 5; 
        startVrijeme2 = millis();
        odrediCiglice2 = 1;
    }
}

void ZaslonIgre3(){  
    PImage slikaPozadine1 = loadImage("background1.jpg");
    background(slikaPozadine1);
    IspisiVrijeme(startVrijeme2);
    //samo jednom želimo odrediti boje ciglica    
    if(odrediCiglice2 == 1){
      OdrediCiglice2();
      odrediCiglice2 = 0;
    }    
    NacrtajCiglice();
    NacrtajLopticu(loptica1);
    NacrtajLopticu(loptica2);
    NacrtajReket2();
    PrimijeniGravitaciju(loptica1);
    PrimijeniGravitaciju(loptica2);
    ZadrziLopticuNaZaslonu(loptica1);
    ZadrziLopticuNaZaslonu(loptica2);
    OdbijanjeLopticeOdReketa2(loptica1);
    OdbijanjeLopticeOdReketa2(loptica2);
    PrimijeniHorizontalnuBrzinu(loptica1);
    PrimijeniHorizontalnuBrzinu(loptica2);
    SudaranjeSaCiglicama(loptica1);
    SudaranjeSaCiglicama(loptica2);
    IspisiUkupniRezultatNakonDrugeIgre();
    // kraj igre    
    if( ciglice.size()==0){
        zaslon = 2;
        krajVrijeme2 = millis();
        ukupnoVrijemeSec2 = (krajVrijeme2 - startVrijeme2)/1000;
        // ukupnom rezultatu dodajemo broj obrnuto proporacionalan vremenu potrebnom za pogađanje svih ciglica 
        rezultat += round(150 - 2 * ukupnoVrijemeSec2); 
    }
}


void ZaslonInstrukcije(){
    background(255);
    fill(46, 204, 113);
    textAlign(CENTER);
    textSize(40);
    text("INSTRUKCIJE", height/2, 40);
    fill(255,0,0);
    textSize(18);
    text("Pritisni tipke:", height/2, 80);
    fill(77,0,75);
    text("s  -  za pauziranje igre", height/2, 100);
    text("p  -  za ponovno pokretanje igre", height/2, 120);
    text("x  -  za vracanje na pocetni zaslon", height/2, 140);
    fill(255,0,0);
    text("Cilj igre 1:", height/2, 180);
    fill(77,0,75);
    text("Izbjegni sudaranje loptice sa zidom tako da je", height/2, 200);
    text("reketom odmakneš od zidova. Svako sudaranje", height/2, 220);
    text("loptice sa zidom, oduzima ti dio života. Igra 1", height/2,240);
    text("završava kada ti linija života postane bijela.", height/2, 260);
    fill(255,0,0);
    text("Cilj igre 2:", height/2, 300);
    fill(77,0,75);
    text("Pogodi sve ciglice u što manjem vremenu!", height/2, 320);
    fill(255,0,0);
    text("Cilj igre 3:", height/2, 360);
    fill(77,0,75);
    text("Uz pomocu 2 loptice pogodi sve ciglice u što manjem vremenu!", height/2, 380);
    fill(255,0,0);
    text("Reket i loptica:", height/2, 420);
    fill(77,0,75);
    text("Reket kontroliraš pomicanjem miša.", height/2, 440);
    text("Lopticu udari sredinom reketa ako želiš da ide", height/2, 460);
    text("vertikalno prema stropu, lijevim rubom reketa", height/2, 480);
    text("ako je želiš pomaknuti ulijevo, te desnim rubom", height/2, 500);
    text("reketa ako je želiš pomaknuti udesno. ", height/2, 520);

    fill(46, 204, 113);
    textSize(20);
    text("Klikni za start!", height/2, 560);
}
