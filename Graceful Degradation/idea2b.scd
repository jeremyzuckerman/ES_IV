

//begining. lines transform from homogenous to varied rhythmically - v4 Added some poly-tonality and fixed envelopes (had one extra time value). changed 4th pattern
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=60, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
var c1,c2,c3,c4,c5,c6,c7,c8;

/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(7, {1/8}).normalizeSum*gestureDurScale);

line2_rw1 = Env(Array.fill(8, {0}), Array.fill(7, {1/8}).normalizeSum*gestureDurScale);

/*
line2_rw1 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw2 = Env([0.5,0.5,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw3 = Env([0,0,5,5], [1,1,1].normalizeSum*gestureDurScale);
line2_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line2_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line2_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);

line3_rw1 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw2 = Env([0.5,0.5,10,10], [1,1,1].normalizeSum*gestureDurScale);
line3_rw3 = Env([0,0,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw4 = Env([0,0,1,1], [1,1,1].normalizeSum*gestureDurScale);
line3_rw5 = Env([5,5,0,0], [1,1,1].normalizeSum*gestureDurScale);
line3_rw6 = Env([10,10,0,0], [1,1,1].normalizeSum*gestureDurScale);
*/

/*testenv = Env([0,0,1,1], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv2 = Env([0,0,0,0], [ 1,2,1 ].normalizeSum*gestureDurScale);
testenv3  = Env([1,1,0,0], [1,2,1].normalizeSum*gestureDurScale);*/

//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = #[1,1,0.5, 0.2].normalizeSum; //static values

/*line1_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line2_restWeighting = #[0,1,0,0,5,8].normalizeSum;
line3_restWeighting = #[0,1,0,0,5,8].normalizeSum;*/

/*
line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6]).collect(_.normalizeSum).asStream;
line3_restWeighting = Ptuple([line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6]).collect(_.normalizeSum).asStream;
*/

//line1_restWeighting = Ptuple([testenv, testenv2, testenv2, testenv2, testenv2, testenv3]).collect(_.normalizeSum).asStream;
/*line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;*/
line1_restWeighting = #[0.5,1,0,0,0,0,0].normalizeSum;
line2_restWeighting = #[0,1,0,0,0,0,0].normalizeSum;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 63;
p6 = 61;

p7 = 69;
p8 = 68;
p9 = 66;
p10 = 63;
p11 = 61;
p12 = 71;

c1=24; c2=36; c3=48; c4=60; c5=72; c6=84; c7=96; //might be easier to add and subtract from these numbers in the patterns instead of typing each midinote.

//multiple iterations
fork{
	4.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p2,p9,p4,p10]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting)
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p2,p9,p4,p10]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line2_restWeighting) //for v2 used line1_restWeighting here
				])
				, Pseq([
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5]), Pseq([p2,p3,p4,p5,p6]), Pseq([p7,p8,p9,p10,p11]), Pseq([p12,p2,p9,p4,p10]) ], [1,0.8,0.1,0.05].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
				, Pseq([
					Ptuple([ Pseq([ c6+1, c5+8, c5+4, c5+1 ]), Pseq( Array.fill(4, 0.25) ), Pseq( Array.fill(4, 0.1) ) ])
					, Pwrand([
						Ptuple([ Pseq([ c5+8, c5+4, c5+2, c5+1 ])
							, Pwrand([ Pseq( Array.fill(4, 0.25) ), Pseq( Array.fill(3, 1/3)++[1] ) ], [1,0.5].normalizeSum)
							, Pwrand([ Pseq( Array.fill(4, 0.1) ), Pseq( Array.fill(4, 1/3) )], [1,0.5].normalizeSum) ])
						, Ptuple([ Pseq([ c5+8, c5+6, c5+4, c5+2 ])
							, Pwrand([ Pseq( Array.fill(4, 0.25) ), Pseq( Array.fill(3, 1/3)++[1] ) ], [1,0.5].normalizeSum)
							, Pwrand([ Pseq( Array.fill(4, 0.1) ), Pseq( Array.fill(4, 1/3) )], [1,0.5].normalizeSum) ])
						, Pwrand([
							Ptuple([ Pseq([c5+9, c5+7, c5+2, c5, c6+3]), Pseq( Array.fill(4, 0.25)++[1] ), Pseq( Array.fill(5, 0.25) ) ])
							, Ptuple([ Pseq([c5+9, c5+7, c5+2, c5, c6+3]), Pseq( Array.fill(3, 1/6)++[0.5, 1] ), Pseq( Array.fill(4, 1/6)++[0.15] ) ])
						], [1,0.5].normalizeSum)
					], [1,1,0.5].normalizeSum)
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
					], [1,1].normalizeSum)
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)
