import 'package:avatar_view/avatar_view.dart';
import 'package:batman/controls/error_indicator.dart';
import 'package:batman/controls/loading_indicator.dart';
import 'package:batman/models/youtube_models.dart';
import 'package:batman/pages/video_details.dart';
import 'package:batman/styles/app_styles.dart';
import 'package:batman/viewmodels/start_page_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class InitPage extends StatefulWidget {
  InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  late StartPageViewModel viewModel;
  final _searchBarController = TextEditingController();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartPageViewModel>.reactive(
        viewModelBuilder: () => StartPageViewModel(),
        onViewModelReady: (vm) {
          vm.searchVideos();
          _scrollController.addListener(() {
            if (_scrollController.position.pixels >
                (0.95 * _scrollController.position.maxScrollExtent)) {
              vm.loadMoreVideos();
            }
          });
        },
        builder: (context, vm, child) {
          viewModel = vm;
          return Scaffold(
              backgroundColor: kPageBackgroundColor,
              appBar: AppBar(
                leading: const Icon(Icons.menu, color: kLightColor),
                centerTitle: true,
                elevation: 0,
                title: Text(
                  vm.Title,
                  style: const TextStyle(color: kLightColor),
                ),
                backgroundColor: Colors.transparent,
              ),
              body: _buildUI());
        });
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(4),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          color: kDarkColor, borderRadius: BorderRadius.circular(8)),
      child: TextField(
        controller: _searchBarController,
        onSubmitted: (value) =>
            viewModel.queryForVideos(_searchBarController.text),
        style: kRegularLightText16,
        decoration: InputDecoration(
            filled: true,
            hintText: "Search Videos",
            contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
            hintStyle: kRegularLightText16.copyWith(
                color: kLightTextColor.withOpacity(0.55)),
            border: InputBorder.none,
            fillColor: Colors.transparent,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 2, left: 2),
              child: InkWell(
                  onTap: () =>
                      viewModel.queryForVideos(_searchBarController.text),
                  child: const Icon(
                    Icons.search,
                    color: kLightColor,
                  )),
            )),
      ),
    );
  }

  Widget _buildUI() {
    // check for errors and show error indicator
    if (viewModel.IsErrorState) {
      return ErrorIndicator(errorText: viewModel.ErrorMessage);
    }
    // check if state is busy, then loading indicator
    if (viewModel.IsBusy) {
      return LoadingIndicator(loadingText: viewModel.LoadingText);
    }
    // check if data is loaded
    if (viewModel.DataLoaded) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
          child: Column(
            children: [
              // search bar
              _buildSearchBar(),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: _buildVideoList()),
              SizedBox(
                height: 8,
              ),
              Visibility(
                visible: viewModel.isLoadingMore,
                child: Center(
                  child: SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kLightColor),
                    ),
                  ),
                ),
              )
            ],
          ));
    }
    return const Placeholder();
  }

  Widget _buildVideoList() {
    return ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        final video = viewModel.YoutubeVideos[index];
        return _buildVideoCell(video);
      },
      itemCount: viewModel.YoutubeVideos.length,
    );
  }

  Widget _buildVideoCell(YoutubeVideo video) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => VideoDetailsPage(videoId: video.id!.videoId!))),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
            color: kCardFillColor,
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 5,
                    child: CachedNetworkImage(
                      imageUrl: video.snippet!.thumbnails!.high!.url!,
                      placeholder: (context, url) => const Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(kLightColor)),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2))
                            ],
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(12),
                          child: AvatarView(
                            radius: 16,
                            borderWidth: 1,
                            borderColor: kLightBorderColor,
                            avatarType: AvatarType.CIRCLE,
                            backgroundColor: Colors.transparent,
                            imagePath: video.snippet!.channelImageUrl!,
                            placeHolder: Placeholder(),
                            errorWidget: Placeholder(),
                          )),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            video.snippet!.channelTitle!,
                            style: kMediumLightText18,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            video.snippet!.title!,
                            style: kRegularLightText14,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )),
                      const SizedBox(
                        width: 12,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: kLightColor,
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
