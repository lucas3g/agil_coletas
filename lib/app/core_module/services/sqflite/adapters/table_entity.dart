import 'package:equatable/equatable.dart';

class TableEntity extends Equatable {
  final String name;
  final Set<TableFieldEntity> fields;

  const TableEntity({
    required this.name,
    required this.fields,
  });

  @override
  List<Object?> get props => [name];
}

class TableFieldEntity extends Equatable {
  final String name;
  final FieldType type;
  final bool pk;
  final bool nullable;

  const TableFieldEntity({
    required this.name,
    required this.type,
    this.pk = false,
    this.nullable = false,
  });

  @override
  List<Object?> get props => [name];
}

enum FieldType { integer, string, real }
