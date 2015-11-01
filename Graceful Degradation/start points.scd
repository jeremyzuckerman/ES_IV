//use to make random start points
(
var time;
time = #[6,7,8]*2;

~algoMIDI1_ES4.value(
	"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/startPoints "++Main.elapsedTime.round(0.1)++".mid" //filename
	, 120
	, 120 //duration of file
	, Ptuple([ Pseq([1]), Pwrand([  Pseq([time[0]]), Pseq([time[1]]), Pseq([time[2]]), Pseq([time[3]]) ], [1.3,1,1,0.9].normalizeSum), Pseq([0.1]) ], inf).asStream
	, 1
	, 1
	, 50
)
)