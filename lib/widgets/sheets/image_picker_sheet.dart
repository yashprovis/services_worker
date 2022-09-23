import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../helpers/methods.dart';

import '../../providers/worker_provider.dart';

import '../../services/worker_service.dart';

import '../sw_text.dart';

Future imagePickerSheet(BuildContext context) async {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        WorkerProvider workerProvider = Provider.of<WorkerProvider>(context);
        return StatefulBuilder(builder: (context, ss) {
          return Container(
              padding: const EdgeInsets.all(16),
              height: 180,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SwText(
                        "Profile Picture",
                        size: 18,
                        weight: FontWeight.w500,
                      ),
                      GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () async {
                                XFile file = await getImageFromCamera();
                                File imageFile = File(file.path);
                                WorkerService()
                                    .updateWorkerProfilePicture(
                                        context: context,
                                        workerId: workerProvider.getWorker.id,
                                        image: imageFile)
                                    .whenComplete(() {
                                  workerProvider
                                      .updateWorker(
                                          name: null,
                                          phone: null,
                                          gender: null,
                                          image:
                                              "$uploadUrl/workers/worker--${workerProvider.getWorker.id}",
                                          context: context)
                                      .whenComplete(
                                          () => Navigator.of(context).pop());
                                });
                              },
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  width: 60,
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Icon(CupertinoIcons.camera))),
                          const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: SwText(
                                "Camera",
                                size: 14,
                              ))
                        ],
                      ),
                      const SizedBox(width: 30),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              XFile file = await getImageFromGallery();
                              File imageFile = File(file.path);
                              WorkerService()
                                  .updateWorkerProfilePicture(
                                      context: context,
                                      workerId: workerProvider.getWorker.id,
                                      image: imageFile)
                                  .whenComplete(() {
                                workerProvider
                                    .updateWorker(
                                        name: null,
                                        phone: null,
                                        gender: null,
                                        image:
                                            "$uploadUrl/workers/worker--${workerProvider.getWorker.id}",
                                        context: context)
                                    .whenComplete(
                                        () => Navigator.of(context).pop());
                              });
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.only(top: 8, bottom: 8),
                                width: 60,
                                height: 60,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                    CupertinoIcons.photo_on_rectangle)),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: SwText(
                                "Gallery",
                                size: 14,
                              ))
                        ],
                      ),
                      const SizedBox(width: 30),
                      workerProvider.getWorker.image == ""
                          ? const SizedBox()
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    WorkerService()
                                        .updateWorkerProfile(
                                            context: context, image: "")
                                        .whenComplete(() {
                                      workerProvider
                                          .refreshWorker()
                                          .whenComplete(() =>
                                              Navigator.of(context).pop());
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      width: 60,
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                        color: Colors.white,
                                      )),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: SwText(
                                      "Remove",
                                      size: 14,
                                    ))
                              ],
                            ),
                    ],
                  ),
                ],
              ));
        });
      });
}
