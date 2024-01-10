/********* FUNKCIJE 1. IGRE *********/

void NacrtajPticicu() {
    ptica.resize(50, 50);
    image(ptica, x, y);
    x++;
    y=150+8*sin(x/2); //za dojam da ptičica leti
}

void NacrtajLopticu(Loptica l) {
    stroke(0);
    strokeWeight(2);
    fill(l.lopticaBoja);
    ellipse(l.lopticaX, l.lopticaY, l.lopticaVelicina, l.lopticaVelicina);
}

void PrimijeniGravitaciju(Loptica l) {
    // brzinu loptice povećava utjecaj gravitacije, a smanjuje otpor zraka
    // vertikalni položaj loptice mijenja se za brzinu loptice
    l.lopticaBrzinaVert += gravitacija;
    l.lopticaBrzinaVert -= (l.lopticaBrzinaVert * otporZraka) * abs(l.lopticaBrzinaVert);
    l.lopticaY += l.lopticaBrzinaVert;      
}

void OdbijOdDna(float podloga,Loptica l) {
    // najdonju točku loptice postavi na dno podloge, promijeni smjer brzine (pomonoži s -1) 
    // smanji brzinu za otpor podloge
    l.lopticaY = podloga - l.lopticaVelicina/2;
    l.lopticaBrzinaVert -= (l.lopticaBrzinaVert * otporPodlogeVert);
    l.lopticaBrzinaVert *= -1;
}

void OdbijOdStropa(float podloga,Loptica l) {
    l.lopticaY = podloga + l.lopticaVelicina/2;
    l.lopticaBrzinaVert -= (l.lopticaBrzinaVert * otporPodlogeVert);
    l.lopticaBrzinaVert *= -1;
}

void PrimijeniHorizontalnuBrzinu(Loptica l){
    l.lopticaX += l.lopticaBrzinaHorizon;
    l.lopticaBrzinaHorizon -= (l.lopticaBrzinaHorizon * otporZraka) * abs(l.lopticaBrzinaHorizon);
}

void OdbijOdLijevogRuba(float podloga,Loptica l){
    l.lopticaX = podloga + l.lopticaVelicina/2;
    l.lopticaBrzinaHorizon -= (l.lopticaBrzinaHorizon * otporPodlogeHoriz);
    l.lopticaBrzinaHorizon *= -1;
}

void OdbijOdDesnogRuba(float podloga,Loptica l){
    l.lopticaX = podloga-(l.lopticaVelicina/2);
    l.lopticaBrzinaHorizon *= -1;
    l.lopticaBrzinaHorizon -= (l.lopticaBrzinaHorizon * otporPodlogeHoriz);
}

void ZadrziLopticuNaZaslonu(Loptica l) {
    // ako loptica padne na pod, tj. ako najdonja točka loptice bude veća od visine ekrana
    if (l.lopticaY + l.lopticaVelicina/2 > height) { 
      OdbijOdDna(height,l);
    }
    // ako loptica dotakne strop
    if (l.lopticaY - l.lopticaVelicina/2 < 0) {
      OdbijOdStropa(0,l);
    }
    // ako loptica dotakne lijevi rub
    if (l.lopticaX - l.lopticaVelicina/2 < 0){
      OdbijOdLijevogRuba(0,l);
    }
    // ako loptica dotakne desni rub
    if (l.lopticaX + l.lopticaVelicina/2 > width){
      OdbijOdDesnogRuba(width,l);
    }
}

void NacrtajReket(){
    fill(reketBoja);
    rectMode(CENTER);
    rect(mouseX, mouseY, reketSirina, reketDuzina);
}

void OdbijanjeLopticeOdReketa(Loptica l) {
    // pomak misa u novom u odnosu na prethodni frame
    float pomakMisa = mouseY - pmouseY;  
    // ako se loptica nalazi unutar širine reketa
    if ((l.lopticaX + l.lopticaVelicina/2 > mouseX- reketSirina/2) && (l.lopticaX - l.lopticaVelicina/2 < mouseX + reketSirina/2)) {
      // ako je udaljenost središta loptice i središta reketa manja od pola veličine loptice i pomaka miša
      // tj. ako je došlo do sudara loptice i reketa 
      if (dist(l.lopticaX, l.lopticaY, l.lopticaX, mouseY) <= l.lopticaVelicina/2 + abs(pomakMisa)) {
          OdbijOdDna(mouseY,l);       
          // povećaj brzinu i položaj loptice u odnosu na jačinu udara
          if (pomakMisa < 0) {
            l.lopticaY += pomakMisa;
            l.lopticaBrzinaVert += pomakMisa;
          }        
          //ide li loptica lijevo ili desno ovisi o točki reketa na koju je pala
          l.lopticaBrzinaHorizon = (l.lopticaX - mouseX)/10; // 1/10 vrijednosti najprirodnije
      }
    }
}

void DodavanjeZidova() {
    // ako je između sada i vremena zadnjeg dodavanja zida prošlo više od zadanog intervala
    if (millis() - zadnjeVrijemeDodavanja > intervalDodavanjaZidova) {
        // udaljenost između novog para zidova bude random vrijednost unutar zadanog intervala
        int udaljenostZidova = round(random(minUdaljenostZidova, maxUdaljenostZidova));
        // visina gornjeg zida bude također random vrijednost
        int visinaGornjegZida = round(random(0, height-udaljenostZidova));
        // zid pamtimo kao niz u kojem su vrijednosti
        // {početnaTočkaZida, visinaGornjegZida, širinaZida, udaljenostZidova, brojSudaraLopticeSaZidom};
        int[] noviParZidova = {width, visinaGornjegZida, sirinaZida, udaljenostZidova, 0}; 
        zidovi.add(noviParZidova);
        zadnjeVrijemeDodavanja = millis();
    }
}

void CrtajZid(int index) {
    int[] zid = zidovi.get(index);
    // zid pamtimo kao niz u kojem su vrijednosti
    // {početnaTočkaZida, visinaGornjegZida, širinaZida, udaljenostZidova, brojSudaraLopticeSaZidom};
    rectMode(CORNER);
    fill(bojaZidova);
    // gornji zid: od (početnaTočka, 0) do (širinaZida, visinaGornjegZida)
    rect(zid[0], 0, zid[2], zid[1], 7);
    //donji zid: od (početnaTočka, visinaGornjegZida + udaljenostZidova) do (širinaZida, preostala visina))
    rect(zid[0], zid[1]+zid[3], zid[2], height-(zid[1]+zid[3]), 7);
}
void PomakniZid(int index) {
    int[] zid = zidovi.get(index);
    // zidove mičemo ulijevo
    zid[0] -= BrzinaZidova;
}

void IzbrisiZid(int index) {
    int[] zid = zidovi.get(index);
    // ako je početnaTočka - širinaZida < 0, odnosno zid ispada sa zaslona
    if (zid[0]+zid[2] <= 0) {
      zidovi.remove(index);
    }
}

void SudaranjeSaZidom(int index,Loptica l) {
  int[] zid = zidovi.get(index);  
  int sudar = zid[4];
  int gornjiZidX = zid[0];
  int gornjiZidY = 0;
  int gornjiZidVisina = zid[1];
  int donjiZidX = zid[0];
  int donjiZidY = zid[1] + zid[3];
  int donjiZidVisina = height - ( zid[1] + zid[3] );
  
  // ako se sudari s gornjim zidom
  if ((l.lopticaX + l.lopticaVelicina/2 > gornjiZidX) &&
      (l.lopticaX - l.lopticaVelicina/2 < gornjiZidX + sirinaZida) &&
      (l.lopticaY + l.lopticaVelicina/2 > gornjiZidY) && 
      (l.lopticaY - l.lopticaVelicina/2 < gornjiZidY + gornjiZidVisina)) 
      { 
          fill(color(255,0,0));
          rect(gornjiZidX, gornjiZidY, sirinaZida, gornjiZidVisina, 7);
          SmanjiZivot(l); 
          zid[4] = 1; // dogodio se sudar s tim zidom
      }
  // ako se sudari s donjim zidom
  if ((l.lopticaX + l.lopticaVelicina/2 > donjiZidX) &&
      (l.lopticaX - l.lopticaVelicina/2 < donjiZidX + sirinaZida) &&
      (l.lopticaY + l.lopticaVelicina/2 > donjiZidY) &&
      (l.lopticaY - l.lopticaVelicina/2 < donjiZidY + donjiZidVisina)) 
      {
          fill(color(255,0,0));
          rect(donjiZidX, donjiZidY, sirinaZida, donjiZidVisina, 7);
          SmanjiZivot(l); 
          zid[4]=1; // dogodio se sudar s tim zidom
      }
  
  if (l.lopticaX > (zid[0] + sirinaZida) && sudar == 0) {
      // samo jedanput brojimo jedan zid
      sudar = 1; 
      zid[4] = 1;
      rezultat++; //ovaj if se izvrši i kada nemamo sudar
  }
}

void ispisiRezultat(){
    fill(255,140,0);
    textSize(50);
    textAlign(CENTER);
    if (rezultat < 0) 
      rezultat = 0;
    text(rezultat, height/2 , 50);
}

void IscrtajLinijuZivota(Loptica l) {
    noStroke();
    fill(236, 240, 241);
    rectMode(CORNER);
    rect(l.lopticaX- sirinaLinijeZivota/2, l.lopticaY - 30, sirinaLinijeZivota, 5);
    if (zivot > 60) {
      fill(57,255,20);
    } 
    else if (zivot > 30) {
      fill(230, 126, 34);
    } 
    else {
      fill(255, 0, 0);
    }
    rectMode(CORNER);
    rect(l.lopticaX-sirinaLinijeZivota/2, l.lopticaY - 30, sirinaLinijeZivota * zivot/maxZivot, 5);
}

void SmanjiZivot(Loptica l){
    zivot -= 1;
    if (zivot <= 0){
      // kraj igre 1, prijedi na igru 2
      //****************
      zaslon = 4;
      // postavi koordinate za lopticu u novoj igri
      l.lopticaX = height/2; l.lopticaY = 400;
      // odredi startVrijeme za drugu igru
      startVrijeme = millis();
    }
}
