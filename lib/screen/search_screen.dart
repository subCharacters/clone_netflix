import 'package:clone_netflix/model/model_movie.dart';
import 'package:clone_netflix/screen/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // 검색 위젯을 컨트롤하는 위젯
  final TextEditingController _filter = TextEditingController();

  // 현재 검색 위젯에 커서가 있는지에 대한 상태를 가지는 위젯
  FocusNode focusNode = FocusNode();

  // 현재 검색 값
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(30)),
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 6,
                    child: TextField(
                      focusNode: focusNode,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      autofocus: true,
                      controller: _filter,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white60,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white60,
                            size: 20,
                          ),
                          suffixIcon: focusNode.hasFocus
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _filter.clear();
                                      _searchText = "";
                                    });
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    size: 20,
                                  ))
                              : Container(),
                          hintText: '검색',
                          hintStyle: TextStyle(color: Colors.white60),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    )),
                focusNode.hasFocus
                    ? Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _filter.clear();
                              _searchText = "";
                              focusNode.unfocus();
                            });
                          },
                          child: Text('취소'),
                        ),
                      )
                    : Expanded(flex: 0, child: Container())
              ],
            ),
          ),
          _buildBody(context)
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot d in snapshot) {
      if (d.data().toString().contains(_searchText)) {
        searchResults.add(d);
      }
    }
    return Expanded(
        child: GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1 / 1.5,
      padding: EdgeInsets.all(3),
      children: searchResults.map((e) => _buildListItem(context, e)).toList(),
    ));
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final movie = Movie.fromSnapShot(data);
    /** InkWell 위젯
     * Container와 같이 제스쳐기능을 제공하지 않는 위젯을 래핑하여 onTap 기능 제공
     * InkWell 위젯을 탭하면 물결모양의 애니메이션 효과가 발생함
     * InkWell의 onTap() 제스쳐 기능을 이용하여 컨테이너가 버튼처럼 눌려지는 기능을 부여할 수 있게 된다.
     */
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            }));
      },
    );
  }
}
