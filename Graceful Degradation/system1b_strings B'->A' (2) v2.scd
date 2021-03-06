/////////////////////////////////////////
//Part 2 of B'--> A' v2. s2-s3. 16th trips are signifiers for Tim. they = regular 8th trips, slurred, with extreme pressure and ff

//Vn1 Part 2 of B' -> A' s
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=62, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);

dw1 = 0.9;
dw2 = Env([1, 0, 0], [0.5, 0.5].normalizeSum*gestureDurScale, curve:2);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;

dw2Envs = #[0.9, 1, 1];

rw1 = Env([1,0.3], [1].normalizeSum*gestureDurScale, curve:2);
rw2 = 0.3;
rwEnvs = Ptuple([rw1, rw2]).collect(_.normalizeSum).asStream;


fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn1 "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand(
			//array of Pwxrands of different durations
			Array.fill(iterationArray.size, {|i|
				var iterations = iterationArray[i];

				Pwxrand([
					Pwxrand([
						Ptuple([ Pseq([ c5+1, c4+8, c4+6 ], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+3, c4+9, c4+8], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+4, c5-1, c5-3], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+3, c5-1, c5-3], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					], [1,1,1,1].normalizeSum)
					, Pwxrand([
						Ptuple([ Pseq([ c5+1, c5+1, c4+8, c4+8, c4+6, c4+6 ], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c5+3, c5+3, c4+9, c4+9, c4+8, c4+8], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c5+4, c5+4, c5-1, c5-1, c5-3, c5-3], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c5+3, c5+3, c5-1, c5-1, c5-3, c5-3], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
					], [1,1,1,1].normalizeSum)
				], rwEnvs)
			})
			, [1,1].normalizeSum, inf).asStream;
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
var cresc, dim, gestureDur=62, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);

dw1 = 0.9;
dw2 = Env([1, 0, 0], [0.5, 0.5].normalizeSum*gestureDurScale, curve:2);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;

dw2Envs = #[0.9, 1, 1];

rw1 = Env([1,0.3], [1].normalizeSum*gestureDurScale, curve:2);
rw2 = 0.3;
rwEnvs = Ptuple([rw1, rw2]).collect(_.normalizeSum).asStream;

fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand(
			Array.fill(iterationArray.size, {|i|
				var iterations = iterationArray[i];

				Pwxrand([
					Pwxrand([
						Ptuple([ Pseq([c4+1, c4-4, c4-6], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c4+1,c4-3,c4-4], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c4-4,c3+3,c3+1], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					], [1,1,1].normalizeSum)
					, Pwxrand([
						Ptuple([ Pseq([c4+1, c4+1, c4-4, c4-4, c4-6, c4-6], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c4+1, c4+1, c4-3, c4-3, c4-4, c4-4], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c4-4, c4-4, c3+3, c3+3, c3+3, c3+1], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
					], [1,1,1].normalizeSum)
				], rwEnvs)
			})
			, [1,1].normalizeSum, inf).asStream //[4 beats, 3 beats] weights
		, 0
		, 80
		, speedUpProcess
	);
}
)

//Vn2 Part 2 of B' -> A'
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=62, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);

dw1 = 0.9;
dw2 = Env([1, 0, 0], [0.5, 0.5].normalizeSum*gestureDurScale, curve:2);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;

dw2Envs = #[0.9, 1, 1];

rw1 = Env([1,0.3], [1].normalizeSum*gestureDurScale, curve:2);
rw2 = 0.3;
rwEnvs = Ptuple([rw1, rw2]).collect(_.normalizeSum).asStream;

fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn2 "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand(
			//array of Pwxrands of different durations
			Array.fill(iterationArray.size, {|i|
				var iterations = iterationArray[i];

				Pwxrand([
					Pwxrand([
						Ptuple([ Pseq([ c5+1, c4+8, c4+6 ], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+3, c4+9, c4+8], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+4, c5-1, c5-3], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+3, c5-1, c5-3], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					], [1,1,1,1].normalizeSum)
					, Pwxrand([
						Ptuple([ Pseq([ c5+1, c5+1, c4+8, c4+8, c4+6, c4+6 ], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c5+3, c5+3, c4+9, c4+9, c4+8, c4+8], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c5+4, c5+4, c5-1, c5-1, c5-3, c5-3], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c5+3, c5+3, c5-1, c5-1, c5-3, c5-3], iterations), Pseq(Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
					], [1,1,1,1].normalizeSum)
				], rwEnvs)
			})
			, [1,1].normalizeSum, inf).asStream; //[4 beats, 3 beats] weights
		, 0
		, 80
		, speedUpProcess
	);
}
)

//Va Part 2 of B' -> A'
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var cresc, dim, gestureDur=62, speedUpProcess=50, bpm=120;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;
var rw1, rw2, rwEnvs;
var dw2_1, dw2_2, dw2Envs;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);

dw1 = 0.9;
dw2 = Env([1, 0, 0], [0.5, 0.5].normalizeSum*gestureDurScale, curve:2);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;

dw2Envs = #[0.9, 1, 1];

rw1 = Env([1,0.3], [1].normalizeSum*gestureDurScale, curve:2);
rw2 = 0.3;
rwEnvs = Ptuple([rw1, rw2]).collect(_.normalizeSum).asStream;

fork{
	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Va "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand(
			Array.fill(iterationArray.size, {|i|
				var iterations = iterationArray[i];

				Pwxrand([
					Pwxrand([
						Ptuple([ Pseq([c4+9, c4+8, c4+3], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c4+8,c4+6,c4+4], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c4+6,c4+3,c4+1], iterations), Pseq( [1/3,1/3,1/3], iterations), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					], [1,1,1].normalizeSum)
					, Pwxrand([
						Ptuple([ Pseq([c4+9, c4+9, c4+8, c4+8, c4+3, c4+3], iterations), Pseq( Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c4+8, c4+8, c4+6, c4+6, c4+4, c4+4], iterations), Pseq( Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
						, Ptuple([ Pseq([c4+6, c4+6, c4+3, c4+3, c4+1, c4+1], iterations), Pseq( Array.fill(6, 1/6), iterations), Pseq(Array.fill(6, 1/6), iterations)
							, Pwrand([ Pseq(Array.fill(iterations*6, 110)), Pseq(Array.fill(iterations*6, 95)), Pseq(Array.fill(iterations*6, 80)) ], dw2Envs) ])
					], [1,1,1].normalizeSum)
				], rwEnvs) //[8th trips, 16th trips]
			})
			, [1,1].normalizeSum, inf).asStream;
		, 0
		, 80
		, speedUpProcess
	);
}
)

//single note lines, 16ths and 8th trips, <>, strings synched (scattered beats: 16,15,14,12,8,4)
//increasing harmonic rhythm
(
var repeats;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var rhythmWeighting, dynWeighting;
var cresc, dim, gestureDur=120, speedUpProcess=50, bpm=120;
var we1, we2, we3, we4, we5, we6, we7, we8, weEnvs;
var iterationArray, gestureDurScale;
var dw1, dw2, dwEnvs;

gestureDurScale=(gestureDur/speedUpProcess)*(bpm/60); //to compensate for bpm

iterationArray = #[16, 15, 14, 12, 8, 5, 4, 3]; //# of beats

cresc = (10..100);
dim = (100..10);
rhythmWeighting = #[1,0.7];
dynWeighting = #[0.9,1];

dw1 = 0.9;
dw2 = Env([1, 1, 0, 0], [3.5/9, 3.5/9, 2/9].normalizeSum*gestureDurScale);
dwEnvs = Ptuple([dw1, dw2]).collect(_.normalizeSum).asStream;

we1 = Env([1, 1, 0, 0], [5/9, 0, 4/9].normalizeSum*gestureDurScale); //16
we2 = Env([0, 0, 1, 1, 0, 0], [1/9, 0, 4/9, 0, 4/9].normalizeSum*gestureDurScale); //15
we3 = Env([0, 0, 1, 1, 0, 0], [2/9, 0, 3/9, 0, 4/9].normalizeSum*gestureDurScale); //14
we4 = Env([0, 0, 1, 1, 0, 0], [2/9, 0, 3/9, 0, 4/9].normalizeSum*gestureDurScale); //12
we5 = Env([0, 0, 1, 1, 0, 0], [3/9, 0, 2/9, 0, 4/9].normalizeSum*gestureDurScale); //8
we6 = Env([0, 0, 1, 1], [3/9, 0, 6/9].normalizeSum*gestureDurScale); //5
we7 = Env([0, 0, 1, 1], [3/9, 0, 6/9].normalizeSum*gestureDurScale); //4
we8 = Env([0, 0, 1, 1], [4/9, 0, 5/9].normalizeSum*gestureDurScale); //3
weEnvs = Ptuple([we1, we2, we3, we4, we5, we6, we7, we8]).collect(_.normalizeSum).asStream;

fork{

	2.do{
		~algoMIDI1_ES4.value(
			"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vn "++Main.elapsedTime.round(0.1)++".mid" //filename
			, 120
			, gestureDur
			, Pwxrand(
				//array of Pwxrands of different durations
				Array.fill(iterationArray.size, {|i|
					var iterations = iterationArray[i];

					Pwxrand([
						Ptuple([ Pseq([ c5+1, c4+8, c4+6 ], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+3, c4+9, c4+8], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+4, c5-1, c5-3], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
						, Ptuple([ Pseq([c5+3, c5-1, c5-3], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
							, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					], [1,1,1,1].normalizeSum)
				})
				, weEnvs, inf).asStream;
			, 0
			, 80
			, speedUpProcess
		);
		0.1.wait;
	};

	0.2.wait;

	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Va "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand(
			Array.fill(iterationArray.size, {|i|
				var iterations = iterationArray[i];

				Pwxrand([
					Ptuple([ Pseq([c4+9, c4+8, c4+3], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
						, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					, Ptuple([ Pseq([c4+8,c4+6,c4+4], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
						, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					, Ptuple([ Pseq([c4+6,c4+3,c4+1], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
						, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
				], [1,1,1].normalizeSum)
			})
			, weEnvs, inf).asStream;
		, 0
		, 80
		, speedUpProcess
	);

	0.2.wait;

	~algoMIDI1_ES4.value(
		"/Users/jeremyzuckerman/Documents/ES_IV/MIDI/Vc "++Main.elapsedTime.round(0.1)++".mid" //filename
		, 120
		, gestureDur
		, Pwxrand(
			Array.fill(iterationArray.size, {|i|
				var iterations = iterationArray[i];

				Pwxrand([
					Ptuple([ Pseq([c4+1, c4-4, c4-6], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
						, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					, Ptuple([ Pseq([c4+1,c4-3,c4-4], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
						, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
					, Ptuple([ Pseq([c4-4,c3+3,c3+1], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
						, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dwEnvs) ])
				], [1,1,1].normalizeSum)
			})
			, weEnvs, inf).asStream
		, 0
		, 80
		, speedUpProcess
	);
}
)