(
var numNotes=20, cresc, hairpin, dyn, dyn_sw=0.5, pchSet1, pchSet2, rhythm;
var numPchs;

cresc = #[2,4,6,7].choose;
hairpin = #[4,8,12,14].choose;
pchSet1 = #[68,69].choose;
pchSet2 = #[90,92].choose;
rhythm = [1/4,1/3,1/2,3/2].choose;

numNotes.do{
	if (dyn_sw.coin==true) //dyn=1 is true
	{
		dyn=cresc;
		if (rhythm==(1/4)){
			"16ths <".postln;
			//dyn.postln;
			numPchs = dyn*

		};
		if (rhythm==(1/2)){"8ths <".postln;};
		if (rhythm==(1/3)){"8th trips <".postln};
		if (rhythm==(3/2)){"1/4 trips <".postln};
	}
	{
		dyn=hairpin;
		if (rhythm==(1/4)){"16ths <>".postln;};
		if (rhythm==(1/2)){"8ths <>".postln;};
		if (rhythm==(1/3)){"8th trips <>".postln};
		if (rhythm==(3/2)){"1/4 trips <>".postln};
	};
};
)




	}{dyn=hairpin};
	dyn.postln;
}
)

Pcoin

Prout


Psomething( (0..10), 32)

[1, 2, 3].normalize(-20, 10);