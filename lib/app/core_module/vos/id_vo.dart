import 'package:agil_coletas/app/core_module/vos/value_object.dart';
import 'package:result_dart/result_dart.dart';

class IdVO extends ValueObject<String> {
  const IdVO(super.value);

  @override
  Result<IdVO, String> validate([Object? object]) {
    if (value.isEmpty) {
      return '$runtimeType cannot be empty'.toFailure();
    }
    return Success(this);
  }
}
