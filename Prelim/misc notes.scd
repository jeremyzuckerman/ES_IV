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
