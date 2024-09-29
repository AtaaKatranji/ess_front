class CheckInOutList {
  String checkDate;
  String checkInTime;
  String checkOutTime;
  bool isChecked;
  

  CheckInOutList({
    required this.checkDate,
    required this.checkInTime,
    required this.checkOutTime,
    this.isChecked = false,
    
  });
}
