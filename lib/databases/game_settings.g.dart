// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGameSettingsCollection on Isar {
  IsarCollection<GameSettings> get gameSettings => this.collection();
}

const GameSettingsSchema = CollectionSchema(
  name: r'GameSettings',
  id: 8079257701246494831,
  properties: {
    r'inquiry': PropertySchema(
      id: 0,
      name: r'inquiry',
      type: IsarType.long,
    ),
    r'introTime': PropertySchema(
      id: 1,
      name: r'introTime',
      type: IsarType.long,
    ),
    r'mainSpeakTime': PropertySchema(
      id: 2,
      name: r'mainSpeakTime',
      type: IsarType.long,
    ),
    r'narrator': PropertySchema(
      id: 3,
      name: r'narrator',
      type: IsarType.string,
    ),
    r'narrators': PropertySchema(
      id: 4,
      name: r'narrators',
      type: IsarType.stringList,
    ),
    r'playMusic': PropertySchema(
      id: 5,
      name: r'playMusic',
      type: IsarType.bool,
    ),
    r'soundEffect': PropertySchema(
      id: 6,
      name: r'soundEffect',
      type: IsarType.bool,
    )
  },
  estimateSize: _gameSettingsEstimateSize,
  serialize: _gameSettingsSerialize,
  deserialize: _gameSettingsDeserialize,
  deserializeProp: _gameSettingsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'scenario': LinkSchema(
      id: 952426394030150318,
      name: r'scenario',
      target: r'Scenario',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _gameSettingsGetId,
  getLinks: _gameSettingsGetLinks,
  attach: _gameSettingsAttach,
  version: '3.1.0+1',
);

int _gameSettingsEstimateSize(
  GameSettings object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.narrator.length * 3;
  bytesCount += 3 + object.narrators.length * 3;
  {
    for (var i = 0; i < object.narrators.length; i++) {
      final value = object.narrators[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _gameSettingsSerialize(
  GameSettings object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.inquiry);
  writer.writeLong(offsets[1], object.introTime);
  writer.writeLong(offsets[2], object.mainSpeakTime);
  writer.writeString(offsets[3], object.narrator);
  writer.writeStringList(offsets[4], object.narrators);
  writer.writeBool(offsets[5], object.playMusic);
  writer.writeBool(offsets[6], object.soundEffect);
}

GameSettings _gameSettingsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GameSettings();
  object.id = id;
  object.inquiry = reader.readLong(offsets[0]);
  object.introTime = reader.readLong(offsets[1]);
  object.mainSpeakTime = reader.readLong(offsets[2]);
  object.narrator = reader.readString(offsets[3]);
  object.narrators = reader.readStringList(offsets[4]) ?? [];
  object.playMusic = reader.readBool(offsets[5]);
  object.soundEffect = reader.readBool(offsets[6]);
  return object;
}

P _gameSettingsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringList(offset) ?? []) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _gameSettingsGetId(GameSettings object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _gameSettingsGetLinks(GameSettings object) {
  return [object.scenario];
}

void _gameSettingsAttach(
    IsarCollection<dynamic> col, Id id, GameSettings object) {
  object.id = id;
  object.scenario.attach(col, col.isar.collection<Scenario>(), r'scenario', id);
}

extension GameSettingsQueryWhereSort
    on QueryBuilder<GameSettings, GameSettings, QWhere> {
  QueryBuilder<GameSettings, GameSettings, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GameSettingsQueryWhere
    on QueryBuilder<GameSettings, GameSettings, QWhereClause> {
  QueryBuilder<GameSettings, GameSettings, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension GameSettingsQueryFilter
    on QueryBuilder<GameSettings, GameSettings, QFilterCondition> {
  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      inquiryEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inquiry',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      inquiryGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inquiry',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      inquiryLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inquiry',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      inquiryBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inquiry',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      introTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'introTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      introTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'introTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      introTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'introTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      introTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'introTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      mainSpeakTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainSpeakTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      mainSpeakTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainSpeakTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      mainSpeakTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainSpeakTime',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      mainSpeakTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainSpeakTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'narrator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'narrator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'narrator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'narrator',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'narrator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'narrator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'narrator',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'narrator',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'narrator',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'narrator',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'narrators',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'narrators',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'narrators',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'narrators',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'narrators',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'narrators',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'narrators',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'narrators',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'narrators',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'narrators',
        value: '',
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'narrators',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'narrators',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'narrators',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'narrators',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'narrators',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      narratorsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'narrators',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      playMusicEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playMusic',
        value: value,
      ));
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      soundEffectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'soundEffect',
        value: value,
      ));
    });
  }
}

extension GameSettingsQueryObject
    on QueryBuilder<GameSettings, GameSettings, QFilterCondition> {}

extension GameSettingsQueryLinks
    on QueryBuilder<GameSettings, GameSettings, QFilterCondition> {
  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition> scenario(
      FilterQuery<Scenario> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'scenario');
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterFilterCondition>
      scenarioIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'scenario', 0, true, 0, true);
    });
  }
}

extension GameSettingsQuerySortBy
    on QueryBuilder<GameSettings, GameSettings, QSortBy> {
  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByInquiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inquiry', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByInquiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inquiry', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByIntroTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'introTime', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByIntroTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'introTime', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByMainSpeakTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainSpeakTime', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy>
      sortByMainSpeakTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainSpeakTime', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByNarrator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'narrator', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByNarratorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'narrator', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByPlayMusic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playMusic', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortByPlayMusicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playMusic', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> sortBySoundEffect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEffect', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy>
      sortBySoundEffectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEffect', Sort.desc);
    });
  }
}

extension GameSettingsQuerySortThenBy
    on QueryBuilder<GameSettings, GameSettings, QSortThenBy> {
  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByInquiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inquiry', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByInquiryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inquiry', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByIntroTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'introTime', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByIntroTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'introTime', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByMainSpeakTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainSpeakTime', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy>
      thenByMainSpeakTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainSpeakTime', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByNarrator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'narrator', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByNarratorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'narrator', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByPlayMusic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playMusic', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenByPlayMusicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playMusic', Sort.desc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy> thenBySoundEffect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEffect', Sort.asc);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QAfterSortBy>
      thenBySoundEffectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'soundEffect', Sort.desc);
    });
  }
}

extension GameSettingsQueryWhereDistinct
    on QueryBuilder<GameSettings, GameSettings, QDistinct> {
  QueryBuilder<GameSettings, GameSettings, QDistinct> distinctByInquiry() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inquiry');
    });
  }

  QueryBuilder<GameSettings, GameSettings, QDistinct> distinctByIntroTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'introTime');
    });
  }

  QueryBuilder<GameSettings, GameSettings, QDistinct>
      distinctByMainSpeakTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainSpeakTime');
    });
  }

  QueryBuilder<GameSettings, GameSettings, QDistinct> distinctByNarrator(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'narrator', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GameSettings, GameSettings, QDistinct> distinctByNarrators() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'narrators');
    });
  }

  QueryBuilder<GameSettings, GameSettings, QDistinct> distinctByPlayMusic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playMusic');
    });
  }

  QueryBuilder<GameSettings, GameSettings, QDistinct> distinctBySoundEffect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'soundEffect');
    });
  }
}

extension GameSettingsQueryProperty
    on QueryBuilder<GameSettings, GameSettings, QQueryProperty> {
  QueryBuilder<GameSettings, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GameSettings, int, QQueryOperations> inquiryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inquiry');
    });
  }

  QueryBuilder<GameSettings, int, QQueryOperations> introTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'introTime');
    });
  }

  QueryBuilder<GameSettings, int, QQueryOperations> mainSpeakTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainSpeakTime');
    });
  }

  QueryBuilder<GameSettings, String, QQueryOperations> narratorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'narrator');
    });
  }

  QueryBuilder<GameSettings, List<String>, QQueryOperations>
      narratorsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'narrators');
    });
  }

  QueryBuilder<GameSettings, bool, QQueryOperations> playMusicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playMusic');
    });
  }

  QueryBuilder<GameSettings, bool, QQueryOperations> soundEffectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'soundEffect');
    });
  }
}
