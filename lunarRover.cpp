#include <iostream>
#include <stdio.h>

using namespace std;

/*TODO:
	-libreria de tiempo
	-chequear
	-tercera variedad de piso
	- mensajes por consola
*/


class brazo
 {
 public:
 	brazo();
 	~brazo();
 	void girar_horario(int velocidad, int t);
 	void girar_antihorario(int velocidad, int t);
 	void accionar_cierre();
 	void extraer_muestra(double porosidadSuelo, double durezaSuelo);

 private:
 	int rpm;
	bool giroHorario;
	int tiempo;
 };

brazo::brazo(){
	rpm = 0;
	tiempo = 0;
}

void girar_horario(int velocidad, int t){
	giroHorario = true;
	rpm = velocidad;
	sleep(t);
	rpm = 0;
}

void girar_antihorario(int velocidad, int t){
	giroHorario = false;
	rpm = velocidad;
	sleep(t);
	rpm = 0;
}

void accionar_cierre(){
	rpm = 0;
}

void extraer_muestra(double porosidadSuelo, double durezaSuelo){
	if (porosidadSuelo<0.5 && durezaSuelo>0.5){
		scioli.girar_horario(150,10);
		scioli.accionar_cierre();
		scioli.girar_antihorario(150,10);
	}else if (porosidadSuelo>0.5 && durezaSuelo<0.5){
		scioli.girar_antihorario(100,5);
		scioli.accionar_cierre();
		scioli.girar_horario(100,5);
	}else{
		cerr<<"ERROR: tipo de suelo desconocido"<<endl;
	}
}

int main(int argc, char const *argv[]){
	double durezaSuelo;
	double porosidadSuelo;

	brazo scioli;

	scioli.extraer_muestra(porosidadSuelo, durezaSuelo);
	
	return 0;
}