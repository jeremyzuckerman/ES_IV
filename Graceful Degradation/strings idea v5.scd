/////////////////////////////////////////
//dynamic weighting of lines implemented!

//function: Added a duration mode switch: 0 = original way (sep time and dur), 1 = time and dur the same (legato)
(
~state1_ES4 = { |filename, bpm=60, gestureDur=10, durMode=0, veloMode=0, lines, velo2=80, speedUpProcess=10, randOct=0 /*chance from 0-1*/, accent=60, numMIDITracks=1|

	var arraySize=2048; //can not be an argument
	var notePchArr, noteStartArr, noteDurArr, noteVeloArr;
	var w1, w2, pch, start=0, dur, velo;
	var weighting, gestureDurScale;
	var notePch, noteStart/*e.g. 8ths, 16th, etc*/, noteDur, noteVelo;
	var m; //bpm doesn't matter when importing as SMF into a DAW

	notePchArr = Array.new(arraySize); //MIDI pchs added here. make a big array to avoid running out of space
	noteStartArr = Array.new(arraySize); //start times added here
	noteDurArr = Array.new(arraySize); //note durations added here
	noteVeloArr = Array.new(arraySize); //note velocities added here

	gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

	fork{
		var t1, t2;

		"wait ".post; gestureDurScale.post; " seconds...".postln;

		t1 = Main.elapsedTime;
		//first make the arrays
		while {
			t2 = Main.elapsedTime; //incremental time
			(t2-t1)<=(gestureDurScale); //time scaling
		}
		{
			var next;

			next = lines.next;
			pch = next[0]; //pitches
			start = next[1]; //start times
			dur = next[2]; //durations
			velo = next[3]; //velocities

			notePchArr.add(pch);
			noteStartArr.add(start);
			//noteDurArr.add(dur);
			if (durMode ==1){noteDurArr.add(start)}{noteDurArr.add(dur)}; //durMode arg switches between using the start values for duration and independent duration values
			noteVeloArr.add(velo);

			(start/speedUpProcess).wait; //time scaling for faster than RT while still using the SystemClock
		};

		noteStartArr = noteStartArr.integrate; //.integrate the note start times

		//make the MIDI file
		m = SimpleMIDIFile( filename ); // create empty file
		m.init1( numMIDITracks, 60, "4/4" );	// num separate midi tracks, tempo, 4/4 measures
		m.timeMode = \seconds;

		//MIDI data
		notePchArr.size.do{|i,c|
			var start_t, velocity, acc, r_oct, octave;

			r_oct = randOct.coin; //
			if (r_oct==false){octave=0; acc=0;}{octave=12; acc=accent;}; //

			if (c==0){start_t=0}{start_t=noteStartArr[c]-(noteStartArr[c]-noteStartArr[c-1])}; //so that the first note starts at time 0
			if (veloMode==0){velocity = noteVeloArr[c]}{velocity = velo2.next};
			m.addNote( notePchArr[c], velocity, start_t, noteDurArr[c]/*note length*/, 0, 0, 0 ); //note num, velo, startTime, upVel, chan, track*/
		};

		//finish file
		m.adjustEndOfTrack;
		m.write;
		"MIDI file is ready.".postln;
	};
};
)

//strings idea v5. all 4 'STATE 1' - incomplete
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var rhythmWeighting, dynWeighting;
var cresc, dim, gestureDur=30;
var speedUp = 50;

cresc = (10..100);
dim = (100..10);
rhythmWeighting = #[1,0.7];
dynWeighting = #[0.9,1];

fork{

	var vn1RandArr, vn2RandArr, vaRandArr, vcRandArr;

	vn1RandArr = Prand([6,7.5,8,9.25], inf).asStream;
	vn2RandArr = Prand([6,7.5,8,9.25], inf).asStream;
	vaRandArr = Prand([6,7.5,8,9.25], inf).asStream;
	vcRandArr = Prand([6,7.5,8,9.25], inf).asStream;

	~state1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn1 "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, 1
		, 1
/*		, Ptuple([ Pwrand([ Pseq([c6+7, c6+6, c6+2]), Pseq([c6+6, c6+1, c6-1]), Pseq([c6+2, c6+1, c5+9]) ], [1,1,1].normalizeSum) //pch
			, vn1RandArr //time & dur
			, 0 //not using this arg
		], inf).asStream;*/
		, Ptuple([ Pxrand([c6+7, c6+6, c6+2, c6+1, c6-1, c5+9], inf)//pch
			, vn1RandArr //time & dur
			, 0 //not using this arg
		], inf).asStream;
		, Prand( (2..8), inf).asStream
		, speedUp
	);

	0.2.wait;

	~state1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn2 "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, 1
		, 1
/*		, Ptuple([ Pwrand([ Pseq([c5+8, c5+6, c5+2]), Pseq([c5+6, c5+4, c5-1]), Pseq([c5+4, c5+2, c4+9]) ], [1,1,1].normalizeSum) //pch
			, vn2RandArr //time & dur
			, 0 //not using this arg
		], inf).asStream;*/
		, Ptuple([ Pxrand([c5+8,c5+6,c5+2,c5+4,c5-1,c4+9], inf) //pch
			, vn2RandArr //time & dur
			, 0 //not using this arg
		], inf).asStream;
		, Prand( (2..8), inf).asStream
		, speedUp
	);

	~state1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Va "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, 1
		, 1
/*		, Ptuple([ Pwrand([ Pseq([c5+1, c4+8, c4+6]), Pseq([c4+8, c4+3, c4+1]), Pseq([c4+3, c4+1, c3+9]) ], [1,1,1].normalizeSum) //pch
			, vaRandArr //time & dur
			, 0 //not using this arg
		], inf).asStream;*/
		, Ptuple([ Pxrand([c5+1,c4+8,c4+6,c4+3,c4+1,c3+9], inf) //pch
			, vaRandArr //time & dur
			, 0 //not using this arg
		], inf).asStream;
		, Prand( (2..8), inf).asStream
		, speedUp
	);

	0.2.wait;

	~state1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, 1
		, 1
/*		, Ptuple([ Pwrand([ Pseq([c4-1, c3+3, c2+8]), Pseq([c3+8, c3+1, c2+4]), Pseq([c3+6, c2+9, c2+1]) ], [1,1,1].normalizeSum) //pch
			, vcRandArr//time & dur
			, 0 //not using this arg
		], inf).asStream;*/
		, Ptuple([ Pxrand([c4-1,c3+3,c2+8,c3+1,c2+4,c3+6,c2+9,c2+1], inf) //pch
			, vcRandArr//time & dur
			, 0 //not using this arg
		], inf).asStream;
		, Prand( (2..8), inf).asStream
		, speedUp
	);
}
)


//strings idea v5. all 4 'STATE 3' - (single note lines, 16ths and 8th trips, <>, strings synched (16 repeats)
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var rhythmWeighting, dynWeighting;
var cresc, dim, gestureDur=120;

cresc = (10..100);
dim = (100..10);
rhythmWeighting = #[1,0.7];
dynWeighting = #[0.9,1];

fork{

	2.do{
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn "++Main.elapsedTime.round(0.1)++".mid" //filename
			, 120
			, gestureDur
			, Pwxrand([
				Ptuple([ Pseq([ c5+1, c4+8, c4+6 ], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
					, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
				, Ptuple([ Pseq([c5+3, c4+9, c4+8], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
					, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
				, Ptuple([ Pseq([c5+4, c5-1, c5-3], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
					, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
				, Ptuple([ Pseq([c5+3, c5-1, c5-3], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
					, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			], [1,1,1,1].normalizeSum, inf).asStream
			, 0
			, 80
			, 30
		);
		0.1.wait;
	};

	0.2.wait;

	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Va "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand([
			Ptuple([ Pseq([c4+9, c4+8, c4+3], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c4+8,c4+6,c4+4], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c4+6,c4+3,c4+1], 16), Pwrand([Pseq( [0.25,0.25,0.5], 16), Pseq( [1/3,1/3,1/3], 16)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], 16)
				, Pwrand([ Pseq( dim.resamp0(48) ), Pseq( cresc.resamp0(48) ) ], dynWeighting.normalizeSum) ])
		], [1,1,1].normalizeSum, inf).asStream
		, 0
		, 80
		, 30
	);

	0.2.wait;

	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
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
		, 30
	);
}
)
