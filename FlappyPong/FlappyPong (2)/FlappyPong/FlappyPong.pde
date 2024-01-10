import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


/********* VARIJABLE *********/

// Konroliramo koji je zaslon aktivan tako što mijenjamo
// vrijednost varijable zaslon, vrijednosti su:
//
// 0: Početni zaslon
// 1: Zaslon za igricu po uzoru na Flappy Bird 
// 2: Kraj igrice
// 3: Zaslon s instrukcijama
// 4: Zaslon za igricu po uzoru na Brick Breaker
// 5: Zaslon za igricu po uzoru na Brick Breaker sa dvije kuglice

int zaslon = 0;

//dvije instance klase Loptica
Loptica loptica1 = new Loptica(100,100);
Loptica loptica2 = new Loptica(100,500);

// početna gravitacija
float gravitacija = 0.3;

// otpor zraka i otpor podloga
float otporZraka = 0.0001;
float otporPodlogeVert = 0.35;
float otporPodlogeHoriz = 0.3;

// reket info
color reketBoja = color(0);
float reketSirina = 100;
int reketDuzina = 10;


//zidovi info
int BrzinaZidova = 5;
int intervalDodavanjaZidova = 1000;
float zadnjeVrijemeDodavanja = 0;
int minUdaljenostZidova = 200;
int maxUdaljenostZidova = 300;
int sirinaZida = 80;
color bojaZidova = color(0,128,0);
ArrayList<int[]> zidovi = new ArrayList<int[]>();

// zivot i rezultat info
int maxZivot = 100;
int zivot = 100;
int sirinaLinijeZivota = 60;
int rezultat = 0; 

// inicijalizacija niza ciglica, sirina i duzina jedne ciglice
ArrayList<int[]> ciglice = new ArrayList<int[]>();
int ciglaSirina = 50, ciglaDuzina = 20;

// samo jednom određujemo boje ciglica
int odrediCiglice = 1;
int odrediCiglice2 = 1;

// vrijeme početka i kraja igre 2 i 3
int startVrijeme, krajVrijeme, startVrijeme2, krajVrijeme2;
float ukupnoVrijemeSec, ukupnoVrijemeSec2;
int meduvrijemePocetak;

// test kad ispisujemo top5
int PrintTop5 = 1;
int[] topRez = new int[6];
String[] imena = new String[6];
// za provjeru da li je rezultat veći od postojećih
int trazeni = 5;

// korisničko ime te varijabla za upis imena
String korisnikIme = "", upisano = "";

//zvukovi
AudioPlayer pjesmica, loptica_zvuk, podogak_zvuk;
Minim minim;

//font
PFont font;

//slika 
PImage ptica;
int x=0;
float y=150;


/********* SETUP DIO *********/

void setup() {
    size(600, 600);
    
    //Zvukovi
    minim = new Minim(this);
    pjesmica = minim.loadFile("pjesmica.mp3");
    loptica_zvuk = minim.loadFile("pingPong.mp3");
    //pogodak_zvuk = minim.loadFile("ding.mp3");
    //font
    font = loadFont("BerlinSansFBDemi-Bold-90.vlw");
    textFont(font);
    //slika
    ptica = loadImage("flappyBird.jpg");
}

/********* DRAW DIO *********/

void draw() {
    // Crta sadržaj trenutnog ekrana
    if (zaslon == 0) {
      pocetniZaslon();
    } 
    else if (zaslon == 1) {
      ZaslonIgre1();
    } 
    else if (zaslon == 2) {
      ZaslonKrajIgre();
    }
    else if(zaslon == 3){
      ZaslonInstrukcije();
    }
    else if(zaslon == 4){
      ZaslonIgre2();                                                                           
    }
     else if(zaslon == 5){
      ZaslonIgre3();
    }
}
