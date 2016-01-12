(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[         0,          0]
NotebookDataLength[     21760,        548]
NotebookOptionsPosition[     20583,        502]
NotebookOutlinePosition[     20937,        518]
CellTagsIndexPosition[     20894,        515]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell[BoxData[
 RowBox[{
  RowBox[{"(*", " ", "parameters", " ", "*)"}], "\n", 
  RowBox[{
   RowBox[{
    RowBox[{"a", "=", "1000"}], ";"}], "  ", 
   RowBox[{"(*", " ", 
    RowBox[{"exp", ".", "norm"}], " ", "*)"}], "\[IndentingNewLine]", 
   RowBox[{
    RowBox[{"b", "=", "0.2"}], " ", ";"}], " ", 
   RowBox[{"(*", " ", 
    RowBox[{"exp", ".", "slope"}], " ", "*)"}], "\n", 
   RowBox[{
    RowBox[{"c", "=", "100"}], " ", ";"}], " ", 
   RowBox[{"(*", " ", 
    RowBox[{"gauss", " ", "norm"}], " ", "*)"}], "\n", 
   RowBox[{
    RowBox[{"mu", "=", "8"}], " ", ";"}], " ", 
   RowBox[{"(*", " ", 
    RowBox[{"peak", " ", "location"}], " ", "*)"}], "\n", 
   RowBox[{
    RowBox[{"sigma", "=", "1"}], " ", ";"}], " ", 
   RowBox[{"(*", "  ", "width", " ", "*)"}], "\n", 
   RowBox[{
    RowBox[{"seed", "=", 
     RowBox[{"{", 
      RowBox[{"a", ",", "b", ",", "c", ",", "mu", ",", "sigma"}], "}"}]}], 
    ";"}]}]}]], "Input",
 CellChangeTimes->{{3.6615383694269123`*^9, 3.661538377495096*^9}, {
  3.661538428873343*^9, 3.661538520916348*^9}}],

Cell[BoxData[{
 RowBox[{
  RowBox[{
   RowBox[{"model", "[", 
    RowBox[{
    "x_", ",", " ", "A_", ",", " ", "B_", ",", " ", "C_", ",", " ", "D_", ",",
      "E_"}], "]"}], ":=", 
   RowBox[{
    RowBox[{"A", "*", 
     RowBox[{"Exp", "[", 
      RowBox[{
       RowBox[{"-", "B"}], "*", "x"}], "]"}]}], "+", 
    RowBox[{"C", "*", 
     RowBox[{"Exp", "[", 
      RowBox[{
       RowBox[{"-", 
        FractionBox["1", "2"]}], "*", 
       SuperscriptBox[
        RowBox[{"(", 
         FractionBox[
          RowBox[{"x", "-", "D"}], "E"], ")"}], "2"]}], "]"}]}]}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"xobs", "=", " ", 
   RowBox[{"Range", "[", "19", "]"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"yobs", "=", 
   RowBox[{"{", 
    RowBox[{
    "800", ",", "704", ",", "578", ",", "458", ",", "339", ",", "323", ",", 
     "320", ",", "311", ",", "221", ",", "139", ",", "105", ",", "87", ",", 
     "73", ",", "60", ",", "56", ",", "46", ",", "36", ",", "32", ",", "26"}],
     "}"}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"ystd", "=", 
   RowBox[{"Map", "[", 
    RowBox[{
     RowBox[{"Sqrt", "[", "x", "]"}], ",", "yobs"}], "]"}]}], 
  ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"obs", "=", 
   RowBox[{"Transpose", "@", 
    RowBox[{"{", 
     RowBox[{"xobs", ",", "yobs"}], "}"}]}]}], ";"}], "\[IndentingNewLine]", 
 RowBox[{
  RowBox[{"p1", "=", 
   RowBox[{"Plot", "[", 
    RowBox[{
     RowBox[{"model", "[", 
      RowBox[{"x", ",", "a", ",", "b", ",", "c", ",", "mu", ",", "sigma"}], 
      "]"}], ",", 
     RowBox[{"{", 
      RowBox[{"x", ",", "0", ",", "20"}], "}"}]}], "]"}]}], ";"}]}], "Input",
 CellChangeTimes->{{3.661538528708692*^9, 3.661538560797431*^9}, {
   3.661538683699066*^9, 3.661538697890053*^9}, {3.6615387393610573`*^9, 
   3.661538964443571*^9}, {3.661539128559292*^9, 3.661539174731019*^9}, {
   3.661539611323238*^9, 3.661539612594648*^9}, {3.6615403046590147`*^9, 
   3.661540323849843*^9}, {3.6615403614762487`*^9, 3.661540367772293*^9}, 
   3.661540416423358*^9, {3.6615404563109303`*^9, 3.661540457031475*^9}, {
   3.661540518005616*^9, 3.661540518112833*^9}, {3.661540555882464*^9, 
   3.661540563228095*^9}, {3.661540660335642*^9, 3.661540668271838*^9}, {
   3.661540764282528*^9, 3.661540785891037*^9}, {3.661540816606577*^9, 
   3.661540886110013*^9}, {3.66154094260958*^9, 3.661540944431312*^9}, {
   3.661552067100721*^9, 3.661552069337474*^9}}],

Cell[BoxData[
 RowBox[{
  RowBox[{"p2", "=", 
   RowBox[{"ListPlot", "[", 
    RowBox[{"obs", ",", 
     RowBox[{"PlotRange", "\[Rule]", "All"}], ",", 
     RowBox[{"Frame", "\[Rule]", "True"}], ",", 
     RowBox[{"Axes", "\[Rule]", "True"}]}], "]"}]}], ";"}]], "Input",
 CellChangeTimes->{{3.66153970330896*^9, 3.661539720813014*^9}, {
   3.6615400198001966`*^9, 3.6615400259638033`*^9}, {3.661540063127277*^9, 
   3.661540088844529*^9}, {3.661540235548305*^9, 3.6615402379950047`*^9}, {
   3.661540325718753*^9, 3.661540349021196*^9}, {3.6615403812217293`*^9, 
   3.661540381717841*^9}, {3.661540422423003*^9, 3.6615404533396263`*^9}, {
   3.6615405658275557`*^9, 3.661540568491342*^9}, 3.661550963460696*^9}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"Show", "[", 
  RowBox[{"p1", ",", "p2"}], "]"}]], "Input",
 CellChangeTimes->{{3.661540327402401*^9, 3.6615403274235277`*^9}, {
  3.661540572091714*^9, 3.66154057565882*^9}}],

Cell[BoxData[
 GraphicsBox[{{{}, {}, 
    {RGBColor[0.368417, 0.506779, 0.709798], AbsoluteThickness[1.6], Opacity[
     1.], LineBox[CompressedData["
1:eJwV1nk8lN8XB3AqSkkiy4yZMRhLKtuElPhElEiSpZBdZMnyWMpWKMkypLTJ
koqi0lcUKSUqCS0iRIsKiYgoUv3u7695vec+c+e5555z7pVzD7T2msXHx7eb
n4/v/585se6Cmp7ZBjyK2/bPMB25DkOr7dn7DNd83D6goZOOzs3JIWz2EcOD
micWeS1PR8SGHSIC7NOG582jTrRLp8O0Hk4/ZS8bLj31w/ftdx6uxq9MGJWt
Mvwr1mh/4AIPH9yuSQ7LPjG8/H7otKAwD1Fb/Vy/ynYaarxX3z/wMRVCU9lP
/NUGDXPSBKf8k5IR/GB/6lDIuOFpm+HRvXFJULtw7EX5tSnDl1es3bVLEvHZ
0ofxbhUfHiidVO1+dRAn6YnMc66zIa3tfN0BCdALqSyd3SSI8edsq7Qrcah7
nW0VqDwfp1Lnc7bhADRT/xpImy3ELezOWSkSiw19q99p2IuiKGnQLu9sFPpX
3DT5MbQY9y62850/uA9RM0e4dyLFEev/8YPOxQi0hHocj4wTx/SczOr4nAiw
h/UnViWJQ/uKYcjLrAjU94zcrMgSR4iJd2JMYgSE79muLr0uDumrs+7M8olA
bpzcuoI+cWw3ey/XvCwCtYJVlknWS5CVZbY74WY45i4e2G2jKoES9XZUd4Zh
8rCTSZ6GBM7Fb48+1RqGvr/P2YM6Etip4e4Z2RyGR0NVr/cbS6DcpdvGojYM
iQ0pJiVOEvDY0h229HIYBA+oy81Kl0DzgUOtLfuIR8I7SsclYL+5mDvFIvN7
fb0xPSWBhKttb/bRyPzdLukmfJL4yu1g8C0h8zduNH0jLAnG5fgjTCEyfyG9
XFBJEgLffo2cHQ+FoHNN+s7tklhN9qXiSSgEmgU2LLgriZ67qa6HIkMhHHDW
o6dOEmfmmV72CAvFkoXcA6WNksjTV7hvFhQKzmbXqm0dknC+FJOwYlco1jff
XnZ2XBKXPSN5NtahiG8OFF2hKgWP+DfiqstDkRwguOKfhhSyRptMkpVDkbkw
x+yFrhROmm8ZHZMPRcHmxvgwEynYXKQ6emihqG3mTNx1lYJFvPUSmXmh4Gvp
7LQ8KYVvZq58+n0U5u0JmmTnSiF4nW6ESi8FUZG54uMXpFBWJyXAekuBbbnS
4mSZFE7d7kzmtFMwbOHVvGuWQuwV+pr8RxRiW4zPB82RhkK+QNWOyxQS93Td
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
Etc5tL6WZist/A9dLdap
      "]]}}, {{}, 
    {RGBColor[0.368417, 0.506779, 0.709798], PointSize[0.019444444444444445`],
      AbsoluteThickness[1.6], PointBox[CompressedData["
1:eJxTTMoPSmViYGAQBmIQDQEf7CF0pwNUAEq3QWkOCC3QBOULQOgFNVC+CIQ2
KIXyJaD8EihfBkrD+AoQuqAYyleCmpcN5atA6IREKF8NQjtEQfkaEPpAKJSv
BZUPgvJ1oLQflNaD0j5Q2gBKu0NpQyjtBKWNoLQDlDaG0lYOABGYGZU=
      "]]}, {}}},
  AspectRatio->NCache[GoldenRatio^(-1), 0.6180339887498948],
  Axes->{True, True},
  AxesLabel->{None, None},
  AxesOrigin->{0, 0},
  DisplayFunction->Identity,
  Frame->{{False, False}, {False, False}},
  FrameLabel->{{None, None}, {None, None}},
  FrameTicks->{{Automatic, Automatic}, {Automatic, Automatic}},
  GridLines->{None, None},
  GridLinesStyle->Directive[
    GrayLevel[0.5, 0.4]],
  Method->{"DefaultBoundaryStyle" -> Automatic, "ScalingFunctions" -> None},
  PlotRange->{{0, 20}, {0., 999.9999183673515}},
  PlotRangeClipping->True,
  PlotRangePadding->{{
     Scaled[0.02], 
     Scaled[0.02]}, {
     Scaled[0.05], 
     Scaled[0.05]}},
  Ticks->{Automatic, Automatic}]], "Output",
 CellChangeTimes->{3.661540576016551*^9, 3.661550965155533*^9, 
  3.661552411691206*^9}]
}, Open  ]],

Cell[BoxData[
 RowBox[{
  RowBox[{"chi2", "[", 
   RowBox[{"A_", ",", "B_", ",", "C_", ",", "D_", ",", "e_"}], "]"}], ":=", 
  RowBox[{"Total", "[", 
   RowBox[{"Table", "[", 
    RowBox[{
     FractionBox[
      SuperscriptBox[
       RowBox[{"(", 
        RowBox[{
         RowBox[{"model", "[", 
          RowBox[{
           RowBox[{"xobs", "[", 
            RowBox[{"[", "i", "]"}], "]"}], ",", "A", ",", "B", ",", "C", ",",
            "D", ",", "e"}], "]"}], "-", 
         RowBox[{"yobs", "[", 
          RowBox[{"[", "i", "]"}], "]"}]}], ")"}], "2"], 
      RowBox[{"model", "[", 
       RowBox[{
        RowBox[{"xobs", "[", 
         RowBox[{"[", "i", "]"}], "]"}], ",", "A", ",", "B", ",", "C", ",", 
        "D", ",", "e"}], "]"}]], ",", 
     RowBox[{"{", 
      RowBox[{"i", ",", "1", ",", 
       RowBox[{"Length", "[", "xobs", "]"}]}], "}"}]}], "]"}], 
   "]"}]}]], "Input",
 CellChangeTimes->{{3.6615510534770327`*^9, 3.661551060807399*^9}, {
  3.661551105200808*^9, 3.66155121560867*^9}, {3.6615512662738867`*^9, 
  3.661551455308552*^9}, {3.661551962716992*^9, 3.661551965524716*^9}, {
  3.661552196894318*^9, 3.661552200995797*^9}}],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"chi2", "[", 
  RowBox[{"a", ",", "b", ",", "c", ",", "mu", ",", "sigma"}], "]"}]], "Input",\

 CellChangeTimes->{{3.66155191650482*^9, 3.661551928120173*^9}}],

Cell[BoxData["11.719457029279617`"], "Output",
 CellChangeTimes->{3.661551928713849*^9, 3.6615521903351707`*^9, 
  3.661552411740237*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData[
 RowBox[{"sol", "=", 
  RowBox[{"FindMinimum", "[", 
   RowBox[{
    RowBox[{"chi2", "[", 
     RowBox[{"aa", ",", "bb", ",", "cc", ",", "dd", ",", "ee"}], "]"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"aa", ",", "1000"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"bb", ",", "0.2"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"cc", ",", "100"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"dd", ",", "8"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"ee", ",", "1"}], "}"}]}], "}"}], ",", 
    RowBox[{"Method", "->", "\"\<Newton\>\""}]}], "]"}]}]], "Input",
 CellChangeTimes->{{3.6615512446809998`*^9, 3.66155125310915*^9}, {
  3.6615515788259068`*^9, 3.6615515848266993`*^9}, {3.661551647904093*^9, 
  3.6615517012392178`*^9}, {3.661551743346376*^9, 3.66155181515201*^9}, {
  3.661552119976247*^9, 3.6615521550865726`*^9}, {3.661552234760941*^9, 
  3.661552256500207*^9}}],

Cell[BoxData[
 RowBox[{"{", 
  RowBox[{"9.439490168472993`", ",", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"aa", "\[Rule]", "1003.860183037922`"}], ",", 
     RowBox[{"bb", "\[Rule]", "0.19820260319759436`"}], ",", 
     RowBox[{"cc", "\[Rule]", "109.01864864137217`"}], ",", 
     RowBox[{"dd", "\[Rule]", "7.860140676823067`"}], ",", 
     RowBox[{"ee", "\[Rule]", "0.8975275802994251`"}]}], "}"}]}], 
  "}"}]], "Output",
 CellChangeTimes->{
  3.6615517021681843`*^9, 3.661551783248049*^9, 3.661551885976698*^9, {
   3.661552139907638*^9, 3.66155215564282*^9}, {3.661552214349904*^9, 
   3.6615522574764967`*^9}, 3.661552412018545*^9}]
}, Open  ]],

Cell[CellGroupData[{

Cell[BoxData["errors"], "Input",
 CellChangeTimes->{{3.661552287562285*^9, 3.661552288500649*^9}}],

Cell[BoxData["errors"], "Output",
 CellChangeTimes->{3.6615524122488737`*^9}]
}, Open  ]],

Cell[BoxData[""], "Input",
 CellChangeTimes->{{3.661552372920087*^9, 3.66155238212848*^9}, 
   3.661552423569776*^9}],

Cell[CellGroupData[{

Cell[BoxData[{
 RowBox[{"Needs", "[", "\"\<ErrorBarPlots`\>\"", "]"}], "\[IndentingNewLine]", 
 RowBox[{"Show", "[", 
  RowBox[{"ErrorListPlot", "[", 
   RowBox[{"obs", ",", "ystd"}], "]"}], "]"}]}], "Input",
 CellChangeTimes->{{3.661552260368476*^9, 3.661552273102023*^9}, {
  3.661552317656184*^9, 3.661552350537591*^9}, {3.661552425752082*^9, 
  3.661552426346591*^9}}],

Cell[BoxData[
 RowBox[{
  StyleBox[
   RowBox[{"Show", "::", "gtype"}], "MessageName"], 
  RowBox[{
  ":", " "}], "\<\"\[NoBreak]\\!\\(ErrorListPlot\\)\[NoBreak] is not a type \
of graphics. \\!\\(\\*ButtonBox[\\\"\[RightSkeleton]\\\", \
ButtonStyle->\\\"Link\\\", ButtonFrame->None, \
ButtonData:>\\\"paclet:ref/message/Show/gtype\\\", ButtonNote -> \
\\\"Show::gtype\\\"]\\)\"\>"}]], "Message", "MSG",
 CellChangeTimes->{
  3.661552350884582*^9, {3.6615524123471622`*^9, 3.661552427329866*^9}}],

Cell[BoxData[
 RowBox[{"Show", "[", 
  RowBox[{"ErrorListPlot", "[", 
   RowBox[{
    RowBox[{"{", 
     RowBox[{
      RowBox[{"{", 
       RowBox[{"1", ",", "800"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"2", ",", "704"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"3", ",", "578"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"4", ",", "458"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"5", ",", "339"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"6", ",", "323"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"7", ",", "320"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"8", ",", "311"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"9", ",", "221"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"10", ",", "139"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"11", ",", "105"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"12", ",", "87"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"13", ",", "73"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"14", ",", "60"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"15", ",", "56"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"16", ",", "46"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"17", ",", "36"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"18", ",", "32"}], "}"}], ",", 
      RowBox[{"{", 
       RowBox[{"19", ",", "26"}], "}"}]}], "}"}], ",", 
    RowBox[{"{", 
     RowBox[{
      RowBox[{
       SqrtBox["x"], "[", "800", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "704", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "578", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "458", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "339", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "323", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "320", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "311", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "221", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "139", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "105", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "87", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "73", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "60", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "56", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "46", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "36", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "32", "]"}], ",", 
      RowBox[{
       SqrtBox["x"], "[", "26", "]"}]}], "}"}]}], "]"}], "]"}]], "Output",
 CellChangeTimes->{
  3.661552350888053*^9, {3.661552412352982*^9, 3.66155242733538*^9}}]
}, Open  ]]
},
WindowSize->{724, 754},
WindowMargins->{{Automatic, 207}, {Automatic, 0}},
FrontEndVersion->"10.0 for Mac OS X x86 (32-bit, 64-bit Kernel) (June 27, \
2014)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[400, 13, 1052, 29, 131, "Input"],
Cell[1455, 44, 2453, 63, 153, "Input"],
Cell[3911, 109, 711, 13, 28, "Input"],
Cell[CellGroupData[{
Cell[4647, 126, 198, 4, 28, "Input"],
Cell[4848, 132, 8633, 153, 232, "Output"]
}, Open  ]],
Cell[13496, 288, 1153, 30, 100, "Input"],
Cell[CellGroupData[{
Cell[14674, 322, 182, 4, 28, "Input"],
Cell[14859, 328, 137, 2, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[15033, 335, 945, 23, 46, "Input"],
Cell[15981, 360, 640, 14, 28, "Output"]
}, Open  ]],
Cell[CellGroupData[{
Cell[16658, 379, 98, 1, 28, "Input"],
Cell[16759, 382, 77, 1, 28, "Output"]
}, Open  ]],
Cell[16851, 386, 117, 2, 28, "Input"],
Cell[CellGroupData[{
Cell[16993, 392, 372, 7, 46, "Input"],
Cell[17368, 401, 496, 11, 24, "Message"],
Cell[17867, 414, 2700, 85, 136, "Output"]
}, Open  ]]
}
]
*)

