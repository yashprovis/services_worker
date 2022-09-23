// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:services_worker/models/worker_model.dart';
import 'package:services_worker/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../helpers/methods.dart';

class WorkerService {
  Future<Worker> getWorkerDetails() async {
    http.Response response =
        await http.get(headers: headerApiMap, Uri.parse("$baseUrl/worker"));
    return Worker.fromJson(jsonDecode(response.body)['data']);
  }

  Future loginWorker(
      {required String email,
      required String password,
      required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      FocusScope.of(context).unfocus();
      http.Response response = await http.post(
          body: jsonEncode({"email": email, "password": password}),
          headers: headerApiMap,
          Uri.parse("$baseUrl/worker/login"));
      if (response.statusCode == 200) {
        prefs
            .setString(tokenPref, jsonDecode(response.body)['data']["token"])
            .then((value) => Navigator.of(context)
                .pushNamedAndRemoveUntil(HomeScreen.routeName, (r) => true));
      }
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future registerWorker(
      {required Map<String, String> body,
      required List tags,
      required XFile image,
      required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      FocusScope.of(context).unfocus();
      var request =
          http.MultipartRequest("POST", Uri.parse("$baseUrl/worker/register"));
      print(image.path);
      var multipartFile = http.MultipartFile.fromBytes(
        'workerImage',
        await image.readAsBytes(),
        filename: "worker-${body["email"]}.${image.path.split(".").last}",
      );
      request.files.add(multipartFile);
      request.fields.addAll(body);
      print(request);
      for (var e in tags) {
        request.files
            .add(http.MultipartFile.fromString('workingTags', e.toString()));
      }
      http.Response response =
          await http.Response.fromStream(await request.send());
      print(response.body);
      if (response.statusCode == 200) {
        showSnack(
            context: context,
            message: 'Registered Successfully.',
            color: Colors.green);
        prefs
            .setString(tokenPref, jsonDecode(response.body)['data']["token"])
            .then((value) => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName));
      }
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future updateWorkerProfile(
      {String? name,
      String? phone,
      String? image,
      String? gender,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      Map body = {};
      if (name != null) {
        body["name"] = name;
      }
      if (phone != null) {
        body["phone"] = phone;
      }
      if (image != null) {
        body["image"] = image;
      }
      if (gender != null) {
        body["gender"] = gender;
      }
      await http.post(
          body: jsonEncode(body),
          headers: headerApiMap,
          Uri.parse("$baseUrl/worker/update"));

      showSnack(
          context: context,
          message: 'Profile Updated Successfully.',
          color: Colors.green);
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future updateWorkerSettings(
      {required Map body, required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      await http.post(
          body: jsonEncode(body),
          headers: headerApiMap,
          Uri.parse("$baseUrl/worker/update"));

      showSnack(
          context: context,
          message: 'Settings Updated Successfully.',
          color: Colors.green);
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future updateWorkerProfilePicture(
      {File? image,
      required String workerId,
      required BuildContext context}) async {
    try {
      FocusScope.of(context).unfocus();
      var request = http.MultipartRequest(
          "POST", Uri.parse("$baseUrl/worker/updateWorkerPicture"));
      final fileString = workerId +
          image!.path.substring(image.path.lastIndexOf(".", image.path.length));
      final httpImage = await http.MultipartFile.fromPath(
          "workerImage", image.path,
          filename: fileString);

      request.headers.addAll(headerApiMap);
      request.files.add(httpImage);
      request.send().then((response) {
        print(response.reasonPhrase);
      });
      showSnack(
          context: context,
          message: 'Profile Updated Successfully.',
          color: Colors.green);
    } catch (e) {
      showSnack(context: context, message: e.toString());
    }
  }

  Future sendForgotEmail({required String email}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode({"email": email}),
        Uri.parse("$baseUrl/worker/sendForgotEmail"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      return jsonDecode(response.body)["message"];
    }
  }

  Future forgotPassword(
      {required String email, required String newPassword}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode({"email": email, "newPassword": newPassword}),
        Uri.parse("$baseUrl/worker/forgotPassword"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      return jsonDecode(response.body)["message"];
    }
  }

  Future resetPassword(
      {required String oldPassword, required String newPassword}) async {
    http.Response response = await http.post(
        headers: headerApiMap,
        body: jsonEncode(
            {"oldPassword": oldPassword, "newPassword": newPassword}),
        Uri.parse("$baseUrl/worker/resetPassword"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      return jsonDecode(response.body)["message"];
    }
  }
}
