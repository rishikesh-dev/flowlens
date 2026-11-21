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
  test('startChildSpan generates unique spanID', () {
    final tracerSpan = tracer.startRootSpan(name: 'hey');
    final tracerChildSpan = tracer.startChildSpan(
      traceContext: TraceContext(
        traceId: tracerSpan.traceId,
        parentSpanId: tracerSpan.spanId,
      ),
      name: 'Hey 2',
    );
    final tracerGrandChildSpan = tracer.startChildSpan(
      traceContext: TraceContext(
        traceId: tracerSpan.traceId,
        parentSpanId: tracerChildSpan.spanId,
      ),
      name: 'Hey 3',
    );
    expect(tracerChildSpan.parentSpanId, tracerSpan.spanId);
    expect(tracerChildSpan.traceId, tracerSpan.traceId);
    expect(tracerChildSpan.spanId, isNot(tracerSpan.spanId));
    expect(tracerGrandChildSpan.parentSpanId, tracerChildSpan.spanId);
    expect(tracerGrandChildSpan.traceId, tracerChildSpan.traceId);
    expect(tracerGrandChildSpan.spanId, isNot(tracerChildSpan.spanId));
  });
}
