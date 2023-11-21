import 'dart:convert';
import 'dart:io';

import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:adguard_home_manager/models/github_release.dart';
import 'package:adguard_home_manager/constants/urls.dart';
import 'package:adguard_home_manager/services/api_client.dart';

class ExternalRequests {
  static Future<ApiResponse> getUpdateChangelog({
    required String releaseTag
  }) async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse("${Urls.adGuardHomeReleasesTags}/$releaseTag"));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      if (response.statusCode == 200) {
        return ApiResponse(
          successful: true,
          content: jsonDecode(reply)['body'],
          statusCode: response.statusCode
        );
      }
      else {
        return const ApiResponse(successful: false);
      }    
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return const ApiResponse(successful: false);
    } 
  }

  static Future<ApiResponse> getReleasesGitHub() async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(Urls.getReleasesGitHub));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      if (response.statusCode == 200) {
        return ApiResponse(
          successful: true,
          content:  List<GitHubRelease>.from(jsonDecode(reply).map((entry) => GitHubRelease.fromJson(entry)))
        );
      }
      else {
        return const ApiResponse(successful: false);
      }    
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return const ApiResponse(successful: false);
    } 
  }

  static Future<ApiResponse> getLatestReleaseGitHub() async {
    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(Urls.getLatestReleaseGitHub));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      if (response.statusCode == 200) {
        return ApiResponse(
          successful: true,
          content: GitHubRelease.fromJson(jsonDecode(reply)),
          statusCode: response.statusCode
        );
      }
      else {
        return const ApiResponse(successful: false);
      }    
    } catch (e, stackTrace) {
      Sentry.captureException(e, stackTrace: stackTrace);
      return const ApiResponse(successful: false);
    } 
  }
}