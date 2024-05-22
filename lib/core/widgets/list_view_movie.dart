import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/core/widgets/fav_positioned.dart';
import 'package:moviedb/features/movie/presentation/list/cubits/list_cubit.dart';
import 'package:moviedb/features/userfavorites/presentation/favmovielist/cubits/fav_movie_cubit.dart';

import '../resources/dimens.dart';
import '../resources/palette.dart';
import '../routes/app_routes.dart';
import 'loading.dart';

class ListViewMovie extends StatelessWidget {
  const ListViewMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                final String detailsRoute =
                    "/${Routes.details.name}/${index.toString()}";
                context.go(detailsRoute);
              },
              child: Stack(
                alignment: Alignment.topRight,
                  children: [
                Container(
                  padding: EdgeInsets.all(Dimens.space6),
                  color: Palette.cardDark,
                  child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const Loading(showMessage: false),
                      imageUrl: context
                                  .read<ListCubit>()
                                  .state
                                  .movie[index]
                                  .posterPath !=
                              null
                          ? 'https://image.tmdb.org/t/p/w500${context.read<ListCubit>().state.movie[index].posterPath}'
                          : "https://springerhealthcare.it/GIHTAD/wp-content/uploads/2021/03/placeholder.jpg"),
                ),
                FavPositioned(index: index)
              ]),
            ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: context.read<ListCubit>().state.movie.length);
  }
}
