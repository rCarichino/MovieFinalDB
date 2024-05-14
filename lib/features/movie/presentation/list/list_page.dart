import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/core/resources/palette.dart';

import '../../../../core/routes/app_routes.dart';
import 'cubits/list_cubit.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Palette.redLatte, Palette.blueLatte],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
        ),
        title: BlocBuilder<ListCubit, ListState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300,
                        color: Palette.text,
                      ),
                      validator: (value) => _validate(value),
                      onFieldSubmitted: (value) => context.read<ListCubit>().getSearchedMovies(query: value.trim())),
                ],
              ),
            );
          },
        ),
      ),
      body: BlocBuilder<ListCubit, ListState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error.isNotEmpty && !state.isLoading) {
            return ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => GoRouter.of(context)
                    .go("/${Routes.details.name}/:${state.movie[index].id}"),
                child: Column(
                  children: [
                    Text("${state.movie[index].originalTitle}"),
                    Text("${state.movie[index].title}"),
                  ],
                ),
              ),
              itemCount: state.movie.length,
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return const Center(
            child: Text("Search for a Movie"),
          );
        },
      ),
    );
  }
}

String? _validate(value) {
  if (value == null) {
    return "Look for something to search first";
  }
}
