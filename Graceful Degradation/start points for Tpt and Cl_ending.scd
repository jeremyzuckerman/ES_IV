//use to make random start points
(
var array, stream, dur=65, bpm=120, speedUpProcess=50;
var gestureDurScale;

gestureDurScale=(dur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

array  = #[1,2,4,8,12];
stream = Env([array.size-1, 0, 0], [0.6, 0.4].normalizeSum*gestureDurScale).asStream.round(1);

//|filename, bpm=60, gestureDur=10, envMode=0, stream, speedUpProcess=10, array, numMIDITracks=1|

~markers.value(
	"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/startPoints "++Main.elapsedTime.round(0.1)++".mid" //filename
	, bpm
	, dur
	, 1
	, stream
	, speedUpProcess
	, array
)
)