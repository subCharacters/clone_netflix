import 'package:flutter/material.dart';
import 'package:clone_netflix/model/model_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';

// 단순 이미지 슬라이드가 아니라 찜하기, 상세성보등이 있기에 StatefulWidget을 상속
class CarouselImage extends StatefulWidget {
  final List<Movie> movies;

  CarouselImage({required this.movies});

  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  // 스테이트 관리 변수들 선언
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;
  int _currentPage = 0; // 현재 위치
  late String _currentKeyword;

  @override
  void initState() {
    super.initState();
    // 상위 클래스인 StatefulWidget에서 가져온 movies를 참조할 수 있도록 세팅
    movies = widget.movies;
    images = movies.map((e) => Image.asset('./images/' + e.poster)).toList();
    keywords = movies.map((e) => e.keyword).toList();
    likes = movies.map((e) => e.like).toList();
    _currentKeyword = keywords[0];
  }
  // EdgeInsets는 padding,margin과 같이 크기 조정할때 자주 사용하는 클래스
  // EdgeInsets.only 특정영역에만 여백을 지정하고 싶을때 사용
  // EdgeInsets.fromLTRB 왼쪽,위,오른쪽,밑 순으로 지정이 가능
  // EdgeInsets.symmetric symmetric은 대칭적인 이라는 의미로 수평(horizontal), 수직(vertical)을 기준으로 여백지정이 가능
  // 수직(vertical) = 위,아래 수평(horizontal) = 왼쪽,오른쪽
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),
          // 강의와 다른 버전으로 작성법이 달라졌다.
          CarouselSlider(
              items: images,
              options: CarouselOptions(onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                  _currentKeyword = keywords[_currentPage];
                });
              })),
          // 키워드 출력.
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 3),
            child: Text(
              _currentKeyword,
              style: TextStyle(fontSize: 11),
            ),
          ),
          // 메뉴바
          Container(
              child: Row(
            // 따닥따닥 붙어있는 메뉴 목록들을 보기좋게 정렬
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    // 찜하기 true false 표시 제어
                    likes[_currentPage]
                        ? IconButton(onPressed: () {}, icon: Icon(Icons.check))
                        : IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                    Text('내가 찜한 콘텐츠', style: TextStyle(fontSize: 11))
                  ],
                ),
              ),
              // 재생 버튼
              Container(
                  padding: EdgeInsets.only(right: 10),
                  // 강의에서 FlatButton이지만 TextButton으로 대체되어 변경
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Row(
                      children: <Widget>[
                        Icon(Icons.play_arrow, color: Colors.black),
                        Padding(padding: EdgeInsets.all(3)),
                        Text('재생', style: TextStyle(color: Colors.black))
                      ],
                    ),
                  )),
              // 정보 버튼
              Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: <Widget>[
                      IconButton(onPressed: () {}, icon: Icon(Icons.info)),
                      Text(
                        '정보',
                        style: TextStyle(fontSize: 11),
                      )
                    ],
                  ))
            ],
          )),
          // makeIndicator 함수를 호출하여 그 결과를 Row 위젯의 자식(children)으로 사용하여 화면에 표시
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes, _currentPage),
            ),
          )
        ],
      ),
    );
  }
}

// 주어진 목록에 대한 페이지 인디케이터UI를 생성하는 함수, 각 항목은 현재 페이지에 따라 색이 다르게 표시
List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
              ? Color.fromRGBO(255, 255, 255, 0.9)
              : Color.fromRGBO(255, 255, 255, 0.4)),
    ));
  }
  return results;
}
