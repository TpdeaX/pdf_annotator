// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroke.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStrokeCollection on Isar {
  IsarCollection<Stroke> get strokes => this.collection();
}

const StrokeSchema = CollectionSchema(
  name: r'Stroke',
  id: -1792224709188651575,
  properties: {
    r'colorValue': PropertySchema(
      id: 0,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'documentDriveId': PropertySchema(
      id: 1,
      name: r'documentDriveId',
      type: IsarType.string,
    ),
    r'pointsX': PropertySchema(
      id: 2,
      name: r'pointsX',
      type: IsarType.doubleList,
    ),
    r'pointsY': PropertySchema(
      id: 3,
      name: r'pointsY',
      type: IsarType.doubleList,
    ),
    r'strokeWidth': PropertySchema(
      id: 4,
      name: r'strokeWidth',
      type: IsarType.double,
    ),
    r'timestamp': PropertySchema(
      id: 5,
      name: r'timestamp',
      type: IsarType.long,
    )
  },
  estimateSize: _strokeEstimateSize,
  serialize: _strokeSerialize,
  deserialize: _strokeDeserialize,
  deserializeProp: _strokeDeserializeProp,
  idName: r'id',
  indexes: {
    r'documentDriveId': IndexSchema(
      id: -1966325113181795335,
      name: r'documentDriveId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'documentDriveId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _strokeGetId,
  getLinks: _strokeGetLinks,
  attach: _strokeAttach,
  version: '3.1.0+1',
);

int _strokeEstimateSize(
  Stroke object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.documentDriveId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pointsX;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.pointsY;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _strokeSerialize(
  Stroke object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.colorValue);
  writer.writeString(offsets[1], object.documentDriveId);
  writer.writeDoubleList(offsets[2], object.pointsX);
  writer.writeDoubleList(offsets[3], object.pointsY);
  writer.writeDouble(offsets[4], object.strokeWidth);
  writer.writeLong(offsets[5], object.timestamp);
}

Stroke _strokeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Stroke();
  object.colorValue = reader.readLongOrNull(offsets[0]);
  object.documentDriveId = reader.readStringOrNull(offsets[1]);
  object.id = id;
  object.pointsX = reader.readDoubleList(offsets[2]);
  object.pointsY = reader.readDoubleList(offsets[3]);
  object.strokeWidth = reader.readDoubleOrNull(offsets[4]);
  object.timestamp = reader.readLongOrNull(offsets[5]);
  return object;
}

P _strokeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDoubleList(offset)) as P;
    case 3:
      return (reader.readDoubleList(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _strokeGetId(Stroke object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _strokeGetLinks(Stroke object) {
  return [];
}

void _strokeAttach(IsarCollection<dynamic> col, Id id, Stroke object) {
  object.id = id;
}

extension StrokeQueryWhereSort on QueryBuilder<Stroke, Stroke, QWhere> {
  QueryBuilder<Stroke, Stroke, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StrokeQueryWhere on QueryBuilder<Stroke, Stroke, QWhereClause> {
  QueryBuilder<Stroke, Stroke, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Stroke, Stroke, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterWhereClause> idBetween(
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

  QueryBuilder<Stroke, Stroke, QAfterWhereClause> documentDriveIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'documentDriveId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterWhereClause> documentDriveIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'documentDriveId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterWhereClause> documentDriveIdEqualTo(
      String? documentDriveId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'documentDriveId',
        value: [documentDriveId],
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterWhereClause> documentDriveIdNotEqualTo(
      String? documentDriveId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'documentDriveId',
              lower: [],
              upper: [documentDriveId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'documentDriveId',
              lower: [documentDriveId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'documentDriveId',
              lower: [documentDriveId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'documentDriveId',
              lower: [],
              upper: [documentDriveId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension StrokeQueryFilter on QueryBuilder<Stroke, Stroke, QFilterCondition> {
  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> colorValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'colorValue',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> colorValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'colorValue',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> colorValueEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> colorValueGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> colorValueLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> colorValueBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'colorValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'documentDriveId',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition>
      documentDriveIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'documentDriveId',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentDriveId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition>
      documentDriveIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentDriveId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentDriveId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentDriveId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentDriveId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentDriveId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentDriveId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentDriveId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> documentDriveIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentDriveId',
        value: '',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition>
      documentDriveIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentDriveId',
        value: '',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pointsX',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pointsX',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pointsX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pointsX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pointsX',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pointsX',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsX',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsX',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsX',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsX',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsX',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsXLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsX',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pointsY',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pointsY',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYElementEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pointsY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYElementGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pointsY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYElementLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pointsY',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYElementBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pointsY',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsY',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsY',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsY',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsY',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsY',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> pointsYLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'pointsY',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> strokeWidthIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'strokeWidth',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> strokeWidthIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'strokeWidth',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> strokeWidthEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'strokeWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> strokeWidthGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'strokeWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> strokeWidthLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'strokeWidth',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> strokeWidthBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'strokeWidth',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> timestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> timestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> timestampEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> timestampGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> timestampLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterFilterCondition> timestampBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StrokeQueryObject on QueryBuilder<Stroke, Stroke, QFilterCondition> {}

extension StrokeQueryLinks on QueryBuilder<Stroke, Stroke, QFilterCondition> {}

extension StrokeQuerySortBy on QueryBuilder<Stroke, Stroke, QSortBy> {
  QueryBuilder<Stroke, Stroke, QAfterSortBy> sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> sortByDocumentDriveId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentDriveId', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> sortByDocumentDriveIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentDriveId', Sort.desc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> sortByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> sortByStrokeWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.desc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension StrokeQuerySortThenBy on QueryBuilder<Stroke, Stroke, QSortThenBy> {
  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByDocumentDriveId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentDriveId', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByDocumentDriveIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentDriveId', Sort.desc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByStrokeWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.desc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<Stroke, Stroke, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension StrokeQueryWhereDistinct on QueryBuilder<Stroke, Stroke, QDistinct> {
  QueryBuilder<Stroke, Stroke, QDistinct> distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorValue');
    });
  }

  QueryBuilder<Stroke, Stroke, QDistinct> distinctByDocumentDriveId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentDriveId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Stroke, Stroke, QDistinct> distinctByPointsX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pointsX');
    });
  }

  QueryBuilder<Stroke, Stroke, QDistinct> distinctByPointsY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pointsY');
    });
  }

  QueryBuilder<Stroke, Stroke, QDistinct> distinctByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strokeWidth');
    });
  }

  QueryBuilder<Stroke, Stroke, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension StrokeQueryProperty on QueryBuilder<Stroke, Stroke, QQueryProperty> {
  QueryBuilder<Stroke, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Stroke, int?, QQueryOperations> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorValue');
    });
  }

  QueryBuilder<Stroke, String?, QQueryOperations> documentDriveIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentDriveId');
    });
  }

  QueryBuilder<Stroke, List<double>?, QQueryOperations> pointsXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pointsX');
    });
  }

  QueryBuilder<Stroke, List<double>?, QQueryOperations> pointsYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pointsY');
    });
  }

  QueryBuilder<Stroke, double?, QQueryOperations> strokeWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strokeWidth');
    });
  }

  QueryBuilder<Stroke, int?, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
