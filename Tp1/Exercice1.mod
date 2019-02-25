/*********************************************
 * OPL 12.7.1.0 Model
 * Author: BETOURNE Aurelien, ZIANE Sofiane
 * Creation Date: 14 nov. 2018 at 10:46:59
 *********************************************/
 
 // Optimum : x=1 , y=2 //
 
 // Question n°1 //
 /*
 
 dvar float x;
 dvar float y;
 
  minimize
 	0.3*x + 0.2*y;
 subject to {
 	x*8 + y*12 >= 24;
 	x*12 + y*12 >= 36;
 	x*2 + y*1 >= 4;
 	x + y <= 5;
 	x>=0;
 	y>=0; 
}

*/

// Question n°2 //

 int nbsAli = 2; //nombres d'aliments
 //nombres d'attributs [lipides,glucides,prots,onces]
 int nbsAttributs = 4;

 int lipides = 24; // lipides max
 int glucides = 36; // glucides max
 int prots = 4; // prots max
 int onces = 5; // onces max
 
 // apports en nutriments de chaque aliment
 float val[1..nbsAli][1..nbsAttributs] = [[8,12,2,0.3],[12,12,1,0.2]];
 // conditions d'apport en nutriments
 float condi[1..nbsAttributs] = [lipides,glucides,prots,onces];
 
 // variables de décisions
 dvar float recherche[1..2];
 
 /*
 	On cherche à minimiser le coût
 */
 minimize
 	sum(i in 1..nbsAli) val[i][4]*recherche[i];
 subject to{ 
 	forall(j in 1..3){	
 		(sum(i in 1..nbsAli)  val[i][j]*recherche[i])	>= condi[j];	
 	}
 	(sum(i in 1..2) recherche[i])<=condi[4];
 	forall(i in 1..2)	recherche[i]>=0;
} 