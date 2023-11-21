import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:student_admin_panel/features/domain/entity/subject_entites.dart';



class SubjectModel extends SubjectEntities {
  final String? subjectName;
  final String? subjectCode;
  final String? branch;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final List<bool>? daysSelected;

  SubjectModel({
     this.subjectName,
     this.subjectCode,
     this.branch,
     this.startTime,
    this.endTime,
     this.daysSelected,
  }) : super(subjectName: subjectCode, subjectCode: subjectCode, branch: branch, startTime: startTime, endTime: endTime, daysSelected: daysSelected);

  @override
  List<Object?> get props => [
    subjectName,
    subjectCode,
    branch,
    startTime,
    endTime,
    daysSelected,
  ];

  // Convert a SubjectEntities object to a Map for Firebase
  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'subjectCode': subjectCode,
      'branch': branch,
      'startTime': '${startTime?.hour}:${startTime?.minute}',
      'endTime': '${endTime?.hour}:${endTime?.minute}',
      'daysSelected': daysSelected,
    };
  }

  // Create a SubjectEntities object from a Map received from Firebase
  factory SubjectModel.fromSnapshot(DocumentSnapshot snap) {
    var map=snap.data() as Map<String,dynamic>;
    return SubjectModel(
      subjectName: map['subjectName'] ?? '',
      subjectCode: map['subjectCode'] ?? '',
      branch: map['branch'] ?? '',
      startTime: _parseTimeOfDay(map['startTime']),
      endTime: _parseTimeOfDay(map['endTime']),
      daysSelected: List<bool>.from(map['daysSelected'] ?? []),
    );
  }

  static TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}






