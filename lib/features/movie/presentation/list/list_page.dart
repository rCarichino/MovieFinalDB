import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moviedb/core/resources/palette.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';
import '../../../../core/widgets/error_dialog.dart';
import '../../../../core/widgets/grid_view_movie.dart';
import '../../../../core/widgets/list_view_movie.dart';
import '../../../../core/widgets/loading.dart';
import '../../../../core/widgets/search_form.dart';
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
          title: SearchForm(formKey: formKey),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<ListCubit>().toggleTypeView();
                },
                icon: const Icon(Icons.grid_3x3))
          ]),
      body: Column(
        children: [
          Expanded(
              child: Center(
            heightFactor: 1,
            child: Container(
              color: Palette.backgroundDark,
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
                    return state.isGrid
                        ? const GridViewMovie()
                        : const ListViewMovie();
                  }
                  if (state.movie.isEmpty && state.error.isEmpty) {
                    return const Center(
                      child: Text("No data"),
                    );
                  }
                  if (state.error.isNotEmpty) {
                    return Center(
                      child: Text("Error: ${state.error}"),
                    );
                  }
                  return Center(
                    child: Image.asset(
                      Images.loading,
                      height: Dimens.imageW,
                      width: Dimens.imageW,
                    ),
                  );
                },
              ),
            ),
          )),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }
}
