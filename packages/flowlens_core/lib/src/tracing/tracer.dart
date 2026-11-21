import 'package:uuid/uuid.dart';

import '../models/span.dart';
import 'trace_context.dart';

class Tracer {
  final Uuid _uuid = Uuid();
  Span startRootSpan({required String name}) {
    final traceId = _uuid.v4();
    final spanId = _uuid.v4();
    return Span(
      spanId: spanId,
      traceId: traceId,
      name: name,
      parentSpanId: null,
      startTime: DateTime.now(),
      status: SpanStatus.running,
    );
  }

  Span startChildSpan({
    required TraceContext traceContext,
    required String name,
  }) {
    final spanId = _uuid.v4();
    return Span(
      spanId: spanId,
      traceId: traceContext.traceId,
      parentSpanId: traceContext.parentSpanId,
      name: name,
      startTime: DateTime.now(),
      status: SpanStatus.running,
    );
  }
}
