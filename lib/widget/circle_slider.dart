import 'package:flutter/material.dart';
import 'package:clone_netflix/model/model_movie.dart';

// 상태변화가 없는 위젯이므로 StatelessWidget
class CircleSlider extends StatelessWidget {
  // moive에서 정보를 가져와야 하므로
  final List<Movie> movies;

  CircleSlider({required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      // Column : 수직(세로)방향 배치위젯
      child: Column(
        // 가로정렬 start는 default 값으로 왼쪽에 붙게 한다.
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('미리보기'),
          Container(
            height: 120,
            // 횡단 스크롤이 되는 ListView
            child: ListView(
              // 좌우로 스크롤이 가능
              // vertical은 위아래로 스크롤이 가능(디폴트)
              scrollDirection: Axis.horizontal,
              // makeCircleImages 함수를 만들어 사용하여 원형 이미지 위젯을 생성
              children: makeCircleImages(movies),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> makeCircleImages(List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    // InkWell : 클릭 가능하도록 만들어줌
    results.add(InkWell(onTap: () {},
    child: Container(
      padding: EdgeInsets.only(right: 10),
      // Align : 자식 위젯을 원하는 방향으로 정리하고 싶을 때 Align 위젯을 사용하여 정렬할 수 있다.
      child: Align(
        // 정렬하는 것(왼쪽끝)
        alignment: Alignment.centerLeft,
        // 원형 이미지를 만들어냄
        child: CircleAvatar(
          // poster파일명에 images/를 붙여놓으면 일일이 안적어도 됨..
          backgroundImage: AssetImage('images/' + movies[i].poster),
          radius: 48,
        ),
      ),
    ),
    ));
  }

  return results;
}