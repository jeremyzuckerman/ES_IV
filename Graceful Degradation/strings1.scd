//Vn
(
var lineWeighting, restWeighting, gestureDur=40, speedUpProcess=60, gestureDurScale;
var bpm;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = Array.fill(40, 1);
restWeighting = #[1, 0.5, 0.1]; //weight the pauses between patterns [no pause, 1 beat, 3 beats]

fork{
	2.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file
			, Pwrand([

				//----------> INSERT PATTERNS: these patterns were generated with 'print all line combinations (strings).scd' <----------
				Pseq([
					Ptuple([ Pseq( Array.fill(32, 68) ), Pseq( Array.fill(32, 0.25) ), Pseq( Array.fill(32, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(48, 68) ), Pseq( Array.fill(48, 0.25) ), Pseq( Array.fill(48, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(56, 68) ), Pseq( Array.fill(56, 0.25) ), Pseq( Array.fill(56, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(64, 68) ), Pseq( Array.fill(64, 0.25) ), Pseq( Array.fill(64, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(76, 68) ), Pseq( Array.fill(76, 0.25) ), Pseq( Array.fill(76, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(24, 68) ), Pseq( Array.fill(24, 0.33333333333333) ), Pseq( Array.fill(24, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(36, 68) ), Pseq( Array.fill(36, 0.33333333333333) ), Pseq( Array.fill(36, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(42, 68) ), Pseq( Array.fill(42, 0.33333333333333) ), Pseq( Array.fill(42, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(48, 68) ), Pseq( Array.fill(48, 0.33333333333333) ), Pseq( Array.fill(48, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(57, 68) ), Pseq( Array.fill(57, 0.33333333333333) ), Pseq( Array.fill(57, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(16, 68) ), Pseq( Array.fill(16, 0.5) ), Pseq( Array.fill(16, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(24, 68) ), Pseq( Array.fill(24, 0.5) ), Pseq( Array.fill(24, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(28, 68) ), Pseq( Array.fill(28, 0.5) ), Pseq( Array.fill(28, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(32, 68) ), Pseq( Array.fill(32, 0.5) ), Pseq( Array.fill(32, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(38, 68) ), Pseq( Array.fill(38, 0.5) ), Pseq( Array.fill(38, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(12, 68) ), Pseq( Array.fill(12, 0.66666666666667) ), Pseq( Array.fill(12, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(18, 68) ), Pseq( Array.fill(18, 0.66666666666667) ), Pseq( Array.fill(18, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(21, 68) ), Pseq( Array.fill(21, 0.66666666666667) ), Pseq( Array.fill(21, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(24, 68) ), Pseq( Array.fill(24, 0.66666666666667) ), Pseq( Array.fill(24, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(28.5, 68) ), Pseq( Array.fill(28.5, 0.66666666666667) ), Pseq( Array.fill(28.5, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(32, 69) ), Pseq( Array.fill(32, 0.25) ), Pseq( Array.fill(32, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(48, 69) ), Pseq( Array.fill(48, 0.25) ), Pseq( Array.fill(48, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(56, 69) ), Pseq( Array.fill(56, 0.25) ), Pseq( Array.fill(56, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(64, 69) ), Pseq( Array.fill(64, 0.25) ), Pseq( Array.fill(64, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(76, 69) ), Pseq( Array.fill(76, 0.25) ), Pseq( Array.fill(76, 0.25) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(24, 69) ), Pseq( Array.fill(24, 0.33333333333333) ), Pseq( Array.fill(24, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(36, 69) ), Pseq( Array.fill(36, 0.33333333333333) ), Pseq( Array.fill(36, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(42, 69) ), Pseq( Array.fill(42, 0.33333333333333) ), Pseq( Array.fill(42, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(48, 69) ), Pseq( Array.fill(48, 0.33333333333333) ), Pseq( Array.fill(48, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(57, 69) ), Pseq( Array.fill(57, 0.33333333333333) ), Pseq( Array.fill(57, 0.33333333333333) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(16, 69) ), Pseq( Array.fill(16, 0.5) ), Pseq( Array.fill(16, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(24, 69) ), Pseq( Array.fill(24, 0.5) ), Pseq( Array.fill(24, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(28, 69) ), Pseq( Array.fill(28, 0.5) ), Pseq( Array.fill(28, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(32, 69) ), Pseq( Array.fill(32, 0.5) ), Pseq( Array.fill(32, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(38, 69) ), Pseq( Array.fill(38, 0.5) ), Pseq( Array.fill(38, 0.5) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(12, 69) ), Pseq( Array.fill(12, 0.66666666666667) ), Pseq( Array.fill(12, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(18, 69) ), Pseq( Array.fill(18, 0.66666666666667) ), Pseq( Array.fill(18, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(21, 69) ), Pseq( Array.fill(21, 0.66666666666667) ), Pseq( Array.fill(21, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(24, 69) ), Pseq( Array.fill(24, 0.66666666666667) ), Pseq( Array.fill(24, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				]),
				Pseq([
					Ptuple([ Pseq( Array.fill(28.5, 69) ), Pseq( Array.fill(28.5, 0.66666666666667) ), Pseq( Array.fill(28.5, 0.66666666666667) ) ]),
					Ptuple([ Pseq([1]), Pwrand([ Pseq([0]), Pseq([1]), Pseq([3]) ], restWeighting.normalizeSum), Pseq([1]) ])
				])
				//----------> PATTERNS DONE HERE <----------

			], lineWeighting.normalizeSum, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (30..50), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //writes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)