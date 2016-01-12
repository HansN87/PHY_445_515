(* ::Package:: *)

Needs["ErrorBarPlots`"]
(* parameters *)
a=1000;  (* exp.norm *)
b=0.2 ; (* exp.slope *)
c=100 ; (* gauss norm *)
mu=8 ; (* peak location *)
sigma=1 ; (*  width *)
seed={a,b,c,mu,sigma};
model[x_, A_, B_, C_, D_,E_]:=A*Exp[-B*x]+C*Exp[-(1/2)*((x-D)/E)^2];
xobs= Range[19];
yobs={800,704,578,458,339,323,320,311,221,139,105,87,73,60,56,46,36,32,26};
ystd=Sqrt[#]&/@yobs;
obs=Transpose@{xobs,yobs};
obse=Table[{{xobs[[j]],yobs[[j]]},ErrorBar[ystd[[j]]]},{j,1,Length[xobs]}];
p1=Plot[model[x,a,b,c,mu,sigma],{x,0,20}];
p2=ListPlot[obs,PlotRange->All,Frame->True,Axes->True];
chi2[A_,B_,C_,D_,e_]:=Total[Table[(model[xobs[[i]],A,B,C,D,e]-yobs[[i]])^2/model[xobs[[i]],A,B,C,D,e],{i,1,Length[xobs]}]]
sol=FindMinimum[chi2[aa,bb,cc,dd,ee],{{aa,1000},{bb,0.2},{cc,100},{dd,8},{ee,1}},Method->"Newton"];
pic=Show[Plot[{model[x,a,b,c,mu,sigma],model[x,aa,bb,cc,dd,ee]/.sol[[2]]},{x,0,Max[xobs]},Frame->True,PlotStyle->{{Dashed,Black},{Thick,Darker[Green,0.1]}},FrameTicksStyle->Directive[15],FrameLabel->{Style["Energy[keV]",15],Style["Counts",15]},ImageSize->500],ErrorListPlot[obse,PlotStyle->{PointSize[0.01],Orange}]];
finde=Quiet[{#,FindMinimum[chi2[aa,bb,cc,#,ee],{{aa,1000},{bb,0.2},{cc,100},{ee,1}},Method->"Newton"][[1]]}&/@Range[sol[[2,4,2]]-0.2,sol[[2,4,2]]+0.2,0.01]];
e1=FindRoot[Interpolation[finde][x]==sol[[1]]+1,{x,sol[[2,4,2]]+0.1}];
e2=FindRoot[Interpolation[finde][x]==sol[[1]]+1,{x,sol[[2,4,2]]-0.1}];
e1[[1,2]]-sol[[2,4,2]]
-e2[[1,2]]+sol[[2,4,2]]
0.15204823903478637`
0.1561115725512927`
