import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title; // 제목
  final String keyword; // 키워드
  final String poster; // 포스터의 url
  final bool like; // 찜 기능
  /*
    실제 firebase firestore에 있는 데이터 컬럼을 참조할 수 있는 링크
    CRUD기능을 아주 간단하게 처리 가능
  */
  final DocumentReference reference;

  // fromMap은 map 데이터 구조를 초기화하는 생성자 메서드
  // Dynamic 타입은 타입 체크를 하지 않고 런타임에 객체의 타입을 결정
  // 타입 안정성을 보장하지 않지만, 동적으로 객체의 타입을 변경하는 경우에 유용
  Movie.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  // 작성 중 자동완성이 안되나 전부 작성하면 컴파일에러가 사라짐..
  Movie.fromSnapShot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  @override
  String toString() => "Movie<$title:$keyword>";
}
