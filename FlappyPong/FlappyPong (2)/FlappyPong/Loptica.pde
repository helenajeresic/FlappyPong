/********* KLASA LOPTICA *********/
class Loptica { 
  float lopticaX,lopticaY; 
  int lopticaVelicina;
  int lopticaBoja; 
  float lopticaBrzinaVert;
  float lopticaBrzinaHorizon;
  
  Loptica(float x,float y, int a, int b, int c) {
    lopticaX = x; 
    lopticaY = y; 
    lopticaVelicina = 20;
    lopticaBoja = color(a,b,c);
    lopticaBrzinaVert = 0;
    lopticaBrzinaHorizon = 0;
  }
}
