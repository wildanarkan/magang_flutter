import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_dropdown.dart';
import 'package:magang_flutter/widgets/build_pick_date.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

class AskLeavePage extends StatefulWidget {
  const AskLeavePage({super.key});

  @override
  _AskLeavePageState createState() => _AskLeavePageState();
}

class _AskLeavePageState extends State<AskLeavePage> {
  final List<String> companyItem = [
    'Cuti Tahunan',
    'Cuti Bulanan',
    'Cuti Mingguan',
    'Cuti Harian',
  ];

  late String selectedCompany;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCompany = companyItem[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BuildTestAppbar(title: 'Form Ask to Leave'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.backgroundOnProgress,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Leave Category',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColor.textBody,
                      ),
                    ),
                    BuildDropdown(
                      hint: 'Select',
                      title: '',
                      selectedItem: selectedCompany,
                      item: companyItem,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Limit:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          ' 10 days',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    const BuildTextField(
                      title: 'Reason For Leave',
                      hintText: 'Holiday',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: BuildPickDate(
                            title: 'Start Leave Date',
                            dateController: startDateController,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: BuildPickDate(
                            title: 'End Leave Date',
                            dateController: endDateController,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: BuildButton(
              context: context,
              title: 'Simpan',
              width: 320,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
