import 'package:hele_app/db/database/entity/subjects_star.dart';

class TrackingTypeList {
  late List<SubjectsStar> wantToRead;
  late List<SubjectsStar> currentlyReading;
  late List<SubjectsStar> read;
  late List<SubjectsStar> onHold;
  late List<SubjectsStar> dropped;

  TrackingTypeList(this.wantToRead, this.currentlyReading, this.read, this.onHold, this.dropped);
}
