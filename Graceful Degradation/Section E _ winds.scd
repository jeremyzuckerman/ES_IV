/////////////////////////////////////////
//dynamic weighting of lines implemented!

(
//wind gestures 2 (nested function instead of copying code)
~wind_gestures_FC = {|filename, gestureDur=60, transpose=0|

	var lineWeighting, lw1, lw2, restWeighting, speedUpProcess=40, gestureDurScale;
	var bpm;
	var c1,c2,c3,c4,c5,c6,c7,c8;
	/*var filename, transpose=0;

	filename = "Fl";*/

	bpm=120;

	gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

	// //env times scaled to gesture duration
	// lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
	// lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
	// );

	//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
	lineWeighting = #[1,0.2].normalizeSum; //static values

	c1=24; c2=36; c3=48; c4=60; c5=72; c6=84; c7=96; //easier to add and subtract from these numbers in the patterns instead of typing each midinote.

	//multiple iterations
	fork{
		//Fl
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/"++filename++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file
			, Pwrand([
				Pseq([
					Ptuple([ Pseq([ c6+1, c5+8, c5+4, c5+1 ]+transpose), Pseq( Array.fill(4, 0.25) ), Pseq( Array.fill(4, 0.1) ) ])
					, Pwrand([
						Pwrand([
							Ptuple([ Pseq([ c5+8, c5+4, c5+2, c5+1]+transpose), Pseq(Array.fill(4, 0.25)), Pseq(Array.fill(4, 0.1)) ])
							, Ptuple([ Pseq([ c5+8, c5+4, c5+2, c5+1]+transpose), Pseq(Array.fill(3, 1/3)++[1]), Pseq(Array.fill(4, 1/3)) ])
						], [1,0.5].normalizeSum)
						, Pwrand([
							Ptuple([ Pseq([ c5+8, c5+6, c5+4, c5+2 ]+transpose), Pseq(Array.fill(4, 0.25)), Pseq(Array.fill(4, 0.1)) ])
							, Ptuple([ Pseq([ c5+8, c5+6, c5+4, c5+2 ]+transpose), Pseq(Array.fill(3, 1/3)++[1]), Pseq(Array.fill(4, 1/3)) ])
						], [1,0.5].normalizeSum)
						, Pwrand([
							Ptuple([ Pseq([c5+9, c5+7, c5+2, c5, c6+3]+transpose), Pseq( Array.fill(4, 0.25)++[1] ), Pseq( Array.fill(5, 0.25) ) ])
							, Ptuple([ Pseq([c5+9, c5+7, c5+2, c5, c6+3]+transpose), Pseq( Array.fill(3, 1/6)++[0.5, 1] ), Pseq( Array.fill(4, 1/6)++[0.15] ) ])
						], [1,0.5].normalizeSum)
					], [1,1,0.5].normalizeSum)
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
					], [0,1].normalizeSum)
				])
				, Pwrand([
					Pseq([
						Ptuple([ Pseq([ c6+1, c5+8, c5+4, c5+1, c5+9, c5+7, c5+3, c5+2, c5+8, c5+6, c5+4, c5+3 ]), Pseq( Array.fill(12, 0.25) ), Pseq( Array.fill(12, 0.1) ) ])
						, Pwrand([
							Ptuple([ Pseq([ c5+6, c5+4, c5+2, c5+1 ]+transpose), Pseq(Array.fill(4, 0.25)), Pseq(Array.fill(4, 0.1)) ])
							, Ptuple([ Pseq([ c5+6, c5+4, c5+2, c5+1 ]+transpose), Pseq([1/3,1/3,1/3,1]), Pseq(Array.fill(4, 1/3)) ])
							, Ptuple([ Pseq([ c5+6, c5+4, c5+2, c5+1 ]+transpose), Pseq([1/6,1/6,1/6,1]), Pseq(Array.fill(4, 1/6)) ])
						], [0,1,0.4].normalizeSum)
						, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
							, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						], [0,1].normalizeSum)
					])
					, Pseq([
						Ptuple([ Pseq([ c6+1, c5+8, c5+4, c5+2, c5+9, c5+7, c5+5, c5+3, c5+8, c5+6, c5+4, c5+2]+transpose), Pseq( Array.fill(12, 0.25) ), Pseq( Array.fill(12, 0.1) ) ])
						, Pwrand([
							Ptuple([ Pseq([ c5+6, c5+4, c5+2, c5+1 ]+transpose), Pseq(Array.fill(4, 0.25)), Pseq(Array.fill(4, 0.1)) ])
							, Ptuple([ Pseq([ c5+6, c5+4, c5+2, c5+1 ]+transpose), Pseq([1/3,1/3,1/3,1]), Pseq(Array.fill(4, 1/3)) ])
							, Ptuple([ Pseq([ c5+6, c5+4, c5+2, c5+1 ]+transpose), Pseq([1/6,1/6,1/6,1]), Pseq(Array.fill(4, 1/6)) ])
						], [0,1,0.4].normalizeSum)
						, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
							, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						], [0,1].normalizeSum)
					])
				], [1,1].normalizeSum)
			], lineWeighting, inf).asStream //lines
			, 1 //velocity switch. 0: in line, 1: separate pattern
			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
	}
}
)

(
//execture the nested functions
~wind_gestures_FC.value("Fl", 120, 0);
~wind_gestures_FC.value("Bsn", 120, -12);
)

//using the Bsn patterns for Bs Cl - Ostinato
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var rhythmWeighting, dynWeighting;
var cresc, dim, gestureDur=120, speedUpProcess=50;
var cmm, cSharpPhr, cSharpMin, polytonalityFl, polytonalityCl, polytonalityBsCl, polytonalityBsn;
var gestureDurScale, bpm=120;
var beatsArray, beatsWeighting;
var flPats1, flPats2, flPats3, flPats4, flPats5, flPats6, flPats;
var clPats1, clPats2, clPats3, clPats4, clPats5, clPats;
var bsClPats1, bsClPats2, bsClPats3, bsClPats4, bsClPats5, bsClPats;
var bsnPats1, bsnPats2, bsnPats3, bsnPats4, bsnPats5, bsnPats;
var b16, b15, b14, b12;

cresc = (10..100);
dim = (100..10);
//rhythmWeighting = #[1,0.7];
rhythmWeighting = #[1, 0.85];

dynWeighting = #[0.9,1];

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

//dynamic control of the polytonality:
cSharpMin = Env(#[1,1],  [1].normalizeSum*gestureDurScale, curve:2);
cSharpPhr = 0;
cmm = 0;
// cSharpPhr = Env(#[0.2, 0.4, 1, 0, 0],  [1/6, 2/6, 2/6, 1/6].normalizeSum*gestureDurScale, curve:2);
//cmm = Env(#[0.05, 0.15, 1, 0, 0], [1/6, 2/6, 2/6, 1/6].normalizeSum*gestureDurScale, curve:2);

polytonalityFl = Ptuple([cmm, cSharpMin, cmm, cSharpPhr, cmm, cSharpMin]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
polytonalityCl = Ptuple([cmm, cSharpPhr, cSharpMin, cmm, cSharpMin]).collect(_.normalizeSum).asStream;
polytonalityBsCl = Ptuple([cSharpMin, cmm, cSharpMin, cmm, cSharpMin]).collect(_.normalizeSum).asStream;
polytonalityBsn = #[1,1,1]; //all in C#m

beatsArray = #[16, 15, 14, 12];
// beatsWeighting = Array.fill(beatsArray.size, 1).normalizeSum;

b16 = Env(#[1,1], #[1].normalizeSum*gestureDurScale);
b15 = Env(#[0, 0, 1, 1], #[0.25, 0, 0.75].normalizeSum*gestureDurScale);
b14 = Env(#[0, 0, 1, 1], #[0.5, 0, 0.5].normalizeSum*gestureDurScale);
b12 = Env(#[0, 0, 1, 1], #[0.75, 0, 0.25].normalizeSum*gestureDurScale);
beatsWeighting = Ptuple([b16, 0, 0, 0]).collect(_.normalizeSum).asStream;

////////////
//Line Data:

//Fl Patterns
flPats1 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6+2, c6, c6-5], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), Pseq( [0.25,0.25,0.5], beatsArray[i]), Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats1 = Pwrand(flPats1, beatsWeighting);

flPats2 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6+1, c6-4, c5+4], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), Pseq( [0.25,0.25,0.5], beatsArray[i]), Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats2 = Pwrand(flPats2, beatsWeighting);

flPats3 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-3, c6-5, c5+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats3 = Pwrand(flPats3, beatsWeighting);

flPats4 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-4, c5+4, c5+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats4 = Pwrand(flPats4, beatsWeighting);

flPats5 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-5, c5+3, c5+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats5 = Pwrand(flPats5, beatsWeighting);

flPats6 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-1, c5+4, c5+1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats6 = Pwrand(flPats6, beatsWeighting);

flPats = Pwxrand([flPats1, flPats2, flPats3, flPats4, flPats5, flPats6], polytonalityFl, inf).asStream; //each array contains a pitch sequence with every possible beatsArray value

//Cl
clPats1 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-3, c5+3, c5+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats1 = Pwrand(clPats1, beatsWeighting);

clPats2 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-6, c5+2,c5+1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats2 = Pwrand(clPats2, beatsWeighting);

clPats3 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5+4, c5-1, c5-3], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats3 = Pwrand(clPats3, beatsWeighting);

clPats4 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5+2, c5, c5-5], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats4 = Pwrand(clPats4, beatsWeighting);

clPats5 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5+1, c5-4, c5-6], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats5 = Pwrand(clPats5, beatsWeighting);

clPats = Pwxrand([clPats1, clPats2, clPats3, clPats4, clPats5], polytonalityCl, inf).asStream;

//Bs Cl
bsClPats1 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5-4, c4+3, c4+1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats1 = Pwrand(bsClPats1, beatsWeighting);

bsClPats2 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5-5, c4+3, c4+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats2 = Pwrand(bsClPats2, beatsWeighting);

bsClPats3 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+3, c4+1, c4-1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats3 = Pwrand(bsClPats3, beatsWeighting);

bsClPats4 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+2, c4-3, c4-5], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats4 = Pwrand(bsClPats4, beatsWeighting);

bsClPats5 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+1, c4-4, c3+4], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats5 = Pwrand(bsClPats5, beatsWeighting);

bsClPats = Pwxrand([bsClPats1, bsClPats2, bsClPats3, bsClPats4, bsClPats5], polytonalityBsCl, inf).asStream;

//Bsn
bsnPats1 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+1, c4-4, c4-6], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsnPats1 = Pwrand(bsnPats1, beatsWeighting);

bsnPats2 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+1,c4-3,c4-4], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsnPats2 = Pwrand(bsnPats2, beatsWeighting);

bsnPats3 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4-4,c3+3,c3+1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsnPats3 = Pwrand(bsnPats3, beatsWeighting);

bsnPats = Pwxrand([bsnPats1, bsnPats2, bsnPats3, bsnPats4, bsnPats5], [1,1,1].normalizeSum, inf).asStream;
//////////

fork{
	/*	~algoMIDI4.value(
	//~algoMIDI4 = { |filename, bpm=60, gestureDur=10, durMode=0, veloMode=0, lines, velo2=80, speedUpProcess=10, randOct=0 /*chance from 0-1*/, octTrans=1 /*12*this*/, accent=60, numMIDITracks=1|

	"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Fl "++Main.elapsedTime.round(0.1)++".mid" //filename
	, 120
	, gestureDur
	, 1
	, 0
	, flPats
	, 80
	, speedUpProcess
	);

	0.2.wait;

	~algoMIDI4.value(
	"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Cl "++Main.elapsedTime.round(0.1)++".mid" //filename
	, 120
	, gestureDur
	, 1
	, 0
	, clPats
	, 80
	, speedUpProcess
	);

	0.2.wait;*/

	~algoMIDI4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/BsCl "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, 1
		, 0
		, bsClPats
		, 80
		, speedUpProcess
	);

	0.2.wait;

	~algoMIDI4.value(
	"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Bsn "++Main.elapsedTime.round(0.1)++".mid" //filename
	, 120
	, gestureDur
	, 1
	, 0
	, bsnPats
	, 80
	, speedUpProcess
	);
}
)
