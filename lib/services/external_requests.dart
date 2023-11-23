import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:adguard_home_manager/models/github_release.dart';
import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/services/api_client.dart';

class ExternalRequests {
  static Future<ApiResponse> getReleasesGitHub() async {
    try {
      final response = await http.get(Uri.parse(Urls.getReleasesGitHub));
      if (response.statusCode == 200) {
        return ApiResponse(
          successful: true,
          content:  List<GitHubRelease>.from(
            jsonDecode(response.body).map((entry) => GitHubRelease.fromJson(entry))
          )
        );
      }
      else {
        return const ApiResponse(successful: false);
      }    
    } catch (e) {
      return const ApiResponse(successful: false);
    } 
  }

  static Future<ApiResponse> getReleaseData({
    // If releaseTag is null gets latest release
    String? releaseTag
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
          releaseTag != null 
            ? "${Urls.adGuardHomeReleasesTags}/$releaseTag" 
            : Urls.getLatestReleaseGitHub
        )
      );
      if (response.statusCode == 200) {
        return ApiResponse(
          successful: true,
          content: GitHubRelease.fromJson(jsonDecode(response.body)),
          statusCode: response.statusCode
        );
      }
      else {
        return const ApiResponse(successful: false);
      }    
    } catch (e) {
      return const ApiResponse(successful: false);
    } 
  }
}