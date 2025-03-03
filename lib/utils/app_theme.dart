import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // الألوان الرئيسية
  static const Color primary = Color(0xFF2196F3);    // أزرق فاتح
  static const Color secondary = Color(0xFF1976D2);  // أزرق غامق
  static const Color accent = Color(0xFF64B5F6);     // أزرق فاتح جداً
  
  // ألوان الحالة
  static const Color success = Color(0xFF4CAF50);    // أخضر
  static const Color warning = Color(0xFFFFA726);    // برتقالي
  static const Color error = Color(0xFFEF5350);      // أحمر
  
  // ألوان محايدة
  static const Color background = Color(0xFFF5F5F5); // رمادي فاتح
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  // أنماط النصوص
  static TextStyle get headingLarge => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static TextStyle get headingMedium => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  static TextStyle get bodyLarge => TextStyle(
    fontSize: 16.sp,
    color: textPrimary,
  );

  static TextStyle get bodyMedium => TextStyle(
    fontSize: 14.sp,
    color: textSecondary,
  );

  // أنماط الأزرار
  static ButtonStyle get primaryButton => ElevatedButton.styleFrom(
    backgroundColor: primary,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
  );

  // أنماط البطاقات
  static BoxDecoration get cardDecoration => BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(12.r),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // أنماط حقول الإدخال
  static InputDecoration inputDecoration({required String label}) => InputDecoration(
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(color: Colors.grey[300]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(color: primary),
    ),
    filled: true,
    fillColor: surface,
  );
} 