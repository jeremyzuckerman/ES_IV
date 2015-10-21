/////////////////////////////////////////
//dynamic weighting of lines implemented!

//system 2 strings C#m
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=120, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cmm=0.02, dSharpLoc=1, cSharpPhr=0.1; //polytonality weights
var vn1DSharpLocLines, vn1CSharpPhrLines, vn1CmmLines;
var vn2DSharpLocLines, vn2CSharpPhrLines, vn2CmmLines;
var vaDSharpLocLines, vaCSharpPhrLines, vaCmmLines;
var vcDSharpLocLines, vcCSharpPhrLines;

/*original polytonal :
vn1: Pseq([c6+3, c6+1, c6-1, c6-4]), Pseq([c6+2, c6+1, c6-1, c6-3, c6-4]), Pseq([c6, c6-3, c6-5, c5+5, c5+3]), Pseq([c6-3, c6-5, c5+5, c5+3, c5+2])
vn2: Pseq([c6-3, c6-4, c6-6, c5+4, c5+3]), Pseq([c6-3, c6-4, c6-6, c5+4, c5+2]), Pseq([c6-5, c5+3, c5+2, c5, c5-1]), Pseq([c5+3, c5+2, c5, c5-1, c5-3])
va: Pseq([c5+1, c5-1, c5-3, c5-4, c5-6]), Pseq([c5-3, c5-4, c5-6, c4+4, c4+2]), Pseq([c5-1, c5-3, c5-5, c4+5, c4+3]), Pseq([c5-5, c4+5, c4+3, c4+2, c4])
*/

vn1DSharpLocLines = [ Pseq([c6+3, c6+1, c6-1, c6-4]), Pseq([c6-1, c6-4, c6-6, c5+4, c5+3]), Pseq([c6-1, c6-3, c6-4, c5+6, c5+4]), Pseq([c6-3, c6-4, c5+6, c5+4, c5+3]) ];
vn2DSharpLocLines = [ Pseq([c6-3, c6-4, c6-6, c5+4, c5+3]), Pseq([c6-3, c6-6, c5+4, c5+3, c5+1]), Pseq([c6-4, c5+6, c5+3, c5+1, c5-1]), Pseq([c5+3, c5+1, c5-1, c5-3, c5-4]) ];
vaDSharpLocLines = [ Pseq([c5+1, c5-1, c5-3, c5-4, c5-6]), Pseq([c5-3, c5-4, c5-6, c4+4, c4+3]), Pseq([c5-1, c5-4, c5-6, c4+4, c4+3]), Pseq([c5-4, c5-6, c4+4, c4+3, c4+1]) ];
vcDSharpLocLines = [ Pseq([c4+3, c4+1, c4-1, c4-3, c4-4]), Pseq([c3+3, c3+1, c3-1, c3-3, c3-4]), Pseq([c4-3, c4-4, c4-6, c3+4, c3+3]), Pseq([c4-3, c4-4, c4-6, c3+4, c3+1]) ];

bpm=120;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([1, 1, 1, 1], [0.25, 0.75, 0.2].normalizeSum*gestureDurScale, [1,2,1]); //time scaled weighting envs
lw2 = Env([0, 0, 1, 1], [0.25, 0.75, 0.2].normalizeSum*gestureDurScale, [1,2,1]);
lw3 = Env([0, 0, 1, 1], [0.25, 0.75, 0.2].normalizeSum*gestureDurScale, [1,2,1]);

//env times scaled to gesture duration
/*line1_rw1 = Env([0.5, 0, 0], [gestureDur-2, 2], curve:-2);
line1_rw2 = Env([1,0,0], [gestureDur-2, 2], curve:2);
line1_rw3 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw4 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw5 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw6 = Env([0,1,1], [gestureDur-2, 2], curve:-2);
line1_rw7 = Env([0,1,1], [gestureDur-2, 2], curve:-2);

line2_rw1 = Env([0,0,0], [gestureDur-2, 2], curve:2);*/

line1_rw4 = Env([ 1, 1, 0.1 ], [0.25, 0.75].normalizeSum*gestureDurScale, [1, 2]);
line1_rw5 = Env([ 1, 1, 0, 0 ], [0.25, 0.75, 0.2].normalizeSum*gestureDurScale, [1, 2, 1]);
line1_rw6 = Env([ 1, 1, 0, 0 ],  [0.25, 0.75, 0.2].normalizeSum*gestureDurScale, [1, 2, 1]);

lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
//lineWeighting = #[0,1,0].normalizeSum; //static values

/*line1_restWeighting = #[0.5,1,1,0.2,0,0,0].normalizeSum; //[0, 0.5, 1, 1.5, 2, 4, 7.5]
line2_restWeighting = #[0,1,1,0.2,0,0,0].normalizeSum;*/

line1_restWeighting = Ptuple([ 0.5, 0.5, 0.5, line1_rw4, line1_rw5, line1_rw6, 0 ]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([0, 0.5, 0.5, line1_rw4, line1_rw5, line1_rw6, 0]).collect(_.normalizeSum).asStream;


//multiple iterations
fork{
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand(vn1DSharpLocLines, [1,1,1,1].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting)
					, Ptuple([ Pwrand(vn1DSharpLocLines, [1,1,1,1].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand(vn1DSharpLocLines, [1,1,1,1].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (80..100), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
	0.2.wait;

			~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn2 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand(vn2DSharpLocLines, [1,1,1,1].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting)
					, Ptuple([ Pwrand(vn2DSharpLocLines, [1,1,1,1].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand(vn2DSharpLocLines, [1,1,1,1].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (80..100), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
	0.2.wait;

				~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Va "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand(vaDSharpLocLines, [1,1,1,1].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting)
					, Ptuple([ Pwrand(vaDSharpLocLines, [1,1,1,1].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand(vaDSharpLocLines, [1,1,1,1].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (80..100), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
	0.2.wait;

					~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand(vcDSharpLocLines, [1,1,1,1].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting)
					, Ptuple([ Pwrand(vcDSharpLocLines, [1,1,1,1].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand(vcDSharpLocLines, [1,1,1,1].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (80..100), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
};
)

//system 2 strings
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=30, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cmm=0.02, dSharpLoc=1, cSharpPhr=0.1; //polytonality weights
var vn1DSharpLocLines, vn1CSharpPhrLines, vn1CmmLines;
var vn2DSharpLocLines, vn2CSharpPhrLines, vn2CmmLines;
var vaDSharpLocLines, vaCSharpPhrLines, vaCmmLines;
var vnDSharpLocLines, vcCSharpPhrLines;

// vn1DSharpLocLines = [ Pseq([c6+3, c6+1, c6-1, c6-4]), Pseq([c6+2, c6+1, c6-1, c6-3, c6-4]), Pseq([c6, c6-3, c6-5, c5+5, c5+3]), Pseq([c6-3, c6-5, c5+5, c5+3, c5+2]) ];

bpm=120;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0.5, 0, 0], [gestureDur-2, 2], curve:-2);
line1_rw2 = Env([1,0,0], [gestureDur-2, 2], curve:2);
line1_rw3 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw4 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw5 = Env([0,0,0], [gestureDur-2, 2], curve:2);
line1_rw6 = Env([0,1,1], [gestureDur-2, 2], curve:-2);
line1_rw7 = Env([0,1,1], [gestureDur-2, 2], curve:-2);

line2_rw1 = Env([0,0,0], [gestureDur-2, 2], curve:2);

// lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = #[0,1,0].normalizeSum; //static values

/*line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;*/
line1_restWeighting = #[0.5,1,1,1,0,0,0].normalizeSum; //[0, 0.5, 1, 1.5, 2, 4, 7.5]
line2_restWeighting = #[0,1,1,1,0,0,0].normalizeSum;

//multiple iterations
fork{
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand([ Pseq([c6+3, c6+1, c6-1, c6-4]), Pseq([c6+2, c6+1, c6-1, c6-3, c6-4]), Pseq([c6, c6-3, c6-5, c5+5, c5+3]), Pseq([c6-3, c6-5, c5+5, c5+3, c5+2]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting) //for v2 used line1_restWeighting here
					, Ptuple([ Pwrand([ Pseq([c6+3, c6+1, c6-1, c6-4]), Pseq([c6+2, c6+1, c6-1, c6-3, c6-4]), Pseq([c6, c6-3, c6-5, c5+5, c5+3]), Pseq([c6-3, c6-5, c5+5, c5+3, c5+2]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand([ Pseq([c6+3, c6+1, c6-1, c6-4]), Pseq([c6+2, c6+1, c6-1, c6-3, c6-4]), Pseq([c6, c6-3, c6-5, c5+5, c5+3]), Pseq([c6-3, c6-5, c5+5, c5+3, c5+2]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (80..100), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
	0.2.wait;

			~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn2 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand([ Pseq([c6-3, c6-4, c6-6, c5+4, c5+3]), Pseq([c6-3, c6-4, c6-6, c5+4, c5+2]), Pseq([c6-5, c5+3, c5+2, c5, c5-1]), Pseq([c5+3, c5+2, c5, c5-1, c5-3]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting) //for v2 used line1_restWeighting here
					, Ptuple([ Pwrand([ Pseq([c6-3, c6-4, c6-6, c5+4, c5+3]), Pseq([c6-3, c6-4, c6-6, c5+4, c5+2]), Pseq([c6-5, c5+3, c5+2, c5, c5-1]), Pseq([c5+3, c5+2, c5, c5-1, c5-3]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand([ Pseq([c6-3, c6-4, c6-6, c5+4, c5+3]), Pseq([c6-3, c6-4, c6-6, c5+4, c5+2]), Pseq([c6-5, c5+3, c5+2, c5, c5-1]), Pseq([c5+3, c5+2, c5, c5-1, c5-3]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (80..100), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
	0.2.wait;

				~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Va "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand([ Pseq([c5+1, c5-1, c5-3, c5-4, c5-6]), Pseq([c5-3, c5-4, c5-6, c4+4, c4+2]), Pseq([c5-1, c5-3, c5-5, c4+5, c4+3]), Pseq([c5-5, c4+5, c4+3, c4+2, c4]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting) //for v2 used line1_restWeighting here
					, Ptuple([ Pwrand([ Pseq([c5+1, c5-1, c5-3, c5-4, c5-6]), Pseq([c5-3, c5-4, c5-6, c4+4, c4+2]), Pseq([c5-1, c5-3, c5-5, c4+5, c4+3]), Pseq([c5-5, c4+5, c4+3, c4+2, c4]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand([ Pseq([c5+1, c5-1, c5-3, c5-4, c5-6]), Pseq([c5-3, c5-4, c5-6, c4+4, c4+2]), Pseq([c5-1, c5-3, c5-5, c4+5, c4+3]), Pseq([c5-5, c4+5, c4+3, c4+2, c4]) ], [dSharpLoc, cSharpPhr, cmm*0.5, cmm*0.5].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (80..100), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
	0.2.wait;

					~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				, 	Ptuple([ Pwrand([ Pseq([c4+3, c4+1, c4-1, c4-3, c4-4]), Pseq([c3+3, c3+1, c3-1, c3-3, c3-4]), Pseq([c4-3, c4-4, c4-6, c3+4, c3+2]), Pseq([c4-3, c4-4, c4-6, c3+4, c3+1]) ], [dSharpLoc/3, dSharpLoc/3, cSharpPhr, dSharpLoc/3].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting) //for v2 used line1_restWeighting here
					, Ptuple([ Pwrand([ Pseq([c4+3, c4+1, c4-1, c4-3, c4-4]), Pseq([c3+3, c3+1, c3-1, c3-3, c3-4]), Pseq([c4-3, c4-4, c4-6, c3+4, c3+2]), Pseq([c4-3, c4-4, c4-6, c3+4, c3+1]) ], [dSharpLoc/3, dSharpLoc/3, cSharpPhr, dSharpLoc/3].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
				])
				, Pseq([
					Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
					, Ptuple([ Pwrand([ Pseq([c4+3, c4+1, c4-1, c4-3, c4-4]), Pseq([c3+3, c3+1, c3-1, c3-3, c3-4]), Pseq([c4-3, c4-4, c4-6, c3+4, c3+2]), Pseq([c4-3, c4-4, c4-6, c3+4, c3+1]) ], [dSharpLoc/3, dSharpLoc/3, cSharpPhr, dSharpLoc/3].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (80..100), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
};
)