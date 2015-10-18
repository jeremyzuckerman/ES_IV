/////////////////////////////////////////
//dynamic weighting of lines implemented!

//function:
(
~algoMIDI1_ES4 = { |filename, bpm=60, gestureDur=10, lines, veloSwitch=0, velo2=80, speedUpProcess=10, randOct=0 /*chance from 0-1*/, accent=60, numMIDITracks=1|

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
			noteDurArr.add(dur);
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
			if (veloSwitch==0){velocity = noteVeloArr[c]}{velocity = velo2.next};
			m.addNote( notePchArr[c], velocity, start_t, noteDurArr[c]/*note length*/, 0, 0, 0 ); //note num, velo, startTime, upVel, chan, track*/
		};

		//finish file
		m.adjustEndOfTrack;
		m.write;
		"MIDI file is ready.".postln;
	};
};
)

//v7 beginning ending. density quickly decreases. Put rests 1st in sequece. (DIDN'T USE THIS)
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=7, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=120;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0.5, 0, 0], [gestureDur-2, 2], curve:-2);
line1_rw2 = Env([1,0,0], [gestureDur-2, 2], curve:2);
line1_rw3 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw4 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw5 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw6 = Env([0,1,1], [gestureDur-2, 2], curve:-2);
line1_rw7 = Env([0,1,1], [gestureDur-2, 2], curve:-2);

line2_rw1 = Env([0,0,0], [gestureDur-2, 2], curve:2);

/*
line2_rw1 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw2 = Env([0.5,0.5,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw3 = Env([0,0,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line2_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);

line3_rw1 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw2 = Env([0.5,0.5,10,10], [1,1,1].normalizeSum*gestureDurScale);
line3_rw3 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);
*/

/*testenv = Env([0,0,1,1], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv2 = Env([0,0,0,0], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv3  = Env([1,1,0,0], [1,2,1].normalizeSum*gestureDurScale);*/

lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
//lineWeighting = #[1,1,0.5].normalizeSum; //static values

/*line1_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line2_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line3_restWeighting = #[0,1,0,0,5,8].normalizeSum;*/

/*
line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6]).collect(_.normalizeSum).asStream;
line3_restWeighting = Ptuple([line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6]).collect(_.normalizeSum).asStream;
*/

//line1_restWeighting = Ptuple([testenv, testenv2, testenv2, testenv2, testenv2, testenv3]).collect(_.normalizeSum).asStream;
line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 63;
p6 = 61;

p7 = 69;
p8 = 67;
p9 = 65;
p10 = 63;
p11 = 62;
p12 = 71;

//multiple iterations
fork{
	4.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //for v2 used line1_restWeighting here
					, Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)

//begining. lines transform from homogenous to varied rhythmically - v7 longer. added exponential curves to rest weighting envs
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=130, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=120;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(7, {1/8}).normalizeSum*(gestureDurScale, curve:2);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:2);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:2);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:2);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:2);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:-2);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:-2);

line2_rw1 = Env(Array.fill(8, {0}), Array.fill(7, {1/8}).normalizeSum*gestureDurScale);

/*
line2_rw1 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw2 = Env([0.5,0.5,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw3 = Env([0,0,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line2_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);

line3_rw1 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw2 = Env([0.5,0.5,10,10], [1,1,1].normalizeSum*gestureDurScale);
line3_rw3 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);
*/

/*testenv = Env([0,0,1,1], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv2 = Env([0,0,0,0], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv3  = Env([1,1,0,0], [1,2,1].normalizeSum*gestureDurScale);*/

lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
//lineWeighting = #[1,1,0.5].normalizeSum; //static values

/*line1_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line2_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line3_restWeighting = #[0,1,0,0,5,8].normalizeSum;*/

/*
line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6]).collect(_.normalizeSum).asStream;
line3_restWeighting = Ptuple([line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6]).collect(_.normalizeSum).asStream;
*/

//line1_restWeighting = Ptuple([testenv, testenv2, testenv2, testenv2, testenv2, testenv3]).collect(_.normalizeSum).asStream;
line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 63;
p6 = 61;

p7 = 69;
p8 = 67;
p9 = 65;
p10 = 63;
p11 = 62;
p12 = 71;

//multiple iterations
fork{
	4.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
/*					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p2,p8,p9,p10]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])*/ //mistake in last pseq pchs
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //for v2 used line1_restWeighting here
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)

//begining. lines transform from homogenous to varied rhythmically - v4 Added some poly-tonality and fixed envelopes (had one extra time value). changed 4th pattern
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=60, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);

line2_rw1 = Env(Array.fill(8, {0}), Array.fill(7, {1/8}).normalizeSum*gestureDurScale);

/*
line2_rw1 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw2 = Env([0.5,0.5,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw3 = Env([0,0,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line2_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);

line3_rw1 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw2 = Env([0.5,0.5,10,10], [1,1,1].normalizeSum*gestureDurScale);
line3_rw3 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);
*/

/*testenv = Env([0,0,1,1], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv2 = Env([0,0,0,0], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv3  = Env([1,1,0,0], [1,2,1].normalizeSum*gestureDurScale);*/

lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
//lineWeighting = #[1,1,0.5].normalizeSum; //static values

/*line1_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line2_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line3_restWeighting = #[0,1,0,0,5,8].normalizeSum;*/

/*
line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6]).collect(_.normalizeSum).asStream;
line3_restWeighting = Ptuple([line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6]).collect(_.normalizeSum).asStream;
*/

//line1_restWeighting = Ptuple([testenv, testenv2, testenv2, testenv2, testenv2, testenv3]).collect(_.normalizeSum).asStream;
line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 63;
p6 = 61;

p7 = 69;
p8 = 67;
p9 = 65;
p10 = 63;
p11 = 62;
p12 = 71;

//multiple iterations
fork{
	4.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
/*					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p2,p8,p9,p10]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])*/ //mistake in last pseq pchs
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //for v2 used line1_restWeighting here
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)


//begining. lines transform from homogenous to varied rhythmically - v3 Added some poly-tonality and fixed envelopes (had one extra time value). See below for v2 note
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=60, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);

line2_rw1 = Env(Array.fill(8, {0}), Array.fill(7, {1/8}).normalizeSum*gestureDurScale);

/*
line2_rw1 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw2 = Env([0.5,0.5,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw3 = Env([0,0,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line2_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);

line3_rw1 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw2 = Env([0.5,0.5,10,10], [1,1,1].normalizeSum*gestureDurScale);
line3_rw3 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);
*/

/*testenv = Env([0,0,1,1], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv2 = Env([0,0,0,0], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv3  = Env([1,1,0,0], [1,2,1].normalizeSum*gestureDurScale);*/

lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
//lineWeighting = #[1,1,0.5].normalizeSum; //static values

/*line1_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line2_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line3_restWeighting = #[0,1,0,0,5,8].normalizeSum;*/

/*
line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6]).collect(_.normalizeSum).asStream;
line3_restWeighting = Ptuple([line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6]).collect(_.normalizeSum).asStream;
*/

//line1_restWeighting = Ptuple([testenv, testenv2, testenv2, testenv2, testenv2, testenv3]).collect(_.normalizeSum).asStream;
line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 63;
p6 = 61;

p7 = 69;
p8 = 67;
p9 = 65;
p10 = 63;
p11 = 62;
p12 = 71;

//multiple iterations
fork{
	4.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p9,p8,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p8,p9,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //for v2 used line1_restWeighting here
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5-1,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p9,p8,p10,p11]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)

//begining. lines transform from homogenous to varied rhythmically - v2b. See below for v2 note
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=60, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 62;
p6 = 61;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);

line2_rw1 = Env(Array.fill(8, {0}), Array.fill(8, {1/8}).normalizeSum*gestureDurScale);

/*
line2_rw1 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw2 = Env([0.5,0.5,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw3 = Env([0,0,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line2_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);

line3_rw1 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw2 = Env([0.5,0.5,10,10], [1,1,1].normalizeSum*gestureDurScale);
line3_rw3 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);
*/

/*testenv = Env([0,0,1,1], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv2 = Env([0,0,0,0], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv3  = Env([1,1,0,0], [1,2,1].normalizeSum*gestureDurScale);*/

lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
//lineWeighting = #[1,1,0.5].normalizeSum; //static values

/*line1_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line2_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line3_restWeighting = #[0,1,0,0,5,8].normalizeSum;*/

/*
line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6]).collect(_.normalizeSum).asStream;
line3_restWeighting = Ptuple([line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6]).collect(_.normalizeSum).asStream;
*/

//line1_restWeighting = Ptuple([testenv, testenv2, testenv2, testenv2, testenv2, testenv3]).collect(_.normalizeSum).asStream;
line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;

//do some iterations and choose best one
fork{
	4.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5,p6]) ], [1,1].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5,p6]) ], [1,1].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //for v2 used line1_restWeighting here
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5,p6]) ], [1,1].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)


//begining. lines transform from homogenous to varied rhythmically
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=60, speedUpProcess=60, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 62;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);

/*
line2_rw1 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw2 = Env([0.5,0.5,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw3 = Env([0,0,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line2_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);

line3_rw1 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw2 = Env([0.5,0.5,10,10], [1,1,1].normalizeSum*gestureDurScale);
line3_rw3 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);
*/

/*testenv = Env([0,0,1,1], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv2 = Env([0,0,0,0], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv3  = Env([1,1,0,0], [1,2,1].normalizeSum*gestureDurScale);*/

lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
//lineWeighting = #[1,1,0.5].normalizeSum; //static values

/*line1_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line2_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line3_restWeighting = #[0,1,0,0,5,8].normalizeSum;*/

/*
line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6]).collect(_.normalizeSum).asStream;
line3_restWeighting = Ptuple([line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6]).collect(_.normalizeSum).asStream;
*/

//line1_restWeighting = Ptuple([testenv, testenv2, testenv2, testenv2, testenv2, testenv3]).collect(_.normalizeSum).asStream;
line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;

//do some iterations and choose best one
fork{
	4.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				])
				, Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line2_restWeighting
				])
				, Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)
