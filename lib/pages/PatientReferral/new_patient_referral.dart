import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:theunion/components/custom_button.dart';
import 'package:theunion/components/custom_date_picker.dart';
import 'package:theunion/components/custom_dropdown.dart';
import 'package:theunion/components/custom_input_field.dart';
import 'package:theunion/models/patient.dart';
import 'package:theunion/network/api.dart';
import 'package:theunion/pages/PatientReferral/components/validator.dart';
import 'package:theunion/resources/app_config.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';
import 'package:theunion/services/common.dart';

class NewPatientReferral extends StatefulWidget {
  final bool isDetailView;
  final Patient? patient;

  const NewPatientReferral({Key? key, required this.isDetailView, this.patient})
      : super(key: key);

  @override
  State<NewPatientReferral> createState() => _NewPatientReferralState();
}

class _NewPatientReferralState extends State<NewPatientReferral> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _referDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final SingleValueDropDownController _sexController =
      SingleValueDropDownController();
  final SingleValueDropDownController _townshipController =
      SingleValueDropDownController();
  final SingleValueDropDownController _referFromController =
      SingleValueDropDownController();
  final SingleValueDropDownController _referToController =
      SingleValueDropDownController();

  final List<String> sexList = ['-', 'Male', 'Female'];
  final List<String> townshipList = [
    '-',
    'AMP',
    'AMT',
    'CAT',
    'CMT',
    'PTG',
    'PGT',
    'MHA'
  ];

  final List<String> referFromList = ['-', 'Vol1', 'Vol2'];
  final List<String> referToList = ['-', 'Union', 'THD', 'Other'];

  bool isLoading = false;
  bool isDetailView = false;

  Patient patientForm = Patient(
      patientid: "",
      name: "",
      sex: "-",
      age: "",
      referDate: "",
      township: "-",
      address: "",
      referFrom: "-",
      referTo: "-",
      signAndSymptom: "Fever");

  @override
  void initState() {
    super.initState();
    isDetailView = widget.isDetailView;
    var tempPatientData = widget.patient;
    if (isDetailView) {
      patientForm = tempPatientData!;
      _nameController.text = patientForm.name;
      _ageController.text = patientForm.age;
      _referDateController.text = patientForm.referDate;
      _addressController.text = patientForm.address;
    }

    _sexController.dropDownValue =
        DropDownValueModel(name: patientForm.sex, value: patientForm.sex);
    _townshipController.dropDownValue = DropDownValueModel(
        name: patientForm.township, value: patientForm.township);
    _referFromController.dropDownValue = DropDownValueModel(
        name: patientForm.referFrom, value: patientForm.referFrom);
    _referToController.dropDownValue = DropDownValueModel(
        name: patientForm.referTo, value: patientForm.referTo);
  }

  _submitBtnClick(context) async {
    debugPrint("${patientForm.toJson()}");
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        patientForm.age = int.parse(patientForm.age).toString();
        await API().addPatientReferral(patientForm);
        showToast(SUCCESS_MESSAGE, SUCCESS_COLOR, WEB_SUCCESS_COLOR);
        Navigator.pop(context, patientForm);
      } catch (e) {
        showToast(e.toString(), ERROR_COLOR, WEB_ERROR_COLOR);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isDetailView ? patientForm.name : 'Add Patient Referral',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.9,
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: MARGIN_MEDIUM_3),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        CustomInputField(
                            hintText: 'Name',
                            disable: isDetailView,
                            onChanged: (val) {
                              setState(() {
                                patientForm.name = val;
                              });
                            },
                            validator: (val) => Validator.validateGeneralField(
                                patientForm.name),
                            controller: _nameController),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomDropdown(
                          label: 'Sex',
                          selectedValue: patientForm.sex,
                          itemsList: sexList,
                          disable: isDetailView,
                          onChange: (val) => {
                            setState(() {
                              patientForm.sex = val.value;
                            })
                          },
                          validator: (val) =>
                              Validator.validateDropdownField(patientForm.sex),
                          controller: _sexController,
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                            isNumber: true,
                            hintText: 'Age',
                            disable: isDetailView,
                            next: false,
                            onChanged: (val) {
                              setState(() {
                                patientForm.age = val;
                              });
                            },
                            validator: (val) =>
                                Validator.validateAge(patientForm.age),
                            controller: _ageController),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomDatePicker(
                            label: 'Refer Date',
                            controller: _referDateController,
                            disable: isDetailView,
                            onChange: (val) {
                              setState(() {
                                patientForm.referDate = val;
                              });
                            },
                            validator: (val) => Validator.validateGeneralField(
                                patientForm.referDate)),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomDropdown(
                          label: 'Township',
                          selectedValue: patientForm.township,
                          itemsList: townshipList,
                          disable: isDetailView,
                          onChange: (val) => {
                            setState(() {
                              patientForm.township = val.value;
                            })
                          },
                          controller: _townshipController,
                          validator: (val) => Validator.validateDropdownField(
                              patientForm.township),
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                            isTextarea: true,
                            hintText: 'Address',
                            disable: isDetailView,
                            onChanged: (val) {
                              setState(() {
                                patientForm.address = val;
                              });
                            },
                            validator: (val) =>
                                Validator.validateAddress(patientForm.address),
                            controller: _addressController),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomDropdown(
                          label: 'Refer From',
                          selectedValue: patientForm.referFrom,
                          itemsList: referFromList,
                          disable: isDetailView,
                          onChange: (val) => {
                            setState(() {
                              patientForm.referFrom = val.value;
                            })
                          },
                          controller: _referFromController,
                          validator: (val) => Validator.validateDropdownField(
                              patientForm.referFrom),
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomDropdown(
                          label: 'Refer To',
                          selectedValue: patientForm.referTo,
                          itemsList: referToList,
                          disable: isDetailView,
                          onChange: (val) => {
                            setState(() {
                              patientForm.referTo = val.value;
                            })
                          },
                          controller: _referToController,
                          validator: (val) => Validator.validateDropdownField(
                              patientForm.referTo),
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        AbsorbPointer(
                          absorbing: isDetailView,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
                                child: const Text(
                                  'Sign And Symptom',
                                  style: TextStyle(color: INPUT_COLOR),
                                ),
                              ),
                              RadioListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  title: const Text(
                                    'Fever',
                                    style: TextStyle(color: INPUT_COLOR),
                                  ),
                                  fillColor:
                                      MaterialStateProperty.resolveWith<
                                          Color>((Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.white.withOpacity(.32);
                                    }
                                    return PRIMARY_COLOR;
                                  }),
                                  value: 'Fever',
                                  groupValue: patientForm.signAndSymptom,
                                  onChanged: (value) => {
                                        setState(() {
                                          patientForm.signAndSymptom = value!;
                                        })
                                      }),
                              RadioListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  title: const Text(
                                    'Weight loss',
                                    style: TextStyle(color: INPUT_COLOR),
                                  ),
                                  fillColor:
                                      MaterialStateProperty.resolveWith<
                                          Color>((Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.white.withOpacity(.32);
                                    }
                                    return PRIMARY_COLOR;
                                  }),
                                  value: 'Weight Loss',
                                  groupValue: patientForm.signAndSymptom,
                                  onChanged: (value) => {
                                        setState(() {
                                          patientForm.signAndSymptom = value!;
                                        })
                                      }),
                              RadioListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  title: const Text(
                                    'Cough more than two weeks',
                                    style: TextStyle(color: INPUT_COLOR),
                                  ),
                                  fillColor:
                                      MaterialStateProperty.resolveWith<
                                          Color>((Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.white.withOpacity(.32);
                                    }
                                    return PRIMARY_COLOR;
                                  }),
                                  value: 'Cough more than two weeks',
                                  groupValue: patientForm.signAndSymptom,
                                  onChanged: (value) => {
                                        setState(() {
                                          patientForm.signAndSymptom = value!;
                                        })
                                      })
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        isDetailView
                            ? Container()
                            : CustomButton(
                              text: "Submit",
                              loading: isLoading,
                              press: () {
                                if (_key.currentState?.validate() == true) {
                                  _submitBtnClick(context);
                                }
                              },
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
