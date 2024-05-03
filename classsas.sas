libname proclib 'SAS-library';
options fmtsearch=(proclib);
TITLE "Blood Pressure Type and Catagory Compared to Mortality Status";
proc report data=sashelp.heart;
   column status BP_Status Systolic, (n mean std min max)   ;
   define Status / group across;
   define BP_Status / group order=data;
   define Systolic /  N  Mean  STD Min Max;

run;
proc report data=sashelp.heart;
   column status BP_Status Diastolic, (n mean std min max)  ;
   define Status / group across;
   define BP_Status / group order=data;
   define Diastolic /  N  Mean  std  Min Max ;

run;

proc logistic data=SASHELP.HEART;
class status / REF=first param=glm;
model Status(event='Dead')=Weight Systolic Diastolic Smoking  Cholesterol /
link=logit technique=fisher;
run;

DATA gordis ;
        INPUT fish $ sick $ patients ;
DATALINES ;
        fish sick 50
        fish no_sick    22
        No_fish sick     88 
        No_fish no_sick    37

;
PROC FREQ DATA = gordis ;
  TABLES fish*sick / RELRISK RISKDIFF;
  WEIGHT patients ;
RUN ;


DATA stroke ;
   INPUT   hyper count_h not_hyper count_not;
   DATALINES ;
  18  252  46  998
 ; RUN;
PROC STDRATE DATA=stroke
            REFDATA =stroke
             METHOD=INDIRECT(AF)
             STAT=RISK
             ;
   POPULATION EVENT=hyper  TOTAL =count_h;
    REFERENCE EVENT = not_hyper TOTAL = count_not ;
RUN ;

