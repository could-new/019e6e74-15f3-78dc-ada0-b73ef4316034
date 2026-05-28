import 'package:flutter/material.dart';
import 'models.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  const EmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final employee = ModalRoute.of(context)!.settings.arguments as Employee;

    return Scaffold(
      appBar: AppBar(
        title: Text(employee.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('معلومات الموظف', style: Theme.of(context).textTheme.titleLarge),
                    const Divider(),
                    _buildInfoRow('الاسم', employee.name),
                    _buildInfoRow('الوظيفة', employee.position),
                    _buildInfoRow('الرصيد المرحل من العام السابق', '${employee.carriedOverLeaves} يوم'),
                    _buildInfoRow('إجمالي الرصيد السنوي (بما فيه المرحل)', '${employee.totalAnnualLeaves} يوم'),
                    _buildInfoRow('الرصيد المتبقي', '${employee.remainingAnnualLeaves} يوم'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('سجل الإجازات والمأموريات', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (employee.records.isEmpty)
              const Text('لا يوجد سجلات.')
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: employee.records.length,
                itemBuilder: (context, index) {
                  final record = employee.records[index];
                  return Card(
                    child: ListTile(
                      title: Text(_getRecordTypeName(record.type)),
                      subtitle: Text('من: ${_formatDate(record.startDate)} إلى: ${_formatDate(record.endDate)}\nالمدة: ${record.durationDays} يوم'),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  String _getRecordTypeName(RecordType type) {
    switch (type) {
      case RecordType.annualLeave:
        return 'إجازة اعتيادية';
      case RecordType.sickLeave:
        return 'إجازة مرضية';
      case RecordType.mission:
        return 'مأمورية';
      default:
        return 'غير معروف';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
