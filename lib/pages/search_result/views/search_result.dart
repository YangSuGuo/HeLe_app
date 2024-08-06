import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hele_app/pages/rank_list/widget/ranked_cards_list.dart';
import 'package:hele_app/pages/search_result/controllers/search_result_controllers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final SearchResultControllers _searchResultController = Get.find<SearchResultControllers>();

  // final SearchResultControllers _searchResultController = Get.put(SearchResultControllers());
  late ScrollController scrollController;
  Future? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = _searchResultController.getSearchResults();
    scrollController = _searchResultController.scrollController;
    scrollController.addListener(() async {
      // 触底加载
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        EasyThrottle.throttle('SearchResult', const Duration(seconds: 1), () {
          if (_searchResultController.offset < 50) {
            _searchResultController.next();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withOpacity(0.08),
            width: 1,
          ),
        ),
        titleSpacing: 0,
        centerTitle: false,
        title: GestureDetector(
          onTap: () => Get.back(),
          child: SizedBox(
            width: double.infinity,
            child: AutoSizeText(
              '${_searchResultController.keyword}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: _searchResults,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Obx(() => ListView.builder(
                  controller: scrollController,
                  itemCount: _searchResultController.searchResults.length,
                  itemBuilder: (BuildContext context, int index) {
                    return RankedCardsList(
                      datum: _searchResultController.searchResults[index],
                      index: index,
                      isRank: false,
                    );
                  }));
            } else {
              return Center(
                  child: LoadingAnimationWidget.stretchedDots(
                color: colorScheme.primary,
                size: 140.sp,
              ));
            }
          }),
    );
  }
}
