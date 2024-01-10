/********* FUNKCIJE ZA ISPIS NA KRAJU *********/
void PronadiTop5(){
   String[] top5 = loadStrings("top5.txt");
   // zapisemo rezultate i imena iz txt u 2 odvojena niza
   for(int i = 0; i < 5; i++){
     String[] line = split(top5[i], ' ');
     topRez[i] = Integer.parseInt(line[0]);
     imena[i] = line[1];
   }
   // tražimo da li je rezultat veći od nekog u top5
   for(int i = 0; i < 5; i++)
     if(rezultat > topRez[i]){
         trazeni = i;
         break;
     }
   // ako je, ubacujemo taj rezultat i korisničko ime na odgovarajuće mjesto
   if(trazeni >= 0){
     for(int i=4; i > trazeni; i--){
       int temp = topRez[i];
       String tempIme = imena[i];
       topRez[i] = topRez[i-1];
       imena[i] = imena[i-1];
       topRez[i-1] = temp;
       imena[i-1] = tempIme;
     } 
     topRez[trazeni] = rezultat;
   }
}

void IspisiTop5(){
  // zapisemo (novi) poredak ponovno u txt
   String[] top5 = new String[5];
   for(int i = 0; i < 5; i++)
       top5[i] = str(topRez[i]) + " " + imena[i];
   saveStrings("top5.txt", top5);
   
   // ispisi na zaslon top 5
   text("Mjesto      Ime      Rezultat", height/2, width/3 + 100);
   for(int i = 0; i < 5; i++){
       String text = str(i+1) + ".          " + imena[i] + "          " + str(topRez[i]);
       if(i == trazeni) fill(255,0,0);
       if(i == trazeni + 1) fill(77,0,75); 
       text(text, height/2, width/3 + 120 + 20*i);
   }
}

void UpisiKorisnickoIme(){
    text("Upiši ime i pritisni Enter za spremi. ",  height/2, width/3 + 40);
    text("Ime: " + upisano,  height/2, width/3 + 55);
}
