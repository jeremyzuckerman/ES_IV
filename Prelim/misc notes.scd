////////////////////////////
//envelope indexing an array
(
var a,b,c,d;

a = #[12, 8, 4, 2, 1].reverse; //.reverse is so great.

b = Env([a.size-1, 0], #[10]).asStream;

fork{
	100.do{
		a[b.next.round(1)].postln;
		0.1.wait;
	}
}
)

//as a function
~func = {|array, stream|
	fork{
		100.do{
			array[stream.next].postln;
			0.1.wait;
		}
	}
};

(
var a, b;
a = #[12, 8, 4, 2, 1];
b = Env([0, a.size-1], #[10]).asStream.round(1);

~func.value( a, b )
)

(
Ptuple([ Pseq([0],

///////////////////////////////////
//can have static and dynamic values
(
var a,b,c,d;

// a = Ptuple([0, 1, Env([10,20],[5]) ]).collect(_.normalizeSum).asStream;
a = Ptuple([0, 1, Env([10,20],[5]) ]).asStream;

fork{
	10.do{
		a.next.postln;

		0.5.wait;
	}
}
)

//switching loop on and off. needs fork to be timed
~a=1;
~a=0;
(
fork{
	while {~a==1} {"iterate".postln; 0.1.wait;};
};
)

//counter example
(
var i;
i = -1; //so i starts at 0

while {i<10} {
	i = (i+1).postln; //serves as a counter
};
)

//using a timer to stop the while loop
(
fork{
	var t1, t2, duration=2;

	t1 = Main.elapsedTime;

	"start".postln;

	while { //use a while loop as opposed to a do loop
		t2 = Main.elapsedTime; //incremental time
		t2-t1<=duration;
	}{
		"iterating".postln;
		0.1.wait
	};
	"done".postln; //evaluated after while loop is completed
};
)

//make and array, then .integrate
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

//how to access patterns in a Ptuple
(
p = Ptuple([Pseq([1,2,3]), Pseq([60,70,80])], inf).asStream;
p.next[0].postln;
)

//adding timestamp to name
(
("test "++Main.elapsedTime.round(0.1)).postln
)
