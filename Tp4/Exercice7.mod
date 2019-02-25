/*********************************************
 * OPL 12.7.1.0 Model
 * Author: ZIANE Sofiane, BETOURNE Aurelien
 * Creation Date: 9 déc. 2018 at 23:45:15
 *********************************************/

 /*
 	Solution : Optimum : 18135,
 	
 	y = [1 0 0 0 1 0 0 1 1 0 0 1];
 	
 	x = [
 			[0 0 1 1 0 0 0 0 0 0 0 1]
            [0 0 0 0 0 0 0 0 0 0 0 0]
            [0 0 0 0 0 0 0 0 0 0 0 0]
            [0 0 0 0 0 0 0 0 0 0 0 0]
            [1 1 0 0 0 0 0 0 0 0 0 0]
            [0 0 0 0 0 0 0 0 0 0 0 0]
            [0 0 0 0 0 0 0 0 0 0 0 0]
            [0 0 0 0 1 1 0 0 0 0 0 0]
            [0 0 0 0 0 0 0 0 0 1 1 0]
            [0 0 0 0 0 0 0 0 0 0 0 0]
            [0 0 0 0 0 0 0 0 0 0 0 0]
            [0 0 0 0 0 0 1 1 1 0 0 0]
        ];
        
 */

 int nbSites = 12;	// nombre de sites
 int nbCentrales = 12; // nombre de centrales
 int nbClients = 12; // nombre de clients
 
 // Tableau coûts de livraison (100€)
 int cout[1..nbSites][1..nbCentrales] =
 	[
 		[100, 80, 50, 50,   60,    100,   120, 90, 60, 70,   65,    110],
 		[120, 90, 60, 70,   65,    110,   140,110, 80, 80,   75,    130],
 		[140,110, 80, 80,   75,    130,   160,125,100,100,   80,    150],
 		[160,125,100,100,   80,    150,   190,150,130,maxint,maxint,maxint],
 		[190,150,130,maxint,maxint,maxint,200,180,150,maxint,maxint,maxint],
 		[200,180,150,maxint,maxint,maxint,100, 80, 50, 50,   60,    100],
 		[100, 80, 50, 50,   60,    100,   120, 90, 60, 70,   65,    110],
 		[120, 90, 60, 70,   65,    110,   140,110, 80, 80,   75,    130],
 		[140,110, 80, 80,   75,    130,   160,125,100,100,   80,    150],
 		[160,125,100,100,   80,    150,   190,150,130,maxint,maxint,maxint],
 		[190,150,130,maxint,maxint,maxint,200,180,150,maxint,maxint,maxint],
 		[200,180,150,maxint,maxint,maxint,100, 80, 50, 50,   60,    100]
 	];
 	
 // Données entrepôts : coût (100€)
 int coutEntrepots[1..nbSites] = [3500,9000,10000,4000,3000,9000,9000,3000,4000,10000,9000,3500];
 // Données entrepôts : capacité (t)
 int capa[1..nbSites] = [300,250,100,180,275,300,200,220,270,250,230,180];
 // Données clients : demande (t)
 int demande[1..nbClients] = [120,80,75,100,110,100,90,60,30,150,95,120];
 
 
 // Variables de décisions :
 dvar int y[1..nbSites]; // variable binaire, vaut 1 quand le site est choisi
 
 // pourcentage de la demande d'un client livré par un entrepôt, valeur [0,1]
 dvar int x[1..nbClients][1..nbCentrales];
 
 // On cherche à minimiser le coût
 
 minimize
 	  (sum(i in 1..nbSites) coutEntrepots[i]*y[i])
 	+ (sum(i in 1..nbSites)(sum(j in 1..nbClients) cout[i][j]*x[i][j]));
 subject to{
 	forall(i in 1..nbSites){
 		forall(j in 1..nbClients)	x[i][j]<=1 && x[i][j]>=0;; // valeur x entre 0 et 1 
 	}
 	forall(j in 1..nbClients){
 		(sum(i in 1..nbSites) x[i][j])==1; // satisfaire la demande d'un client 
 	} 
 	// contraintes capacités entrepôts
 	forall(i in 1..nbSites){
 		(sum(j in 1..nbClients) demande[j]*x[i][j]) <= capa[i]*y[i]; 
 	}
 	forall(i in 1..nbSites)	y[i]==0 || y[i]==1; // y vaut soit 0 soit 1
 }
 