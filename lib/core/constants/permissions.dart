enum UserRole { admin, pharmacist, cashier, accountant, auditor }

enum ModulePermission { none, read, readWrite, readWriteDelete }

class PermissionMatrix {
  const PermissionMatrix._();

  static const Map<UserRole, Map<String, ModulePermission>> byRole = {
    UserRole.admin: {
      'Billing/POS': ModulePermission.readWriteDelete,
      'Inventory': ModulePermission.readWriteDelete,
      'Purchases': ModulePermission.readWriteDelete,
      'Returns': ModulePermission.readWriteDelete,
      'Customers': ModulePermission.readWriteDelete,
      'H1 Register': ModulePermission.readWrite,
      'Reports': ModulePermission.readWrite,
      'Accounting': ModulePermission.readWrite,
      'User Mgmt': ModulePermission.readWriteDelete,
      'Backup': ModulePermission.readWrite,
      'Audit Logs': ModulePermission.readWrite,
    },
    UserRole.pharmacist: {
      'Billing/POS': ModulePermission.readWrite,
      'Inventory': ModulePermission.readWrite,
      'Purchases': ModulePermission.readWrite,
      'Returns': ModulePermission.readWrite,
      'Customers': ModulePermission.readWrite,
      'H1 Register': ModulePermission.readWrite,
      'Reports': ModulePermission.readWrite,
      'Accounting': ModulePermission.none,
      'User Mgmt': ModulePermission.none,
      'Backup': ModulePermission.none,
      'Audit Logs': ModulePermission.read,
    },
    UserRole.cashier: {
      'Billing/POS': ModulePermission.readWrite,
      'Inventory': ModulePermission.none,
      'Purchases': ModulePermission.none,
      'Returns': ModulePermission.none,
      'Customers': ModulePermission.readWrite,
      'H1 Register': ModulePermission.none,
      'Reports': ModulePermission.none,
      'Accounting': ModulePermission.none,
      'User Mgmt': ModulePermission.none,
      'Backup': ModulePermission.none,
      'Audit Logs': ModulePermission.none,
    },
    UserRole.accountant: {
      'Billing/POS': ModulePermission.read,
      'Inventory': ModulePermission.read,
      'Purchases': ModulePermission.readWrite,
      'Returns': ModulePermission.readWrite,
      'Customers': ModulePermission.read,
      'H1 Register': ModulePermission.read,
      'Reports': ModulePermission.readWrite,
      'Accounting': ModulePermission.readWrite,
      'User Mgmt': ModulePermission.none,
      'Backup': ModulePermission.none,
      'Audit Logs': ModulePermission.none,
    },
    UserRole.auditor: {
      'Billing/POS': ModulePermission.read,
      'Inventory': ModulePermission.read,
      'Purchases': ModulePermission.read,
      'Returns': ModulePermission.read,
      'Customers': ModulePermission.read,
      'H1 Register': ModulePermission.read,
      'Reports': ModulePermission.read,
      'Accounting': ModulePermission.read,
      'User Mgmt': ModulePermission.none,
      'Backup': ModulePermission.none,
      'Audit Logs': ModulePermission.read,
    },
  };
}
