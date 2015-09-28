(
fork{
	var t1, t2, duration=2;

	t1 = Main.elapsedTime;

	"start".postln;

	inf.do{|i|
		t2 = Main.elapsedTime;
		if (t2-t1>duration){nil.alwaysYield}{"iterating".postln; 0.1.wait};
	};

	"done".postln;
}
)





(
var arr, p;
var w1,w2, gestureDur=10, now=0, item=0, arrIntegrate;
var speedUpProcess=10; //faster than RT. use to timeScale any envs and anywhere bpm is used
var weighting;

w1 = Env([1,0], [gestureDur/speedUpProcess]);
w2 = Env([0,1], [gestureDur/speedUpProcess]);

arr = Array.new(4096);

//weighting = [1,1].normalizeSum;
weighting = Ptuple([w1, w2]).collect(_.normalizeSum);

p = Pwrand([Pseq([0.25,0.25,0.5]), Pseq([0.5, 0.5, 0.25]) ],
	weighting,
	inf).asStream;

//first make the array
fork{
	var t1, t2;
	t1 = Main.elapsedTime;

	inf.do{|i|
		t2 = Main.elapsedTime; //incremental time

		if (t2-t1>(gestureDur/speedUpProcess)){nil.alwaysYield}{
				item = p.next;
				arr.add(item);
				(item/speedUpProcess).wait;
			};
		};

		arr.postcs; //not contining pass the do loop because of .alwaysYield. need to figure out
		//	arrIntegrate=arr.integrate.postcs; //then .integrate it
	};
)





////////////////////////////////////
(
var arr, p;
arr = Array.new(10);
p = Pseq([0.25,0.25,0.5], inf).asStream;

//first make the array
10.do{
	var item;
	item = p.next;
	arr.add(item);
};
arr.postcs;
arr.integrate.postcs; //then integrate it
)
