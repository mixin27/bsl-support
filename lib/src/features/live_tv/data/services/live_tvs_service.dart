import 'dart:convert';

import 'package:bsl_support/src/features/live_tv/domain/live_tv_model.dart';
import 'package:flutter/services.dart';

class LiveTvsService {
  Future<List<LiveTvModel>> getAllLiveTvs() async {
    final result = await rootBundle.loadString('assets/tvs/live-tvs.json');
    final jsonData = jsonDecode(result) as List<dynamic>;
    return jsonData
        .map((e) => LiveTvModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
