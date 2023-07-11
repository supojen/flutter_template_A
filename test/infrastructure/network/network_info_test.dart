


import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/infrastructure/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {

  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockChecker;

  setUp(() {
    mockChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(checker: mockChecker);
  });

  group('isConnected', () {
    test(
      'should forward the call to Connectivity',
      () async {
        // arrange
        final tHasConnectionFuture = Future.value(true);
        when(mockChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);
        // act
        final result = await networkInfo.isConnected;
        // assert
        verify(mockChecker.hasConnection);
        expect(result, tHasConnectionFuture);
      }
    );
  });
}