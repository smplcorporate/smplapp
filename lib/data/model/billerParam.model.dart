class ParamsState {
  final String param1;
  final String param2;
  final String param3;
  final String param4;
  final String param5;

  ParamsState({
    required this.param1,
    required this.param2,
    required this.param3,
    required this.param4,
    required this.param5,
  });

  ParamsState copyWith({
    String? param1,
    String? param2,
    String? param3,
    String? param4,
    String? param5,
  }) {
    return ParamsState(
      param1: param1 ?? this.param1,
      param2: param2 ?? this.param2,
      param3: param3 ?? this.param3,
      param4: param4 ?? this.param4,
      param5: param5 ?? this.param5,
    );
  }
}
