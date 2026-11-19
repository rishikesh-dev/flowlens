enum SpanStatus { running, success, error }

class Span {
  final String spanId;
  final String traceId;
  final String? parentSpanId;
  final String name;
  final DateTime startTime;
  final DateTime? endTime;
  final SpanStatus status;
  final String? errorType;
  final String? errorMessage;
  final StackTrace? stackTrace;

  const Span({
    required this.spanId,
    required this.traceId,
    this.parentSpanId,
    required this.name,
    required this.startTime,
    this.endTime,
    required this.status,
    this.errorType,
    this.errorMessage,
    this.stackTrace,
  });
  Span copyWith({
    SpanStatus? status,
    DateTime? endTime,
    String? errorType,
    String? errorMessage,
    StackTrace? stackTrace,
  }) {
    return Span(
      spanId: spanId,
      traceId: traceId,
      parentSpanId: parentSpanId,
      name: name,
      startTime: startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      errorType: errorType ?? this.errorType,
      errorMessage: errorMessage ?? this.errorMessage,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  Duration get duration {
    return (endTime ?? DateTime.now()).difference(startTime);
  }
}
