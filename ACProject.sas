ods graphics on / discretemax= 1600;
data project;
infile '/home/u63652615/sasuser.v94/bikebuyerscsv(in)-3.csv' dlm=',' firstobs=2;
length Education $25 Commute_Distance $10 Occupation $25;
input @1 Marital_Status $ Gender $ Income Children Education $ Occupation $ Home_Owner $ Cars Commute_Distance $ Region $ Age Purchased_Bike $;

run;


data female;
    set project;
    where Gender = 'Female';
run;


data male;
    set project;
    where Gender = 'Male';
run;


proc freq data = project;
tables Gender*Purchased_Bike / plots=mosaicplot chisq cmh nocol nopercent;
run;

proc freq data = project;
tables Purchased_Bike*Occupation / plots=mosaicplot chisq cmh nocol nopercent relrisk;
run;

proc freq data = project;
tables Purchased_Bike*Cars / plots=mosaicplot chisq cmh nocol nopercent;
run;

proc freq data = project;
tables Purchased_Bike*Commute_Distance / plots=mosaicplot chisq cmh nocol nopercent;
run;

proc freq data = project;
tables Purchased_Bike*Region / plots=mosaicplot chisq cmh nocol nopercent;
run;

proc freq data = project;
tables Purchased_Bike*Home_Owner / plots=mosaicplot chisq cmh nocol nopercent;
run;

proc freq data = project;
tables Purchased_Bike*Marital_Status / plots=mosaicplot chisq cmh nocol nopercent;
run;

proc logistic order=data;
class Gender (ref = "Male") /param=reference;
model Purchased_Bike =Gender Age Cars/link=logit;
run;

proc logistic order=data;
class Gender (ref = "Male") /param=reference;
model Purchased_Bike =Gender Income Cars/link=logit;
run;

proc logistic order=data;
class Gender (ref = "Male") /param=reference;
model Purchased_Bike =Gender Children Cars/link=logit;
run;


proc logistic data = female order=data;
class Gender (ref = "Female") /param=reference;
model Purchased_Bike =Gender Age Cars/link=logit;
run;

proc logistic data = female order=data;
class Gender (ref = "Female") /param=reference;
model Purchased_Bike =Gender Income Cars/link=logit;
run;


proc means data = female sum;
run;