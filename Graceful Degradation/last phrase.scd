//Tpt, Cl, BsCl (or A Cl?), Vn1
(
var lineWeighting, lw1, lw2, lw3, gestureDur=20, speedUpProcess=50, gestureDurScale;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
var sw1, sw2, systemWeighting;
var restWeighting, rw1, rw2, rw3, rw4;
var c4=60, c5=72, c6=84, c7=96;
var lineWeighting2;

bpm=120;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = #[1,1,1,1].normalizeSum; //static values
lineWeighting2 = #[1,1,1,1,1].normalizeSum;

p1 = 78;
p2 = 76;
p3 = 75;
p4 = 73;
p5 = 71;
p6 = 68;

/*sw1 = Env(#[0, 1, 1], #[70, 30].normalizeSum*gestureDurScale, curve:2);
sw2 = Env(#[1,1, 1], #[40, 60].normalizeSum*gestureDurScale, curve:2);
systemWeighting =Ptuple([sw1,sw2]).collect(_.normalizeSum).asStream;*/
systemWeighting = #[1,1].normalizeSum;

/*rw4 = Env(#[1,1,0,0], [2/5, 0, 3/5].normalizeSum*gestureDurScale);
rw3 = Env(#[0,0,1,1,0,0], [1/5, 0, 2/5, 0, 2/5].normalizeSum*gestureDurScale);
rw2 = Env(#[0,0,1,1,0,0], [2/5, 0, 2/5, 0, 1/5].normalizeSum*gestureDurScale);
rw1 = Env(#[0,0,1,1], [3/5, 0, 2/5].normalizeSum*gestureDurScale);
restWeighting = Ptuple([rw1, rw2, rw3, rw4]).collect(_.normalizeSum).asStream;*/
restWeighting = #[0,1,0,0].normalizeSum;

//do some iterations and choose best one
fork{
	6.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/tpt_and_Cl "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				Pwxrand([
					//variations
					Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(13, c5+3) ), Pseq([1/3,1/3,1/3,0.5,0.5,2/3,2/3,2/3,1,1,1.5,2.25,2.25]), Pseq(Array.fill(10, 0.2)++[1.5,2.25,2.25]) ])
					])
					, Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(8, c5+1)++Array.fill(3, c5+4) ), Pseq(Array.fill(6, 2/3)++[1.5,1.5,1.5,2.5,1]), Pseq(Array.fill(11, 0.2)) ])
					])
					, Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(8, c5+3) ), Pseq(Array.fill(6, 2/3)++[1,3]), Pseq(Array.fill(8, 0.2)) ])
					])
					, Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(4, c5+4) ), Pseq(#[1,1,1.5,2.5,2]), Pseq( #[0.2,0.2,1.5,2.5,0.2] ) ])
					])
					, Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(4, c5+6) ), Pseq(#[1,1,1.5,1.5,3]), Pseq( #[0.2,0.2,1.5,1.5,0.2] ) ])
					])
				], lineWeighting2)
				, Pwxrand([
					//original lines
					Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(12, p1)++Array.fill(5, p2)), Pseq( Array.fill(16, {2/3})++[4/3] ), Pseq(Array.fill(17, 0.2)) ])
					])
					, Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(10, p2)++[p5,p5] ), Pseq( [1/3,1/3,1/3,0.5,0.5,2/3,2/3,2/3,1,1,1,1] ), Pseq( Array.fill(12, 0.2) ) ])
					])
					, Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(12, p3)++Array.fill(5, p1) ) , Pseq( Array.fill(16, {2/3})++[4/3] ), Pseq( Array.fill(17, 0.2) ) ])
					])
					, Pseq([
						Ptuple([ Pseq([108]), Pwrand([ Pseq([1]), Pseq([2]), Pseq([6]), Pseq([12]) ], restWeighting ), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq( Array.fill(9, p4)++Array.fill(5, p6) ) , Pseq( Array.fill(6, 1)++Array.fill(6, {2/3})++[0.5,1.5] ), Pseq( Array.fill(14, 0.2) ) ])
					])
				], lineWeighting) //lines
			], systemWeighting, inf).asStream
			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..70), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)