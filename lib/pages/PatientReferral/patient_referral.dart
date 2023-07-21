import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theunion/components/empty.dart';
import 'package:theunion/components/loading.dart';
import 'package:theunion/models/patient.dart';
import 'package:theunion/network/api.dart';
import 'package:theunion/pages/PatientReferral/components/patient_card.dart';
import 'package:theunion/pages/PatientReferral/new_patient_referral.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';
import 'package:theunion/services/common.dart';

class PatientReferral extends StatefulWidget {
  const PatientReferral({Key? key}) : super(key: key);

  @override
  State<PatientReferral> createState() => _PatientReferralState();
}

class _PatientReferralState extends State<PatientReferral> {
  RefreshController _refreshController = RefreshController();

  List<Patient> patientReferral = [];
  List<Patient> filteredPatientReferral = [];

  bool isLoading = false;
  bool isRefreshing = false;
  String searchText = "";

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _getPatientReferrals();
  }

  Future<void> _getPatientReferrals() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        patientReferral = await API().getPatientReferrals();
        onSearch(searchText);
      } catch (e) {
        showToast(e.toString(), ERROR_COLOR, WEB_ERROR_COLOR);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _onRefresh() async {
    if (!isRefreshing) {
      setState(() {
        isRefreshing = true;
      });
      try {
        patientReferral = await API().getPatientReferrals();
        onSearch(searchText);
      } catch (e) {
        showToast(e.toString(), ERROR_COLOR, WEB_ERROR_COLOR);
      } finally {
        _refreshController.refreshCompleted();
        setState(() {
          isRefreshing = false;
        });
      }
    }
  }

  Future _navigateToPage(Widget page) async {
    Patient? result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
    if (result != null) {
      setState(() {
        patientReferral.insert(0, result);
        onSearch(searchText);
      });
    }
  }

  onSearch(String searchText) {
    setState(() {
      searchText = searchText.toLowerCase();
      filteredPatientReferral = patientReferral
          .where(
            (element) => element.name.toLowerCase().contains(
                  searchText,
                ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('Patient Referral'),
        onSearch: (value) => setState(() => onSearch(value)),
        searchBackgroundColor: PRIMARY_COLOR,
        searchTextStyle: const TextStyle(color: PRIMARY_TEXT_COLOR),
        searchCursorColor: PRIMARY_TEXT_COLOR,
        
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: isLoading
                ? const Loading()
                : filteredPatientReferral.isEmpty
                    ? const Empty()
                    : SmartRefresher(
                        controller: _refreshController,
                        enablePullDown: true,
                        enablePullUp: false,
                        onRefresh: _onRefresh,
                        header: CustomHeader(
                          builder: (context, mode) {
                            return SizedBox(
                              height: 60.0,
                              child: SizedBox(
                                  height: 20.0, width: 20.0, child: spinkit),
                            );
                          },
                        ),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(MARGIN_MEDIUM_2),
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: filteredPatientReferral.length,
                            itemBuilder: (context, index) {
                              return PatientCard(
                                patient: filteredPatientReferral[index],
                                onTap: () => _navigateToPage(
                                  NewPatientReferral(
                                    isDetailView: true,
                                    patient: filteredPatientReferral[index],
                                  ),
                                ),
                              );
                            }),
                      ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: PRIMARY_BUTTON_COLOR,
        foregroundColor: PRIMARY_TEXT_COLOR,
        onPressed: () => {
          _navigateToPage(const NewPatientReferral(
            isDetailView: false,
          ))
        },
        label: const Text('+ Add New'),
      ),
    );
  }
}
