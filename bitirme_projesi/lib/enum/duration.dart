enum DurationEnum { HIGH, NORMAL, LOW }

extension DurationEnumEx on DurationEnum {
  Duration get time {
    switch (this) {
      case DurationEnum.HIGH:
        return Duration(seconds: 10);
      case DurationEnum.NORMAL:
        return Duration(seconds: 5);
      case DurationEnum.LOW:
        return Duration(seconds: 1);
      default:
        throw "Duration not found";
    }
  }
}
