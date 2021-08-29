abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsCangBotomNavBar extends NewsState {}

class NewsGetBusniessLoadingState extends NewsState {}

class NewsGetBusniessSuccessState extends NewsState {}

class NewsGetBusniessErorrState extends NewsState {
  final String error;

  NewsGetBusniessErorrState(this.error);
}

class NewsGetScienceLoadingState extends NewsState {}

class NewsGetScienceSuccessState extends NewsState {}

class NewsGetScienceErorrState extends NewsState {
  final String error;

  NewsGetScienceErorrState(this.error);
}

class NewsGetSportsLoadingState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErorrState extends NewsState {
  final String error;

  NewsGetSportsErorrState(this.error);
}

class NewsGetSearchLoadingState extends NewsState {}

class NewsGetSearchSuccessState extends NewsState {}

class NewsGetSearchErorrState extends NewsState {
  final String error;

  NewsGetSearchErorrState(this.error);
}
