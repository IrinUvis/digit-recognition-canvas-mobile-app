import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class DrawnLine extends Equatable {
  final List<Offset> path;

  const DrawnLine({required this.path});

  @override
  List<Object?> get props => [path];
}
