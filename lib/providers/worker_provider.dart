import 'package:flutter/material.dart';

import '../models/worker_model.dart';
import '../services/worker_service.dart';

class WorkerProvider with ChangeNotifier {
  Worker? _worker;

  Worker get getWorker =>
      _worker ??
      Worker(
          id: "",
          name: "",
          image: "",
          email: "",
          phone: "",
          desc: "",
          workingCity: "",
          workingExperience: 0,
          workingSpecialisation: "",
          workingTags: [],
          hourlyRate: 0,
          gender: "",
          ratings: []);

  Future<void> refreshWorker() async {
    Worker worker = await WorkerService().getWorkerDetails();
    _worker = worker;
    notifyListeners();
  }

  Future updateWorker(
      {required String? name,
      required String? phone,
      required String? image,
      required String? gender,
      required BuildContext context}) async {
    await WorkerService().updateWorkerProfile(
        name: name,
        phone: phone,
        gender: gender,
        image: image,
        context: context);
    refreshWorker();
  }

  Future updateWorkerSettings(
      {required Map body, required BuildContext context}) async {
    await WorkerService().updateWorkerSettings(body: body, context: context);
    refreshWorker();
  }
}
