///////////////////////////////////////////////////////////
//generates & formats all patterns possiblities. copy and paste

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

pchs = #[68,69];
rhythms = [1/4,1/3,1/2,2/3];
nextPch = #[8,12,14,16,19];

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