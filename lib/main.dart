import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'terminal_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _status = 'Ready';

  Future<void> _updateWidget() async {
    setState(() => _status = 'Updating Android widget...');
    try {
      await HomeWidget.updateWidget(
        name: 'GeminiTerminalWidget',
        androidName: 'GeminiTerminalWidget',
        iOSName: 'GeminiTerminalWidget',
      );
      debugPrint('Widget update triggered');

      setState(() => _status = 'Native widget refreshed!');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Native widget refreshed!')),
        );
      }
    } catch (e) {
      debugPrint('Error updating widget: $e');
      setState(() => _status = 'Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateWidget,
        child: const Icon(Icons.refresh),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TerminalWidget(),
              const SizedBox(height: 16),
              Text(
                _status,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
