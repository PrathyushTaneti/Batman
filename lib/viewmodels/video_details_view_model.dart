import 'package:batman/constants/app_constants.dart';
import 'package:batman/models/youtube_models.dart';
import 'package:batman/services/youtube_api_service.dart';
import 'package:batman/viewmodels/base_view_model.dart';

class VideoDetailsPageViewModel extends BaseViewModel{
  final YoutubeApiService _apiService = YoutubeApiService();
  late final YoutubeVideoDetail _theVideo;
  YoutubeVideoDetail get TheVideo => _theVideo;
  late final Channel _theChannel;
  Channel get TheChannel => _theChannel;
  VideoDetailsPageViewModel(){
    Title = "Youtube";
  }

  Future<void> getVideoDetails(String videoId) async{
    setDataLoadingIndicators(isStarting: true);
    LoadingText = "Hold on while we load the video details...!";
    try{
      // search for youtube video and get the details of the video
      _theVideo = await _apiService.getVideoDetails(videoId);
      var channelSearchResults =
        await _apiService.getChannels(_theVideo.snippet!.channelId!);
      _theChannel = channelSearchResults.items!.first!;
      DataLoaded = true;
    }
    catch(ex){
      IsErrorState = true;
      ErrorMessage = "${ex.toString()}. If problem persists, please contact admin at ${Constants.authorEmail}";
    }
    finally{
      setDataLoadingIndicators(isStarting: false);
    }
  }

}