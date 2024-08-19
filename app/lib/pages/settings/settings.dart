import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ThemeData.dart';
import '../../main.dart';
import 'UpdateUrlsPage.dart';
// Security - Navigate to a security settings page.
// Language - Navigate to a language settings page.
// Help & Support - Navigate to a help and support page.
// About - Navigate to an about page.

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('الملف الشخصي'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileSettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('الإشعارات'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationsSettingsPage()));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.link),
          //   title: const Text('link'),
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => const UpdateUrlsPage()));
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('الثيم'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeSettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('الخصوصية'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacySettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('الأمان'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SecuritySettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('اللغة'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageSettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('المساعدة والدعم'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpSupportPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('حول'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('مسح حسابك', style: TextStyle(color: Colors.red)),
            onTap: () {
              // Implement delete account functionality
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('تأكيد المسح'),
                  content: const Text('هل أنت متأكد أنك تريد مسح حسابك نهائيًا؟'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('إلغاء'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Implement the delete functionality here
                        Navigator.pop(context);
                        print('Account deleted');
                      },
                      child: const Text('مسح', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'الاسم',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality or navigation
                print('Save Profile Changes');
              },
              child: const Text('حفظ التغييرات'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() => _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _promotionalNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات الإشعارات'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('الإشعارات الفورية'),
            subtitle: const Text('تفعيل أو تعطيل الإشعارات الفورية'),
            value: _pushNotifications,
            onChanged: (bool value) {
              setState(() {
                _pushNotifications = value;
              });
            },
            secondary: const Icon(Icons.notifications_active),
          ),
          SwitchListTile(
            title: const Text('الإشعارات البريدية'),
            subtitle: const Text('تفعيل أو تعطيل الإشعارات عبر البريد الإلكتروني'),
            value: _emailNotifications,
            onChanged: (bool value) {
              setState(() {
                _emailNotifications = value;
              });
            },
            secondary: const Icon(Icons.email),
          ),
          SwitchListTile(
            title: const Text('العروض الترويجية'),
            subtitle: const Text('تفعيل أو تعطيل الإشعارات للعروض الترويجية'),
            value: _promotionalNotifications,
            onChanged: (bool value) {
              setState(() {
                _promotionalNotifications = value;
              });
            },
            secondary: const Icon(Icons.local_offer),
          ),
        ],
      ),
    );
  }
}

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({super.key});

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  // Convert ThemeMode to a more readable string format for matching with Radio buttons
  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      default:
        return 'System';
    }
  }

  void _changeTheme(String theme, BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    provider.setThemeMode(
      theme == 'Light'
          ? ThemeMode.light
          : theme == 'Dark'
              ? ThemeMode.dark
              : ThemeMode.system,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the current theme mode from the provider and convert it to string
    final _selectedTheme = _themeModeToString(
      Provider.of<ThemeProvider>(context).themeMode,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('اختيار الثيم'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('الوضع الفاتح'),
            leading: Radio<String>(
              value: 'Light',
              groupValue: _selectedTheme,
              onChanged: (value) {
                if (value != null) {
                  _changeTheme(value, context);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('الوضع المظلم'),
            leading: Radio<String>(
              value: 'Dark',
              groupValue: _selectedTheme,
              onChanged: (value) {
                if (value != null) {
                  _changeTheme(value, context);
                }
              },
            ),
          ),
          // If you decide to use 'System' mode, uncomment this part
          // ListTile(
          //   title: const Text('الوضع المخصص'),
          //   leading: Radio<String>(
          //     value: 'System',
          //     groupValue: _selectedTheme,
          //     onChanged: (value) {
          //       if (value != null) {
          //         _changeTheme(value, context);
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool _locationServicesEnabled = true;
  bool _allowAppAnalytics = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات الخصوصية'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text('خدمات الموقع'),
            subtitle: const Text('تمكين أو تعطيل خدمات الموقع'),
            value: _locationServicesEnabled,
            onChanged: (bool value) {
              setState(() {
                _locationServicesEnabled = value;
              });
            },
            secondary: const Icon(Icons.location_on),
          ),
          SwitchListTile(
            title: const Text('التحليلات'),
            subtitle: const Text('السماح بتحليلات التطبيق لتحسين الخدمة'),
            value: _allowAppAnalytics,
            onChanged: (bool value) {
              setState(() {
                _allowAppAnalytics = value;
              });
            },
            secondary: const Icon(Icons.analytics),
          ),
          // Additional privacy settings can be added here
        ],
      ),
    );
  }
}

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  bool _twoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات الأمان'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('تغيير كلمة المرور'),
            onTap: () {
              // Navigate to change password page or dialog
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
            },
          ),
          SwitchListTile(
            title: const Text('المصادقة الثنائية'),
            subtitle: const Text('تفعيل أو تعطيل المصادقة الثنائية لزيادة الأمان'),
            value: _twoFactorEnabled,
            onChanged: (bool value) {
              setState(() {
                _twoFactorEnabled = value;
              });
            },
            secondary: const Icon(Icons.phonelink_lock),
          ),
          // Additional security settings can be added here
        ],
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تغيير كلمة المرور'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'كلمة المرور القديمة',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'كلمة المرور الجديدة',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'تأكيد كلمة المرور الجديدة',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement password change logic
                print('Password Changed Successfully');
              },
              child: const Text('تغيير كلمة المرور'),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String _selectedLanguage = 'Arabic'; // Default to Arabic

  void _changeLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
    // Implement language change logic here, e.g., using Provider or another state management solution
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات اللغة'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('English'),
            leading: Radio<String>(
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (String? value) {
                if (value != null) {
                  _changeLanguage(value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('العربية'),
            leading: Radio<String>(
              value: 'Arabic',
              groupValue: _selectedLanguage,
              onChanged: (String? value) {
                if (value != null) {
                  _changeLanguage(value);
                }
              },
            ),
          ),
          ListTile(
            title: const Text('Français'),
            leading: Radio<String>(
              value: 'French',
              groupValue: _selectedLanguage,
              onChanged: (String? value) {
                if (value != null) {
                  _changeLanguage(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعدة والدعم'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.question_answer),
            title: const Text('الأسئلة المتكررة'),
            onTap: () {
              // Navigate to FAQ page or show FAQ dialog
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text('التواصل مع الدعم'),
            onTap: () {
              // Navigate to a contact form or initiate a support chat
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('دليل المستخدم'),
            onTap: () {
              // Navigate to a user guide page or open a PDF user manual
            },
          ),
          // Additional help and support options can be added here
        ],
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/logo.png'), // Use your logo image
            ),
            const SizedBox(height: 20),
            const Text(
              'اسم التطبيق',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'وصف مختصر للتطبيق. هذه التطبيق يساعد المستخدمين في القيام بالمهام التالية ...',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'الإصدار: 1.0.0',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            const Text(
              'المطورون:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'اسم المطور 1',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'اسم المطور 2',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'تواصل معنا:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'البريد الإلكتروني: support@app.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'الهاتف: +123456789',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
