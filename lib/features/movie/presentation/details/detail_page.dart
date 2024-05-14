import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/dimens.dart';
import '../../../../core/resources/images.dart';
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
        title: const Text("Details"),
      ),
      body: BlocBuilder<ListCubit, ListState>(
        builder: (BuildContext context, ListState state) {
          return Column(
            children: [
              Row(
                children: [
                  FadeInImage.assetNetwork(
                      height: 300,
                      width: 300,
                      placeholder: Images.loading,
                      image: state.movie[index].posterPath ??
                          Images.posterPlaceholder)
                ],
              ),
              Row(
                children: [
                  Text("${state.movie[index].title}",
                      style: TextStyle(
                          fontSize: Dimens.headlineMedium,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
