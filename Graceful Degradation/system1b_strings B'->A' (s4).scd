/////////////////////////////////////////
//Part 2 of B'--> A' v2. s2-s3. 16th trips are signifiers for Tim. they = regular 8th trips, slurred, with extreme pressure and ff

//Vn1 Part 4 s4->
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=17, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;
var durW_1, durW_2, durW_3, durW_4, durW_Envs;
var randOct;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

durW_1 = Env(#[1, 0, 0], [1/3, 2/3].normalizeSum*gestureDurScale, curve:1);
durW_2 = Env(#[0, 1, 0, 0], [1/3, 1/3, 1/3].normalizeSum*gestureDurScale, curve:2);
durW_3 = Env(#[0, 0, 1, 1], [1/3, 1/3, 1/3].normalizeSum*gestureDurScale, curve:2);
durW_Envs = Ptuple([durW_1, durW_2, durW_3]).collect(_.normalizeSum).asStream;

randOct = Env(#[0, 0.5, 0.5], [0.75, 0.25].normalizeSum*gestureDurScale).asStream;

fork{
	~algoMIDI3_ES4.value( //randOct
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn1 "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pxrand([
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5-3]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5-3]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5-3]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5-1]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5-1]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5-1]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5+1]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+1]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+1]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5+3]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+3]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+3]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5+4]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+4]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+4]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5+2]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+2]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+2]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+2]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+2]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+2]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
		], inf).asStream
		, 0
		, 80
		, speedUpProcess
		, randOct
		, -1 // 1=8va, -1=8vb, -2=15vb, etc.
	);
}
)

//Vc Part 4 of B' -> A' s4->
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=17, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;
var durW_1, durW_2, durW_3, durW_4, durW_Envs;
var randOct;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

durW_1 = Env(#[1, 0, 0], [1/3, 2/3].normalizeSum*gestureDurScale, curve:1);
durW_2 = Env(#[0, 1, 0, 0], [1/3, 1/3, 1/3].normalizeSum*gestureDurScale, curve:2);
durW_3 = Env(#[0, 0, 1, 1], [1/3, 1/3, 1/3].normalizeSum*gestureDurScale, curve:2);
durW_Envs = Ptuple([durW_1, durW_2, durW_3]).collect(_.normalizeSum).asStream;

randOct = Env(#[0, 0.5, 0.5], [0.75, 0.25].normalizeSum*gestureDurScale).asStream;

fork{
	~algoMIDI3_ES4.value( //randOct
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pxrand([
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c3+1]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+1]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+1]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+1]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+1]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c3+3]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+3]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+3]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+3]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+3]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4-6]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-6]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4-6]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-6]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4-6]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-6]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4-4]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-4]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4-4]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-4]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4-4]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-4]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4-3]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4-3]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-3]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4-3]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4-3]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+1]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+1]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+1]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+1]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+1]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c3+2]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+2]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+2]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+2]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+2]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+2]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c3+5]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+5]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+5]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+5]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+5]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c3+7]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+7]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+7]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+7]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c3+7]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c3+7]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
		], inf).asStream
		, 0
		, 80
		, speedUpProcess
		, randOct
		, -1 // 1=8va, -1=8vb, -2=15vb, etc.
	);
}
)


//Vn2 Part 4 s4->
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=22, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;
var durW_1, durW_2, durW_3, durW_4, durW_Envs;
var randOct;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

durW_1 = Env(#[1, 0, 0], [1/3, 2/3].normalizeSum*gestureDurScale, curve:1);
durW_2 = Env(#[0, 1, 0, 0], [1/3, 1/3, 1/3].normalizeSum*gestureDurScale, curve:2);
durW_3 = Env(#[0, 0, 1, 1], [1/3, 1/3, 1/3].normalizeSum*gestureDurScale, curve:2);
durW_Envs = Ptuple([durW_1, durW_2, durW_3]).collect(_.normalizeSum).asStream;

randOct = Env(#[0, 0.5, 0.5], [0.75, 0.25].normalizeSum*gestureDurScale).asStream;

fork{
	~algoMIDI3_ES4.value( //randOct
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn2 "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pxrand([
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5-3]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5-3]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5-3]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5-1]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5-1]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5-1]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5+1]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+1]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+1]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5+3]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+3]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+3]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5+4]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+4]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+4]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5+2]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+2]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+2]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+2]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5+2]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+2]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c5]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c5]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
		], inf).asStream
		, 0
		, 80
		, speedUpProcess
		, randOct
		, -1 // 1=8va, -1=8vb, -2=15vb, etc.
	);
}
)


//Va Part 4 s4
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=32, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;
var durW_1, durW_2, durW_3, durW_4, durW_Envs;
var randOct;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

// iterationArray = #[4, 3]; //# of beats

// cresc = (10..100);
// dim = (100..10);

durW_1 = Env(#[1, 0, 0], [1/3, 2/3].normalizeSum*gestureDurScale, curve:1);
durW_2 = Env(#[0, 1, 0, 0], [1/3, 1/3, 1/3].normalizeSum*gestureDurScale, curve:2);
durW_3 = Env(#[0, 0, 1, 1], [1/3, 1/3, 1/3].normalizeSum*gestureDurScale, curve:2);
durW_Envs = Ptuple([durW_1, durW_2, durW_3]).collect(_.normalizeSum).asStream;

randOct = Env(#[0, 0.5, 0.5], [0.75, 0.25].normalizeSum*gestureDurScale).asStream;

fork{
	~algoMIDI3_ES4.value( //rand8va
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Va "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pxrand([
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+1]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+1]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+1]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+1]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+1]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+3]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+3]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+3]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+3]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+3]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+6]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+8]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+9]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+9]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+9]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+9]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+9]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+9]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+2]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+2]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+2]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+2]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+2]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+2]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+7]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4+5]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs) ,
			Pwxrand([
				Prand([
					Ptuple([ Pseq([c4]), Pseq([2.5]), Pseq([2.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4]), Pseq([3.5]), Pseq([3.5]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4]), Pseq([4]), Pseq([4]), Prand((90..100)) ]) ,
				]),
				Prand([
					Ptuple([ Pseq([c4]), Pseq([6]), Pseq([6]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4]), Pseq([7]), Pseq([7]), Prand((90..100)) ]) ,
				]),
			], durW_Envs)
		], inf).asStream
		, 0
		, 80
		, speedUpProcess
		, randOct
		, -1 // 1=8va, -1=8vb, -2=15vb, etc.
	);
}
)
