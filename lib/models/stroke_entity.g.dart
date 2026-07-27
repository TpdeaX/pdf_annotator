// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroke_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStrokeEntityCollection on Isar {
  IsarCollection<StrokeEntity> get strokeEntitys => this.collection();
}

const StrokeEntitySchema = CollectionSchema(
  name: r'StrokeEntity',
  id: 1652844139129545802,
  properties: {
    r'colorValue': PropertySchema(
      id: 0,
      name: r'colorValue',
      type: IsarType.long,
    ),
    r'pageNumber': PropertySchema(
      id: 1,
      name: r'pageNumber',
      type: IsarType.long,
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
    )
  },
  estimateSize: _strokeEntityEstimateSize,
  serialize: _strokeEntitySerialize,
  deserialize: _strokeEntityDeserialize,
  deserializeProp: _strokeEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _strokeEntityGetId,
  getLinks: _strokeEntityGetLinks,
  attach: _strokeEntityAttach,
  version: '3.1.0+1',
);

int _strokeEntityEstimateSize(
  StrokeEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.pointsX.length * 8;
  bytesCount += 3 + object.pointsY.length * 8;
  return bytesCount;
}

void _strokeEntitySerialize(
  StrokeEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.colorValue);
  writer.writeLong(offsets[1], object.pageNumber);
  writer.writeDoubleList(offsets[2], object.pointsX);
  writer.writeDoubleList(offsets[3], object.pointsY);
  writer.writeDouble(offsets[4], object.strokeWidth);
}

StrokeEntity _strokeEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StrokeEntity();
  object.colorValue = reader.readLong(offsets[0]);
  object.id = id;
  object.pageNumber = reader.readLong(offsets[1]);
  object.pointsX = reader.readDoubleList(offsets[2]) ?? [];
  object.pointsY = reader.readDoubleList(offsets[3]) ?? [];
  object.strokeWidth = reader.readDouble(offsets[4]);
  return object;
}

P _strokeEntityDeserializeProp<P>(
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
      return (reader.readDoubleList(offset) ?? []) as P;
    case 3:
      return (reader.readDoubleList(offset) ?? []) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _strokeEntityGetId(StrokeEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _strokeEntityGetLinks(StrokeEntity object) {
  return [];
}

void _strokeEntityAttach(
    IsarCollection<dynamic> col, Id id, StrokeEntity object) {
  object.id = id;
}

extension StrokeEntityQueryWhereSort
    on QueryBuilder<StrokeEntity, StrokeEntity, QWhere> {
  QueryBuilder<StrokeEntity, StrokeEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StrokeEntityQueryWhere
    on QueryBuilder<StrokeEntity, StrokeEntity, QWhereClause> {
  QueryBuilder<StrokeEntity, StrokeEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterWhereClause> idBetween(
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

extension StrokeEntityQueryFilter
    on QueryBuilder<StrokeEntity, StrokeEntity, QFilterCondition> {
  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      colorValueEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'colorValue',
        value: value,
      ));
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      colorValueGreaterThan(
    int value, {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      colorValueLessThan(
    int value, {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      colorValueBetween(
    int lower,
    int upper, {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition> idBetween(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pageNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pageNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pageNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pageNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXElementEqualTo(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXElementGreaterThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXElementLessThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXElementBetween(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXLengthEqualTo(int length) {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXIsEmpty() {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXIsNotEmpty() {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXLengthLessThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXLengthGreaterThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsXLengthBetween(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYElementEqualTo(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYElementGreaterThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYElementLessThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYElementBetween(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYLengthEqualTo(int length) {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYIsEmpty() {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYIsNotEmpty() {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYLengthLessThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYLengthGreaterThan(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      pointsYLengthBetween(
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      strokeWidthEqualTo(
    double value, {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      strokeWidthGreaterThan(
    double value, {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      strokeWidthLessThan(
    double value, {
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

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterFilterCondition>
      strokeWidthBetween(
    double lower,
    double upper, {
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
}

extension StrokeEntityQueryObject
    on QueryBuilder<StrokeEntity, StrokeEntity, QFilterCondition> {}

extension StrokeEntityQueryLinks
    on QueryBuilder<StrokeEntity, StrokeEntity, QFilterCondition> {}

extension StrokeEntityQuerySortBy
    on QueryBuilder<StrokeEntity, StrokeEntity, QSortBy> {
  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy> sortByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy>
      sortByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy> sortByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy>
      sortByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy> sortByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.asc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy>
      sortByStrokeWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.desc);
    });
  }
}

extension StrokeEntityQuerySortThenBy
    on QueryBuilder<StrokeEntity, StrokeEntity, QSortThenBy> {
  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy> thenByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.asc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy>
      thenByColorValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'colorValue', Sort.desc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy> thenByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.asc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy>
      thenByPageNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageNumber', Sort.desc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy> thenByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.asc);
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QAfterSortBy>
      thenByStrokeWidthDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'strokeWidth', Sort.desc);
    });
  }
}

extension StrokeEntityQueryWhereDistinct
    on QueryBuilder<StrokeEntity, StrokeEntity, QDistinct> {
  QueryBuilder<StrokeEntity, StrokeEntity, QDistinct> distinctByColorValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'colorValue');
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QDistinct> distinctByPageNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageNumber');
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QDistinct> distinctByPointsX() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pointsX');
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QDistinct> distinctByPointsY() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pointsY');
    });
  }

  QueryBuilder<StrokeEntity, StrokeEntity, QDistinct> distinctByStrokeWidth() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'strokeWidth');
    });
  }
}

extension StrokeEntityQueryProperty
    on QueryBuilder<StrokeEntity, StrokeEntity, QQueryProperty> {
  QueryBuilder<StrokeEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StrokeEntity, int, QQueryOperations> colorValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'colorValue');
    });
  }

  QueryBuilder<StrokeEntity, int, QQueryOperations> pageNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageNumber');
    });
  }

  QueryBuilder<StrokeEntity, List<double>, QQueryOperations> pointsXProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pointsX');
    });
  }

  QueryBuilder<StrokeEntity, List<double>, QQueryOperations> pointsYProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pointsY');
    });
  }

  QueryBuilder<StrokeEntity, double, QQueryOperations> strokeWidthProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'strokeWidth');
    });
  }
}
