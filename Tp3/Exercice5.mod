/*********************************************
 * OPL 12.7.1.0 Model
 * Author: ZIANE Sofiane, BETOURNE Aurelien
 * Creation Date: 28 nov. 2018 at 11:01:02
 *********************************************/

/*
 Optimum : passagers sans transfert = 112
 x = [
       [0 0 0 1 0 0]
       [0 1 0 0 0 0]
       [0 0 1 0 0 0]
       [1 0 0 0 0 0]
       [0 0 0 0 1 0]
       [0 0 0 0 0 1]
     ];
*/

 int nbAvions = 6; // nombres d'avions
 
 int passagers[1..nbAvions][1..nbAvions] =
 [
 	[35,12,16,38, 5, 2],
 	[25, 8, 9,24, 6, 8],
 	[12, 8,11,27, 3, 2],
 	[38,15,14,30, 2, 9],
 	[ 0, 9, 8,25,10, 5],
 	[ 0, 0, 0,14, 6, 7]
 ]; // nombres de passagers en transfert entre deux vols
 
 // nombres de Passagers totals
 int totalPassagers = sum(i in 1..nbAvions) (sum(j in 1..nbAvions) passagers[i][j]);
 
 // variables de décisions
 dvar int x[1..nbAvions][1..nbAvions]; // vaut 1 si un avion d'une certaine provenance assure le vol à une certaine destination
 
 
 //	On cherche à minimiser le nombres de passagers devant changer de vol.
 /*
 	c1: les aéroports d'arrivées doivent recevoir un seul vol
 	c2: un seul vol doit quitter chaque ville de départ
 */
 minimize
 	totalPassagers - sum(i in 1..nbAvions) (sum(j in 1..nbAvions) passagers[i][j]*x[i][j]);
 subject to{
 	forall(j in 1..nbAvions){
 	 	(sum(i in 1..nbAvions)	x[i][j]) ==1; // contrainte 1
 	 	(sum(i in 1..nbAvions)	x[j][i]) ==1; // contrainte 2
 	 	forall(i in 1..nbAvions){
 	 	 	 x[j][i]>=0; // positivité
 	 	}
 	}
 }