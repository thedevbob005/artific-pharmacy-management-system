import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/customers_bloc.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _categoryController = TextEditingController(text: 'Regular');

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomersBloc()..add(const CustomersStarted()),
      child: ScaffoldPage(
        header: const PageHeader(title: Text('Customers')),
        content: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<CustomersBloc, CustomersState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InfoBar(
                        title: const Text('Customer operation failed'),
                        content: Text(state.error!),
                        severity: InfoBarSeverity.error,
                      ),
                    ),
                  if (state.status == CustomersStatus.saved)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: InfoBar(
                        title: Text('Customer saved'),
                        content: Text('Customer record created successfully.'),
                        severity: InfoBarSeverity.success,
                      ),
                    ),
                  _CustomerForm(
                    nameController: _nameController,
                    phoneController: _phoneController,
                    emailController: _emailController,
                    addressController: _addressController,
                    categoryController: _categoryController,
                    onSave: () {
                      context.read<CustomersBloc>().add(
                        CustomerSaved(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          email: _emailController.text,
                          address: _addressController.text,
                          category: _categoryController.text,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: _CustomerList(
                      customers: state.customers,
                      selectedCustomerId: state.selectedCustomer?.id,
                      onSelect: (id) => context.read<CustomersBloc>().add(
                        CustomerSelected(id),
                      ),
                      onDelete: (id) => context.read<CustomersBloc>().add(
                        CustomerDeleted(id),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CustomerForm extends StatelessWidget {
  const _CustomerForm({
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.addressController,
    required this.categoryController,
    required this.onSave,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController categoryController;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 220,
              child: TextBox(
                controller: nameController,
                placeholder: 'Customer name',
              ),
            ),
            SizedBox(
              width: 180,
              child: TextBox(controller: phoneController, placeholder: 'Phone'),
            ),
            SizedBox(
              width: 220,
              child: TextBox(controller: emailController, placeholder: 'Email'),
            ),
            SizedBox(
              width: 260,
              child: TextBox(
                controller: addressController,
                placeholder: 'Address',
              ),
            ),
            SizedBox(
              width: 180,
              child: TextBox(
                controller: categoryController,
                placeholder: 'Category',
              ),
            ),
            FilledButton(onPressed: onSave, child: const Text('Save customer')),
          ],
        ),
      ),
    );
  }
}

class _CustomerList extends StatelessWidget {
  const _CustomerList({
    required this.customers,
    required this.selectedCustomerId,
    required this.onSelect,
    required this.onDelete,
  });

  final List<CustomerRecord> customers;
  final int? selectedCustomerId;
  final ValueChanged<int> onSelect;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    if (customers.isEmpty) {
      return const Center(child: Text('No customers added yet.'));
    }

    return ListView.separated(
      itemCount: customers.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final customer = customers[index];
        final isSelected = selectedCustomerId == customer.id;
        return Card(
          borderRadius: BorderRadius.circular(6),
          child: ListTile.selectable(
            selected: isSelected,
            title: Text('${customer.name} • ${customer.phone}'),
            subtitle: Text(
              '${customer.category} • ₹${customer.totalPurchases.toStringAsFixed(2)}',
            ),
            trailing: IconButton(
              icon: const Icon(FluentIcons.delete),
              onPressed: () => onDelete(customer.id),
            ),
            onPressed: () => onSelect(customer.id),
          ),
        );
      },
    );
  }
}
