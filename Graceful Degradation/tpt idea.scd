//Tpt
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=120, speedUpProcess=40, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=120;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);

//env times scaled to gesture duration
line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);

line2_rw1 = Env(Array.fill(8, {0}), Array.fill(8, {1/8}).normalizeSum*gestureDurScale);

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
lineWeighting = #[1,1,1,1].normalizeSum; //static values

//line1_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
//line2_restWeighting = Ptuple([line2_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;

p1 = 78;
p2 = 76;
p3 = 75;
p4 = 73;
p5 = 71;
p6 = 68;

//do some iterations and choose best one
fork{
	6.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pseq([1]), Pwrand([ Pseq([8]), Pseq([12]), Pseq([16]), Pseq([18]) ], [1,1,1,1].normalizeSum ), Pseq([0]), Pseq([0]) ])
					, Ptuple([ Pseq( Array.fill(12, p1)++Array.fill(5, p2)), Pseq( Array.fill(16, {2/3})++[4/3] ), Pseq(Array.fill(17, 0.2)) ])
				])
				, Pseq([
					Ptuple([ Pseq([1]), Pwrand([ Pseq([8]), Pseq([12]), Pseq([16]), Pseq([18]) ], [1,1,1,1].normalizeSum ), Pseq([0]), Pseq([0]) ])
					, Ptuple([ Pseq( Array.fill(10, p2)++[p5,p5] ), Pseq( [1/3,1/3,1/3,0.5,0.5,2/3,2/3,2/3,1,1,1,1] ), Pseq( Array.fill(12, 0.2) ) ])
				])
				, Pseq([
					Ptuple([ Pseq([1]), Pwrand([ Pseq([8]), Pseq([12]), Pseq([16]), Pseq([18]) ], [1,1,1,1].normalizeSum ), Pseq([0]), Pseq([0]) ])
					, Ptuple([ Pseq( Array.fill(12, p3)++Array.fill(5, p1) ) , Pseq( Array.fill(16, {2/3})++[4/3] ), Pseq( Array.fill(17, 0.2) ) ])
				])
				, Pseq([
					Ptuple([ Pseq([1]), Pwrand([ Pseq([8]), Pseq([12]), Pseq([16]), Pseq([18]) ], [1,1,1,1].normalizeSum ), Pseq([0]), Pseq([0]) ])
					, Ptuple([ Pseq( Array.fill(9, p4)++Array.fill(5, p6) ) , Pseq( Array.fill(6, 1)++Array.fill(6, {2/3})++[0.5,1.5] ), Pseq( Array.fill(14, 0.2) ) ])
				])
			], lineWeighting, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..70), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)