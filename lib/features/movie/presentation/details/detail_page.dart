import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/resources/images.dart';
import '../../../../core/resources/palette.dart';
import '../../../../core/routes/app_routes.dart';
import '../list/cubits/list_cubit.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    int index = int.parse(id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.titleLarge),
                "Details"),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).go(Routes.home.path);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<ListCubit, ListState>(
        builder: (BuildContext context, ListState state) {
          return Card(
            elevation: Dimens.space6,
            margin: EdgeInsets.all(Dimens.space16),
            child: Padding(
              padding: EdgeInsets.all(Dimens.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${state.movie[index].title}',
                    style: TextStyle(
                        color: Palette.redLatte,
                        fontSize: Dimens.titleMedium,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: Dimens.space16),
                  FadeInImage.assetNetwork(
                    fit: BoxFit.contain,
                    height: Dimens.posterW,
                    placeholder: Images.loading,
                    image: state.movie[index].posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500${state.movie[index].posterPath}'
                        : Images.posterPlaceholderURL,
                  ),
                  SizedBox(height: Dimens.space16),
                  Text(
                      style: TextStyle(
                          color: Palette.text,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.headlineSmall),
                      "Description:"),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimens.cornerRadius),
                        color: Palette.card,
                      ),
                      margin: EdgeInsets.all(Dimens.space6),
                      padding: EdgeInsets.all(Dimens.space12),
                      child: SingleChildScrollView(
                        child: Text(
                          style: TextStyle(
                              fontSize: Dimens.labelLarge,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
                          '${state.movie[index].overview}',
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
