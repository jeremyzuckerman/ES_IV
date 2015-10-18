(
var p,q,r;

p = Prand( (0..10), inf).asStream;

10.do{

	q = p.next;
	r = p.next;

	[q,r].collect(_.postln); //(_.postln) is a shortcut for ({|i| i.postln})
}
)

(
var p;

p = Ptuple([ Pseq( (0..10) ), Prand( (100..110), inf ) ], inf).asStream;

10.do{
	p.next.postln;
}
)



(
//mini example of ~algoMIDI1_ES4 for testing
~mini = {|iter=10, p, r|
	r = r.nextN(iter);

	fork{

		iter.do{|i|
			var rext;

			rext = r[i];

			//[ p.next[0], p.next[1], p.next[2] ].collect(_.postln);
			[p.next, rext, rext].collect(_.postln);


			0.1.wait;
		}
	}
}
)

(
var rand, rand2;
rand = Prand( (100..200), inf).asStream;

fork{
	~mini.value(20,
		Pseq( (0..3), inf).asStream
		, rand
	)
}
)



