//another way to organize the rests. cleaner? easier to control? Could use stepped envs to progress.
Pwrand([
	Pwrand([0, 0.5], [1,1].normalizeSum)
	, Pwrand([0.5, 1], [1,1].normalizeSum)
	, Pwrand([1, 1.5], [1,1].normalizeSum)
	, Pwrand([1.5, 2], [1,1].normalizeSum)
	, Pwrand([2, 2.5, 4], [1,1,1].normalizeSum)
	, Pwrand([4, 7.5], [1,1].normalizeSum)
], [densLev1, densLev2, densLev3, densLev4, densLev5, densLev6] /*envs or static values*/
, inf)