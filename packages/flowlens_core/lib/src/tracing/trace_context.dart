class TraceContext {
  final String traceId;
  final String parentSpanId;

  const TraceContext({required this.traceId, required this.parentSpanId});
}
