import 'package:equatable/equatable.dart';

import '../network/error_message_model.dart';

abstract class Failure extends Equatable {
  final ErrorMessageModel errorModel;

  const Failure(this.errorModel);

  @override
  List<Object> get props => [errorModel];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(ErrorMessageModel model) : super(model);

  static handleError(ErrorMessageModel model) {
    dynamic result = model.statusMessage;
    if (result.runtimeType == List) {
      // ToastHelper.showError(message: result.join('!@#').replaceAll('!@#', "'\n"));
    }else{
      // ToastHelper.showError(message: result ?? "");
    }
  }
}
