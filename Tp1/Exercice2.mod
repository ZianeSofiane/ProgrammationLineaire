/*********************************************
 * OPL 12.7.1.0 Model
 * Author: ZIANE Sofiane, BETOURNE Aurelien
 * Creation Date: 7 déc. 2018 at 20:23:10
 *********************************************/

/*
	Optimum : 173
	x = [
			[1 0 0 0 0 0 0 0 1 0]
            [0 1 0 0 1 0 0 0 0 0]
            [0 0 1 0 0 0 0 1 0 0]
            [0 0 0 0 0 1 1 0 0 1]
            [0 0 0 1 0 0 0 0 0 0]
        ];
*/

int nbMachines = 5; // nombre de machines
int nbLots = 10; // nombre de lots

// capacités totale de traitements de chaque machine 
int capacite[1..nbMachines] = [18,19,25,19,20];

 // cout de production de chaque lot selon la machine à laquelle il est affecté

int cout[1..nbMachines][1..nbLots] = 
[
	[17,21,22,18,24,15,20,18,19,18],
	[23,16,21,16,17,16,19,25,18,21],
	[16,20,16,25,24,16,17,19,19,18],
	[19,19,22,22,20,16,19,17,21,19],
	[18,19,15,15,21,25,16,16,23,15] 
 ] ;
 
 // durée du traitement de chaque lots pour chaque machines
 
 int traitement[1..nbMachines][1..nbLots] = 
 [
 	[ 8,15,14,23, 8,16, 8,25, 9,17],
 	[15, 7,23,22,11,11,12,10,17,16],
 	[21,20, 6,22,24,10,24, 9,21,14],
 	[20,11, 8,14, 9, 5, 6,19,19, 7],
 	[ 8,13,13,13,10,20,25,16,16,17]
 ];
 
 // boolean: vaut 1 si un certain lot est affecté à une certaine machine
 dvar int x[1..nbMachines][1..nbLots];
 
 
 // on cherche à minimiser le cout de production
 
 minimize
	sum(i in 1..nbLots)	(sum(j in 1..nbMachines)	cout[j][i]*x[j][i]);
 subject to{ 
 	// contrainte 1 : un lot peut être produit par seule une machine
  	forall(i in 1..nbLots){
  		(sum(j in 1..nbMachines)	x[j][i]) == 1;
  	}
  	forall(j in 1..nbMachines){  	
  	// contrainte 2 : capacité machine	
  		( sum(i in 1..nbLots)	traitement[j][i]*x[j][i] ) <= capacite[j]; 
  		// x est une variable binaire, vaut 0 ou 1
  		forall(i in 1..nbLots){
  			x[j][i]==0 || x[j][i]==1;  		
  		} 	
  	}
 }