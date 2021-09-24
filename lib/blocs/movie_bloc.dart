// import 'dart:async';

// import 'package:bettips/api/api_response.dart';
// import 'package:bettips/models/movie.dart';
// import 'package:bettips/repositories/movie_repository.dart';

// /*
// The main part of blog comes here as we are going to handle
// all those exceptions that we created. The basic thing that
// we are doing here is to pass different states of our Data
// to our UI using the StreamController.

//  */
// class MovieBloc {
//   MovieRepository _movieRepository;

//   StreamController _movieListController;

//   StreamSink<ApiResponse<List<Movie>>> get movieListSink =>
//       _movieListController.sink;

//   Stream<ApiResponse<List<Movie>>> get movieListStream =>
//       _movieListController.stream;

//   MovieBloc() {
//     _movieListController = StreamController<ApiResponse<List<Movie>>>();
//     _movieRepository = MovieRepository();
//     fetchMovieList();
//   }

//   fetchMovieList() async {
//     movieListSink.add(ApiResponse.loading('Fetching Popular Movies'));
//     try {
//       List<Movie> movies = await _movieRepository.fetchMovieList();
//       movieListSink.add(ApiResponse.completed(movies));
//     } catch (e) {
//       movieListSink.add(ApiResponse.error(e.toString()));
//       print(e);
//     }
//   }

//   dispose() {
//     _movieListController?.close();
//   }
// }
