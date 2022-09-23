import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../helpers/methods.dart';
import '../../providers/worker_provider.dart';
import '../../services/worker_service.dart';
import '../../widgets/sw_button.dart';
import '../../widgets/sw_text.dart';
import '../../widgets/utils/dropdown_container.dart';

class EditWorkSettings extends StatefulWidget {
  static const routeName = "/editWorkSettings";
  const EditWorkSettings({Key? key}) : super(key: key);

  @override
  State<EditWorkSettings> createState() => _EditWorkSettingsState();
}

class _EditWorkSettingsState extends State<EditWorkSettings> {
  String? selectedSpecialization;
  String? selectedExperience;

  String? selectedCity;
  TextEditingController tagsController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  List selectedTags = [];

  final List<String> specializationList = [
    'Car Washing',
    'Cleaning',
    'Hair Styling',
    'Cooking',
    'Massage',
    'Driving'
  ];
  final List<String> tagList = [
    'Hair Stylist',
    'Hair Spa',
    'Car',
    'Train',
    "Truck"
  ];
  final List<String> experienceList = [
    "0-1 Years",
    "2-3 Years",
    "3-5 Years",
    "5+ Years"
  ];

  final List<String> cityList = [
    "Jaipur",
    "Jodhpur",
    "Mumbai",
    "Pune",
    "Delhi"
  ];

  @override
  void initState() {
    WorkerProvider workerProvider =
        Provider.of<WorkerProvider>(context, listen: false);
    selectedSpecialization = workerProvider.getWorker.workingSpecialisation;
    selectedCity = workerProvider.getWorker.workingCity;
    selectedTags = workerProvider.getWorker.workingTags;
    descController.text = workerProvider.getWorker.desc;
    rateController.text = workerProvider.getWorker.hourlyRate.toString();
    selectedExperience = experienceList.firstWhere((element) => element
        .startsWith(workerProvider.getWorker.workingExperience.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WorkerProvider workerProvider = Provider.of<WorkerProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.only(top: 56, left: 16, right: 22),
            child: ListView(padding: EdgeInsets.zero, children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 24,
                      //color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const SwText(
                    "Edit Work Settings",
                    // color: Colors.white,
                    size: 20,
                    //   weight: FontWeight.w500,
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16, left: 6, top: 36),
                //padding: const EdgeInsets.all(8.0),
                child: SwText("Hourly Rate",
                    color: primaryColor, weight: FontWeight.w500),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 6, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      //color: Colors.red,
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    controller: rateController,
                    cursorColor: primaryColor,
                    cursorWidth: 1.5,
                    cursorHeight: 16,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1,
                      letterSpacing: 1.3,
                    ),
                    decoration: InputDecoration(
                        isDense: true,
                        suffixText: "₹",
                        hintText: "Hourly Rate",
                        hintStyle: const TextStyle(
                            fontSize: 14, height: 1, color: primaryColor
                            //  fontWeight: FontWeight.w300,
                            ),
                        errorBorder: errorBorder,
                        focusedBorder: border,
                        enabledBorder: border,
                        focusedErrorBorder: errorBorder,
                        border: border),
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 10),
                child: SwText("Select City",
                    color: primaryColor, weight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      isExpanded: true,
                      customButton: DropdownContainer(
                        title: selectedCity ?? "Pick work location",
                      ),
                      items: cityList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: SwText(
                              item,
                              size: 14,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedCity = value as String;
                        setState(() {});
                      },
                      buttonHeight: 40,
                      buttonWidth: 240,
                      itemHeight: 40,
                      itemPadding: EdgeInsets.zero),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 20),
                child: SwText("Select Specialization",
                    color: primaryColor, weight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    customButton: DropdownContainer(
                      title: selectedSpecialization ?? "Choose your expertise",
                    ),
                    items: specializationList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: SwText(
                            item,
                            size: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedSpecialization = value as String;
                      setState(() {});
                    },
                    buttonHeight: 40,
                    buttonWidth: 240,
                    itemHeight: 40,
                    itemPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 20),
                child: SwText("Select Experience",
                    color: primaryColor, weight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    customButton: DropdownContainer(
                      title: selectedExperience ?? "Pick experience range",
                    ),
                    items: experienceList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: SwText(
                            item,
                            size: 14,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedExperience = value as String;
                      setState(() {});
                    },
                    buttonHeight: 40,
                    buttonWidth: 240,
                    itemHeight: 40,
                    itemPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 20),
                child: SwText("Select Tags",
                    color: primaryColor, weight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 10),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    customButton: const DropdownContainer(
                      title: "Additional qualities",
                    ),
                    items: tagList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        enabled: false,
                        child: StatefulBuilder(
                          builder: (context, menuSetState) {
                            final isSelected = selectedTags.contains(item);
                            return InkWell(
                              onTap: () {
                                isSelected
                                    ? selectedTags.remove(item)
                                    : selectedTags.add(item);

                                setState(() {});

                                menuSetState(() {});
                              },
                              child: Container(
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(children: [
                                    isSelected
                                        ? const Icon(Icons.check_box_outlined)
                                        : const Icon(
                                            Icons.check_box_outline_blank),
                                    const SizedBox(width: 16),
                                    SwText(item, size: 14)
                                  ])),
                            );
                          },
                        ),
                      );
                    }).toList(),
                    searchController: tagsController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 4, right: 8, left: 8),
                      child: TextFormField(
                        controller: tagsController,
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'Search for a tag...',
                          hintStyle: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              letterSpacing: 1.3),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value.toString().contains(searchValue));
                    },
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        tagsController.clear();
                      }
                    },
                    value: selectedTags.isEmpty ? null : selectedTags.last,
                    onChanged: (value) {},
                    buttonHeight: 40,
                    buttonWidth: 240,
                    itemHeight: 40,
                    itemPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              SizedBox(height: selectedTags.isEmpty ? 0 : 14),
              SizedBox(
                height: selectedTags.isEmpty ? 0 : 30,
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedTags.length,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Chip(
                            backgroundColor: secondaryLight.withOpacity(.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            label: SwText(selectedTags[i],
                                size: 14,
                                weight: FontWeight.w500,
                                color: primaryColor),
                            onDeleted: () {
                              setState(() {
                                selectedTags.remove(selectedTags[i]);
                              });
                            }),
                      );
                    }),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8, top: 20),
                child: SwText("Short Description",
                    color: primaryColor, weight: FontWeight.w500),
              ),
              Container(
                margin: const EdgeInsets.only(left: 6, top: 10, bottom: 30),
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: descController,
                  cursorColor: primaryColor,
                  cursorWidth: 1.5,
                  cursorHeight: 16,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 14, height: 1),
                  decoration: InputDecoration(
                      isDense: true,
                      hintText: "Tell us about yourself...",
                      hintStyle: const TextStyle(
                          fontSize: 14, height: 1, color: primaryColor),
                      errorBorder: errorBorder,
                      focusedBorder: border,
                      enabledBorder: border,
                      focusedErrorBorder: errorBorder,
                      border: border),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, bottom: 30),
                child: SwButton(
                    text: "Update Settings",
                    func: () async {
                      if (selectedExperience == null ||
                          selectedCity == null ||
                          selectedSpecialization == null ||
                          selectedTags.isEmpty ||
                          descController.text.trim().isEmpty ||
                          rateController.text.trim().isEmpty) {
                        showSnack(
                            context: context,
                            color: Colors.red,
                            message: "All inputs are required");
                      } else {
                        Map extras = {
                          "workingExperience":
                              selectedExperience!.substring(0, 1),
                          "workingCity": selectedCity.toString(),
                          "workingSpecialisation":
                              selectedSpecialization.toString(),
                          "desc": descController.text.trim(),
                          "workingTags": selectedTags,
                          "hourlyRate": rateController.text.trim(),
                        };
                        await workerProvider.updateWorkerSettings(
                            body: extras, context: context);
                      }
                    },
                    isLoading: false),
              )
            ])));
  }
}
