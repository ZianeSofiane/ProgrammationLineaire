/*********************************************
 * OPL 12.7.1.0 Model
 * Author: BETOURNE Aurelien, ZIANE Sofiane
 * Creation Date: 28 nov. 2018 at 09:28:27
 *********************************************/

// QUESTION N°1 //
// int effectif[1..7]=[14,13,15,16,19,18,11];
/*
	Solution [4 7 1 7 0 3 0]
	Total employés : 22
*/

// QUESTION N°2 a // 
//int effectif[1..7]=[14,13,15,18,19,18,11];
/*
	Solution [4 7 1 7 0 3 0]
	Total employés : 22
*/


// QUESTION N°3 //
int effectif[1..7]=[11,13,15,18,19,18,11];
/*
	Solution [3 7 3 5 1 2 0]
	Total employés : 21
*/


dvar int employe[1..7];
 
 // on cherche à minimiser le nombre total d'employé
 
 minimize
 	sum(i in 1..7) employe[i];
 subject to{
 	(sum(i in 4..7) employe[i]) + employe[1] >= effectif[1];
 	(sum(i in 1..2) employe[i]) + (sum(i in 5..7) employe[i]) >= effectif[2];
 	(sum(i in 1..3) employe[i]) + (sum(i in 6..7) employe[i]) >= effectif[3];
 	(sum(i in 1..4) employe[i]) + employe[7] >= effectif[4];
 	(sum(i in 1..5) employe[i]) >= effectif[5];
 	(sum(i in 2..6) employe[i]) >= effectif[6];
 	(sum(i in 3..7) employe[i]) >= effectif[7];
 	
 	forall(i in 1..7)	employe[i]>=0; 
}