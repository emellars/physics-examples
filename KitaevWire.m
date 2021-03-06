(* ::Package:: *)

(* ::Input:: *)
(*(*Solving for the closed and open Kitaev chains, plotting energies and checking the zero-energy modes against the topological invariant.*)*)
(*Clear["Global`*"]*)
(*$PrePrint=#/.out_->TraditionalForm[out]&;*)
(*Dagger[m_]:=ConjugateTranspose[m]*)
(*MakeReal[xvar_]:={Im[xvar]^=0;Re[xvar]^=xvar;xvar\[Conjugate]^=xvar;}*)
(*(*Pfaffian of a matrix. See https://en.wikipedia.org/wiki/Talk%3APfaffian#Mathematica_code.*)*)
(*Pf[A_]:=If[Length[A]==0,1,Module[{L,A1,MatrixDelete},MatrixDelete[M_,i_]:=Delete[#,i]&/@Delete[M,i];*)
(*L=Length[A];A1=MatrixDelete[A,1];*)
(*Sum[(-1)^i (A[[1]][[i]] Pf[MatrixDelete[A1,i-1]]),{i,2,L}]]]*)
(*\[Sigma][i_]:=PauliMatrix[i];*)
(*ZeroMat[n_]:=ConstantArray[0,{n,n}];*)
(*Id[n_]:=IdentityMatrix[n];*)


(* ::Input:: *)
(*MakeReal[t];MakeReal[k];MakeReal[\[Mu]];MakeReal[\[CapitalDelta]];*)
(*(*Bulk energies.*)*)
(*\[Epsilon]=Sqrt[(2t*Cos[k]+\[Mu])^2+4\[CapitalDelta]^2*Sin[k]^2]*)
(*(*Hamiltonian.*)*)
(*H1=(-2t*Cos[k]-\[Mu])*PauliMatrix[3]-2*\[CapitalDelta]*Sin[k]*PauliMatrix[2]*)
(*U={{1,1},{I,-I}};*)
(*(*Antidiagonal Hamiltonian.*)*)
(*H1anti=FullSimplify[(I/2)U.H1.Dagger[U]]*)
(*(*k=0 the Hamiltonian is real antisymmetric.*)*)
(*zero=H1anti/.k->0*)
(*(*k=\[Pi] the Hamiltonian is real antisymmetric.*)*)
(*pi=H1anti/.k->\[Pi]*)
(*(*Calculate topological invariant.*)*)
(*TopInv=Sign[Pf[zero]*Pf[pi]]*)
(**)


(* ::Input:: *)
(*(*Plot bulk energies + topological invariant with variable \[Mu], t, and \[CapitalDelta].*)*)
(*(*The blue/yellow lines are energies, green line is topological invariant.*)*)
(*Manipulate[Plot[Evaluate[{\[Epsilon],-\[Epsilon],TopInv}/.{\[Mu]->\[Mu]Val,t->tVal,\[CapitalDelta]->\[CapitalDelta]Val}],{k,-\[Pi],\[Pi]}, AxesLabel->{"k","E"}],{\[Mu]Val,-3,3},{tVal,-3,3},{\[CapitalDelta]Val,-5,5}]*)


(* ::Input:: *)
(*(*Finite Kitaev ring energy as a function of \[Lambda] which controls whether its antiperiodic, open, or periodic.*)*)
(*FermionSites=200;*)
(*DiagMat=DiagonalMatrix[Table[\[Mu],{n,1,FermionSites}]]+DiagonalMatrix[Table[t,{n,1,FermionSites-1}],1]+DiagonalMatrix[Table[t,{n,1,FermionSites-1}],-1]+Normal@SparseArray[{{1,FermionSites}->\[Lambda]*t,{FermionSites,1}->\[Lambda]*t}];*)
(*OffDiagMat=DiagonalMatrix[Table[-\[CapitalDelta],{n,1,FermionSites-1}],1]+DiagonalMatrix[Table[\[CapitalDelta],{n,1,FermionSites-1}],-1];*)
(**)
(*HMat=ArrayFlatten[{{DiagMat,OffDiagMat},{OffDiagMat\[ConjugateTranspose],-DiagMat}}];*)
(**)
(*MinVal=1;MaxVal=3;Incr=0.05;*)
(*\[Lambda]Min=-1;\[Lambda]Max=1;*)
(*Do[RingEList[\[Mu]]={};,{\[Mu],MinVal,MaxVal,Incr}]*)
(**)
(*Do[AppendTo[RingEList[\[Mu]],Sort[Eigenvalues[HMat/.{\[CapitalDelta]->1,t->1,\[Lambda]->n}]]],{n,\[Lambda]Min,\[Lambda]Max,Incr},{\[Mu],MinVal,MaxVal,Incr}];//AbsoluteTiming*)
(*Manipulate[ListLinePlot[RingEList[\[Mu]]\[Transpose],DataRange->{\[Lambda]Min,\[Lambda]Max},PlotRange->{Automatic,{-1,1}},PlotStyle->Black,ImageSize->1400,TicksStyle->20,AxesLabel->{"\[Lambda]","E/t"},AxesStyle->30,PlotLabel->Style[StringForm["N = `` and \[Mu]/t = ``.",FermionSites,\[Mu]],FontSize->40]],{\[Mu],MinVal,MaxVal,Incr}]*)


(* ::Input:: *)
(*(*Plotting energies of open Kitaev chain.*)*)
(*FermionSites=59;*)
(*DiagMat=DiagonalMatrix[Table[\[Mu],{n,1,FermionSites}]]+DiagonalMatrix[Table[t,{n,1,FermionSites-1}],1]+DiagonalMatrix[Table[t,{n,1,FermionSites-1}],-1];*)
(*OffDiagMat=DiagonalMatrix[Table[-\[CapitalDelta],{n,1,FermionSites-1}],1]+DiagonalMatrix[Table[\[CapitalDelta],{n,1,FermionSites-1}],-1];*)
(**)
(*HMat=ArrayFlatten[{{DiagMat,OffDiagMat},{OffDiagMat\[ConjugateTranspose],-DiagMat}}];*)
(**)
(*OpenEList={};MinVal=-3;MaxVal=3;Incr=0.01;*)
(*Do[AppendTo[OpenEList,Sort[Eigenvalues[HMat/.{\[Mu]->n,\[CapitalDelta]->1,t->1}]]],{n,MinVal,MaxVal,Incr}]//AbsoluteTiming*)
(**)
(*ListLinePlot[OpenEList\[Transpose],DataRange->{MinVal,MaxVal},PlotStyle->Black,ImageSize->1400,TicksStyle->20,AxesLabel->{"\[Mu]","E/t"},AxesStyle->30,PlotLabel->Style[StringForm["N = ``.",FermionSites],FontSize->40]]*)



