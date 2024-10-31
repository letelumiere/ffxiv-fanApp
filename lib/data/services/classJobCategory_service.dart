
import 'dart:convert';

import 'package:ffxiv/data/models/classJobCategory.dart';
import 'package:ffxiv/data/services/classJobCategory_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassJobCategoryService extends ChangeNotifier {
  final ClassJobCategoryRepository _classJobCategoryRepository;
  final SharedPreferences sharedPreferences;

  ClassJobCategoryService({
    required ClassJobCategoryRepository classJobCategoryRepository,
    required this.sharedPreferences,
  }) : _classJobCategoryRepository = classJobCategoryRepository;

  Future<void> initializeFirebase() async {
      await Firebase.initializeApp();
  }

  Future<String?> getXivString(int classJobId) async {
    try {
      // Repository에서 ClassJobCategory를 가져옵니다.
      final classJobCategory = await _classJobCategoryRepository.getClassJobCategory(classJobId);
      
      // ClassJobCategory가 null이 아닌 경우, xivString을 반환합니다.
      if (classJobCategory != null) {
        final classJob = classJobCategory.xivString;
        print('xivString: $classJob');  // Debugging purpose
        return classJob;
      } else {
        print('ClassJobCategory not found for ID: $classJobId');
        return null;  // classJobCategory가 null인 경우
      }
    } catch (e) {
      // 에러 처리
      print('Error fetching xivString: $e');
      return null;
    }
  }

  Future<String?> getXivStringByKey(int classJobId) async {
    try {
      // Repository에서 xivString 값을 가져옵니다.
      return await _classJobCategoryRepository.getXivStringByKey(classJobId);
    } catch (e) {
      // 에러 처리
      print('Error fetching xivString by key: $e');
      return null;
    }
  }
}
