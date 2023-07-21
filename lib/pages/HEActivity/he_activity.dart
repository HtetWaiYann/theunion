import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:theunion/components/empty.dart';
import 'package:theunion/components/loading.dart';
import 'package:theunion/models/activity.dart';
import 'package:theunion/network/api.dart';
import 'package:theunion/pages/HEActivity/components/activity_card.dart';
import 'package:theunion/pages/HEActivity/new_he_activity.dart';
import 'package:theunion/resources/colors.dart';
import 'package:theunion/resources/dimens.dart';
import 'package:theunion/services/common.dart';

class HEActivity extends StatefulWidget {
  const HEActivity({Key? key}) : super(key: key);

  @override
  State<HEActivity> createState() => _HEActivityState();
}

class _HEActivityState extends State<HEActivity> {
  RefreshController _refreshController = RefreshController();
  List<Activity> activityList = [];
  List<Activity> filteredActivityList = [];

  bool isLoading = false;
  bool isRefreshing = false;

  String searchText = '';

  _getActivityList() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        activityList = await API().getActivityList();
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

  Future _navigateToPage(Widget page) async {
    Activity? result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
    if (result != null) {
      setState(() {
        activityList.insert(0, result);
        onSearch(searchText);
      });
    }
  }

  Future<void> _onRefresh() async {
    if (!isRefreshing) {
      setState(() {
        isRefreshing = true;
      });
      try {
        activityList = await API().getActivityList();
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

  onSearch(String searchText) {
    setState(() {
      searchText = searchText.toLowerCase();
      filteredActivityList = activityList
          .where(
            (element) => element.date.toLowerCase().contains(
                  searchText,
                ),
          )
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
    _getActivityList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text('HE Activity'),
        onSearch: (value) => onSearch(value),
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
                : filteredActivityList.isEmpty
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
                            shrinkWrap: true,
                            itemCount: filteredActivityList.length,
                            itemBuilder: (context, index) {
                              return ActivityCard(
                                activity: filteredActivityList[index],
                                onTap: () => _navigateToPage(
                                  NewHEActivity(
                                    isDetailView: true,
                                    activity: filteredActivityList[index],
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
          _navigateToPage(const NewHEActivity(
            isDetailView: false,
          ))
        },
        label: const Text('+ Add New'),
      ),
    );
  }
}
