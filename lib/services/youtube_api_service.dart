import 'package:batman/constants/app_constants.dart';
import 'package:batman/models/youtube_models.dart';
import 'package:dio/dio.dart';

class YoutubeApiService{

  late Dio _httpClient;

  YoutubeApiService(){
    this._httpClient = Dio();
    this._httpClient.options.baseUrl = Constants.apiURL;
  }

  Future<VideoYoutubeResults> searchVideos(String searchTerm, {String nextPageToken = ""}) async{
    var resourceUri = "search?part=snippet&maxResults=10&q=$searchTerm&type=videos&key=${Constants.apiKey}${nextPageToken.isNotEmpty? "&pageToken=$nextPageToken" : "" }";
    var response = await this._httpClient.get(Uri.encodeFull(resourceUri));
    return VideoYoutubeResults.fromJson(response.data);
 }
}