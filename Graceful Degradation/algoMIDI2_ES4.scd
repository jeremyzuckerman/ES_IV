/////////////////////////////////////////
//dynamic weighting of lines implemented!

//separate function for the MIDI file so forked function calls can write to the same file
(
~midiFile = { |filename, numMIDITracks=1|
	//make the MIDI file. use global variable
	m = SimpleMIDIFile( filename ); // create empty file
	m.init1( numMIDITracks, 60, "4/4" );	// num separate midi tracks, tempo, 4/4 measures
	m.timeMode = \seconds;
};
)

//synched instances - polyphonic but each voice is a separate MIDI file
(
~algoMIDI2_ES4 = { |instances=2, instanceWait=1, bpm=60, gestureDur=10, lines, veloSwitch=0, velo2=80, speedUpProcess=10, randOct=0 /*chance from 0-1*/, accent=60, |

	var arraySize=1024; //can not be an argument
	var notePchArr, noteStartArr, noteDurArr, noteVeloArr;
	var w1, w2, pch, start=0, dur, velo;
	var weighting, gestureDurScale;
	var notePch, noteStart/*e.g. 8ths, 16th, etc*/, noteDur, noteVelo;
	var m; //bpm doesn't matter when importing as SMF into a DAW
	var files; //names of MIDI files

	files = Array.new(50); //can have a maximum of 50 instances

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

//after ~algoMIDI2_ES4 function calls are complete, call this function
(
~writeMIDIFile = {
	//finish file
	m.adjustEndOfTrack;
	m.write;
	"MIDI file is ready.".postln;
}
)

//the calls
//this way i can have them start at the same time
(
fork{
~midiFile.value("/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid"); //filename
	0.1.wait;

	2.do{
		var
~algoMIDI2_ES4.value(
	120
	, 5