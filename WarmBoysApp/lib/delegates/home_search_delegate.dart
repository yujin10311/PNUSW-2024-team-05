import 'package:flutter/material.dart';

class HomeSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // 홈 페이지의 검색 결과를 보여주는 로직
    return Center(
      child: Text('홈페이지 검색 결과: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // 홈 페이지의 검색 중인 동안의 제안 사항을 보여주는 로직
    return Center(
        // child: Text('홈페이지 검색 제안: $query'),
        );
  }

  @override
  void close(BuildContext context, String result) {
    // 리소스 정리 코드
    super.close(context, result);
  }
}
