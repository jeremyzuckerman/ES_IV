(
var w1, w2, now=0, duration=10,waitTime=0.1;
// w1 = 1;
// w2 = 1;
w1 = Env(#[0,1], [duration]);
w2 = Env(#[1,0], [duration]);

fork{
	inf.do{
		if (now>duration){nil.alwaysYield}{
			[1, 2].wchoose([w1[now],w2[now]].normalizeSum).postln;
		};
			waitTime.wait;
			now = now+waitTime;
		};
	};
);