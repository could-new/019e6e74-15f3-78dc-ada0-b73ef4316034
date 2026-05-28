class Employee {
  final String id;
  final String name;
  final String position;
  final int totalAnnualLeave;
  final int rolledOverLeave;
  final int usedAnnualLeave;
  final int usedSickLeave;
  final int usedMissions;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.totalAnnualLeave,
    required this.rolledOverLeave,
    this.usedAnnualLeave = 0,
    this.usedSickLeave = 0,
    this.usedMissions = 0,
  });

  int get remainingAnnualLeave => (totalAnnualLeave + rolledOverLeave) - usedAnnualLeave;
}

class LeaveRecord {
  final String id;
  final String employeeId;
  final LeaveType type;
  final DateTime startDate;
  final DateTime endDate;
  final String notes;

  LeaveRecord({
    required this.id,
    required this.employeeId,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.notes = '',
  });

  int get days {
    return endDate.difference(startDate).inDays + 1;
  }
}

enum LeaveType {
  annual, // إجازة اعتيادية
  sick, // إجازة مرضية
  mission, // مأمورية
}

// Sample Data
final List<Employee> sampleEmployees = [
  Employee(
    id: '1',
    name: 'أحمد محمد',
    position: 'مهندس برمجيات',
    totalAnnualLeave: 21,
    rolledOverLeave: 5,
    usedAnnualLeave: 3,
    usedSickLeave: 2,
    usedMissions: 4,
  ),
  Employee(
    id: '2',
    name: 'سارة خالد',
    position: 'مدير مشروع',
    totalAnnualLeave: 30,
    rolledOverLeave: 10,
    usedAnnualLeave: 12,
    usedSickLeave: 0,
    usedMissions: 2,
  ),
  Employee(
    id: '3',
    name: 'محمود علي',
    position: 'مصمم واجهات',
    totalAnnualLeave: 21,
    rolledOverLeave: 0,
    usedAnnualLeave: 0,
    usedSickLeave: 5,
    usedMissions: 0,
  ),
];

final List<LeaveRecord> sampleLeaveRecords = [
  LeaveRecord(
    id: '1',
    employeeId: '1',
    type: LeaveType.annual,
    startDate: DateTime(2023, 5, 10),
    endDate: DateTime(2023, 5, 12),
    notes: 'إجازة عائلية',
  ),
  LeaveRecord(
    id: '2',
    employeeId: '1',
    type: LeaveType.sick,
    startDate: DateTime(2023, 3, 1),
    endDate: DateTime(2023, 3, 2),
    notes: 'نزلة برد',
  ),
  LeaveRecord(
    id: '3',
    employeeId: '2',
    type: LeaveType.mission,
    startDate: DateTime(2023, 6, 15),
    endDate: DateTime(2023, 6, 16),
    notes: 'اجتماع مع عميل',
  ),
];
