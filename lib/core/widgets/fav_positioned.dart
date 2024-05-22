import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/movie/presentation/list/cubits/list_cubit.dart';
import '../../features/userfavorites/presentation/favmovielist/cubits/fav_movie_cubit.dart';
import '../resources/palette.dart';

class FavPositioned extends StatelessWidget {
  final int index;

  const FavPositioned({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    String movieName = context.read<ListCubit>().state.movie[index].title!;
    bool isFavorite = context
        .watch<FavMovieCubit>()
        .state
        .movies
        .any((favMovie) => favMovie.movieName == movieName);

    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        onPressed: () async {
          String movieId =
              context.read<ListCubit>().state.movie[index].id.toString();
          !isFavorite
              ? await context
                  .read<FavMovieCubit>()
                  .addToFavList(movieName: movieName, movieId: movieId)
              : await context
                  .read<FavMovieCubit>()
                  .removeFromFavlist(movieName: movieName);
          context.read<FavMovieCubit>().getFromFavList();
        },
        icon: const Icon(Icons.favorite),
        color: isFavorite ? Palette.redLatte : Palette.card,
      ),
    );
  }
}
