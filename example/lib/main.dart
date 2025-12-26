import 'package:flutter/material.dart';
import 'package:super_home_widget/super_home_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Super Home Widget
  await SuperHomeWidget().initialize(
    appGroupId: 'group.com.example.superhomewidget',
    configPath: 'assets/config/widget_config.json',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Home Widget Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SuperHomeWidget _widget = SuperHomeWidget();

  final TextEditingController _titleController = TextEditingController(
    text: 'Hello Widget',
  );
  final TextEditingController _subtitleController = TextEditingController(
    text: 'Welcome to Super Home Widget',
  );
  final TextEditingController _bodyController = TextEditingController(
    text:
        'This is an example widget content. Update the fields below to see changes in the widget.',
  );
  final TextEditingController _iconController = TextEditingController(
    text: 'star.fill',
  );

  WidgetSize _selectedSize = WidgetSize.small;
  bool _isUpdating = false;

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _bodyController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  Future<void> _updateWidget() async {
    setState(() {
      _isUpdating = true;
    });

    try {
      final widgetData = WidgetData(
        title: _titleController.text.isEmpty ? null : _titleController.text,
        subtitle: _subtitleController.text.isEmpty
            ? null
            : _subtitleController.text,
        body: _bodyController.text.isEmpty ? null : _bodyController.text,
        iconName: _iconController.text.isEmpty ? null : _iconController.text,
        timestamp: DateTime.now(),
      );

      await _widget.updateWidgetData(
        data: widgetData,
        widgetSize: _selectedSize,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Widget updated successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating widget: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  Future<void> _refreshAllWidgets() async {
    setState(() {
      _isUpdating = true;
    });

    try {
      await _widget.refreshAllWidgets();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All widgets refreshed!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error refreshing widgets: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Home Widget Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Widget Size Selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Widget Size',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<WidgetSize>(
                      segments: const [
                        ButtonSegment<WidgetSize>(
                          value: WidgetSize.small,
                          label: Text('Small'),
                        ),
                        ButtonSegment<WidgetSize>(
                          value: WidgetSize.medium,
                          label: Text('Medium'),
                        ),
                        ButtonSegment<WidgetSize>(
                          value: WidgetSize.large,
                          label: Text('Large'),
                        ),
                      ],
                      selected: {_selectedSize},
                      onSelectionChanged: (Set<WidgetSize> newSelection) {
                        setState(() {
                          _selectedSize = newSelection.first;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title Input
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter widget title',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Subtitle Input
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Subtitle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _subtitleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter widget subtitle',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Body Input
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Body',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _bodyController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Enter widget body text',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Icon Name Input
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Icon Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _iconController,
                      decoration: const InputDecoration(
                        hintText: 'Enter SF Symbol name (e.g., star.fill)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            ElevatedButton.icon(
              onPressed: _isUpdating ? null : _updateWidget,
              icon: _isUpdating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.update),
              label: Text(_isUpdating ? 'Updating...' : 'Update Widget'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _isUpdating ? null : _refreshAllWidgets,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh All Widgets'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 24),

            // Info Card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'How to Use',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '1. Fill in the widget data fields above\n'
                      '2. Select the widget size you want to update\n'
                      '3. Tap "Update Widget" to send data to the widget\n'
                      '4. Go to your iOS home screen and add the widget\n'
                      '5. The widget will display the updated content',
                      style: TextStyle(color: Colors.blue.shade900),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
