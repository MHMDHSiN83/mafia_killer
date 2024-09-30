// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scenario.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetScenarioCollection on Isar {
  IsarCollection<Scenario> get scenarios => this.collection();
}

const ScenarioSchema = CollectionSchema(
  name: r'Scenario',
  id: 6313981072805766721,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'roles': PropertySchema(
      id: 1,
      name: r'roles',
      type: IsarType.objectList,
      target: r'Role',
    )
  },
  estimateSize: _scenarioEstimateSize,
  serialize: _scenarioSerialize,
  deserialize: _scenarioDeserialize,
  deserializeProp: _scenarioDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'Role': RoleSchema},
  getId: _scenarioGetId,
  getLinks: _scenarioGetLinks,
  attach: _scenarioAttach,
  version: '3.1.0+1',
);

int _scenarioEstimateSize(
  Scenario object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.roles.length * 3;
  {
    final offsets = allOffsets[Role]!;
    for (var i = 0; i < object.roles.length; i++) {
      final value = object.roles[i];
      bytesCount += RoleSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _scenarioSerialize(
  Scenario object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeObjectList<Role>(
    offsets[1],
    allOffsets,
    RoleSchema.serialize,
    object.roles,
  );
}

Scenario _scenarioDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Scenario(
    reader.readString(offsets[0]),
  );
  object.id = id;
  object.roles = reader.readObjectList<Role>(
        offsets[1],
        RoleSchema.deserialize,
        allOffsets,
        Role(),
      ) ??
      [];
  return object;
}

P _scenarioDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<Role>(
            offset,
            RoleSchema.deserialize,
            allOffsets,
            Role(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _scenarioGetId(Scenario object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _scenarioGetLinks(Scenario object) {
  return [];
}

void _scenarioAttach(IsarCollection<dynamic> col, Id id, Scenario object) {
  object.id = id;
}

extension ScenarioQueryWhereSort on QueryBuilder<Scenario, Scenario, QWhere> {
  QueryBuilder<Scenario, Scenario, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ScenarioQueryWhere on QueryBuilder<Scenario, Scenario, QWhereClause> {
  QueryBuilder<Scenario, Scenario, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Scenario, Scenario, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterWhereClause> idBetween(
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

extension ScenarioQueryFilter
    on QueryBuilder<Scenario, Scenario, QFilterCondition> {
  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> rolesLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roles',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> rolesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roles',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> rolesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roles',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> rolesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roles',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition>
      rolesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roles',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> rolesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'roles',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ScenarioQueryObject
    on QueryBuilder<Scenario, Scenario, QFilterCondition> {
  QueryBuilder<Scenario, Scenario, QAfterFilterCondition> rolesElement(
      FilterQuery<Role> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'roles');
    });
  }
}

extension ScenarioQueryLinks
    on QueryBuilder<Scenario, Scenario, QFilterCondition> {}

extension ScenarioQuerySortBy on QueryBuilder<Scenario, Scenario, QSortBy> {
  QueryBuilder<Scenario, Scenario, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ScenarioQuerySortThenBy
    on QueryBuilder<Scenario, Scenario, QSortThenBy> {
  QueryBuilder<Scenario, Scenario, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Scenario, Scenario, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ScenarioQueryWhereDistinct
    on QueryBuilder<Scenario, Scenario, QDistinct> {
  QueryBuilder<Scenario, Scenario, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ScenarioQueryProperty
    on QueryBuilder<Scenario, Scenario, QQueryProperty> {
  QueryBuilder<Scenario, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Scenario, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Scenario, List<Role>, QQueryOperations> rolesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'roles');
    });
  }
}
