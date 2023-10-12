import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hris_app_prototype/src/component/constants.dart';
import 'package:hris_app_prototype/src/component/personal/address/add/3_form_create_address%20copy.dart';
import 'package:hris_app_prototype/src/component/personal/address/update/4_form_update_address.dart';
import 'package:hris_app_prototype/src/model/address/addressbyperson_model.dart';
import 'package:hris_app_prototype/src/model/address/delete/delete_address_model.dart';
import 'package:hris_app_prototype/src/model/address/dropdown/addresstype_model.dart';
import 'package:hris_app_prototype/src/services/api_web_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class UpdateAddressbyperson extends StatefulWidget {
  final String personId;
  const UpdateAddressbyperson({super.key, required this.personId});

  @override
  State<UpdateAddressbyperson> createState() => _UpdateAddressbypersonState();
}

class _UpdateAddressbypersonState extends State<UpdateAddressbyperson> {
  bool _isAddressExpanded = false;
  bool isloading = true;
  bool isaddloading = true;
  bool datanull = false;
  bool disable = false;
  int itemCount = 1;
  AddressbypersonModel? _personAddressData;
  AddressDatum? _data;
  String? _addresstypeId;
  String? _addresstypeName;
  TextEditingController comment = TextEditingController();

  List<AddressTypeDatum>? typeaddressList = [];
  String? typeaddressId;

  @override
  void initState() {
    fetchAddress();
    fetchAddressType();
    super.initState();
  }

  void fetchAddress() async {
    _personAddressData =
        await ApiService.getAddressByPersonById(widget.personId);
    if (_personAddressData != null) {
      setState(() {
        datanull = false;
        isloading = false;
        itemCount = _personAddressData!.addressData.length;
        if (itemCount >= 3) {
          disable = true;
        } else {
          disable = false;
        }
      });
    } else {
      setState(() {
        datanull = true;
        isloading = false;
      });
    }
  }

  fetchAddressType() async {
    AddressTypeModel? _dataTypeaddress = await ApiService.getTypeaddress();
    setState(() {
      typeaddressList = _dataTypeaddress?.addressTypeData;

      isaddloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: Card(
            color: titleUpdateColors,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 2,
            child: ListTile(
              onTap: () {
                setState(() {
                  _isAddressExpanded = !_isAddressExpanded;
                });
              },
              leading: const Icon(
                Icons.maps_home_work_outlined,
                color: Colors.black54,
              ),
              title: const Text(
                'ข้อมูลที่อยู่ ( Address TH/ENG)',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              trailing: ExpandIcon(
                isExpanded: _isAddressExpanded,
                expandedColor: Colors.black,
                onPressed: (bool isExpanded) {
                  setState(() {
                    _isAddressExpanded = !isExpanded;
                  });
                },
              ),
            ),
          ),
        ),
        if (_isAddressExpanded)
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              height: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: FutureBuilder(builder:
                        (BuildContext context, AsyncSnapshot snapshot) {
                      return isloading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: itemCount,
                              itemBuilder: (context, index) {
                                var data =
                                    _personAddressData?.addressData[index];
                                _addresstypeId =
                                    data?.addressTypeData.addressTypeId;
                                final addresstypeName =
                                    data?.addressTypeData.addressTypeName;
                                final homenumber = data?.homeNumber;
                                final moo = data?.moo;
                                final housingProject = data?.housingProject;
                                final street = data?.street;
                                final soi = data?.soi;
                                final subDistrict =
                                    data?.subDistrictData.subDistrictNameTh;
                                final district =
                                    data?.districtData.districtNameTh;
                                final province =
                                    data?.provinceData.provinceNameTh;
                                final postcode = data?.postCode;
                                final homePhoneNumber = data?.homePhoneNumber;
                                final addressid = data?.addressId;

                                return datanull == true
                                    ? const Center(
                                        child: SizedBox(
                                            height: 200,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('ไม่พบข้อมูลผู้ติดต่อ'),
                                              ],
                                            )),
                                      )
                                    : Card(
                                        elevation: 4,
                                        child: ListTile(
                                          leading: const Icon(
                                              Icons.home_work_rounded),
                                          title: Text('$addresstypeName'),
                                          subtitle: Text(
                                              'บ้านเลขที่ $homenumber ม. $moo หมู่บ้าน/อาคาร $housingProject ถ. $street ซ. $soi ต. $subDistrict อ. $district จ. $province  ไปรษณีย์ $postcode เบอร์โทร $homePhoneNumber'),
                                          trailing: SizedBox(
                                            width: 100,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      splashRadius: 30,
                                                      color: Colors.yellow[800],
                                                      onPressed: () {
                                                        setState(() {
                                                          _addresstypeName =
                                                              addresstypeName;
                                                          _data = data;
                                                          showDialogEditAddress();
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.edit)),
                                                  IconButton(
                                                      splashRadius: 30,
                                                      color: Colors.red,
                                                      onPressed: () {
                                                        showdialogDelete(
                                                            addressid);
                                                      },
                                                      icon: const Icon(Icons
                                                          .delete_rounded)),
                                                ]),
                                          ),
                                        ),
                                      );
                              },
                            );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // ElevatedButton(
                              //     onPressed: () {
                              //       setState(() {
                              //         fetchAddress();
                              //       });
                              //     },
                              //     child: Icon(Icons.refresh_rounded)),
                              // const SizedBox(width: 5),
                              ElevatedButton(
                                  onPressed: disable
                                      ? null
                                      : () {
                                          showDialogAddAddress();
                                          // if (disable != null) {
                                          //   return showDialogAddAddress();
                                          // } else {
                                          //   return;
                                          // }
                                        },
                                  child: const Icon(Icons.add, size: 20)),
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
          ).animate().fade(duration: 200.ms),
      ],
    );
  }

  void showDialogEditAddress() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('เพิ่มบุคคลที่ติดต่อได้ (Add Contact.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          fetchAddress();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                height: 330,
                width: 800,
                child: Column(
                  children: [
                    Text(
                      'แก้ไขข้อมูล : $_addresstypeName',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    UpdateAddressByType(
                        personId: widget.personId,
                        addressType: _addresstypeId.toString(),
                        data: _data!),
                  ],
                ),
              ));
        });
  }

  showdialogDelete(addressid) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              icon: IconButton(
                color: Colors.red[600],
                icon: const Icon(
                  Icons.cancel,
                ),
                onPressed: () {
                  fetchAddress();
                  fetchAddressType();
                  Navigator.pop(context);
                },
              ),
              content: SizedBox(
                width: 100,
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(child: Text('หมายเหตุ (โปรดระบุ)')),
                    Card(
                      elevation: 2,
                      child: TextFormField(
                        validator: Validatorless.required('กรอกข้อความ'),
                        controller: comment,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                delete(addressid);
                                Navigator.pop(context);
                              },
                              child: const Text("OK"))
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }

  void delete(_addressid) async {
    String employeeId = "";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    employeeId = preferences.getString("employeeId")!;
    DeleteAddressModel delAddressId = DeleteAddressModel(
      adressId: _addressid,
      comment: comment.text,
      modifiedBy: employeeId,
    );
    bool success = await ApiService.delAddressId(delAddressId);

    setState(() {
      if (success == true) {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.success,
          body: const Center(
            child: Column(
              children: [
                Text(
                  'Delete Address Success.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลที่อยู่ สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkOnPress: () {
            setState(() {
              fetchAddress();
              fetchAddressType();
            });
          },
        ).show();
      } else {
        AwesomeDialog(
          dismissOnTouchOutside: false,
          width: 500,
          context: context,
          animType: AnimType.topSlide,
          dialogType: DialogType.error,
          body: const Center(
            child: Column(
              children: [
                Text(
                  'Delete Address Fail.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                Text(
                  'ลบข้อมูลที่อยู่ ไม่สำเร็จ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            setState(() {
              fetchAddress();
            });
          },
        ).show();
      }
    });
  }

  void showDialogAddAddress() {
    fetchAddressType();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('เพิ่มข้อมูลที่อยู่ (Create Address.)'),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text(
                        'X',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          fetchAddress();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: 370,
                  child: Column(
                    children: [
                      isaddloading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : DropdownButtonFormField(
                              hint: const Text(
                                " โปรดเลือกประเภทที่อยู่*",
                                style: TextStyle(color: Colors.red),
                              ),
                              value: typeaddressId,
                              items: typeaddressList?.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e.addressTypeId.toString(),
                                  child: Text(e.addressTypeName),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  typeaddressId = newValue.toString();
                                });
                              },
                            ),
                      Expanded(
                        child: AddAddressByType(
                            personId: widget.personId,
                            addressType: typeaddressId.toString()),
                      ),
                    ],
                  ),
                );
              }));
        });
  }
}
