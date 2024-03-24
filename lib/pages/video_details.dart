import 'package:batman/controls/error_indicator.dart';
import 'package:batman/controls/loading_indicator.dart';
import 'package:batman/styles/app_styles.dart';
import 'package:batman/viewmodels/video_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class VideoDetailsPage extends StatelessWidget {
  final String videoId;
  late VideoDetailsPageViewModel viewModel;
  VideoDetailsPage({required this.videoId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoDetailsPageViewModel>.reactive(
        viewModelBuilder: () => VideoDetailsPageViewModel(),
        onModelReady: (vm) {
          vm.getVideoDetails(videoId);
        },
        builder: (context, vm, child) {
          viewModel = vm;
          return Scaffold(
              backgroundColor: kPageBackgroundColor,
              appBar: AppBar(
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

  Widget _buildUI() {
    if (viewModel.IsErrorState) {
      return ErrorIndicator(errorText: viewModel.ErrorMessage);
    }
    // check if state is busy, then loading indicator
    if (viewModel.IsBusy) {
      return LoadingIndicator(loadingText: viewModel.LoadingText);
    }
    // check if data is loaded
    if (viewModel.DataLoaded) {
      return Text(viewModel.TheVideo.snippet!.title!);
    }
    return const Placeholder();
  }
}
