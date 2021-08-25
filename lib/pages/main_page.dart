import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/controllers/main_page_data_controller.dart';
import 'package:movie_app/models/main_page_data.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/search_category.dart';
import 'package:movie_app/widgets/movie_tile.dart';

final mainPageDataControllerProvider = StateNotifierProvider((ref) {
  return MainPageDataController();
});

class MainPage extends ConsumerWidget {
  MainPageData? _mainPageData;
  MainPageDataController? _mainPageDataController;

  double? _deviceHeight;
  double? _deviceWidth;
  TextEditingController? _searchtextFieldController;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _searchtextFieldController = TextEditingController();

    _mainPageDataController = watch(mainPageDataControllerProvider);
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _backgroundWidget(),
              _foreGroundWidgets(),
            ],
          ),
        ));
  }

  Widget _backgroundWidget() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://terrigen-cdn-dev.marvel.com/content/prod/1x/online_12.jpg'))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _foreGroundWidgets() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight! * 0.02, 0, 0),
      width: _deviceWidth! * .88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          topBarWidgets(),
          Container(
              height: _deviceHeight! * 0.83,
              padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
              child: _moviesListViewWidget())
        ],
      ),
    );
  }

  Widget topBarWidgets() {
    return Container(
      height: _deviceHeight! * 0.08,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFieldWidget(),
          _categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget() {
    final _border = InputBorder.none;
    return Container(
      width: _deviceWidth! * 0.50,
      height: _deviceHeight! * 0.05,
      child: TextField(
          controller: _searchtextFieldController,
          onSubmitted: (_input) {},
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              focusedBorder: _border,
              border: _border,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white24,
              ),
              hintStyle: TextStyle(
                color: Colors.white54,
              ),
              filled: false,
              fillColor: Colors.white24,
              hintText: 'Search....')),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: SearchCategory.popular,
      icon: Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      underline: Container(
        height: 1,
        color: Colors.white24,
      ),
      items: [
        DropdownMenuItem(
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.upcoming,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.popular,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.none,
        ),
      ],
    );
  }

  Widget _moviesListViewWidget() {
    final List<Movie> _movies = [];

    for (var i = 0; i < 20; i++) {
      _movies.add(Movie(
          name: 'Loki',
          language: 'EN',
          isAdult: false,
          description:
              ' Loki marvel movie and best movies of  all time Loki marvel movie and best movies of  all time Loki marvel movie and best movies of  all time Loki marvel movie and best movies of  all time i l ike loki move very much. see u in cinemas ',
          posterPath: 'wdad',
          backdropPath: 'awdawd',
          rating: 8.2,
          releaseDate: '2021-06-05'));
    }

    if (_movies.length != 0) {
      return ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (BuildContext _context, int _count) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
              child: GestureDetector(
                onTap: () {},
                child: MovieTile(
                  height: _deviceHeight! * 0.20,
                  width: _deviceWidth! * 0.85,
                  movie: _movies[_count],
                ),
              ),
            );
          });
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}
