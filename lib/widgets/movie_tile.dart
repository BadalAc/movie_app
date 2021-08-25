import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/movie.dart';

class MovieTile extends StatelessWidget {
  final double? height;
  final double? width;
  final Movie? movie;

  final GetIt _getIt = GetIt.instance;

  MovieTile({this.height, this.width, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePosterWidget(movie!.posterURL()),
          _movieInfoWidget(),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String _imageUrl) {
    return Container(
      height: height,
      width: width! * 0.35,
      color: Colors.red,
      // decoration: BoxDecoration(
      //   image: DecorationImage(image: NetworkImage(_imageUrl)),
      // ),
    );
  }

  Widget _movieInfoWidget() {
    return Container(
      height: height,
      width: width! * 0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: width! * 0.55,
                child: Text(
                  movie!.name.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                movie!.rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height! * 0.02, 0, 0),
            child: Text(
              '${movie!.language.toString().toUpperCase()} | R: ${movie!.isAdult} | ${movie!.releaseDate}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
              0,
              height! * 0.07,
              0,
              0,
            ),
            child: Text(
              movie!.description.toString(),
              maxLines: 9,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: 10),
            ),
          )
        ],
      ),
    );
  }
}
