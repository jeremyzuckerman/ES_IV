//not working correctly!

/*function:
- for making marker points.
- env mode using an envelope to index an array
*/
(
~markers = { |filename, bpm=60, gestureDur=10, envMode=0, stream, speedUpProcess=10, array, numMIDITracks=1|

	var arraySize=2048; //can not be an argument
	var notePchArr, noteStartArr, noteDurArr, noteVeloArr;
	var w1, w2, pch, start=0, dur, velo;
	var weighting, gestureDurScale;
	var notePch, noteStart/*e.g. 8ths, 16th, etc*/, noteDur, noteVelo;
	var m;
	var envStartArr;

	envStartArr = Array.new(arraySize); //start times from array here
	noteStartArr = Array.new(arraySize); //start times added here
	noteDurArr = Array.new(arraySize); //note durations added here

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
			var start, envStart;

			start = stream.next;
			envStart = array[start];

			envStartArr.add(envStart);
			noteStartArr.add(start);
			noteDurArr.add(start);

			(start/speedUpProcess).wait; //time scaling for faster than RT while still using the SystemClock
		};

		noteStartArr = noteStartArr.integrate; //.integrate the note start times

		//make the MIDI file
		m = SimpleMIDIFile( filename ); // create empty file
		m.init1( numMIDITracks, 60, "4/4" );	// num separate midi tracks, tempo, 4/4 measures
		m.timeMode = \seconds;

		//MIDI data
		noteStartArr.size.do{|i,c|
			var start_t, velocity, acc, r_oct, octave;

			if (envMode ==0){
				if (c==0){start_t=0}{start_t=noteStartArr[c]-(noteStartArr[c]-noteStartArr[c-1])}; //so that the first note starts at time 0
			}
			{
				if (c==0){start_t=0}{start_t=envStartArr[c]-(envStartArr[c]-envStartArr[c-1]) }; //so that the first note starts at time 0
			};
			m.addNote( 108, 1, start_t, noteDurArr[c]/*note length*/, 0, 0, 0 ); //note num, velo, startTime, upVel, chan, track*/
		};
		//finish file
		m.adjustEndOfTrack;
		m.write;
		"MIDI file is ready.".postln;
	};
};
)

//example
(
var array, stream, dur=10;

array  = #[1,2,4,8,12];
stream = Env([array.size-1, 0], [dur]).asStream.round(1);

~markers.value(
	"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/startPoints "++Main.elapsedTime.round(0.1)++".mid" //filename
	, 120
	, dur
	, 1
	, stream
	, 40
	, array
)
)