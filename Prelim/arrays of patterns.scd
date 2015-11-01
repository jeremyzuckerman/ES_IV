(
var beatsArray;
var c1=24, c2=36, c3=48, c4=60, c5=72, c6=84, c7=96;
var rhythmWeighting, dynWeighting;
var cresc, dim;
var flPats1, flPats2, flPats3, flPats4, flPats5, flPats;
var clPats1, clPats2, clPats3, clPats4, clPats5, clPats;
var beatsWeighting;
var polytonalityFl;
var bsClPats1, bsClPats2, bsClPats3, bsClPats4, bsClPats5, bsClPats;
var bsnPats1, bsnPats2, bsnPats3, bsnPats4, bsnPats5, bsnPats;

polytonalityFl = #[1,1,1,1,1];

beatsWeighting = #[1,1,1,1];

cresc = (10..100);
dim = (100..10);
rhythmWeighting = #[1,0.7];
dynWeighting = #[0.9,1];

beatsArray = #[16,15,14,12];

//Fl
flPats1 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6+2, c6, c6-5 ], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats1 = Pwrand(flPats1, beatsWeighting);

flPats2 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6+1, c6-4, c5+4], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats2 = Pwrand(flPats2, beatsWeighting);

flPats3 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-3, c6-5, c5+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats3 = Pwrand(flPats3, beatsWeighting);

flPats4 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-4, c5+4, c5+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats4 = Pwrand(flPats4, beatsWeighting);

flPats5 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-5, c5+3, c5+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
flPats5 = Pwrand(flPats5, beatsWeighting);

flPats = Pwxrand([flPats1, flPats2, flPats3, flPats4, flPats5], polytonalityFl, inf).asStream;

//(flPats1++flPats2).postcs

//Cl
clPats1 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-3, c5+3, c5+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats1 = Pwrand(clPats1, beatsWeighting);

clPats2 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c6-6, c5+2,c5+1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats2 = Pwrand(clPats2, beatsWeighting);

clPats3 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5+4, c5-1, c5-3], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats3 = Pwrand(clPats3, beatsWeighting);

clPats4 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5+2, c5, c5-5], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats4 = Pwrand(clPats4, beatsWeighting);

clPats5 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5+1, c5-4, c5-6], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
clPats5 = Pwrand(clPats5, beatsWeighting);

clPats = Pwxrand([clPats1, clPats2, clPats3, clPats4, clPats5], polytonalityCl, inf).asStream;

//Bs Cl
bsClPats1 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5-4, c4+3, c4+1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats1 = Pwrand(bsClPats1, beatsWeighting);

bsClPats2 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c5-5, c4+3, c4+2], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats2 = Pwrand(bsClPats2, beatsWeighting);

bsClPats3 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+3, c4+1, c4-1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats3 = Pwrand(bsClPats3, beatsWeighting);

bsClPats4 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+2, c4-3, c4-5], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats4 = Pwrand(bsClPats4, beatsWeighting);

bsClPats5 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+1, c4-4, c3+4], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsClPats5 = Pwrand(bsClPats5, beatsWeighting);

bsClPats = Pwxrand([bsClPats1, bsClPats2, bsClPats3, bsClPats4, bsClPats5], polytonalityBsCl, inf).asStream;

//Bsn
bsnPats1 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+1, c4-4, c4-6], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsnPats1 = Pwrand(bsnPats1, beatsWeighting);

bsnPats2 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4+1,c4-3,c4-4], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsnPats2 = Pwrand(bsnPats2, beatsWeighting);

bsnPats3 = Array.fill(beatsArray.size, {|i|
	Ptuple([ Pseq([c4-4,c3+3,c3+1], beatsArray[i]), Pwrand([Pseq( [0.25,0.25,0.5], beatsArray[i]), Pseq( [1/3,1/3,1/3], beatsArray[i])], rhythmWeighting.normalizeSum), 0, Pwrand([ Pseq( dim.resamp0(beatsArray[i]*3) ), Pseq( cresc.resamp0(beatsArray[i]*3) ) ], dynWeighting.normalizeSum) ]);
});
bsnPats3 = Pwrand(bsnPats3, beatsWeighting);

bsnPats = Pwxrand([bsnPats1, bsnPats2, bsnPats3, bsnPats4, bsnPats5], polytonalityBsn, inf).asStream;

fork{
	100.do{
		flPats.next.postln;
		0.1.wait;
	}
}
)