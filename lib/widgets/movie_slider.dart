import 'package:flutter/material.dart';
import 'package:disney_movies/models/models.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> popularMovies;
  final String? title;
  final Function onNextPage;

  const MovieSlider(
      {super.key,
      required this.popularMovies,
      this.title,
      required this.onNextPage});

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.popularMovies.isEmpty) {
      return Container(
        width: double.infinity,
        height: 260,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      width: double.infinity,
      height: 260,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(widget.title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.popularMovies.length,
              itemBuilder: (_, int index) => _MoviePoster(
                  widget.popularMovies[index],
                  '${widget.title}-${index}-${widget.popularMovies[index].id}')),
        )
      ]),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _MoviePoster(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.id = heroId;
    return Container(
      width: 130,
      height: 290,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(children: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: movie),
          child: Hero(
            tag: movie.id!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.promoImage),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          movie.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
