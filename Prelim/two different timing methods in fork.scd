//note the difference:
//waits till each interation of the inner is done (all functions inside of fork)
(
fork{
	3.do{|i|
		5.do{
			i.postln;
			0.1.wait;
		};
	}
};
)

//3 instances of inner loop simultaneously (outer loop outside of fork)
(
3.do{|i|
	fork{
		5.do{
			i.postln;
			0.1.wait;
		};
	}
}

)

//same result as first example but illustrates the synchrnous nature of functions inside of a fork
(
fork{
	3.do{|i|
		5.do{
			2.do{
				i.postln;
				0.1.wait;
			};
		};
	}
};
)

//outer loop timed, too
(
fork{
	5.do{|i|
		var time;
		time = rrand(0.5,2);

		5.do{
			i.postln;
			0.1.wait;
		};
		time.postln;
		time.wait;
	}
};
)