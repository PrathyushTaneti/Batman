import 'package:batman/constants/app_constants.dart';
import 'package:batman/models/youtube_models.dart';
import 'package:dio/dio.dart';

class YoutubeApiService{

  late Dio _httpClient;

  YoutubeApiService(){
    _httpClient = Dio();
    _httpClient.options.baseUrl = Constants.apiURL;
  }

  Future<VideoYoutubeResults> searchVideos(String searchTerm, {String nextPageToken = ""}) async{
    var resourceUri = "search?part=snippet&maxResults=10&q=$searchTerm&type=videos&key=${Constants.apiKey}${nextPageToken.isNotEmpty? "&pageToken=$nextPageToken" : "" }";
    var response = await _httpClient.get(Uri.encodeFull(resourceUri));
    return VideoYoutubeResults.fromJson(response.data);
 }

  Future<ChannelSearchResult> getChannels(String channelIds) async{
    var resourceUri = "channels?part=snippet,statistics&maxResults=10&id=$channelIds&key=${Constants.apiKey}";
    var response = await _httpClient.get(Uri.encodeFull(resourceUri));
    return ChannelSearchResult.fromJson(response.data);
  }

  Future<YoutubeVideoDetail> getVideoDetails(String videoId) async{
    var resourceUri = "videos?part=contentDetails,id,snippet,statistics& key=${Constants.apiKey}&id=$videoId";
    var response = await _httpClient.get(Uri.encodeFull(resourceUri));
    return YoutubeVideoDetail.fromJson(response.data);
  }
}