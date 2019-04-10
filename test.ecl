IMPORT ML_Core.Types AS Types;
IMPORT ML_Core.Analysis;
IMPORT ML_Core;
IMPORT Files;
IMPORT LogisticRegression AS LR;

l_features := RECORD
  INTEGER value := 0;
  INTEGER length := 0;
  Types.t_Item class := 0;
END;
addwi(DATASET(Files.Layout) ds, INTEGER w) := PROJECT(ds, TRANSFORM(l_features,
                                                                     SELF.class := w,
                                                                     SELF.value := (INTEGER) LEFT.value,
                                                                     SELF.length := LENGTH(LEFT.value)
                                                                     ));
OUTPUT(Files.zipcode);
firstname := addwi(Files.firstname[1..10000], 1);
lastname := addwi(Files.lastname, 2);
middlename := addwi(Files.middlename, 3);
streetname := addwi(Files.street, 4);
zipcode := addwi(Files.zipcode[1..10000], 0);
OUTPUT(zipcode);
ds := firstname  + zipcode;
ML_Core.AppendSeqID(ds, id, train);
// OUTPUT(train);
ML_Core.ToField(train,trainRecs);
OUTPUT(trainRecs);
x := trainRecs(number < 3);
y := PROJECT(trainRecs(number = 3),TRANSFORM(Types.DiscreteField, SELF.number := 1, SELF := LEFT)) ;
m :=LR.BinomialLogisticRegression(30, 0.001).getmodel(X, Y);
p := LR.BinomialLogisticRegression().Classify(m, x);
output(p);
e:= Analysis.Classification.AccuracyByClass(p, y);
OUTPUT(e);