import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviecorn/common/constants/size_constants.dart';
import 'package:moviecorn/common/constants/transalations_constants.dart';
import 'package:moviecorn/common/extensions/size_extensions.dart';
import 'package:moviecorn/common/extensions/string_extensions.dart';
import 'package:moviecorn/domain/entities/movie_videos_entity.dart';

import 'package:moviecorn/presentation/screens/watch_video/movie_video_arguments.dart';
import 'package:moviecorn/presentation/themes/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({
    Key? key,
    required this.watchVideoArguments,
  }) : super(key: key);
  final WatchVideoArguments watchVideoArguments;
  @override
  WatchVideoScreenState createState() => WatchVideoScreenState();
}

class WatchVideoScreenState extends State<WatchVideoScreen> {
  late List<MovieVideosEntity> _videos;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _videos = widget.watchVideoArguments.videos;
    _controller = YoutubePlayerController(
      initialVideoId: _videos[0].key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationsConstants.watchTrailers.t(context),
        ),
        backgroundColor: AppColors.vulcan,
      ),
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return Column(
              children: [
                player,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i = 0; i < _videos.length; i++)
                          GestureDetector(
                            onTap: () {
                              _controller.load(_videos[i].key);
                              _controller.play();
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 60.h.toDouble(),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: YoutubePlayer.getThumbnail(
                                      videoId: _videos[i].key,
                                      quality: ThumbnailQuality.high,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15.w.toDouble(),
                                  ),
                                  Flexible(
                                    child: Text(
                                      _videos[i].name,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Flexible(
                //   child: ListView.builder(
                //     itemBuilder: (context, index) {
                //       return GestureDetector(
                //         onTap: () {
                //           _controller.load(
                //             _videos[index].key,
                //           );
                //           _controller.play();
                //         },
                //         child: Row(
                //           children: [
                //             CachedNetworkImage(
                //               width: Sizes.dimen_140.w.toDouble(),
                //               height: Sizes.dimen_80.h.toDouble(),
                //               imageUrl: YoutubePlayer.getThumbnail(
                //                 videoId: _videos[index].key,
                //                 quality: ThumbnailQuality.high,
                //               ),
                //             ),
                //             SizedBox(
                //               width: 10.w.toDouble(),
                //             ),
                //             Flexible(
                //               child: Text(
                //                 _videos[index].name,
                //                 style: Theme.of(context).textTheme.subtitle1,
                //               ),
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            );
          }),
    );
  }
}
