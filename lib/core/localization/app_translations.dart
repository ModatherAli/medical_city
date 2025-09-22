import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // Auth Screen Translations
      'Disclaimer': '''
  This app provides daily written ideas for U.S. stocks and options for informational/educational purposes only and does not constitute personal financial advice or a solicitation to buy or sell any security.
  Financial markets inherently involve risk, including the potential loss of capital. 
  By using this app, you acknowledge that you are solely responsible for your investment decisions, and that the developer/operators shall not be liable for any financial losses resulting from the use of this content.
''',
      'Accept': 'Accept',
      'Sign Up': 'Sign Up',
      'Log In': 'Log In',
      'Have an account?': 'Have an account?',
      'New here?': 'New here?',
      'Open account': 'Open account',
      'Forgot your password?': 'Forgot your password?',
      'Or sign in with': 'Or sign in with',
      'Or sign up with': 'Or sign up with',
      'P  assword reset request': 'Password reset request',
      'O  R': 'OR',
      'R  egister via': 'Register via',
      'In Progress...': 'In Progress...',
      'an error occurred!': 'An error occurred!',

      // Form Field Translations
      'Email': 'Email',
      'Password': 'Password',
      'Confirm Password': 'Confirm Password',
      'Full Name': 'Full Name',
      'Phone': 'Phone',
      'Symbol (Optional)': 'Symbol (Optional)',

      // Account Screen Translations
      'Account': 'Account',
      'Your data': 'Your data',
      'Subscription Status': 'Subscription Status',
      'Active until': 'Active until',
      'Edit your data': 'Edit your data',
      'Sign out': 'Sign out',
      'Settings': 'Settings',
      'Language': 'Language',
      'Enable Notifications': 'Enable Notifications',
      'Others': 'Others',
      'Share app': 'Share app',
      'Rate us': 'Rate us',
      'Contact us': 'Contact us',
      'Privacy Policy': 'Privacy Policy',
      'App theme': 'App theme',

      // Main Navigation
      'Stocks': 'Stocks',
      'Options': 'Options',
      'Archive': 'Archive',
      'Notifications': 'Notifications',

      // Stocks Screen
      'Entry': 'Entry',
      'Target': 'Target',
      'Stop': 'Stop',
      'Horizon': 'Horizon',
      'Date': 'Date',
      'Strike': 'Strike',
      'Expiry': 'Expiry',
      'Edit Stock': 'Edit Stock',
      'Delete Stock': 'Delete Stock',
      'Are you sure you want to delete': 'Are you sure you want to delete',
      'Cancel': 'Cancel',
      'Delete': 'Delete',
      'Edit Option': 'Edit Option',
      'Delete Option': 'Delete Option',

      // Notifications Screen
      'No notifications yet': 'No notifications yet',
      'Trade notifications will appear here':
          'Trade notifications will appear here',
      'Refresh': 'Refresh',
      'Error loading notifications': 'Error loading notifications',
      'Retry': 'Retry',

      // Chat Screen
      'Conversations': 'Conversations',
      'Chat': 'Chat',
      'No conversations yet': 'No conversations yet',
      'Conversations will appear here when users start chatting':
          'Conversations will appear here when users start chatting',
      'No messages yet': 'No messages yet',
      'Type a message...': 'Type a message...',
      'Send': 'Send',
      'Just now': 'Just now',
      'Since': 'Since',
      'min': 'min',
      'hours': 'hours',
      'Yesterday': 'Yesterday',
      'Error loading conversations': 'Error loading conversations',
      'Stox Support': 'Stox Support',
      'Error: ': 'Error: ',

      // Subscription Screen
      'Unlock Premium': 'Unlock Premium',
      'Only SAR 20/month': 'Only SAR 20/month',
      'Subscribe Now': 'Subscribe Now',
      'Restore Purchases': 'Restore Purchases',
      'Cancel anytime in your store settings.':
          'Cancel anytime in your store settings.',

      // Error Messages
      'Error': 'Error',
      'Something went wrong': 'Something went wrong',
      'Try again': 'Try again',

      // Common Actions
      'Save': 'Save',
      'Update': 'Update',
      'Add': 'Add',
      'Search': 'Search',
      'Filter': 'Filter',
      'All': 'All',
      'Open': 'Open',
      'Closed': 'Closed',
      'Type:': 'Type:',
      'Status:': 'Status:',
      'Apply Filters': 'Apply Filters',
      'Clear Filters': 'Clear Filters',

      // Subscription Screen
      'Daily stock & options recommendations':
          'Daily stock & options recommendations',
      'Instant push notifications': 'Instant push notifications',
      'Access full archive anytime': 'Access full archive anytime',
      '1:1 chat support': '1:1 chat support',

      // Archive Filter
      'Filter Archive': 'Filter Archive',
      'Date Range:': 'Date Range:',
      'Start Date': 'Start Date',
      'End Date': 'End Date',

      // Form Validation Messages
      'This field is required': 'This field is required',
      'Characters must be at least @min': 'Characters must be at least @min',

      // Payment & Subscription
      'Processing...': 'Processing...',
      'Restoring...': 'Restoring...',
      'Subscription activated successfully!':
          'Subscription activated successfully!',
      'Subscription restored successfully!':
          'Subscription restored successfully!',
      'Characters must be at most @max': 'Characters must be at most @max',
      'Username is required': 'Username is required',
      'Only letters, numbers, dot and underscore allowed':
          'Only letters, numbers, dot and underscore allowed',
      'Username must be 3–30 characters': 'Username must be 3–30 characters',
      'Email is required': 'Email is required',
      'Enter a valid email': 'Enter a valid email',
      'Password is required': 'Password is required',
      'Password must be at least @minLength characters':
          'Password must be at least @minLength characters',
      'Password must contain an uppercase letter':
          'Password must contain an uppercase letter',
      'Password must contain a lowercase letter':
          'Password must contain a lowercase letter',
      'Password must contain a digit': 'Password must contain a digit',
      'Password must contain a special character':
          'Password must contain a special character',
      'Passwords do not match': 'Passwords do not match',
      'Phone number is required': 'Phone number is required',
      'Enter a valid phone number': 'Enter a valid phone number',
      'Must be numeric': 'Must be numeric',
      'Enter a valid URL': 'Enter a valid URL',
      'Please enter a valid number': 'Please enter a valid number',
      'Value must be greater than 0': 'Value must be greater than 0',
      'Stock symbol is required': 'Stock symbol is required',
      'Symbol must be 1-5 uppercase letters':
          'Symbol must be 1-5 uppercase letters',
      'Option type is required': 'Option type is required',
      'Type must be CALL or PUT': 'Type must be CALL or PUT',
      'Strike price is required': 'Strike price is required',
      'Please enter a valid strike price': 'Please enter a valid strike price',
      'Strike price must be greater than 0':
          'Strike price must be greater than 0',
      'Premium is required': 'Premium is required',
      'Please enter a valid premium': 'Please enter a valid premium',
      'Premium must be greater than 0': 'Premium must be greater than 0',
      'Expiry date is required': 'Expiry date is required',
      'Expiry date cannot be in the past': 'Expiry date cannot be in the past',
      'Start date must be before end date':
          'Start date must be before end date',
      'Symbol too long': 'Symbol too long',
      'Phone number must start with country code (+)':
          'Phone number must start with country code (+)',
      'OTP is required': 'OTP is required',
      'OTP must be 6 digits': 'OTP must be 6 digits',

      // Additional missing translations
      'Delete Account': 'Delete Account',
      'Are you sure you want to delete your account? This action cannot be undone.':
          'Are you sure you want to delete your account? This action cannot be undone.',
      'Your name': 'Your name',
      'Phone Number': 'Phone Number',
      'Phone number': 'Phone number',
      'Unknown state': 'Unknown state',
      'No items match your filters': 'No items match your filters',
      'No archive items found': 'No archive items found',
      'Try adjusting your filter criteria':
          'Try adjusting your filter criteria',
      'Your completed stocks and options will appear here':
          'Your completed stocks and options will appear here',
      'Active filters:': 'Active filters:',
      'Symbol:': 'Symbol:',
      'Date:': 'Date:',
      'Clear': 'Clear',
      'OTP sent to': 'OTP sent to',
      'Verify OTP': 'Verify OTP',
      'Phone Authentication': 'Phone Authentication',
      'Enter verification code': 'Enter verification code',
      'Enter your phone number': 'Enter your phone number',
      'We sent a 6-digit code to': 'We sent a 6-digit code to',
      'Enter 6-digit OTP': 'Enter 6-digit OTP',
      'Verify & Sign In': 'Verify & Sign In',
      'Resend OTP': 'Resend OTP',
      'We\'ll send you a verification code':
          'We\'ll send you a verification code',
      'Please enter your phone number with country code':
          'Please enter your phone number with country code',
      'Send OTP': 'Send OTP',

      // Additional auth translations
      'English': 'English',
      'Google': 'Google',

      // Notification Settings Dialog
      'Notification Settings': 'Notification Settings',
      'To change notification preferences, please go to your device settings.':
          'To change notification preferences, please go to your device settings.',
      'Open Settings': 'Open Settings',
    },
    'ar_SA': {
      'Disclaimer': '''
يوفّر هذا التطبيق توصيات يومية مكتوبة لأغراض تعليمية ومعلوماتية فقط، ولا يُعد نصيحة استثمارية أو دعوة للبيع أو الشراء.
 تنطوي الأسواق المالية على مخاطر قد تؤدي إلى خسارة جزئية أو كلية لرأس المال.
  باستخدام التطبيق، تقر بمسؤوليتك الكاملة عن قراراتك، وأن مطوّر التطبيق والقائمين عليه غير مسئولين عن أي خسائر مالية قد تنشأ نتيجة الاعتماد على المحتوى
''',
      'Accept': 'أوافق',
      // Auth Screen Translations
      'Sign Up': 'إنشاء حساب',
      'Log In': 'تسجيل دخول',
      'Have an account?': 'لديك حساب؟',
      'New here?': 'جديد هنا؟',
      'Open account': 'فتح حساب',
      'Forgot your password?': 'نسيت كلمة المرور؟',
      'Or sign in with': 'أو سجل دخول باستخدام',
      'Or sign up with': 'أو أنشئ حساب باستخدام',
      'Password reset request': 'طلب إعادة تعيين كلمة المرور',
      'OR': 'أو',
      'Register via': 'التسجيل عبر',
      'In Progress...': 'جاري التحميل...',
      'an error occurred!': 'حدث خطأ!',

      // Form Field Translations
      'Email': 'البريد الإلكتروني',
      'Password': 'كلمة المرور',
      'Confirm Password': 'تأكيد كلمة المرور',
      'Full Name': 'الاسم الكامل',
      'Phone': 'الهاتف',
      'Symbol (Optional)': 'الرمز (اختياري)',

      // Account Screen Translations
      'Account': 'الحساب',
      'Your data': 'بياناتك',
      'Subscription Status': 'حالة الاشتراك',
      'Active until': 'نشط حتى',
      'Edit your data': 'تعديل بياناتك',
      'Sign out': 'تسجيل خروج',
      'Settings': 'الإعدادات',
      'Language': 'اللغة',
      'Enable Notifications': 'تفعيل الإشعارات',
      'Others': 'أخرى',
      'Share app': 'مشاركة التطبيق',
      'Rate us': 'قيمنا',
      'Contact us': 'اتصل بنا',
      'Privacy Policy': 'سياسة الخصوصية',
      'App theme': 'مظهر التطبيق',

      // Main Navigation
      'Stocks': 'الأسهم',
      'Options': 'الخيارات',
      'Archive': 'الأرشيف',
      'Notifications': 'الإشعارات',

      // Stocks Screen
      'Entry': 'الدخول',
      'Target': 'الهدف',
      'Stop': 'وقف الخسارة',
      'Horizon': 'الأفق',
      'Date': 'التاريخ',
      'Strike': 'سعر التنفيذ',
      'Expiry': 'انتهاء الصلاحية',
      'Edit Stock': 'تعديل السهم',
      'Delete Stock': 'حذف السهم',
      'Are you sure you want to delete': 'هل أنت متأكد من حذف',
      'Cancel': 'إلغاء',
      'Delete': 'حذف',
      'Edit Option': 'تعديل الخيار',
      'Delete Option': 'حذف الخيار',

      // Notifications Screen
      'No notifications yet': 'لا توجد إشعارات بعد',
      'Trade notifications will appear here': 'ستظهر إشعارات التداول هنا',
      'Refresh': 'تحديث',
      'Error loading notifications': 'خطأ في تحميل الإشعارات',
      'Retry': 'إعادة المحاولة',

      // Chat Screen
      'Conversations': 'المحادثات',
      'Chat': 'الدردشة',
      'No conversations yet': 'لا توجد محادثات بعد',
      'Conversations will appear here when users start chatting':
          'ستظهر المحادثات هنا عند بدء المستخدمين بالدردشة',
      'No messages yet': 'لا توجد رسائل بعد',
      'Type a message...': 'اكتب رسالة...',
      'Send': 'إرسال',
      'Just now': 'الآن',
      'Since': 'منذ',
      'min': 'دقيقة',
      'hours': 'ساعة',
      'Yesterday': 'أمس',
      'Error loading conversations': 'خطأ في تحميل المحادثات',
      'Stox Support': 'دعم Stox',
      'Error: ': 'خطأ: ',

      // Subscription Screen
      'Unlock Premium': 'فتح الاشتراك المميز',
      'Only SAR 20/month': 'فقط 20 ريال/الشهر',
      'Subscribe Now': 'اشترك الآن',
      'Restore Purchases': 'استعادة المشتريات',
      'Cancel anytime in your store settings.':
          'يمكنك الإلغاء في أي وقت من إعدادات المتجر.',

      // Error Messages
      'Error': 'خطأ',
      'Something went wrong': 'حدث خطأ ما',
      'Try again': 'حاول مرة أخرى',

      // Common Actions
      'Save': 'حفظ',
      'Update': 'تحديث',
      'Add': 'إضافة',
      'Search': 'بحث',
      'Filter': 'تصفية',
      'All': 'الكل',
      'Open': 'مفتوح',
      'Closed': 'مغلق',
      'Type:': 'النوع:',
      'Status:': 'الحالة:',
      'Apply Filters': 'تطبيق التصفية',
      'Clear Filters': 'مسح التصفية',

      // Subscription Screen
      'Daily stock & options recommendations': 'توصيات يومية للأسهم والخيارات',
      'Instant push notifications': 'إشعارات فورية',
      'Access full archive anytime': 'الوصول للأرشيف الكامل في أي وقت',
      '1:1 chat support': 'دعم المحادثة المباشرة',

      // Archive Filter
      'Filter Archive': 'تصفية الأرشيف',
      'Date Range:': 'المدى الزمني:',
      'Start Date': 'تاريخ البداية',
      'End Date': 'تاريخ النهاية',
      'Confirm password': 'تأكيد كلمة المرور',

      // Form Validation Messages
      'This field is required': 'هذا الحقل مطلوب',
      'Characters must be at least @min': 'الأحرف يجب أن تكون @min على الأقل',
      'Characters must be at most @max': 'الأحرف يجب أن تكون @max على الأكثر',
      'Username is required': 'اسم المستخدم مطلوب',
      'Only letters, numbers, dot and underscore allowed':
          'الحروف والأرقام والنقطة والشرطة السفلى فقط مسموحة',
      'Username must be 3–30 characters':
          'اسم المستخدم يجب أن يكون من 3-30 حرفاً',
      'Email is required': 'البريد الإلكتروني مطلوب',
      'Enter a valid email': 'أدخل بريد إلكتروني صحيح',
      'Password is required': 'كلمة المرور مطلوبة',
      'Password must be at least @minLength characters':
          'كلمة المرور يجب أن تكون @minLength أحرف على الأقل',
      'Password must contain an uppercase letter':
          'كلمة المرور يجب أن تحتوي على حرف كبير',
      'Password must contain a lowercase letter':
          'كلمة المرور يجب أن تحتوي على حرف صغير',
      'Password must contain a digit': 'كلمة المرور يجب أن تحتوي على رقم',
      'Password must contain a special character':
          'كلمة المرور يجب أن تحتوي على رمز خاص',
      'Passwords do not match': 'كلمات المرور غير متطابقة',
      'Phone number is required': 'رقم الهاتف مطلوب',
      'Enter a valid phone number': 'أدخل رقم هاتف صحيح',
      'Must be numeric': 'يجب أن يكون رقمياً',
      'Enter a valid URL': 'أدخل رابط صحيح',
      'Please enter a valid number': 'الرجاء إدخال رقم صحيح',
      'Value must be greater than 0': 'القيمة يجب أن تكون أكبر من 0',
      'Stock symbol is required': 'رمز السهم مطلوب',
      'Symbol must be 1-5 uppercase letters':
          'الرمز يجب أن يكون من 1-5 أحرف كبيرة',
      'Option type is required': 'نوع الخيار مطلوب',
      'Type must be CALL or PUT': 'النوع يجب أن يكون CALL أو PUT',
      'Strike price is required': 'سعر التنفيذ مطلوب',
      'Please enter a valid strike price': 'الرجاء إدخال سعر تنفيذ صحيح',
      'Strike price must be greater than 0':
          'سعر التنفيذ يجب أن يكون أكبر من 0',
      'Premium is required': 'العلاوة مطلوبة',
      'Please enter a valid premium': 'الرجاء إدخال علاوة صحيحة',
      'Premium must be greater than 0': 'العلاوة يجب أن تكون أكبر من 0',
      'Expiry date is required': 'تاريخ انتهاء الصلاحية مطلوب',
      'Expiry date cannot be in the past':
          'تاريخ انتهاء الصلاحية لا يمكن أن يكون في الماضي',
      'Start date must be before end date':
          'تاريخ البداية يجب أن يكون قبل تاريخ النهاية',
      'Symbol too long': 'الرمز طويل جداً',
      'Phone number must start with country code (+)':
          'رقم الهاتف يجب أن يبدأ برمز الدولة (+)',
      'OTP is required': 'رمز التحقق مطلوب',
      'OTP must be 6 digits': 'رمز التحقق يجب أن يكون 6 أرقام',

      // Payment & Subscription
      'Processing...': 'جاري المعالجة...',
      'Restoring...': 'جاري الاستعادة...',
      'Subscription activated successfully!': 'تم تفعيل الاشتراك بنجاح!',
      'Subscription restored successfully!': 'تم استعادة الاشتراك بنجاح!',

      // Additional missing translations
      'Delete Account': 'حذف الحساب',
      'Are you sure you want to delete your account? This action cannot be undone.':
          'هل أنت متأكد من حذف حسابك؟ لا يمكن التراجع عن هذا الإجراء.',
      'Your name': 'اسمك',
      'Phone Number': 'رقم الهاتف',
      'Phone number': 'رقم الهاتف',
      'Unknown state': 'حالة غير معروفة',
      'No items match your filters': 'لا توجد عناصر تطابق المرشحات',
      'No archive items found': 'لم يتم العثور على عناصر في الأرشيف',
      'Try adjusting your filter criteria': 'جرب تعديل معايير التصفية',
      'Your completed stocks and options will appear here':
          'ستظهر الأسهم والخيارات المكتملة هنا',
      'Active filters:': 'المرشحات النشطة:',
      'Symbol:': 'الرمز:',
      'Date:': 'التاريخ:',
      'Clear': 'مسح',
      'OTP sent to': 'تم إرسال رمز التحقق إلى',
      'Verify OTP': 'تحقق من رمز OTP',
      'Phone Authentication': 'مصادقة الهاتف',
      'Enter verification code': 'أدخل رمز التحقق',
      'Enter your phone number': 'أدخل رقم هاتفك',
      'We sent a 6-digit code to': 'أرسلنا رمز مكون من 6 أرقام إلى',
      'Enter 6-digit OTP': 'أدخل رمز OTP المكون من 6 أرقام',
      'Verify & Sign In': 'تحقق وسجل دخول',
      'Resend OTP': 'إعادة إرسال رمز OTP',
      'We\'ll send you a verification code': 'سنرسل لك رمز تحقق',
      'Please enter your phone number with country code':
          'يرجى إدخال رقم هاتفك مع رمز الدولة',
      'Send OTP': 'إرسال رمز OTP',

      // Additional auth translations
      'English': 'English',
      'Google': 'Google',

      // Notification Settings Dialog
      'Notification Settings': 'إعدادات الإشعارات',
      'To change notification preferences, please go to your device settings.':
          'لتغيير تفضيلات الإشعارات، يرجى الذهاب إلى إعدادات الجهاز.',
      'Open Settings': 'فتح الإعدادات',
      'No Internet Connection': 'لا يوجد اتصال بالانترنت',
      "No Stocks Found": 'لم يتم العثور على توصيات',
      "No options found": 'لم يتم العثور على توصيات',
    },
  };
}
