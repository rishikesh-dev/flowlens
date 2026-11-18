import 'package:flowlens_core/flowlens_core.dart';
import 'package:test/test.dart';

void main() {
  final start = DateTime(2026, 1, 1, 10, 0, 0);
  final end = DateTime(2026, 1, 1, 10, 0, 2);
  final expectedTime = end.difference(start);
  test('calculate duration for a completed span', () {
    final span = Span(
      spanId: 'span-1',
      traceId: 'trace-1',
      name: 'HTTP Request',
      startTime: start,
      endTime: end,
      status: SpanStatus.success,
    );
    expect(span.duration, expectedTime);
  });
  test('calculate duration for a running span', () {
    final span = Span(
      spanId: 'span-2',
      traceId: 'trace-1',
      name: 'Database Query',
      startTime: start,
      status: SpanStatus.running,
    );
    expect(span.duration, greaterThanOrEqualTo(Duration.zero));
  });
  test('copyWith creates an updated span without modifying the original', () {
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
    expect(original.duration, greaterThanOrEqualTo(Duration.zero));
  });
}
