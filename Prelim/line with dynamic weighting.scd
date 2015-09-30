/////////////////////////////
//dynamic weighting of lines
(
var lines, arraySize=2048, notePchArr, noteStartArr, noteDurArr, noteVeloArr;
var w1,w2, gestureDur=100, pch, start=0, dur, velo;
var speedUpProcess=20; //faster than RT. use to timescale envelopes, the while loop condition and the while loop wait time
var weighting, gestureDurScale;
var notePch, noteStart/*e.g. 8ths, 16th, etc*/, noteDur, noteVelo;
var m, filename, numMIDITracks=1, bpm=60; //bpm doesn't matter when importing as SMF into a DAW

notePchArr = Array.new(arraySize); //MIDI pchs added here. make a big array to avoid running out of space
noteStartArr = Array.new(arraySize); //start times added here
noteDurArr = Array.new(arraySize); //note durations added here
noteVeloArr = Array.new(arraySize); //note velocities added here

filename = "/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid";

gestureDurScale=gestureDur/speedUpProcess;

//weighting envelopes for
w1 = Env([1,0], [gestureDurScale]); //time scaling
w2 = Env([0,1], [gestureDurScale]); //time scaling

/*w1 = Env([1,1,0,0], [gestureDurScale*0.5, 0, gestureDurScale*0.5]); //predictable results to test
w2 = Env([0,0,1,1], [gestureDurScale*0.5, 0, gestureDurScale*0.5]); //predictable results to test*/

weighting = Ptuple([w1, w2]).collect(_.normalizeSum); //dynamic weighting method using envelopes

/*p = Pwrand([Pseq([0.25,0.25,0.5]), Pseq([0.5, 0.5, 0.25]) ],
weighting,
inf).asStream;*/

lines = Pwrand([
	Ptuple([Pseq([60,62,63]), Pseq([0.25,0.25,0.5]), Pseq([0.25,0.25,0.25]), Pseq([80,80,80])]),
	Ptuple([Pseq([67,69,65]), Pseq([0.25,0.5,0.25]), Pseq([0.25,0.5,0.25]), Pseq([80,80,80])])
], weighting, inf).asStream;

fork{
	var t1, t2;

	"thinking...".postln;

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

	//post the arrays:
	"pchs:".postln;
	notePchArr.postcs;
	/*"start times:".postln;
	noteStartArr.postcs;
	"durs:".postln;
	noteDurArr.postcs;
	"velo:".postln;
	noteVeloArr.postcs;*/

	//make the MIDI file
	m = SimpleMIDIFile( filename ); // create empty file
	m.init1( numMIDITracks, bpm, "4/4" );	// num separate midi tracks, tempo, 4/4 measures
	m.timeMode = \seconds;  // change from default to something useful

	//MIDI data
	notePchArr.size.do{|i,c|
		var start_t;
		if (c==0){start_t=0}{start_t=noteStartArr[c]-(noteStartArr[c]-noteStartArr[c-1])};
		//if (velo_sw==0){velocity = velo[i]}{velocity = velo2.next};
		m.addNote( notePchArr[c], noteVeloArr[c], start_t, noteDurArr[c]/*note length*/, 0, 0, 0 ); //note num, velo, startTime, upVel, chan, track*/
	};

	//write to the MIDI file
	m.adjustEndOfTrack;
	// 0.1.wait; //unncessary?
	m.write;
	"done".postln;
};
)

