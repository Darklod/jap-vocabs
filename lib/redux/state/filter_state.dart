import 'package:flutter/foundation.dart';

@immutable
class FilterState {
  final String type;
  final String search;

  final List<int> jlpt;
  final List<String> level;
  final List<String> partOfSpeech;

  const FilterState({
    @required this.type,
    this.search,
    this.jlpt,
    this.level,
    this.partOfSpeech,
  });

  FilterState.initial()
      : type = 'word',
        search = null,
        jlpt = null,
        level = null,
        partOfSpeech = null;

  FilterState copyWith({
    String type,
    String search,
    List<int> jlpt,
    List<String> level,
    List<String> partOfSpeech,
  }) {
    return FilterState(
      type: type ?? this.type,
      search: search ?? this.search,
      jlpt: jlpt ?? this.jlpt,
      level: level ?? this.level,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterState &&
          type == other.type &&
          search == other.search &&
          jlpt == other.jlpt &&
          level == other.level &&
          partOfSpeech == other.partOfSpeech;

  @override
  int get hashCode =>
      type.hashCode ^
      search.hashCode ^
      jlpt.hashCode ^
      level.hashCode ^
      partOfSpeech.hashCode;
}
