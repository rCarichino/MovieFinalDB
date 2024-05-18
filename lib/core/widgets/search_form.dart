import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/movie/presentation/list/cubits/list_cubit.dart';
import '../resources/dimens.dart';
import '../resources/palette.dart';

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimens.cornerRadius),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: Palette.textDark,
                hintText: "Search for a film",
              ),
              style: Theme.of(context).textTheme.bodyLarge,
              validator: (value) => _validateSearch(value),
              onFieldSubmitted: (value) => context
                  .read<ListCubit>()
                  .getSearchedMovies(query: value.trim())),
        ],
      ),
    );
  }

  String? _validateSearch(value) {

    if (value.lenght == null) {
      return "Look for something to search first";
    }
    return null;
  }
}
