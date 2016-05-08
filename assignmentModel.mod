/*********************************************
 * OPL 12.6.3.0 Model
 * Author: Baturay
 * Creation Date: 11 Nis 2016 at 17:04:53
 *********************************************/

 /***************************
 ***** PARAMETERS, SETS *****
 ***************************/
 
 //*** SCALAR PARAMETERS **//
 
 int Tmax = 5; // Time periods for harvesting
 int Zmax = 5; // Number of Zones
 int Vmax = 10; // Number of vessels
 int BeginningTotalStock = 830000;
 
 {int} Time = asSet(1..Tmax); 
 {int} Zone = asSet(1..Zmax); 
 {int} Vessels = asSet(1..Vmax); 
 
 //BigM
 int BigM = 999999999;
 
 //*** VECTOR PARAMETERS **//
 
 // Annual growth factor for zones
 float GrowthFactor [Zone] = ...;
 
 //maximum sustainable stock level(kg) for zones
 float MaxSustainableLevel [Zone] = ...;
 
 //Operating expenditures for each vessel i zones j
 float OperatingExpenditures [Zone] = ...;
 
 //Revenue
 int Revenue =...;
 
 //AnnualHarvestFee
 int AnnualHarvestFee = ...;
 
 //VesselCapacity
 int VesselCapacity = ...;
 
 //VesselCount
 int VesselCount = ...;
 
 /***************************
 **** DECISION VARIABLES ****
 ***************************/
 
 // number of kg of prawns harvested by vessel i from zone j at the end of year t
 dvar float+ HarvestV [Vessels][Zone][Time];
 dvar float+ HarvestOutputV[Zone][Time];
 // Stocks in the beginning of year t at zone j
 
 dvar int+ CurrentStocksV [Zone][Time];
 // Honey-prown harvested from a zone? 1 for yes 0 for no
 dvar int harvestBinary [Zone][Time] in 0..1;
 
 //  Vessel i used or not for Zone j at year t
 dvar int vesselBinary [Vessels][Zone][Time] in 0..1;
 dvar int+ VesselAllocationOutputV[Zone][Time];
 
 // Binary to handle min[a,b] constraint
 dvar int Z[Zone][Time diff{5}] in 0..1;
 
 /***************************
 **** OBJECTIVE FUNCTION ****
 ***************************/
 
 // Maximize Profit
 //          = sales price 
 //          - harvesting fee 
 //          - operation expense of vessels
 
 maximize 
 	sum (i in Vessels, j in Zone, t in Time ) 
 		Revenue * HarvestV [i][j][t]
 		
 -  sum (j in Zone, t in Time)	
 		AnnualHarvestFee * harvestBinary [j][t]
 		
 -  sum (j in Zone,i in Vessels,t in Time)
 		OperatingExpenditures[j] * vesselBinary[i][j][t];
 		
  /***************************
 ******** CONSTRAINTS *******
 ***************************/
 
 subject to 
 	
 	
 {
  
 //Current Stocks at the beginning of period 1
 ctInitialCurrentStocksV1:
 	CurrentStocksV[1][1] == 200000;
  ctInitialCurrentStocksV2:
 	CurrentStocksV[2][1] == 210000;
  ctInitialCurrentStocksV3:
 	CurrentStocksV[3][1] == 150000;
  ctInitialCurrentStocksV4:
 	CurrentStocksV[4][1] == 160000;
  ctInitialCurrentStocksV5:
 	CurrentStocksV[5][1] == 110000;
 	
 // Capacity restrictions must not be exceeded
 ctRestrCap:
 forall (j in Zone, t in Time)
    sum (i in Vessels)
         HarvestV[i][j][t]
    <= MaxSustainableLevel [j];
 
 // One vessel cannot operates in multiple zones
 ctVesselOperation:
 forall (i in Vessels, t in Time)
    sum (j in Zone)
      	vesselBinary[i][j][t]
    == 1;
 
 // Vessels cannot exceed capaity
 ctVesselCap:
 forall (i in Vessels, j in Zone, t in Time)
         HarvestV[i][j][t]
    <= VesselCapacity;
    
 // At the end of the Harvest amount should be equal to the at the beginning
 //of the first's years stock 
 ctReplenishment: 
 sum(j in Zone)
      CurrentStocksV[j][5]
	== BeginningTotalStock;
	    	   
//Stock in year t+1 = min [sustainable lim, (stock	in	year	t
//	–	harvest	in	year	t)	x	growth	factor ]    
 
 ctStockAmount1:
forall(j in Zone, t in Time diff{5})
   MaxSustainableLevel[j] 
   <= (CurrentStocksV[j][t]- sum (i in Vessels)
   		HarvestV[i][j][t] )* GrowthFactor[j] 
   		+ BigM * Z[j][t];
 
   		
 ctStockAmount2:	 
forall(j in Zone, t in Time diff{5})
  	(CurrentStocksV[j][t] - sum (i in Vessels)
   		HarvestV[i][j][t] )* GrowthFactor[j]
   		<= MaxSustainableLevel[j] 
   		+ (1-Z[j][t])* BigM;
 
 ctStockAmoun3:	 
forall(j in Zone, t in Time diff{5})
  	CurrentStocksV[j][t+1]
   		<= (CurrentStocksV[j][t]- sum (i in Vessels)
   		HarvestV[i][j][t] )* GrowthFactor[j] 
   		+ (1-Z[j][t])* BigM;
 
 ctStockAmoun4:	 
forall(j in Zone, t in Time diff{5})
  	CurrentStocksV[j][t+1]
   		<= MaxSustainableLevel[j]
   		+ Z[j][t] * BigM;
   		
 ctStockAmoun5:
 sum(j in Zone)
  	CurrentStocksV[j][5]
   		== BeginningTotalStock;
   		
 b:
  forall (j in Zone,t in Time)
	HarvestOutputV [j][t]
	== sum(i in Vessels)
	  HarvestV[i][j][t] 
	  ;
	  
ctVesselBinary:
forall(i in Vessels,j in Zone, t in Time)
  	  HarvestV[i][j][t] <= BigM * vesselBinary[i][j][t];

ctHarvestBinary:
forall(i in Vessels,j in Zone, t in Time)
  	  HarvestV[i][j][t] <= BigM * harvestBinary[j][t]; 
  	   	   
ctVesselAmount:
 forall (t in Time)
   sum(i in Vessels, j in Zone)
       vesselBinary[i][j][t]
       <= 10;
 a:
 forall (j in Zone,t in Time)
   VesselAllocationOutputV [j][t]
   
	== sum(i in Vessels)
	  vesselBinary[i][j][t];



 
}
 