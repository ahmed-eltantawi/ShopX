import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  AppStyles._();

  // ── Display / Hero ──────────────────────────────────────────────────────────
  static TextStyle heroTitle(BuildContext context) => TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 42,
    fontWeight: FontWeight.w500,
    color: AppColors.of(context).primaryText,
    height: 1.1,
    letterSpacing: -1.0,
  );

  static TextStyle heroTitleItalic(BuildContext context) => TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 42,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.of(context).secondaryText,
    height: 1.1,
    letterSpacing: -0.5,
  );

  // ── Section headings ────────────────────────────────────────────────────────
  static TextStyle sectionTitle(BuildContext context) => TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.of(context).primaryText,
    height: 1.2,
  );

  static TextStyle sectionTitleItalic(BuildContext context) => TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 26,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: AppColors.of(context).primaryText,
    height: 1.2,
  );

  // ── Labels / Eyebrows ───────────────────────────────────────────────────────
  static TextStyle eyebrow(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.of(context).labelText,
    letterSpacing: 2.5,
  );

  static TextStyle eyebrowAccent(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.of(context).primaryText,
    letterSpacing: 3.0,
  );

  // ── Body ────────────────────────────────────────────────────────────────────
  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.of(context).secondaryText,
    height: 1.6,
  );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.of(context).secondaryText,
    height: 1.5,
    letterSpacing: 0.2,
  );

  // ── Product card ────────────────────────────────────────────────────────────
  static TextStyle productName(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.of(context).primaryText,
    letterSpacing: 0.1,
  );

  static TextStyle productPrice(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.of(context).primaryText,
    letterSpacing: 0.3,
  );

  // ── Form ────────────────────────────────────────────────────────────────────
  static TextStyle inputLabel(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.of(context).labelText,
    letterSpacing: 1.8,
  );

  static TextStyle inputText(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.of(context).primaryText,
  );

  static TextStyle inputHint(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 13,
    fontWeight: FontWeight.w300,
    color: AppColors.of(context).hintText,
  );

  static TextStyle pricePrefix(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.of(context).secondaryText,
  );

  // ── Buttons ─────────────────────────────────────────────────────────────────
  static TextStyle buttonLabel(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.of(context).buttonText,
    letterSpacing: 2.5,
  );

  static TextStyle linkLabel(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.of(context).secondaryText,
    letterSpacing: 1.5,
    decoration: TextDecoration.underline,
  );

  static TextStyle outlinedButtonLabel(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.of(context).primaryText,
    letterSpacing: 2.0,
  );

  // ── Quote / Overlay ─────────────────────────────────────────────────────────
  static TextStyle quote(BuildContext context) => const TextStyle(
    fontFamily: 'PlayfairDisplay',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: Color(0xFFEDEAE3),
    height: 1.6,
  );

  // ── Footer / Meta ────────────────────────────────────────────────────────────
  static TextStyle metaLabel(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 9,
    fontWeight: FontWeight.w500,
    color: AppColors.of(context).labelText,
    letterSpacing: 1.5,
  );

  static TextStyle metaValue(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 9,
    fontWeight: FontWeight.w400,
    color: AppColors.of(context).secondaryText,
    letterSpacing: 0.5,
  );

  // ── App bar title ────────────────────────────────────────────────────────────
  static TextStyle appBarTitle(BuildContext context) => TextStyle(
    fontFamily: 'Jost',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.of(context).primaryText,
    letterSpacing: 4.0,
  );
}

