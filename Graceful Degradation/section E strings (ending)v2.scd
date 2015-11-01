
//begining. lines transform from homogenous to varied rhythmically - v7 longer. added exponential curves to rest weighting envs
(
var lineWeighting, lw1, lw2, lw3, gestureDur=28, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
var testenv, testenv2, testenv3;
var c1,c2,c3,c4,c5,c6,c7,c8;
var vnVaLines, vcLines;
var restWeighting;
var tonalityWeighting, cSharpMin, cSharpPhr, cmm;

c1=24; c2=36; c3=48; c4=60; c5=72; c6=84; c7=96; //might be easier to add and subtract from these numbers in the patterns instead of typing each midinote number.

bpm=120;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([1, 0, 0], [2/3, 1/3].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([0, 0, 1, 1], [0.5, 0, 0.5].normalizeSum*gestureDurScale);
lw3 = Env([1, 0, 0], [2/3, 1/3].normalizeSum*gestureDurScale);
lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes

/*//env times scaled to gesture duration
line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(7, {1/8}).normalizeSum*(gestureDurScale, curve:2));
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:2);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:2);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:2);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:2);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:-2);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale, curve:-2);

line2_rw1 = Env(Array.fill(8, {0}), Array.fill(7, {1/8}).normalizeSum*gestureDurScale);*/

//	line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
// line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
restWeighting = #[0, 1, 0.1, 0.1, 0, 0, 0].normalizeSum;

//tonalityWeighting = #[1,0.8,0.1,0.05].normalizeSum;
//tonalityWeighting = #[1, 0.4, 0.05, 0.05].normalizeSum;
cSharpMin = 1;
// cSharpPhr = Env(#[0.8, 0.8, 0, 0], [0.25, 0.6, 0.15].normalizeSum*gestureDurScale, curve:-1.5);
cSharpPhr = Env(#[0.8, 0.8, 0, 0].reverse, [0.25, 0.6, 0.15].normalizeSum*gestureDurScale, curve:-1.5);
cmm = Env(#[0.3, 0.3, 0, 0].reverse, [0.25, 0.6, 0.15].normalizeSum*gestureDurScale, curve:-1);
tonalityWeighting = Ptuple([cSharpMin, cSharpPhr, cmm]).collect(_.normalizeSum).asStream;

vnVaLines = [ [c4+9, c4+8, c4+6, c4+4, c4+3], [c4+8, c4+6, c4+4, c4+2, c4+1], [c4+9, c4+7, c4+5, c4+3, c4+2], [c5-1, c4+7, c4+5, c4+3, c4+2] ];
vcLines = [ [c4+4, c4+3, c4+1, c4-1, c4-3], [c4+4, c4+2, c4+1, c4-1, c4-3], [c4+3, c4+2, c4, c4-1, c4-3], [c4+3, c4, c4-1, c4-3, c4-5] ];

//multiple iterations
fork{
	3.do{
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vns&Va "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				//all 16ths
				Pseq([
					Ptuple([ Pwrand([ Pseq(vnVaLines[0]), Pseq(vnVaLines[1]), Pseq(vnVaLines[2]), Pseq(vnVaLines[3]) ], tonalityWeighting), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
					, Pwrand([ Ptuple([ Pseq([c7+12]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], restWeighting)
				])
				//all quintuplets
				, Pseq([
					Ptuple([ Pwrand([ Pseq(vnVaLines[0]), Pseq(vnVaLines[1]), Pseq(vnVaLines[2]), Pseq(vnVaLines[3]) ], tonalityWeighting), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([c7+12]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], restWeighting) //for v2 used line1_restWeighting here
				])
				//3 8th trips + 2 8ths
				, Pseq([
					Ptuple([ Pwrand([ Pseq(vnVaLines[0]), Pseq(vnVaLines[1]), Pseq(vnVaLines[2]), Pseq(vnVaLines[3]) ], tonalityWeighting), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([c7+12]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([c7+12]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], restWeighting) //line3_restWeighting
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (15..20), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
	//Vc
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
		, bpm
		, gestureDur

		, Pwrand([
			//all 16ths
			Pseq([
				Ptuple([ Pwrand([ Pseq(vcLines[0]), Pseq(vcLines[1]), Pseq(vcLines[2]), Pseq(vcLines[3]) ], tonalityWeighting), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				, Pwrand([ Ptuple([ Pseq([c7+12]), Pseq([0]), Pseq([0]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
				], restWeighting)
			])
			//all quintuplets
			, Pseq([
				Ptuple([ Pwrand([ Pseq(vcLines[0]), Pseq(vcLines[1]), Pseq(vcLines[2]), Pseq(vcLines[3]) ], tonalityWeighting), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				, Pwrand([ Ptuple([ Pseq([c7+12]), Pseq([0]), Pseq([0]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
				], restWeighting) //for v2 used line1_restWeighting here
			])
			//3 8th trips + 1 8ths
			, Pseq([
				Ptuple([ Pwrand([ Pseq(vcLines[0]), Pseq(vcLines[1]), Pseq(vcLines[2]), Pseq(vcLines[3]) ], tonalityWeighting), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				, Pwrand([ Ptuple([ Pseq([c7+12]), Pseq([0]), Pseq([0]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
					, Ptuple([ Pseq([c7+12]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
				], restWeighting) //line3_restWeighting
			])
		], lineWeighting, inf).asStream //lines

		, 1 //velocity switch. 0: in line, 1: separate pattern

		, Prand( (15..25), inf).asStream //if velocity switch == 1, this pattern is used for velocity
		, speedUpProcess //makes file faster than RT by this factor
	);
};
)