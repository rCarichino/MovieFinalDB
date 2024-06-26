import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/core/widgets/bottom_navigation_bar.dart';
import 'package:moviedb/core/widgets/spacer_h.dart';
import 'package:moviedb/core/widgets/spacer_v.dart';
import 'package:moviedb/features/userfavorites/presentation/favmovielist/cubits/fav_movie_cubit.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/resources/palette.dart';
import '../../../../core/routes/app_routes.dart';

class FavMoviePage extends StatelessWidget {
  const FavMoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontFamily: "Poppins"),
            "Favorities"),
      ),
      body: Column(
        children: [
          BlocBuilder<FavMovieCubit, FavMovieState>(builder: (context, state) {
            if (state.isLoading) {
              return Center(
                child: Image.asset(
                  Images.loading,
                  height: Dimens.imageW,
                  width: Dimens.imageW,
                ),
              );
            }
            if (state.movies.isNotEmpty && !state.isLoading) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: ListView.builder(
                    itemBuilder: (context, index) => Dismissible(
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              context.read<FavMovieCubit>().removeFromFavlist(
                                  movieName: state.movies[index].movieName!);
                            }
                          },
                          key: ValueKey(state.movies[index]),
                          background: Container(
                              color: Palette.redLatte,
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.remove_circle),
                              )),
                          child: Container(
                            padding: EdgeInsets.all(Dimens.space6),
                            color: Palette.cardDark,
                            child: Row(
                              children: [
                                Text(
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontFamily: "Poppins",
                                            color: Palette.redLatte),
                                    state.movies[index].movieName ?? ''),
                                const SpacerH(),
                                Text(
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontFamily: "Poppins"),
                                    state.movies[index].movieId ?? ''),
                              ],
                            ),
                          ),
                        ),
                    itemCount: state.movies.length),
              );
            }
            if (state.movies.isEmpty && state.errorMessage!.isEmpty) {
              return const Center(
                child: Text("No data"),
              );
            }
            if (state.errorMessage!.isNotEmpty) {
              return Center(
                child: Text("Error: ${state.errorMessage}"),
              );
            }
            return Center(
              child: Image.asset(
                Images.loading,
                height: Dimens.imageW,
                width: Dimens.imageW,
              ),
            );
          })
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }
}
