class Movie {
  final String title; // 제목
  final String keyword; // 키워드
  final String poster; // 포스터의 url
  final bool like; // 찜 기능

  // fromMap은 map 데이터 구조를 초기화하는 생성자 메서드
  // Dynamic 타입은 타입 체크를 하지 않고 런타임에 객체의 타입을 결정
  // 타입 안정성을 보장하지 않지만, 동적으로 객체의 타입을 변경하는 경우에 유용
  Movie.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        like = map['like'];

  @override
  String toString() => "Movie<$title:$keyword>";
}
