import 'package:fluent_ui/fluent_ui.dart';

import '../h1/pages/h1_register_page.dart';
import '../ndps/pages/ndps_register_page.dart';
import '../prescriptions/pages/prescriptions_page.dart';

class CompliancePage extends StatefulWidget {
  const CompliancePage({super.key});

  @override
  State<CompliancePage> createState() => _CompliancePageState();
}

class _CompliancePageState extends State<CompliancePage> {
  final ValueNotifier<int> _activeIndex = ValueNotifier<int>(0);

  @override
  void dispose() {
    _activeIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('Compliance')),
      content: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: _activeIndex,
              builder: (context, index, _) {
                return Wrap(
                  spacing: 8,
                  children: [
                    ToggleButton(
                      checked: index == 0,
                      onChanged: (_) => _activeIndex.value = 0,
                      child: const Text('H1 Register'),
                    ),
                    ToggleButton(
                      checked: index == 1,
                      onChanged: (_) => _activeIndex.value = 1,
                      child: const Text('NDPS Registers'),
                    ),
                    ToggleButton(
                      checked: index == 2,
                      onChanged: (_) => _activeIndex.value = 2,
                      child: const Text('Prescriptions'),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ValueListenableBuilder<int>(
                valueListenable: _activeIndex,
                builder: (context, index, _) {
                  return IndexedStack(
                    index: index,
                    children: const [
                      H1RegisterPage(),
                      NdpsRegisterPage(),
                      PrescriptionsPage(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
