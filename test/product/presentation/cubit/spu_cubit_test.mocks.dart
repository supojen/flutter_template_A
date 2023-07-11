// Mocks generated by Mockito 5.4.2 from annotations
// in mobile/test/product/presentation/cubit/spu_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mobile/infrastructure/error/failures.dart' as _i6;
import 'package:mobile/product/domain/entities/spu.dart' as _i7;
import 'package:mobile/product/domain/handlers/get_spu.dart' as _i4;
import 'package:mobile/product/domain/repositories/spu_repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSPURepository_0 extends _i1.SmartFake implements _i2.SPURepository {
  _FakeSPURepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetSPUHandler].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSPUHandler extends _i1.Mock implements _i4.GetSPUHandler {
  MockGetSPUHandler() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SPURepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeSPURepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.SPURepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.SPU>> call(
          _i4.GetSPUCommand? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i7.SPU>>.value(
            _FakeEither_1<_i6.Failure, _i7.SPU>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.SPU>>);
}
