import 'package:batman/constants/app_constants.dart';
import 'package:batman/models/youtube_models.dart';
import 'package:batman/services/youtube_api_service.dart';
import 'package:batman/viewmodels/base_view_model.dart';

class StartPageViewModel extends BaseViewModel{
  final YoutubeApiService _apiService = YoutubeApiService();
  bool isLoadingMore = false;
  String _nextToken = "";
  String _searchTerm = "";
  List<YoutubeVideo> _youtubeVideos = [];
  List<YoutubeVideo> get YoutubeVideos => _youtubeVideos;

  StartPageViewModel(){
    Title = "Youtube";
  }

  Future<void> searchVideos() async{
    setDataLoadingIndicators(isStarting: true);
    LoadingText = "Hold on while we search for the results";
    _youtubeVideos = [];
    try{
      // search for youtube videos
      await Future.delayed(const Duration(seconds: 10));
      DataLoaded = true;
      await _getYoutubeVideos();
    }
    catch(ex){
      IsErrorState = true;
      ErrorMessage = "${ex.toString()}. If problem persists, please contact admin at ${Constants.authorEmail}";
    }
    finally{
      setDataLoadingIndicators(isStarting: false);
    }
  }


  Future<void> _getYoutubeVideos() async{
    // search the videos
    var videoSearchResults = await _apiService.searchVideos(_searchTerm, nextPageToken: _nextToken);
    var channelIDs = videoSearchResults.items!.map((video) =>
        video.snippet!.channelId
    ).join(",");
    var channelSearchResults = await _apiService.getChannels(channelIDs);
    videoSearchResults.items?.forEach((video) {
      video.snippet!.channelImageUrl = channelSearchResults.items!
      .where((channel) => channel.id == video.snippet!.channelId)
      .first.snippet!.thumbnails!.medium!.url!;
    });
    _nextToken = videoSearchResults.nextPageToken!;
    _youtubeVideos.addAll(videoSearchResults.items!);
  }


  Future<void> queryForVideos(String searchQuery) async{
    _nextToken = "";
    _searchTerm = searchQuery.trim();
    await searchVideos();
  }

  Future<void> loadMoreVideos() async{
    if(this.isLoadingMore || _nextToken.isEmpty){ return; };
    this.isLoadingMore = true;
    notifyListeners();
    await _getYoutubeVideos();
    this.isLoadingMore = false;
    notifyListeners();
  }
}