/////////////////////////////////////////
//dynamic weighting of lines implemented!


//like system1_strings but with dynamic polytonality - (single note lines, 16ths and 8th trips, <>, strings synched (16 repeats)
//v2 Mostly tonal-> PT -> tonal
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var rhythmWeighting, dynWeighting;
var cresc, dim, gestureDur=120, speedUpProcess=50;
var cmm, cSharpPhr, cSharpMin, polytonalityFl, polytonalityCl, polytonalityBsCl, polytonalityBsn;
var gestureDurScale, bpm=120;

cresc = (10..100);
dim = (100..10);
rhythmWeighting = #[1,0.7];
dynWeighting = #[0.9,1];

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

//dynamic control of the polytonality:
cSharpMin = Env(#[1,1],  [1].normalizeSum*gestureDurScale, curve:2);
// cSharpPhr = Env(#[0,0,1,1],  [0.25,0.5,0.25].normalizeSum*gestureDurScale, curve:2);
cSharpPhr = Env(#[0.5, 0.5, 1, 0, 0],  [1/6, 2/6, 2/6, 1/6].normalizeSum*gestureDurScale, curve:2);
// cmm = Env([0,0,1,1], [0.25,0.5,0.25].normalizeSum*gestureDurScale, curve:2);
cmm = Env(#[0.15, 0.15, 1, 0, 0], [1/6, 2/6, 2/6, 1/6].normalizeSum*gestureDurScale, curve:2);

//line1_rw1 = Env([0.5, 0, 0], [gestureDur-2, 2], curve:-2);

polytonalityFl = Ptuple([cmm, cSharpMin, cmm, cSharpPhr, cmm]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
polytonalityCl = Ptuple([cmm, cSharpPhr, cSharpMin, cmm, cSharpMin]).collect(_.normalizeSum).asStream;
polytonalityBsCl = Ptuple([cSharpMin, cmm, cSharpMin, cmm, cSharpMin]).collect(_.normalizeSum).asStream;
polytonalityBsn = #[1,1,1]; //all in C#m

// polytonalityFl = Array.fill(5, 1);
// polytonalityCl = Array.fill(5, 1);
// polytonalityBsCl = Array.fill(5, 1);


fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Fl "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand([
			//Cmm
			Ptuple([ Pseq([ c6+2, c6, c6-5 ], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//C#m
			, Ptuple([ Pseq([ c6+1, c6-4, c5+4], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//Cmm
			, Ptuple([ Pseq([c6-3, c6-5, c5+2], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//C#phr
			, Ptuple([ Pseq([c6-4, c5+4, c5+2], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//Cmm
			, Ptuple([ Pseq([c6-5, c5+3, c5+2], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
		], polytonalityFl, inf).asStream //use envelopes on the Cmm and C#phry weighting to control amount of polytonality
		, 0
		, 80
		, speedUpProcess
	);

	0.2.wait;

		~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Cl "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand([
			//Cmm
			Ptuple([ Pseq([c6-3, c5+3, c5+2], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//C#phr
			, Ptuple([ Pseq([c6-6, c5+2,c5+1], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//C#m
			, Ptuple([ Pseq([c5+4, c5-1, c5-3], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//Cmm
			, Ptuple([ Pseq([c5+2, c5, c5-5], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//C#m
			, Ptuple([ Pseq([c5+1, c5-4, c5-6], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
		], polytonalityCl, inf).asStream
		, 0
		, 80
		, speedUpProcess
	);

	0.2.wait;

	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/BsCl "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand([
			//C#m
			Ptuple([ Pseq([c5-4, c4+3, c4+1], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//Cmm
			, Ptuple([ Pseq([c5-5, c4+3, c4+2], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//C#m
			, Ptuple([ Pseq([c4+3, c4+1, c4-1], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//Cmm
			, Ptuple([ Pseq([c4+2, c4-3, c4-5], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			//C#m
			, Ptuple([ Pseq([c4+1, c4-4, c3+4], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
		], polytonalityBsCl, inf).asStream
		, 0
		, 80
		, speedUpProcess
	);

	0.2.wait;

	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Bsn "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand([
			Ptuple([ Pseq([c4+1, c4-4, c4-6], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c4+1,c4-3,c4-4], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c4-4,c3+3,c3+1], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
		], [1,1,1].normalizeSum, inf).asStream
		, 0
		, 80
		, speedUpProcess
	);
}
)
