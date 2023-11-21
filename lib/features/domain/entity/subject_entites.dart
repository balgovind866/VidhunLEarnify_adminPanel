import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SubjectEntities extends Equatable {


  final String? subjectName;
  final String? subjectCode;
  final String? branch;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final List<bool>? daysSelected;

  SubjectEntities({
     this.subjectName,
     this.subjectCode,
     this.branch,
     this.startTime,
     this.endTime,
    this.daysSelected,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
    subjectName,
    subjectCode,
    branch,
    startTime,
    endTime,
    daysSelected,
  ];

}
