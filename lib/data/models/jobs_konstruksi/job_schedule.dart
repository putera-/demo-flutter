class JobSchedule {
  final String start;
  final String end;

  JobSchedule({
    required this.start,
    required this.end,
  });

  factory JobSchedule.fromJson(Map<String, dynamic> json) {
    return JobSchedule(
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}
