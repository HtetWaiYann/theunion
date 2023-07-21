import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:theunion/components/custom_button.dart';
import 'package:theunion/components/custom_date_picker.dart';
import 'package:theunion/components/custom_dropdown.dart';
import 'package:theunion/components/custom_input_field.dart';
import 'package:theunion/models/activity.dart';
import 'package:theunion/network/api.dart';
import 'package:theunion/pages/HEActivity/components/validator.dart';
import 'package:theunion/resources/app_config.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';
import 'package:theunion/services/common.dart';

class NewHEActivity extends StatefulWidget {
  final bool isDetailView;
  final Activity? activity;

  const NewHEActivity({Key? key, required this.isDetailView, this.activity})
      : super(key: key);

  @override
  State<NewHEActivity> createState() => _NewHEActivityState();
}

class _NewHEActivityState extends State<NewHEActivity> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final SingleValueDropDownController _volunteerController = SingleValueDropDownController();
  final TextEditingController _helistController = TextEditingController();
  final TextEditingController _maleController = TextEditingController();
  final TextEditingController _femaleController = TextEditingController();
  

  final List<String> volunteerList = ['-', 'Vol1', 'Vol2'];

  bool isLoading = false;
  bool isDetailView = false;

  Activity activityForm = Activity(
      date: "",
      address: "",
      volunteer: "-",
      helist: "",
      male: "",
      female: "");

  @override
  void initState() {
    super.initState();
    isDetailView = widget.isDetailView;
    var tempActivity = widget.activity;
    if (isDetailView) {
      activityForm = tempActivity!;
      _dateController.text = activityForm.date;
      _addressController.text = activityForm.address;
      _helistController.text = activityForm.helist;
      _maleController.text = activityForm.male;
      _femaleController.text = activityForm.female;
    }
    _volunteerController.dropDownValue = DropDownValueModel(name: activityForm.volunteer, value: activityForm.volunteer);
  }

  _submitBtnClick(context) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        activityForm.male = int.parse(activityForm.male).toString();
        activityForm.female = int.parse(activityForm.female).toString();
        await API().addHEActivity(activityForm);
        showToast(SUCCESS_MESSAGE, SUCCESS_COLOR, WEB_SUCCESS_COLOR);
        Navigator.pop(context, activityForm);
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
          isDetailView ? 'HE Activity' : 'Add HE Activity',
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
                        CustomDatePicker(
                            label: 'Date',
                            controller: _dateController,
                            disable: isDetailView,
                            onChange: (val) {
                              setState(() {
                                activityForm.date = val;
                              });
                            },
                            validator: (val) =>
                                Validator.validateGeneralField(activityForm.date)),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                            isTextarea: true,
                            hintText: 'Address',
                            disable: isDetailView,
                            onChanged: (val) {
                              setState(() {
                                activityForm.address = val;
                              });
                            },
                            validator: (val) => Validator.validateAddress(activityForm.address),
                            controller: _addressController),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomDropdown(
                          label: 'Volunteer',
                          selectedValue: activityForm.volunteer,
                          itemsList: volunteerList,
                          disable: isDetailView,
                          onChange: (val) => {
                            setState(() {
                              activityForm.volunteer = val.value;
                            })
                          },
                          controller: _volunteerController,
                          validator: (val) =>
                              Validator.validateDropdownField(activityForm.volunteer),
                        ),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                            isTextarea: true,
                            hintText: 'HE Attendees List',
                            disable: isDetailView,
                            onChanged: (val) {
                              setState(() {
                                activityForm.helist = val;
                              });
                            },
                            validator: (val) =>
                                Validator.validateGeneralField(activityForm.helist),
                            controller: _helistController),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                            isNumber: true,
                            hintText: 'Male',
                            disable: isDetailView,
                            onChanged: (val) {
                              setState(() {
                                activityForm.male = val;
                              });
                            },
                            validator: (val) => Validator.validateMale(activityForm.male),
                            controller: _maleController),
                        const SizedBox(
                          height: FORM_BOX_HEIGHT,
                        ),
                        CustomInputField(
                            isNumber: true,
                            hintText: 'Female',
                            disable: isDetailView,
                            next: false,
                            onChanged: (val) {
                              setState(() {
                                activityForm.female = val;
                              });
                            },
                            validator: (val) => Validator.validateFemale(activityForm.female),
                            controller: _femaleController),
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
