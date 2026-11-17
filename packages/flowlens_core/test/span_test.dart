import 'package:flowlens_core/flowlens_core.dart';
import 'package:test/test.dart';

void main() {
  test('calculate duration for a completed span', () {
    final start = DateTime(2026, 1, 1, 10, 0);
    final end = DateTime(2026, 1, 1, 10, 0, 2);

    final span = Span(
      spanId: 'span-1',
      traceId: 'trace-1',
      name: 'HTTP Request',
      startTime: start,
      endTime: end,
      status: SpanStatus.success,
    );
    expect(span.duration.inMilliseconds, 2000);
  });
  test('calculate duration for a running span', () {
    final start = DateTime.now().subtract(Duration(seconds: 2));
    final span = Span(
      spanId: 'span-2',
      traceId: 'trace-1',
      name: 'Database Query',
      startTime: start,
      status: SpanStatus.running,
    );
    expect(span.duration.inMilliseconds, 2000);
  });
  test('copyWith creates an updated span without modifying the original', () {
    final start = DateTime.now().subtract(Duration(seconds: 2));
    final original = Span(
      spanId: 'span-2',
      traceId: 'trace-1',
      name: 'Database Query',
      startTime: start,
      status: SpanStatus.running,
    );
    final updated = original.copyWith(status: SpanStatus.success);
    expect(original.status, SpanStatus.running);
    expect(updated.status, SpanStatus.success);
    expect(updated.spanId, original.spanId);
    expect(updated.traceId, original.traceId);
    expect(original.duration.inMilliseconds, 2000);
  });
}
