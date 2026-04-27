import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/contacts_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _gstinController = TextEditingController();
  final _bankController = TextEditingController();
  final _doctorRegController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _gstinController.dispose();
    _bankController.dispose();
    _doctorRegController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactsBloc()..add(const ContactsStarted()),
      child: ScaffoldPage(
        header: const PageHeader(title: Text('Contacts')),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<ContactsBloc, ContactsState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InfoBar(
                        title: const Text('Contact error'),
                        content: Text(state.error!),
                        severity: InfoBarSeverity.error,
                      ),
                    ),
                  if (state.message != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InfoBar(
                        title: const Text('Success'),
                        content: Text(state.message!),
                        severity: InfoBarSeverity.success,
                      ),
                    ),
                  _ContactsTabs(
                    activeType: state.activeType,
                    onChanged: (type) => context.read<ContactsBloc>().add(
                      ContactsTabChanged(type),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _ContactForm(
                    type: state.activeType,
                    nameController: _nameController,
                    phoneController: _phoneController,
                    emailController: _emailController,
                    gstinController: _gstinController,
                    bankController: _bankController,
                    doctorRegController: _doctorRegController,
                    onSave: () {
                      context.read<ContactsBloc>().add(
                        ContactSaved(
                          type: state.activeType,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          email: _emailController.text,
                          gstin: _gstinController.text,
                          bankDetails: _bankController.text,
                          doctorRegistrationNumber: _doctorRegController.text,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: _ContactList(contacts: state.filtered)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ContactsTabs extends StatelessWidget {
  const _ContactsTabs({required this.activeType, required this.onChanged});

  final ContactType activeType;
  final ValueChanged<ContactType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ToggleButton(
          checked: activeType == ContactType.supplier,
          onChanged: (_) => onChanged(ContactType.supplier),
          child: const Text('Suppliers'),
        ),
        ToggleButton(
          checked: activeType == ContactType.doctor,
          onChanged: (_) => onChanged(ContactType.doctor),
          child: const Text('Doctors'),
        ),
        ToggleButton(
          checked: activeType == ContactType.other,
          onChanged: (_) => onChanged(ContactType.other),
          child: const Text('Others'),
        ),
      ],
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm({
    required this.type,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.gstinController,
    required this.bankController,
    required this.doctorRegController,
    required this.onSave,
  });

  final ContactType type;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController gstinController;
  final TextEditingController bankController;
  final TextEditingController doctorRegController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: 220,
              child: TextBox(controller: nameController, placeholder: 'Name'),
            ),
            SizedBox(
              width: 160,
              child: TextBox(controller: phoneController, placeholder: 'Phone'),
            ),
            SizedBox(
              width: 220,
              child: TextBox(controller: emailController, placeholder: 'Email'),
            ),
            if (type == ContactType.supplier) ...[
              SizedBox(
                width: 220,
                child: TextBox(
                  controller: gstinController,
                  placeholder: 'Supplier GSTIN',
                ),
              ),
              SizedBox(
                width: 320,
                child: TextBox(
                  controller: bankController,
                  placeholder: 'Bank details',
                ),
              ),
            ],
            if (type == ContactType.doctor)
              SizedBox(
                width: 240,
                child: TextBox(
                  controller: doctorRegController,
                  placeholder: 'Doctor registration number',
                ),
              ),
            FilledButton(onPressed: onSave, child: const Text('Save contact')),
          ],
        ),
      ),
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList({required this.contacts});

  final List<ContactRecord> contacts;

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Center(child: Text('No contacts in this tab.'));
    }

    return ListView.separated(
      itemCount: contacts.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final contact = contacts[index];
        final extra = contact.type == ContactType.supplier
            ? 'GSTIN: ${contact.gstin ?? '-'}'
            : contact.type == ContactType.doctor
            ? 'Reg No: ${contact.doctorRegistrationNumber ?? '-'}'
            : 'General contact';
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('${contact.name} • ${contact.phone} • $extra'),
          ),
        );
      },
    );
  }
}
