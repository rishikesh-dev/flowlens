import 'package:flowlens_core/flowlens_core.dart';
import 'package:test/test.dart';

void main() {
  final tracer = Tracer();
  test('startRootSpan creates a valid root span', () {
    final tracerSpan = tracer.startRootSpan(name: 'hey');
    expect(tracerSpan.traceId.isNotEmpty, isTrue);
    expect(tracerSpan.spanId.isNotEmpty, isTrue);
    expect(tracerSpan.traceId, isNot(tracerSpan.spanId));
    expect(tracerSpan.status, SpanStatus.running);
    expect(tracerSpan.parentSpanId, isNull);
    expect(tracerSpan.endTime, isNull);
  });
  test('startRootSpan generates unique IDs for separate traces', () {
    final firstSpan = tracer.startRootSpan(name: 'Login');
    final secondSpan = tracer.startRootSpan(name: 'Logout');
    expect(firstSpan.traceId, isNot(secondSpan.traceId));
    expect(firstSpan.spanId, isNot(secondSpan.spanId));
  });
}
