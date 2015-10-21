(
var iterationArray, cresc, dim, rhythmWeighting, dynWeighting, duration=60;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var pattern, we1, we2, we3, we4, we5, we6, we7, we8, weEnvs;

cresc = (10..100);
dim = (100..10);
rhythmWeighting = #[1,0.7];
dynWeighting = #[0.9,1];

iterationArray = #[16, 15, 14, 12, 8, 4]; //# of beats

we1 = 1;
we2 = Env([0, 0, 1, 1], [0.25, 0, 0.75]*duration);
we3 = Env([0, 0, 1, 1], [0.45, 0, 0.55]*duration);
we4 = Env([0, 0, 1, 1], [0.45, 0, 0.55]*duration);
we5 = Env([0, 0, 1, 1], [0.71, 0, 0.29]*duration);
we6 = Env([0, 0, 1, 1], [0.71, 0, 0.29]*duration);

weEnvs = Ptuple([we1, we2, we3, we4, we5, we6]).collect(_.normalizeSum).asStream;

pattern = Pwxrand(
	//array of Pwxrands of different durations
	Array.fill(iterationArray.size, {|i|
		var iterations = iterationArray[i];

		Pwxrand([
			Ptuple([ Pseq([ c5+1, c4+8, c4+6 ], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c5+3, c4+9, c4+8], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c5+4, c5-1, c5-3], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c5+3, c5-1, c5-3], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
		], [1,1,1,1].normalizeSum)
	})
	, weEnvs, inf).asStream;

fork{
	// 0.3.wait;

	200.do{
		pattern.next.postln;
		0.005.wait;
	}
}
)

//va
Pwxrand(
	Array.fill(iterationArray.size, {|i|
	var iterations = iterationArray[i];

Pwxrand([
			Ptuple([ Pseq([c4+9, c4+8, c4+3], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c4+8,c4+6,c4+4], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c4+6,c4+3,c4+1], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
		], [1,1,1].normalizeSum)
	})
	, weEnvs, inf).asStream;

//vc
Pwxrand(
	Array.fill(iterationArray.size, {|i|
	var iterations = iterationArray[i];

	Pwxrand([
			Ptuple([ Pseq([c4+1, c4-4, c4-6], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c4+1,c4-3,c4-4], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
			, Ptuple([ Pseq([c4-4,c3+3,c3+1], iterations), Pwrand([Pseq( [0.25,0.25,0.5], iterations), Pseq( [1/3,1/3,1/3], iterations)], rhythmWeighting.normalizeSum), Pseq([0.25,0.25,0.25], iterations)
				, Pwrand([ Pseq( dim.resamp0(iterations*3) ), Pseq( cresc.resamp0(iterations*3) ) ], dynWeighting.normalizeSum) ])
		], [1,1,1].normalizeSum)
	})
	, weEnvs, inf).asStream
		