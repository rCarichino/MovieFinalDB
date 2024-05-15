import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/core/resources/palette.dart';
import 'package:moviedb/core/widgets/circle_image.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/loading.dart';
import 'cubits/list_cubit.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    String? _validate(value) {
      if (value == null) {
        return "Look for something to search first";
      }
      return null;
    }

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Palette.redLatte, Palette.blueLatte],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
              ),
              title: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimens.cornerRadius),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Palette.textDark,
                          hintText: "cerca un film",
                        ),
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                          color: Palette.text,
                        ),
                        validator: (value) => _validate(value),
                        onFieldSubmitted: (value) => context
                            .read<ListCubit>()
                            .getSearchedMovies(query: value.trim())),
                  ],
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ]),
          body: Column(
            children: [
              Expanded(
                  child: TabBarView(
                children: [
                  Center(
                    heightFactor: 1,
                    child: Container(
                      color: Palette.backgroundDark,
                      margin: EdgeInsets.only(top: Dimens.space12),
                      padding: EdgeInsets.symmetric(
                          vertical: Dimens.space12, horizontal: Dimens.space6),
                      child: BlocBuilder<ListCubit, ListState>(
                          builder: (context, state) {
                        if (state.isLoading) {
                          return Center(
                            child: Image.asset(
                              Images.loading,
                              height: Dimens.imageW,
                              width: Dimens.imageW,
                            ),
                          );
                        }
                        if (state.movie.isNotEmpty && !state.isLoading) {
                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Dimens.space2 as int,
                              mainAxisSpacing: Dimens.space8,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                final String detailsRoute =
                                    "/${Routes.details.name}/${index.toString()}";
                                context.go(detailsRoute);
                              },
                              child: Container(
                                padding: EdgeInsets.all(Dimens.space6),
                                color: Palette.cardDark,
                                child: CachedNetworkImage(
                                    placeholder: (context, url) =>
                                        const Loading(showMessage: false),
                                    imageUrl: state.movie[index].posterPath !=
                                            null
                                        ? 'https://image.tmdb.org/t/p/w500${state.movie[index].posterPath}'
                                        : Images.posterPlaceholderURL),
                              ),
                            ),
                            itemCount: state.movie.length,
                          );
                        }
                        if (state.movie.isEmpty && state.error == '') {
                          errorDialog(context, "No data");
                        }
                        return Center(
                            child: Image.asset(
                          Images.loading,
                          height: Dimens.imageW,
                          width: Dimens.imageW,
                        ));
                      }),
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }
}
