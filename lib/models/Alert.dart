import 'package:flutter/material.dart';

class AlertRequest {
  final String title;
  final String description;
  final String buttonTitle;
  AlertRequest({
    @required this.title,
    @required this.description,
    @required this.buttonTitle,
  });
}

class AlertResponse {
  final String fieldOne;
  final String fieldTwo;
  final bool confirmed;
  AlertResponse({
    this.fieldOne,
    this.fieldTwo,
    this.confirmed,
  });
}