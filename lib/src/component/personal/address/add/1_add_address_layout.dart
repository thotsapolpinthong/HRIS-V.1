import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/personal/address/add/2_add_permanent_address.dart';
import 'package:hris_app_prototype/src/component/personal/address/add/3_form_create_address.dart';

class AddAddressbyperson extends StatefulWidget {
  final String personId;
  const AddAddressbyperson({super.key, required this.personId});

  @override
  State<AddAddressbyperson> createState() => _AddAddressbypersonState();
}

class _AddAddressbypersonState extends State<AddAddressbyperson> {
  bool _isPermanentAddressExpanded = true;
  bool _isIdAddressExpanded = false;
  bool _isPresentAddressExpanded = false;
  String addresstypeId = "1";
  String addresstypePresent = "3";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: Card(
            color: Colors.greenAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 4,
            child: ListTile(
              onTap: () {
                setState(() {
                  _isPermanentAddressExpanded = !_isPermanentAddressExpanded;
                });
              },
              leading: const Icon(Icons.home_rounded),
              title: const Text(
                  'ข้อมูลที่อยู่ตามทะเบียนบ้าน (Permanent Address TH/ENG)'),
              trailing: ExpandIcon(
                isExpanded: _isPermanentAddressExpanded,
                expandedColor: Colors.black,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isPermanentAddressExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isPermanentAddressExpanded)
          AddPermanentAddress(
            personId: widget.personId.toString(),
          ).animate().fade(duration: 300.ms),
        Container(
          height: 55,
          child: Card(
            color: Colors.greenAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 4,
            child: ListTile(
              onTap: () {
                setState(() {
                  _isIdAddressExpanded = !_isIdAddressExpanded;
                });
              },
              leading: const Icon(Icons.home_rounded),
              title: const Text(
                  'ข้อมูลที่อยู่ตามบัตรประชาชน (Address according ID card TH/ENG)'),
              trailing: ExpandIcon(
                isExpanded: _isIdAddressExpanded,
                expandedColor: Colors.black,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isIdAddressExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isIdAddressExpanded)
          AddAddressByType(
            personId: widget.personId.toString(),
            addressType: addresstypeId,
          ).animate().fade(duration: 300.ms),
        SizedBox(
          height: 55,
          child: Card(
            color: Colors.greenAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 4,
            child: ListTile(
              onTap: () {
                setState(() {
                  _isPresentAddressExpanded = !_isPresentAddressExpanded;
                });
              },
              leading: const Icon(Icons.home_rounded),
              title:
                  const Text('ข้อมูลที่อยู่ปัจจุบัน (Present Address TH/ENG)'),
              trailing: ExpandIcon(
                isExpanded: _isPresentAddressExpanded,
                expandedColor: Colors.black,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isPresentAddressExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isPresentAddressExpanded)
          AddAddressByType(
            personId: widget.personId.toString(),
            addressType: addresstypePresent,
          ).animate().fade(duration: 300.ms),
      ],
    );
  }
}
