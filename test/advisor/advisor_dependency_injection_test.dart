import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/features/advisor_nav/data/repo/advisor_repo.dart';
import 'package:edu_advisor/features/requests/data/repo/advisor_request_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    await getIt.reset();
    setupDependencyInjection();
  });

  tearDown(() => getIt.reset());

  test('registers all advisor repositories', () {
    expect(getIt.isRegistered<AdvisorRepo>(), isTrue);
    expect(getIt.isRegistered<AdvisorRequestRepo>(), isTrue);
    expect(getIt<AdvisorRepo>(), isA<AdvisorRepo>());
    expect(getIt<AdvisorRequestRepo>(), isA<AdvisorRequestRepo>());
  });
}
