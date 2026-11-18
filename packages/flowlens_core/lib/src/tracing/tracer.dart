import '../models/span.dart';

import 'package:uuid/uuid.dart';

class Tracer {
  final Uuid _uuid = Uuid();
  Span startRootSpan({required String name}) {
    final traceId = _uuid.v4();
    final spanId = _uuid.v4();
    return Span(
      spanId: spanId,
      traceId: traceId,
      name: name,
      startTime: DateTime.now(),
      status: SpanStatus.running,
    );
  }
}
