import 'package:batman/constants/app_constants.dart';
import 'package:batman/models/youtube_models.dart';
import 'package:batman/services/youtube_api_service.dart';
import 'package:batman/viewmodels/base_view_model.dart';

class StartPageViewModel extends BaseViewModel{
  final YoutubeApiService _apiService = YoutubeApiService();
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
      await _getYoutubeVideos();
    }
    catch(ex){
      ErrorState = true;
      ErrorMessage = "Something went wrong. If problem persists, please contact admin at ${Constants.authorEmail}";
    }
    finally{
      setDataLoadingIndicators(isStarting: false);
    }
  }


  Future<void> _getYoutubeVideos() async{
    // search the videos
    var videoSearchResults = await _apiService.searchVideos(_searchTerm, nextPageToken: _nextToken);
    _nextToken = videoSearchResults.nextPageToken!;
    _youtubeVideos.addAll(videoSearchResults.items!);
  }

}