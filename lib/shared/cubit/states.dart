abstract class NewsStates {}

class NewsInitialState extends NewsStates{}

class NewsChangeNavBarItem extends NewsStates{}

class NewsLoadingBusinessData extends NewsStates{}

class NewsLoadingSportData extends NewsStates{}

class NewsLoadingScienceData extends NewsStates{}

class NewsLoadingSearchData extends NewsStates{}


class NewsGetBusinessSuccessData extends NewsStates{}

class NewsGetSportSuccessData extends NewsStates{}

class NewsGetScienceSuccessData extends NewsStates{}

class NewsGetSearchSuccessData extends NewsStates{}


class NewsGetBusinessErrorData extends NewsStates{}

class NewsGetSportErrorData extends NewsStates{}

class NewsGetScienceErrorData extends NewsStates{}

class NewsGetSearchErrorData extends NewsStates{}

class NewsChangeAppMode extends NewsStates{}



