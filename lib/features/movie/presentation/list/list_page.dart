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

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => context.goNamed(Routes.home.name),
                icon: const Icon(Icons.movie),
              ),
              label: "Movies"),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => context.goNamed(Routes.profile.name),
              ),
              label: "Profile")
        ],
      ),
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
                          borderRadius: BorderRadius.circular(10),
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
              child: Center(
            heightFactor: 1,
            child: Container(
              color: Palette.backgroundDark,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child:
                  BlocBuilder<ListCubit, ListState>(builder: (context, state) {
                if (state.isLoading) {
                  return Center(
                    child: Image.asset(
                      Images.loading,
                      height: 125.0,
                      width: 125.0,
                    ),
                  );
                }
                if (state.movie.isNotEmpty && !state.isLoading) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        final String detailsRoute =
                            "/${Routes.details.name}/${index.toString()}";
                        context.go(detailsRoute);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        color: Palette.cardDark,
                        child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                const Loading(showMessage: false),
                            imageUrl: state.movie[index].posterPath != null
                                ? 'https://image.tmdb.org/t/p/w500${state.movie[index].posterPath}'
                                : "https://springerhealthcare.it/GIHTAD/wp-content/uploads/2021/03/placeholder.jpg"),
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
                  height: 125.0,
                  width: 125.0,
                ));
              }),
            ),
          )),
        ],
      ),
    );
  }
}
