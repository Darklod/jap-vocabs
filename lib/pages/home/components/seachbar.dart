import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:jap_vocab/redux/state/app_state.dart';
import 'package:jap_vocab/redux/thunk/filter.dart';
import 'package:redux/redux.dart';

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => Size.fromHeight(48.0 + 12.0);
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller;
  FocusNode _focus;

  @override
  void initState() {
    _controller = TextEditingController();
    _focus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  // get _color => _focus.hasFocus ? Colors.white70 : Colors.black54;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final vm = _ViewModel.create(store);

    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            onChanged: (String value) async => await vm.setSearch(value),
            controller: _controller,
            focusNode: _focus,
            textInputAction: TextInputAction.search,
            autofocus: false,
            style: TextStyle(
                color: Colors.white, textBaseline: TextBaseline.ideographic),
            cursorRadius: const Radius.circular(8.0),
            decoration: InputDecoration(
              isCollapsed: true,
              filled: true,
              fillColor: Colors.black.withOpacity(0.1),
              prefixIcon: Icon(Icons.search, color: Colors.white70),
              prefixIconConstraints: BoxConstraints.tight(Size(48.0, 40.0)),
              hintText: '探索',
              hintStyle: TextStyle(
                  color: Colors.white70,
                  textBaseline: TextBaseline.ideographic),
              contentPadding: const EdgeInsets.all(8.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close_rounded, color: Colors.white70),
            onPressed: () async {
              _focus.unfocus();
              _controller.clear();
              await vm.resetSearch();
            },
          )
        ],
      ),
    );
  }
}

class _ViewModel {
  final Function(String) setSearch;
  final Function resetSearch;

  _ViewModel({this.setSearch, this.resetSearch});

  factory _ViewModel.create(Store<AppState> store) {
    void _setSearch(String value) {
      store.dispatch(changeSearch(value));
    }

    void _resetSearch() {
      _setSearch('');
    }

    return _ViewModel(
      setSearch: _setSearch,
      resetSearch: _resetSearch,
    );
  }
}
