import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../Utilities/router_config.dart';




class LoadingProvider extends ChangeNotifier {

  static setGeneralLoading({BuildContext? context}) => (context == null && currentContext_ == null)?null: Provider.of<LoadingProvider>(context??currentContext_!,listen: false)._setGeneralLoading(true);

  static setLoading({BuildContext? context}) => (context == null && currentContext_ == null)?null: Provider.of<LoadingProvider>(context??currentContext_!,listen: false)._setLoading(true);
  static removeLoading({BuildContext? context}) => (context == null && currentContext_ == null)?null: Provider.of<LoadingProvider>(context??currentContext_!,listen: false)._setLoading(false);
  static bool loading({BuildContext? context}) => (context == null && currentContext_ == null)?false: Provider.of<LoadingProvider>(context??currentContext_!,listen: false).isLoading;

  Timer? _timer;


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    if(value){
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 60), ()=> _setLoading(false));
    }else{
      _timer?.cancel();
    }
    _isLoading = value;
    notifyListeners();
  }




  bool _generalLoading = false;
  bool get generalLoading => _generalLoading;

  void _setGeneralLoading(bool value) {
    if(value){
      _timer?.cancel();
      _timer = Timer(const Duration(milliseconds: 300), ()=> _setGeneralLoading(false));
    }else{
      _timer?.cancel();
    }
    _generalLoading = value;
    notifyListeners();
  }
}