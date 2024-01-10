/********* KLASA LOPTICA *********/
class Loptica { 
  float lopticaX,lopticaY; 
  int lopticaVelicina;
  int lopticaBoja; 
  float lopticaBrzinaVert;
  float lopticaBrzinaHorizon;
  
  Loptica(float x,float y) {  
    lopticaX = x; 
    lopticaY = y; 
    lopticaVelicina = 20;
    lopticaBoja = color(77,0,75);
    lopticaBrzinaVert = 0;
    lopticaBrzinaHorizon = 0;
  }
}
