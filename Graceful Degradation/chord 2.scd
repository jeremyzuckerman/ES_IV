//Bs Cl
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=20, speedUpProcess=60, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
/*lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);*/

//env times scaled to gesture duration
/*line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);*/


//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = #[1,1,0.5].normalizeSum; //static values

//line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line1_restWeighting = #[0.5,1,0,0,0,0,0].normalizeSum;

p1 = 68;
p2 = 66;
p3 = 64;
p4 = 61;
p5 = 56;

fork{
	2.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
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
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line2_restWeighting
				])
				, Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (20..40), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)

//Bsn
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=20, speedUpProcess=60, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
/*lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);*/

//env times scaled to gesture duration
/*line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);*/


//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = #[1,1,0.5].normalizeSum; //static values

//line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line1_restWeighting = #[0.5,1,0,0,0,0,0].normalizeSum;

p1 = 68;
p2 = 66;
p3 = 62;
p4 = 61;
p5 = 59;
p6 = 56;

fork{
	2.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
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
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line2_restWeighting
				])
				, Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};


)

//Cl
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=20, speedUpProcess=60, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
/*lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);*/

//env times scaled to gesture duration
/*line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);*/


//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = #[1,1,0.5].normalizeSum; //static values

//line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line1_restWeighting = #[0.5,1,0,0,0,0,0].normalizeSum;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 62+12;

fork{
	2.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
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
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line2_restWeighting
				])
				, Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)

//Flute
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=20, speedUpProcess=60, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
/*lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);*/

//env times scaled to gesture duration
/*line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);*/


//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = #[1,1,0.5].normalizeSum; //static values

//line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line1_restWeighting = #[0.5,1,0.05,0,0,0,0].normalizeSum;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 62;
p6 = 61;

fork{
	2.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
				//	Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ]) //v1
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5+12]), Pseq([p2,p3,p4,p5,p6+12]) ], [1,1].normalizeSum), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
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

				//Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ]) //v1
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5+12]), Pseq([p2,p3,p4,p5,p6+12]) ], [1,1].normalizeSum), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line2_restWeighting
				])
				, Pseq([
					//Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])//v1
					Ptuple([ Pwrand([ Pseq([p1,p2,p3,p4,p5+12]), Pseq([p2,p3,p4,p5,p6+12]) ], [1,1].normalizeSum), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)

//Cl, Bs Cl, Bsn:
(
var lineWeighting, lw1, lw2, lw3, restWeighting, gestureDur=20, speedUpProcess=60, gestureDurScale;
var line1_restWeighting, line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7;
var line2_restWeighting, line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_restWeighting, line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;
var bpm;
var p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12;
/*var line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6;
var line2_rw1, line2_rw2, line2_rw3, line2_rw4, line2_rw5, line2_rw6;
var line3_rw1, line3_rw2, line3_rw3, line3_rw4, line3_rw5, line3_rw6;*/
var testenv, testenv2, testenv3;

bpm=150;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //timescaling. makes file faster than RT

//env times scaled to gesture duration
/*lw1 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale); //time scaled weighting envs
lw2 = Env([1, 1, 1, 1], [1,1,1].normalizeSum*gestureDurScale);
lw3 = Env([0, 0, 1, 1], [1,1,1].normalizeSum*gestureDurScale);*/

//env times scaled to gesture duration
/*line1_rw1 = Env([0,0,0,0,0,0.2,0.5,0.5], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw2 = Env([0,0,0,0,0,1,1,1], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw3 = Env([0,0,0,0,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw4 = Env([0,0,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw5 = Env([0,0,3,0.5,0,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw6 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);
line1_rw7 = Env([1,1,1,1,1,1,0,0], Array.fill(8, {1/8}).normalizeSum*gestureDurScale);*/


//lineWeighting = Ptuple([lw1, lw2, lw3]).collect(_.normalizeSum).asStream; //dynamic weighting method using envelopes
lineWeighting = #[1,1,0.5].normalizeSum; //static values

//line1_restWeighting = Ptuple([line1_rw1, line1_rw2, line1_rw3, line1_rw4, line1_rw5, line1_rw6, line1_rw7]).collect(_.normalizeSum).asStream;
line1_restWeighting = #[0.5,1,0,0,0,0,0].normalizeSum;

p1 = 69;
p2 = 68;
p3 = 66;
p4 = 64;
p5 = 62;

fork{
	3.do{
		var note;
		//note = #[60,61,62,63].choose;
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/test1 "++Main.elapsedTime.round(0.1)++".mid" //filename
			, bpm
			, gestureDur //duration of file

			, Pwrand([
				//pchs, note values (e.g. 8th, 16th, etc), note duration, velocity
				Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.25,0.25,0.25,0.25,0.5]), Pseq([0.25,0.25,0.25,0.25,0.25]) ])
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
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([0.2,0.2,0.2,0.2,0.2]), Pseq([0.2,0.2,0.2,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line2_restWeighting
				])
				, Pseq([
					Ptuple([ Pseq([p1,p2,p3,p4,p5]), Pseq([1/3,1/3,1/3,0.5,0.5]), Pseq([1/3,1/3,1/3,0.2,0.2]) ])
					, Pwrand([ Ptuple([ Pseq([1]), Pseq([0]), Pseq([0]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([0.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([1.5]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([2]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([4]), Pseq([0.5]), Pseq([0]) ])
						, Ptuple([ Pseq([1]), Pseq([7.5]), Pseq([0.5]), Pseq([0]) ])
					], line1_restWeighting) //line3_restWeighting
				])
			], lineWeighting.asStream, inf).asStream //lines

			, 1 //velocity switch. 0: in line, 1: separate pattern

			, Prand( (60..80), inf).asStream //if velocity switch == 1, this pattern is used for velocity
			, speedUpProcess //makes file faster than RT by this factor
		);
		0.1.wait;
	};
};
)