import 'package:flutter/foundation.dart';

class BaseViewModel extends ChangeNotifier{
  bool _isBusy = false;
  bool get IsBusy => _isBusy;

  String _title = "";
  String get Title=> _title;
  set Title(String value)=> _title = value;

  String _loadingText = "";
  String get LoadingText => _loadingText;
  set LoadingText(String value) => _loadingText = value;

  bool _dataLoaded = false;
  bool get DataLoaded => _dataLoaded;
  set DataLoaded(bool value) => _dataLoaded = value;

  bool _iserrorState = false;
  bool get IsErrorState => _iserrorState;
  set IsErrorState(bool value) => _iserrorState = value;

  String _errorMessage = "";
  String get ErrorMessage => _errorMessage;
  set ErrorMessage(String value) => _errorMessage = value;

  void setDataLoadingIndicators({bool isStarting = true}){
    if(isStarting){
      _isBusy = true;
      _dataLoaded = false;
      _errorMessage = "";
      _iserrorState = false;
    }
    else{
      _loadingText = "";
      _isBusy = false;
    }
    notifyListeners();
  }
}