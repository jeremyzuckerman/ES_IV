(
/*~f = {|bpm=60, line, velo_sw=0, velo2, filename, numNotes=500, numMIDITracks=1, rand_oct=0, accent=60|*/
var pch;
var bpm=60, line, velo_sw=0, velo2, filename, numNotes=50, numMIDITracks=1;
var now = 0;
var p1=60,p2=72,p3=67,p4=71;
var startArray, time, startArrayIntegrate;
var speedUpFactor = 10; //make array faster than real time. use this same factor to scale envelopes and any bpm data

startArray = Array.new(2096); //can grow to 2056 slots
time = Pseq(#[0.25, 0.25, 0.5], inf).asStream;

pch = Pwrand([ Pseq([p1,p2,p3]), Pseq([p2,p3,p4,p1]) ], [1,1].normalizeSum, inf).asStream;

m = SimpleMIDIFile( "/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1.mid" ); // create empty file
m.init1( numMIDITracks, bpm, "4/4" );	// num separate midi tracks, tempo, 4/4 measures
m.timeMode = \seconds;  // change from default to something useful

fork{
//make the array:
	numNotes.do{|i, c|
		var nextStart;

		nextStart = time.next;
		startArray.add(nextStart); //fill the array with the start times
		(nextStart/speedUpFactor).wait;
	};

	//.integrate it:
	startArrayIntegrate=startArray.integrate;

	numNotes.do{|i,c|
		var start;

		if (c==0){start=0}{start=startArrayIntegrate[c]-(startArrayIntegrate[c]-startArrayIntegrate[c-1])};
		m.addNote( pch.next, 100, start, 0.25/*note length*/, 0, 0, 0 ); //note num, velo, startTime, upVel, chan, track
		//	};
		//0.01.wait; //realtime to use envelopes on weighting. **wait time doesn't have to be same as midi note start times**
	};

	//to write file
	m.adjustEndOfTrack;
	m.write;
	"done".postln;
	startArrayIntegrate.postcs;
};
)

