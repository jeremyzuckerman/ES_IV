/* make a polyphonic version using do loops for the multiple SimpleMIDIFile(s) and nested Ptuples in the function call */

/////////////////////////////////////////
//dynamic weighting of lines implemented!

//function:
(
~algoMIDI1_ES4 = { |filename, gestureDur=10, lines, veloSwitch=0, velo2=80, speedUpProcess=10, randOct=0 /*chance from 0-1*/, accent=60, numMIDITracks=1|

	var arraySize=2048; //can not be an argument
	var notePchArr, noteStartArr, noteDurArr, noteVeloArr;
	var w1, w2, pch, start=0, dur, velo;
	var weighting, gestureDurScale;
	var notePch, noteStart/*e.g. 8ths, 16th, etc*/, noteDur, noteVelo;
	var m, bpm=60; //bpm doesn't matter when importing as SMF into a DAW

	notePchArr = Array.new(arraySize); //MIDI pchs added here. make a big array to avoid running out of space
	noteStartArr = Array.new(arraySize); //start times added here
	noteDurArr = Array.new(arraySize); //note durations added here
	noteVeloArr = Array.new(arraySize); //note velocities added here

	gestureDurScale=gestureDur/speedUpProcess;

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
		m.init1( numMIDITracks, bpm, "4/4" );	// num separate midi tracks, tempo, 4/4 measures
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

//evaluation (where the musical decisions are made):
(
var w1, w2, weighting, gestureDur=30, speedUpProcess=10, gestureDurScale;

gestureDurScale=gestureDur/speedUpProcess; //timescaling. makes file faster than RT

w1 = Env([1,0], [gestureDurScale]); //time scaled weighting envs
w2 = Env([0,1], [gestureDurScale]);

weighting = Ptuple([w1, w2]).collect(_.normalizeSum); //dynamic weighting method using envelopes
//weighting = [0,1]; //static values

//do some iterations and choose best one
fork{
	2.do{
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename

			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Ptuple([ Pseq([60,62,63]), Pseq([0.25,0.25,0.5]), Pseq([0.25,0.25,0.25]) ]), //only have three Patterns in the Ptuplea because velocity switch is set==1
				Ptuple([ Pseq([67,69,65]), Pseq([0.25,0.5,0.25]), Pseq([0.25,0.5,0.25]) ])
			], weighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)

