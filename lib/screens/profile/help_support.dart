import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../widgets/sw_text.dart';

class HelpSupport extends StatefulWidget {
  static const routeName = "/helpSupport";
  const HelpSupport({Key? key}) : super(key: key);

  @override
  State<HelpSupport> createState() => _HelpSupportState();
}

class _HelpSupportState extends State<HelpSupport> {
  List<Map<String, dynamic>> items = List.generate(
      5,
      (index) => {
            'id': index,
            'title': 'Item $index',
            'description':
                'This is the description of the item $index. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            'isExpanded': false
          });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 56),
          child: ListView(padding: EdgeInsets.zero, children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 22),
              child: Row(
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
                    "Help and Support",
                    size: 20,
                  )
                ],
              ),
            ),
            Container(
              height: 160,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(gradient: appGradient),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: Image.asset("assets/images/logo.png"),
            ),
            ExpansionPanelList(
              elevation: 3,
              // Controlling the expansion behavior
              expansionCallback: (index, isExpanded) {
                setState(() {
                  items[index]['isExpanded'] = !isExpanded;
                });
              },
              expandedHeaderPadding: EdgeInsets.zero,
              animationDuration: const Duration(milliseconds: 600),
              children: items
                  .map(
                    (item) => ExpansionPanel(
                      canTapOnHeader: true,
                      backgroundColor: Colors.white,
                      headerBuilder: (_, isExpanded) => Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, right: 30),
                          child: SwText(
                            item['title'],
                          )),
                      body: Container(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 30, right: 30),
                        child: Text(item['description']),
                      ),
                      isExpanded: item['isExpanded'],
                    ),
                  )
                  .toList(),
            ),
          ]),
        ));
  }
}
