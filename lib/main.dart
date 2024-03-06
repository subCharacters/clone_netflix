import 'package:clone_netflix/screen/home_screen.dart';
import 'package:clone_netflix/widget/bottom_bar.dart';
import 'package:flutter/material.dart';

// directory에 대해서
// model 데이터 베이스 모델 관련 파일
// screen 화면별 파일
// widget 반복 되어 자주 사용될 파일
void main() => runApp(MyApp());

// MyApp을 StatelessWidget에서 StatefulWidget를 사용함으로서
// MyHomePage를 사용하지 않는 방식으로 변경.
class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

// MyApp상태 관리
class _MyAppState extends State<MyApp> {
  late TabController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'CloneFlix',
    // 테마 설정
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,

        // accentColor: 는 더 이상 사용되지 않음.
        ).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(secondary: Colors.white)
    ),
    // 홈 설정
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          // NeverScrollableScrollPhysics는 사용자가 손가락 모션을 통해서 스크롤 막기
          body: TabBarView(physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              Container(
                child: Center(
                  child: Text('search'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('save'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('more'),
                ),
              )],
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}