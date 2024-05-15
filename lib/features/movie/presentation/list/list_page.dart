import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/core/resources/palette.dart';
import 'package:moviedb/core/widgets/circle_image.dart';

import '../../../../core/resources/images.dart';
import '../../../../core/routes/app_routes.dart';
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

    return SafeArea(
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
                IconButton(onPressed: (){}, icon: Icon(Icons.search))
              ]),
          body: BlocBuilder<ListCubit, ListState>(builder: (context, state) {
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
              return ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    final String detailsRoute =
                        "/${Routes.details.name}/${index.toString()}";
                    context.go(detailsRoute);
                  },
                  child: Column(
                    children: [
                      Text("${state.movie[index].originalTitle}"),
                      Text("${state.movie[index].title}"),
                      CircleImage(url: "https://image.tmdb.org/t/p/original${state.movie[index].posterPath}")
                    ],
                  ),
                ),
                itemCount: state.movie.length,
                separatorBuilder: (context, index) => const Divider(),
              );
            }
            return Center(
                child: Image.asset(
              Images.loading,
              height: 125.0,
              width: 125.0,
            ));
          })),
    );
  }
}
