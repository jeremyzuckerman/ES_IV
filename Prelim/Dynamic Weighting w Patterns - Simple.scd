////////////////////
//dynamic weighting
(
var arr, p;
var w1,w2, gestureDur=100, now=0, item=0, arrIntegrate;
var speedUpProcess=100; //faster than RT. use to timescale envelopes, the while loop condition and the while loop wait time
var weighting, gestureDurScale;

gestureDurScale=gestureDur/speedUpProcess;

w1 = Env([1,0], [gestureDurScale]); //time scaling
w2 = Env([0,1], [gestureDurScale]); //time scaling

/*w1 = Env([1,1,0,0], [gestureDurScale*0.5, 0, gestureDurScale*0.5]); //predictable results to test
w2 = Env([0,0,1,1], [gestureDurScale*0.5, 0, gestureDurScale*0.5]); //predictable results to test*/

arr = Array.new(4096);

//weighting = [1,1].normalizeSum;
weighting = Ptuple([w1, w2]).collect(_.normalizeSum);

p = Pwrand([Pseq([0.25,0.25,0.5]), Pseq([0.5, 0.5, 0.25]) ],
	weighting,
	inf).asStream;

fork{
	var t1, t2;
	t1 = Main.elapsedTime;
//first make the array
	while {
		t2 = Main.elapsedTime; //incremental time
		(t2-t1)<=(gestureDurScale); //time scaling
	}
	{
		item = p.next;
		arr.add(item);
		(item/speedUpProcess).wait; //time scaling for faster than RT while still using the SystemClock
	};
	arr.postcs;
	arrIntegrate=arr.integrate.postcs; //then .integrate it for MIDI start times
};
)
