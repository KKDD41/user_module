import 'package:flutter/cupertino.dart';


/// Make it beautiful :)
class CustomErrorMessage {
  CustomErrorMessage(String errorMessage) {
    throw ErrorWidget.withDetails(message : errorMessage);
  }
}