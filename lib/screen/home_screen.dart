import 'package:clone_netflix/model/model_movie.dart';
import 'package:clone_netflix/widget/box_slider.dart';
import 'package:clone_netflix/widget/carousel_slider.dart';
import 'package:clone_netflix/widget/circle_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// 영화의 정보는 백엔드에서 가져와야 하기에 StatefulWidget을 사용
class HomeScreen extends StatefulWidget {
  // createState()로 상태관리
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState() {
    super.initState();
    streamData = firestore.collection('movie').snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // 데이터를 다 가져오지 않았다면 로딩화면으로 보여줌
          return LinearProgressIndicator();
        } else {
          // 데이터를 가져왔다면 _buildBody를 호출하여 실제 위젯들 만듦.
          return _buildBody(context, snapshot.data!.docs);
        }
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    // 데이터를 맵으로 만들고 리스트로 바꿈
    List<Movie> movies = snapshot.map((e) => Movie.fromSnapShot(e)).toList();
    return ListView(
      children: <Widget>[
        // Stack은 자료구조 특성 그대로 순서대로 바닥에 깔리게된다.
        // CarouselImage가 제일 밑. 그다음 TopBar의 위젯이 배치된다.
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        CircleSlider(
          movies: movies,
        ),
        BoxSlider(
          movies: movies,
        ),
      ],
    );
  }

// 상단 바의 경우 스택으로 구현이 가능
  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 일정한 간격으로 띄우기
        children: <Widget>[
          Image.asset(
            // 이미지 불러오기
            'images/bbongflix_logo.png',
            fit: BoxFit.contain, // 설정한 크기 안에서 이미지 크기 조정
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1), // 특정 위젯의 상하좌우 여백을 두기 위함
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
