# 5-Year-Harvest-Plan-for-Honey-Prawn-OR
INTRODUCTION

Purpose

The purpose of this report is to provide Deluxe Seafoods Ltd. a 5-year harvest plan for the honey-prawn stocks in each of the 5 zones across the 5-years. This plan is to be optimal with respect to the net present value of the operation. 

In addition, a case for the procurement of an 11th vessel will be investigated. As such, an alternative NPV-optimal harvest plan for a fleet of 11 vessels will also be devised.  

Method

The information used in this report is provided by Deluxe Seafoods Ltd., the Haruchai Government and the Haruchai Department of Primary Industries. This information was used to create the generalised mixed integer programming model for the NPV-optimal harvest plan to aid in the decision making for the upcoming 5 years. 


FINDINGS

Business Case

The net present value of the base case was determined to be: $20,654,241.80. The vessel allocation and amounts of honey prawns to be harvested from each zone can be seen from the NPV-optimal harvest plan attached below.

For the alternative case, it was found that the procurement of an 11th vessel would benefit Deluxe Seafoods. In other words, it is advisable to purchase an additional vessel because in case of buying a new vessel would increase to total NPV to 21,012,020.99 . This is because the one-off capital expenditure (CAPEX) of the 11th vessel is not high enough and we are able to harvest more thanks to 11th vessel without passing the harvesting limits. 

Therefore, if Deluxe Seafoods wish to increase profits hence increase harvest, the procurement of the 11th vessel should be approved.

Decision variables

The following decision variables are as defined and will be used in the generalised mixed integer programming model. 

Let   Vessel allocation for zone j at year t. 

Let   Total harvest amounts from zone j at year t. 

Let   Total population in zone j at year t. 


Let   Profit made in zone j at year t. 
 
Let  

Indices





Parameters

 Growth factor at zone 

 Maximum sustainable stock level at zone .

Maximum amount of prawns able to be harvested per vessel/year  9000kg/vessel/yr.

 40% limit of the maximum sustainable limit of zone .

Revenue of each kg of prawns harvested  $80/kg.

Harvesting fee  $100,000/zone.

OPEX for zone 

N = amount of vessels in the fleet  10 vessels.

T = Current/present total amount of stocks available across the 5 zones   830,000kg















BASE CASE: THE GENERALISED MODEL WHEN THERE ARE 10 VESSELS:

Objective function

Deluxe Seafoods Ltd. desires to have the largest profit, as this will directly affect their ability to pursue their expansion plans in the future.

Max NPV = 


Constraints

The vessel allocation of 10 vessels:


The total population cannot drop below 40% of the sustainable level:


Maximum harvest of 9000kg of prawns in one year/vessel:


If a zone is harvested, then there would be a fixed harvesting fee:


The total stock at the beginning of year 6 must be equal to the total current stocks:


The OPEX for each utilized vessel:


The remaining constraints were derived from the population dynamics constraint.

The objective function tries to maximize  as much as it can so the the profit maximises as well. This means that the stock level in year  would be equal to the minimum of:

Moreover, the 1st or 2nd constraint would be valid and the 3rd or 4th constraint would also be binding since  would want to take the highest amount.






	




ALTERNATIVE CASE: THE GENERALISED MODEL WHEN THERE ARE 10 VESSELS AND AN OPTION OF PROCURING AN ADDITIONAL VESSEL:

Decision Variables

In addition to the decision variables from the base case, a variable for the procurement of the 11th vessel is added to the alternative case.

Let 

Parameters

In addition to the parameters from the base case, an additional parameter is added for the purchase cost of the 11th vessel.

C = Capex for the purchase of the 11th vessel  $95,000

Objective Function

Max NPV:


Constraints

The constraints from the base case remain the same but with the exception of the vessel allocation constraint.


