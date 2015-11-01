///////////////////////////////////////////////////////////
//generates & formats all patterns possiblities. copy and paste

//B'->A' 4 FORMATTED
(
var pStream, rStream, npStream, pchs, rhythms, nextPch;
var pNext=0, rNext=0, npNext=0, iterations;
var factor1, wrappingArray;

//pchs = ["c4+1", "c4+3", "c4+6", "c4+8", "c4+9"]++["c4+2"]++["c4+7", "c4+5", "c4"]; // Va C#m, C#phr, Cmm
//pchs = ["c4+6", "c4+8", "c5-3", "c5-1", "c5+1", "c5+3", "c5+4"]++["c5+2"]++["c4+5", "c4+7", "c5"]; //Vn C#m, C#phr, Cmm
pchs = ["c3+1", "c3+3", "c4-6", "c4-4", "c4-3", "c4+1"]++["c3+2"]++["c3+5", "c3+7", "c4"]; //Vc C#m, C#phr, Cmm

rhythms = #[2.5,3, 3.5,4, 6,7];

"Pxrand([".postln;

//nested do loops
pchs.size.do{|p|
	"Pwxrand([".postln;
	3.do{|r| //3 groups of two rhythms
		"Prand([".postln;
		2.do{|i| //grouping of two rhythms
			"Ptuple([ Pseq([".post; pchs[p].post; "]), Pseq([".post; rhythms[i+(2*r)].post; "]), Pseq([".post; rhythms[i+(2*r)].post; "]), Prand((90..100)) ]) ,".postln;
		};
		"]), ".postln;
	};
	"	], durW_Envs) ,".postln;
};
//*****Don't forgot to remove the last comma******
"], Array.fill(".post; pchs.size.post; ", 1).normalizeSum, inf).asStream".postln;
)

//B'->A' 3
(
var pStream, rStream, npStream, pchs, rhythms, nextPch;
var pNext=0, rNext=0, npNext=0, iterations;
var factor1, wrappingArray;

pchs = ["c4+1", "c4+3", "c4+6", "c4+8", "c4+9"]; // Va C#m
//pchs = ["c4+2"]; //Va C# Phry
//pchs = ["c4+7", "c4+5", "c4"]; //Va Cmm
//pchs = ["c4+6", "c4+8", "c5-3", "c5-1", "c5+1", "c5+3", "c5+4"]; //Vn C#m
//pchs = ["c5+2"]; //Vn C# phr
//pchs = ["c4+5", "c4+7", "c5"]; //Vn Cmm
//pchs = ["c3+1", "c3+3", "c4-6", "c4-4", "c4-3", "c4+1"]; //vc C#m
//pchs = ["c3+2"]; //Vc C#phr
//pchs = ["c3+5", "c3+7", "c4"]; //Vc Cmm

rhythms = #[3,4,6];
nextPch = #[1];

pStream = Pseq( (0..pchs.size-1), inf ).asStream;
rStream = Pseq( (0..rhythms.size-1), inf).asStream;

wrappingArray = nextPch.size; //choose one of the arrays to wrap

iterations = pchs.size*rhythms.size*wrappingArray; //multiple the sizes of the three arrays
factor1 = wrappingArray*rhythms.size; //wrappingArray * 2nd largest

iterations.do{|i|
	var noteNum, rhythmVal, beats, numItemsInPattern, noteDur;

	if (i%factor1==0){pNext = pStream.next};
	if (i%wrappingArray==0){rNext = rStream.next};
	noteNum = pchs[pNext];
	rhythmVal = rhythms[rNext];
	beats = nextPch[i%wrappingArray]; //wraps as opposed to the other values

	noteDur = rhythmVal; //for clarity

	numItemsInPattern = beats/rhythmVal;

	//[numItemsInPattern, noteNum, numItemsInPattern, rhythmVal, numItemsInPattern, 0.2].postln;

	"Ptuple([ Pseq([".post; noteNum.post; "]), ".post; //pch
	"Pseq([".post; rhythmVal.post; "]), ".post; //rhythm
	"Pseq([".post; rhythmVal.post; "]), ".post; //duration
	"Prand((90..100)) ]) ,".postln;
	//*****Don't forgot to remove the last comma******
}
)

/*
With Rests.

eg:
Pseq([
Ptuple([ Pseq( Array.fill(32, 68) ), Pseq( Array.fill(32, 1/4) ), Pseq( Array.fill(32, 1/4) ) ]),
Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], [1,1,1].normalizeSum), Pseq([1]) ])
]),
*/
(
var pStream, rStream, npStream, pchs, rhythms, nextPch;
var pNext=0, rNext=0, npNext=0, iterations;
var factor1, wrappingArray;

pchs = ["c4+1", "c4+3", "c4+6", "c4+8", "c4+9"];
rhythms = #[2,3];
nextPch = #[2,3];

pStream = Pseq( (0..pchs.size-1), inf ).asStream;
rStream = Pseq( (0..rhythms.size-1), inf).asStream;

wrappingArray = nextPch.size; //choose one of the arrays to wrap

iterations = pchs.size*rhythms.size*wrappingArray; //multiple the sizes of the three arrays
factor1 = wrappingArray*rhythms.size; //wrappingArray * 2nd largest

iterations.do{|i|
	var noteNum, rhythmVal, beats, numItemsInPattern, noteDur;

	if (i%factor1==0){pNext = pStream.next};
	if (i%wrappingArray==0){rNext = rStream.next};
	noteNum = pchs[pNext];
	rhythmVal = rhythms[rNext];
	beats = nextPch[i%wrappingArray]; //wraps as opposed to the other values

	noteDur = rhythmVal; //for clarity

	numItemsInPattern = beats/rhythmVal;

	//[numItemsInPattern, noteNum, numItemsInPattern, rhythmVal, numItemsInPattern, 0.2].postln;

	"Pseq([".postln;
	"Ptuple([ Pseq( Array.fill(".post; numItemsInPattern.post; ", ".post; noteNum.post;
	") ), Pseq( Array.fill(".post; numItemsInPattern.post; ", ".post; rhythmVal.post;
	") ), Pseq( Array.fill(".post; numItemsInPattern.post; ", ".post; noteDur.post;
	") ) ]),".postln;
	"Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])".postln;
	"]),".postln; //*****Don't forgot to remove the last comma******
}
)