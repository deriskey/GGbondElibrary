import 'package:flutter/material.dart';
import 'reserve_successfully_page.dart';

class AvailableTimePage2 extends StatelessWidget {
  const AvailableTimePage2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Available Time'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1607569596748-4bfb2922f01a'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildTimePicker(context, 'Date', 'July 15, 2023', Icons.calendar_today),
              _buildTimePicker(context, 'Start Time', '10:00 AM', Icons.access_time),
              _buildTimePicker(context, 'End Time', '11:00 AM', Icons.access_time),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReserveSuccessfullyPage()),
                  );
                },
                child: const Text('Reserve'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context, String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white.withOpacity(0.9),
      child: ListTile(
        title: Text(label),
        subtitle: Text(value),
        trailing: Icon(icon),
        onTap: () {
          // Date/Time picker logic
        },
      ),
    );
  }
} 