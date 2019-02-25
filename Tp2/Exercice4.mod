/*********************************************
 * OPL 12.7.1.0 Model
 * Author: ZIANE Sofiane, BETOURNE Aurelien
 * Creation Date: 28 nov. 2018 at 10:15:29
 *********************************************/

/*
	Optimum : 6793
		P1 = 119 , P2 = 162
		Pub = 7
		supp1 = 0 , supp2 = 0
*/

dvar int P1 ; // pubs produit 1
dvar int P2 ; // pubs produit 2
dvar int Pub;// nbspubs

dvar float supp1;// heures supp pour p1
dvar float supp2; // heures supp p2


// On cherche à maximiser le rendement de l'entreprise
maximize
	30*P1 + 15*P2 - (1.5*(2*P1+P2) + 10* ((supp1 + supp2)-140) + Pub);
subject to {
	90*P1 + 48 * P2 <=19200; // c1: contrainte temps machine
	2*P1+1*P2 <= 400 ;// c2: contrainte matieres premieres
	Pub <= 100; //contrainte nombre de pub
	P1 <= (50 + 10 *Pub) ;// contrainte pub 1
	P2 <= (60 + 15 *Pub);// contrainte pub 2
	
	// positivité
	P1 >= 50; 
	P2 >= 60;
	Pub >= 0;
	supp1 >= 0;
	supp2 >= 0;
	
}
