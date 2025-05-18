enum DateType {
  dDay('디데이', '지정한 날짜를 D+0으로 계산합니다.'),
  anniversary('기념일', '지정한 날짜를 D+1으로 계산합니다.');

  final String name;
  final String description;

  const DateType(this.name, this.description);
}

enum CalculationType {
  byDate('날짜로 계산'),
  byCount('일수로 계산');

  final String name;

  const CalculationType(this.name);
}
