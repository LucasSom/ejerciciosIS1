#include <iostream>
#include <stdio.h>
#include <unistd.h>

using namespace std;

/*TODO:
	-tercera variedad de piso
*/


class brazo
 {
 public:
 	brazo(){
		rpm = 0;
		tiempo = 0;
	}
 	~brazo(){
 		free(this);
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
		if (porosidadSuelo<0.35 && durezaSuelo>0.65){
			this->girar_horario(150,10);
			this->accionar_cierre();
			this->girar_antihorario(150,10);
		}else if (porosidadSuelo>0.65 && durezaSuelo<0.35){
			this->girar_antihorario(100,5);
			this->accionar_cierre();
			this->girar_horario(100,5);
		}else if (porosidadSuelo>0.35 && porosidadSuelo<0.65 && durezaSuelo<0.65 && durezaSuelo<0.35){
			this->girar_horario(150,5);
			this->accionar_cierre();
			this->girar_antihorario(100,10);
		}else{
			cerr<<"ERROR: tipo de suelo desconocido"<<endl;
		}
	}

 private:
 	int rpm;
	bool giroHorario;
	int tiempo;
 };



int main(int argc, char const *argv[]){
	double porosidadSuelo;
	double durezaSuelo;

	brazo scioli;

	while(1){
		cout<<endl<<"Ingresar porosidad del suelo: ";
		cin>>porosidadSuelo;
		cout<<endl<<"Ingresar dureza del suelo: ";
		cin>>durezaSuelo;
		scioli.extraer_muestra(porosidadSuelo, durezaSuelo);
	}
	

	return 0;
}
