/////////////////////////////////////////
//Part 2 of B'--> A' v2. s2-s3. 16th trips are signifiers for Tim. they = regular 8th trips, slurred, with extreme pressure and ff

//Vn1 Part 2 of B' -> A' s
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=14, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;
var tw1, tw2, tw3, twEnvs;
var vnPchSets;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);

/*//dynamics weights
dw1 = 0.9;
dw2 = Env([1, 0, 0], [0.5, 0.5].normalizeSum*gestureDurScale, curve:2);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;*/

dw2Envs = #[0.9, 1, 1]; //sextuplets dynamics (static)

//system weights (chooses between the sextuplets patterns (slurred extreme pressure 8th trips) and the extreme pressure long notes
rw1 = Env(#[1,0.4], #[1].normalizeSum*gestureDurScale, curve:-2);
rw2 = Env(#[0.1, 0.8], #[1].normalizeSum*gestureDurScale, curve:1.5);
rwEnvs = Ptuple([rw1, rw2]).collect(_.normalizeSum).asStream;

//tonality weights (C#m, C#phr, Cmm)
tw1 = 1;
tw2 = Env(#[1,1], #[1].normalizeSum*gestureDurScale, curve:2);
tw3 = Env(#[0.5, 1], #[1].normalizeSum*gestureDurScale, curve:-2);
twEnvs = Ptuple([tw1, tw2, tw3]).collect(_.normalizeSum).asStream;

//pitch lines
vnPchSets = [ [ c5+1, c5+1, c4+8, c4+8, c4+6, c4+6 ], [c5+3, c5+3, c4+9, c4+9, c4+8, c4+8], [c5+4, c5+4, c5-1, c5-1, c5-3, c5-3], [c5+3, c5+3, c5-1, c5-1, c5-3, c5-3] ];

fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwrand([
			Pwxrand(
				Array.fill(iterationArray.size, {|i| //array of  [4,3] beats
					var iterations = iterationArray[i];

					Pwxrand([
						Ptuple([ Pseq(vnPchSets[0], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq(vnPchSets[1], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq(vnPchSets[2], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq(vnPchSets[3], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
					], [1,1,1,1].normalizeSum)
				})
				, [1,1].normalizeSum) //4 or 3 beats
			, Pwrand([ //again, don't want a Pwxrand here.
				Pwxrand([ //C#m
					Ptuple([ Pseq([c4+6]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], Array.fill(14, 1).normalizeSum) //choose a line
				, Pwxrand([ //C#Phry
					Ptuple([ Pseq([c5+2]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+2]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], [1,1].normalizeSum)
				, Pwxrand([ //Cmm
					Ptuple([ Pseq([c4+5]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], Array.fill(6, 1).normalizeSum)
			], twEnvs) // [C#m, C#phr, Cmm] weights
		], rwEnvs, inf).asStream; //systems weights
		, 0
		, 80
		, speedUpProcess
	);
}
)

//Vc Part 2 of B' -> A'
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=17, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;
var tw1, tw2, tw3, twEnvs;
var pchSets;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);

/*//dynamics weights
dw1 = 0.9;
dw2 = Env([1, 0, 0], [0.5, 0.5].normalizeSum*gestureDurScale, curve:2);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;*/

dw2Envs = #[0.9, 1, 1]; //sextuplets dynamics (static)

//system weights (chooses between the sextuplets patterns (slurred extreme pressure 8th trips) and the extreme pressure long notes
rw1 = Env(#[1,0.4], #[1].normalizeSum*gestureDurScale, curve:-2);
rw2 = Env(#[0.1, 0.8], #[1].normalizeSum*gestureDurScale, curve:1.5);
rwEnvs = Ptuple([rw1, rw2]).collect(_.normalizeSum).asStream;

//tonality weights (C#m, C#phr, Cmm)
tw1 = 1;
tw2 = Env(#[1,1], #[1].normalizeSum*gestureDurScale, curve:2);
tw3 = Env(#[0.3, 0.9], #[1].normalizeSum*gestureDurScale, curve:-2);
twEnvs = Ptuple([tw1, tw2, tw3]).collect(_.normalizeSum).asStream;

//pitch lines
pchSets = [ [c4+1, c4+1, c4-4, c4-4, c4-6, c4-6], [c4+1, c4+1, c4-3, c4-3, c4-4, c4-4], [c4-4, c4-4, c3+3, c3+3, c3+3, c3+1] ];

fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwrand([
	Pwxrand(
		Array.fill(iterationArray.size, {|i| //array of  [4,3] beats
			var iterations = iterationArray[i];

			Pwxrand([
				Ptuple([ Pseq(pchSets[0], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
					, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
				, Ptuple([ Pseq(pchSets[1], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
					, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
				, Ptuple([ Pseq(pchSets[2], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
					, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
			], [1,1,1].normalizeSum)
		})
		, [1,1].normalizeSum) //4 or 3 beats
	, Pwrand([ //again, don't want a Pwxrand here.
		Pwxrand([ //C#m
			Ptuple([ Pseq([c3+1]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c3+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c3+3]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c3+3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4-6]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4-6]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4-4]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4-4]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4-3]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4-3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4+1]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
		], Array.fill(12, 1).normalizeSum) //choose a line
		, Pwxrand([ //C#Phry
			Ptuple([ Pseq([c3+2]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c3+2]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
		], [1,1].normalizeSum)
		, Pwxrand([ //Cmm
			Ptuple([ Pseq([c3+5]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c3+5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c3+7]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c3+7]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
			Ptuple([ Pseq([c4]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
		], Array.fill(6, 1).normalizeSum)
	], twEnvs) // [C#m, C#phr, Cmm] weights
], rwEnvs, inf).asStream; //systems weights
		, 0
		, 80
		, speedUpProcess
	);
}
)

//Vn2 Part 3 s3->s4
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=22, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;
var tw1, tw2, tw3, twEnvs;
var vnPchSets;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);

/*//dynamics weights
dw1 = 0.9;
dw2 = Env([1, 0, 0], [0.5, 0.5].normalizeSum*gestureDurScale, curve:2);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;*/

dw2Envs = #[0.9, 1, 1]; //sextuplets dynamics (static)

//system weights (chooses between the sextuplets patterns (slurred extreme pressure 8th trips) and the extreme pressure long notes
rw1 = Env(#[1,0.4], #[1].normalizeSum*gestureDurScale, curve:-2);
rw2 = Env(#[0.1, 0.8], #[1].normalizeSum*gestureDurScale, curve:1.5);
rwEnvs = Ptuple([rw1, rw2]).collect(_.normalizeSum).asStream;

//tonality weights (C#m, C#phr, Cmm)
tw1 = 1;
tw2 = Env(#[0.2,1], #[1].normalizeSum*gestureDurScale, curve:2);
tw3 = Env(#[0, 0.35], #[1].normalizeSum*gestureDurScale, curve:-2);
twEnvs = Ptuple([tw1, tw2, tw3]).collect(_.normalizeSum).asStream;

//pitch lines
vnPchSets = [ [ c5+1, c5+1, c4+8, c4+8, c4+6, c4+6 ], [c5+3, c5+3, c4+9, c4+9, c4+8, c4+8], [c5+4, c5+4, c5-1, c5-1, c5-3, c5-3], [c5+3, c5+3, c5-1, c5-1, c5-3, c5-3] ];

fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwrand([
			Pwxrand(
				Array.fill(iterationArray.size, {|i| //array of  [4,3] beats
					var iterations = iterationArray[i];

					Pwxrand([
						Ptuple([ Pseq(vnPchSets[0], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq(vnPchSets[1], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq(vnPchSets[2], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq(vnPchSets[3], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
					], [1,1,1,1].normalizeSum)
				})
				, [1,1].normalizeSum) //4 or 3 beats
			, Pwrand([ //again, don't want a Pwxrand here.
				Pwxrand([ //C#m
					Ptuple([ Pseq([c4+6]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5-1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+4]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], Array.fill(14, 1).normalizeSum) //choose a line
				, Pwxrand([ //C#Phry
					Ptuple([ Pseq([c5+2]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5+2]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], [1,1].normalizeSum)
				, Pwxrand([ //Cmm
					Ptuple([ Pseq([c4+5]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c5]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], Array.fill(6, 1).normalizeSum)
			], twEnvs) // [C#m, C#phr, Cmm] weights
		], rwEnvs, inf).asStream; //systems weights
		, 0
		, 80
		, speedUpProcess
	);
}
)

//Va Part 3 s3->s4
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=22, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;
var tw1, tw2, tw3, twEnvs;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);

/*//dynamics weights
dw1 = 0.9;
dw2 = Env([1, 0, 0], [0.5, 0.5].normalizeSum*gestureDurScale, curve:2);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;*/

dw2Envs = #[0.9, 1, 1]; //sextuplets dynamics (static)

//system weights (chooses between the sextuplets patterns (slurred extreme pressure 8th trips) and the extreme pressure long notes
rw1 = Env(#[1,0.4], #[1].normalizeSum*gestureDurScale, curve:-2);
rw2 = Env(#[0.1, 0.8], #[1].normalizeSum*gestureDurScale, curve:1.5);
rwEnvs = Ptuple([rw1, rw2]).collect(_.normalizeSum).asStream;

//tonality weights (C#m, C#phr, Cmm)
tw1 = 1;
tw2 = Env(#[0,1], #[1].normalizeSum*gestureDurScale, curve:2);
tw3 = Env(#[0, 0, 0.1], #[0.5,1].normalizeSum*gestureDurScale, curve:2);
twEnvs = Ptuple([tw1, tw2, tw3]).collect(_.normalizeSum).asStream;

fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Va "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwrand([ //be careful with Pwxrand. it will alternate if there are only two items even if on of the weights is 0.
			Pwxrand(
				Array.fill(iterationArray.size, {|i| //array of  [4,3] beats
					var iterations = iterationArray[i];

					Pwxrand([
						Ptuple([ Pseq([c4+9, c4+9, c4+8, c4+8, c4+3, c4+3], iterations), Pseq( Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c4+8, c4+8, c4+6, c4+6, c4+4, c4+4], iterations), Pseq( Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c4+6, c4+6, c4+3, c4+3, c4+1, c4+1], iterations), Pseq( Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
					], [1,1,1].normalizeSum)
				})
				, [1,1].normalizeSum) //4 or 3 beats
			, Pwrand([ //again, don't want a Pwxrand here.
				Pwxrand([ //C#m
					Ptuple([ Pseq([c4+1]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+1]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+3]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+3]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+6]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+8]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+9]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+9]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], Array.fill(10, 1).normalizeSum) //choose a line
				, Pwxrand([ //C#Phry
					Ptuple([ Pseq([c4+2]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+2]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], [1,1].normalizeSum)
				, Pwxrand([ //Cmm
					Ptuple([ Pseq([c4+7]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+7]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4+5]), Pseq([3]), Pseq([3]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4]), Pseq([2]), Pseq([2]), Prand((90..100)) ]) ,
					Ptuple([ Pseq([c4]), Pseq([3]), Pseq([3]), Prand((90..100)) ])
				], Array.fill(6, 1).normalizeSum)
			], twEnvs) // [C#m, C#phr, Cmm] weights
		], rwEnvs, inf).asStream //
		, 0
		, 80
		, speedUpProcess
	);
}
)
