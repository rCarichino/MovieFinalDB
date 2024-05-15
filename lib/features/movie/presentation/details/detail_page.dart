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
            const Text(
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 25),
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
            elevation: 5,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${state.movie[index].title}',
                    style: const TextStyle(
                        color: Palette.redLatte,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  FadeInImage.assetNetwork(
                    fit: BoxFit.contain,
                    height: 475,
                    placeholder: Images.loading,
                    image:
                        state.movie[index].posterPath != null ? 'https://image.tmdb.org/t/p/w500${state.movie[index].posterPath}' : "https://springerhealthcare.it/GIHTAD/wp-content/uploads/2021/03/placeholder.jpg",
                  ),
                  const SizedBox(height: 16),
                  const Text(
                      style: TextStyle(
                          color: Palette.text,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 23),
                      "Description:"),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Palette.card,
                      ),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Text(
                          style: const TextStyle(
                              fontSize: 16,
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
