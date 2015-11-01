/////////////////////////////////////////
//dynamic weighting of lines implemented!

/*function:
- Added a duration mode switch: 0 = original way (sep time and dur), 1 = time and dur the same (legato)
- Added dynamic random octave displacement with specifiable octaves up or down.
*/
(
~algoMIDI4 = { |filename, bpm=60, gestureDur=10, durMode=0, veloMode=0, lines, velo2=80, speedUpProcess=10, randOct=0 /*chance from 0-1*/, octTrans=1 /*12*this*/, accent=60, numMIDITracks=1|

	var arraySize=2048; //can not be an argument
	var notePchArr, noteStartArr, noteDurArr, noteVeloArr;
	var w1, w2, pch, start=0, dur, velo;
	var weighting, gestureDurScale;
	var notePch, noteStart/*e.g. 8ths, 16th, etc*/, noteDur, noteVelo;
	var m;
	var randOctArr;


	notePchArr = Array.new(arraySize); //MIDI pchs added here. make a big array to avoid running out of space
	noteStartArr = Array.new(arraySize); //start times added here
	noteDurArr = Array.new(arraySize); //note durations added here
	noteVeloArr = Array.new(arraySize); //note velocities added here
	randOctArr = Array.new(arraySize); //octave displacement data (note-by-note)

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

			randOctArr.add(randOct.next);

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

			// r_oct = randOctArr[c].coin; //use a Pattern
			r_oct = randOctArr[c].coin; //use a Pattern
			if (r_oct==false){octave=0; acc=0;}{octave= (12*octTrans); acc=accent;}; //randOct

			if (c==0){start_t=0}{start_t=noteStartArr[c]-(noteStartArr[c]-noteStartArr[c-1])}; //so that the first note starts at time 0
			if (veloMode==0){velocity = noteVeloArr[c]}{velocity = velo2.next}; //veloMode switches between velocity data in the line Ptuple as a fourth pattern, or as a Pattern separate from the Ptuple (velo2 arg)
			m.addNote( notePchArr[c]+octave, velocity, start_t, noteDurArr[c]/*note length*/, 0, 0, 0 ); //note num, velo, startTime, upVel, chan, track*/
		};

		//finish file
		m.adjustEndOfTrack;
		m.write;
		"MIDI file is ready.".postln;
	};
};
)