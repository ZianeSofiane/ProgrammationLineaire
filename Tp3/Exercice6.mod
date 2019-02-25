/*********************************************
 * OPL 12.7.1.0 Model
 * Author: BETOURNE Aurelien, ZIANE Sofiane
 * Creation Date: 8 d�c. 2018 at 19:45:30
 *********************************************/

 /*
	Optimum: 45590 ; (en milliers)
		Bn = [28 15 15 28 30 30 30 30 26 14 25 30];
		Bs = [0 0 0 0 0 10 15 15 0 0 0 0];
		stock = [0 0 0 3 0 0 0 0 0 0 0 0];
 */
 
 
 int capa = 30; // capacit� de production par mois en milliers 
 int mois = 12; // nombres de mois
 int coutN = 130; // cout d'une bicyclette en heure normal
 int coutS = 160; // cout d'une bicyclette en heure supp
 int coutStock = 20; // cout de stockage mensuel d'une bicyclette en milliers
 
 dvar int Bn[1..mois]; // nombres de bicyclettes fabriquer en heures normales chaque mois
 dvar int Bs[1..mois]; // nombres de bicyclettes fabriquer en heures supps chaque mois
 dvar int stock[1..mois]; // nombres de bicyclettes stock�es � la fin de chaque mois
 
 int stockInitial = 2; // stock initial au d�but de l'ann�e
 // prevision de ventes pour chaque mois en milliers
 int prevision[1..mois] = [30,15,15,25,33,40,45,45,26,14,25,30];
 
 
 // On cherche � minimiser les co�ts de production
 minimize
 	sum(i in 1..mois)	(coutN*Bn[i] + coutS*Bs[i] + coutStock*stock[i]);
 subject to{ 
	/*
		chaque mois le nombre de byciclette disponible doit �tre au 
		moins �gal � la pr�vision de vente, le plus est stock�
 	*/
 	// Premier mois
 	Bn[1] + Bs[1] + stockInitial >= prevision[1];
 	stock[1] == (Bn[1] + Bs[1] + stockInitial) - prevision[1];
 	// Relation de r�curence pour les mois suivants
 	forall(i in 2..mois){
 		Bn[i] + Bs[i] + stock[i-1] >= prevision[i]; 	
 		stock[i] == (Bn[i] + Bs[i] + stock[i-1]) - prevision[i];
 	}
 	
 	forall(i in 1..mois){
 		Bn[i]<= capa; // contrainte de capacit�
 		// positivit�
 		Bs[i]>=0; Bn[i]>=0; stock[i]>=0;	
 	}
 }