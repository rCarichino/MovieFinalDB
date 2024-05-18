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
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
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
              child:
                  BlocBuilder<ListCubit, ListState>(builder: (context, state) {
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Dimens.space2int,
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
                  height: Dimens.imageW,
                  width: Dimens.imageW,
                ));
              }),
            ),
          )),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }


}

