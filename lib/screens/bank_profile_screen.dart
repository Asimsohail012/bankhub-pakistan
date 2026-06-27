import 'package:flutter/material.dart';

import '../data/models/financial_institution.dart';
import '../widgets/bank_profile/branch_information_section.dart';
import '../widgets/bank_profile/capability_section.dart';
import '../widgets/bank_profile/card_services_section.dart';
import '../widgets/bank_profile/digital_banking_section.dart';
import '../widgets/bank_profile/information_section.dart';
import '../widgets/bank_profile/institution_profile_header.dart';
import '../widgets/bank_profile/islamic_banking_section.dart';
import '../widgets/bank_profile/last_updated_footer.dart';
import '../widgets/bank_profile/source_information_footer.dart';
import '../widgets/bank_profile/verification_badge.dart';

/// Universal bank/institution profile screen.
///
/// Displays a complete profile for any FinancialInstitution with all
/// capabilities, services, and metadata.
///
/// All sections automatically hide if data is null/empty (no empty cards).
class BankProfileScreen extends StatefulWidget {
  final FinancialInstitution institution;

  /// Optional star rating (0-5)
  final double? rating;

  /// Optional callback for favorite toggle
  final VoidCallback? onFavoriteTap;

  /// Whether institution is favorited
  final bool isFavorite;

  const BankProfileScreen({
    super.key,
    required this.institution,
    this.rating,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  @override
  State<BankProfileScreen> createState() => _BankProfileScreenState();
}

class _BankProfileScreenState extends State<BankProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final institution = widget.institution;

    return Scaffold(
      appBar: AppBar(
        title: Text(institution.officialName),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Institution Header ──────────────────────────────────────
            InstitutionProfileHeader(
              institution: institution,
              rating: widget.rating,
              onFavoriteTap: widget.onFavoriteTap,
              isFavorite: widget.isFavorite,
            ),

            const SizedBox(height: 20),

            // ── Verification Badge ──────────────────────────────────────
            VerificationBadge(
              status: institution.sbpVerified ? 'verified' : null,
              verificationDate: institution.verificationDate,
            ),

            const SizedBox(height: 20),

            // ── Institution Information Section ────────────────────────
            InformationSection(
              officialWebsite: institution.officialWebsite,
              officialEmail: institution.officialEmail,
              helpline: institution.helpline,
              title: 'Contact Information',
            ),

            const SizedBox(height: 20),

            // ── Branch Information Section ─────────────────────────────
            BranchInformationSection(
              branchCount: null, // Not available in current model
              atmCount: null,    // Not available in current model
              serviceArea: null, // Not available in current model
              title: 'Branch Network',
            ),

            const SizedBox(height: 20),

            // ── Digital Banking Section ────────────────────────────────
            DigitalBankingSection(
              digitalServices: null, // Not populated in Phase 6 CP1
              title: 'Digital Banking',
            ),

            const SizedBox(height: 20),

            // ── Card Services Section ──────────────────────────────────
            CardServicesSection(
              cardServices: null, // Not populated in Phase 6 CP1
              title: 'Card Services',
            ),

            const SizedBox(height: 20),

            // ── Islamic Banking Section (conditional) ──────────────────
            IslamicBankingSection(
              islamicServices: null, // Not populated in Phase 6 CP1
              title: 'Islamic Banking',
            ),

            const SizedBox(height: 20),

            // ── Account Capabilities ───────────────────────────────────
            CapabilitySection(
              title: 'Account Products',
              capabilities: institution.accountCapabilities,
              badgeColor: const Color(0xFFE8EAF6),
              badgeTextColor: const Color(0xFF1E3A8A),
            ),

            const SizedBox(height: 16),

            // ── Card Capabilities ──────────────────────────────────────
            CapabilitySection(
              title: 'Card Products',
              capabilities: institution.cardCapabilities,
              badgeColor: const Color(0xFFEDE7F6),
              badgeTextColor: const Color(0xFF512DA8),
            ),

            const SizedBox(height: 16),

            // ── Digital Banking Capabilities ───────────────────────────
            CapabilitySection(
              title: 'Digital Services',
              capabilities: institution.digitalBankingCapabilities,
              badgeColor: const Color(0xFFF3E5F5),
              badgeTextColor: const Color(0xFF7B1FA2),
            ),

            const SizedBox(height: 16),

            // ── Payment Capabilities ───────────────────────────────────
            CapabilitySection(
              title: 'Payment Services',
              capabilities: institution.paymentCapabilities,
              badgeColor: const Color(0xFFE3F2FD),
              badgeTextColor: const Color(0xFF1565C0),
            ),

            const SizedBox(height: 16),

            // ── Financing Capabilities ────────────────────────────────
            CapabilitySection(
              title: 'Financing Products',
              capabilities: institution.financingCapabilities,
              badgeColor: const Color(0xFFE8F5E9),
              badgeTextColor: const Color(0xFF2E7D32),
            ),

            const SizedBox(height: 16),

            // ── Islamic Banking Capabilities ───────────────────────────
            CapabilitySection(
              title: 'Islamic Products',
              capabilities: institution.islamicBankingCapabilities,
              badgeColor: const Color(0xFFE8F5E9),
              badgeTextColor: const Color(0xFF1B5E20),
            ),

            const SizedBox(height: 16),

            // ── Overseas Pakistanis Capabilities ───────────────────────
            CapabilitySection(
              title: 'Overseas Services',
              capabilities: institution.overseasPakistanisCapabilities,
              badgeColor: const Color(0xFFE0F2F1),
              badgeTextColor: const Color(0xFF00695C),
            ),

            const SizedBox(height: 16),

            // ── Remittance Capabilities ────────────────────────────────
            CapabilitySection(
              title: 'Remittance Services',
              capabilities: institution.remittanceCapabilities,
              badgeColor: const Color(0xFFFFF3E0),
              badgeTextColor: const Color(0xFFF57C00),
            ),

            const SizedBox(height: 16),

            // ── Branch Services Capabilities ───────────────────────────
            CapabilitySection(
              title: 'Branch Services',
              capabilities: institution.branchServiceCapabilities,
              badgeColor: const Color(0xFFE0F7FA),
              badgeTextColor: const Color(0xFF00838F),
            ),

            const SizedBox(height: 16),

            // ── Customer Support Capabilities ──────────────────────────
            CapabilitySection(
              title: 'Customer Support',
              capabilities: institution.customerSupportCapabilities,
              badgeColor: const Color(0xFFF1F5FE),
              badgeTextColor: const Color(0xFF0D47A1),
            ),

            const SizedBox(height: 16),

            // ── Security Capabilities ──────────────────────────────────
            CapabilitySection(
              title: 'Security Features',
              capabilities: institution.securityCapabilities,
              badgeColor: const Color(0xFFFFEBEE),
              badgeTextColor: const Color(0xFFC62828),
            ),

            const SizedBox(height: 16),

            // ── Investment Capabilities ────────────────────────────────
            CapabilitySection(
              title: 'Investment Services',
              capabilities: institution.investmentCapabilities,
              badgeColor: const Color(0xFFF3E5F5),
              badgeTextColor: const Color(0xFF6A1B9A),
            ),

            const SizedBox(height: 16),

            // ── SME Services Capabilities ──────────────────────────────
            CapabilitySection(
              title: 'SME Services',
              capabilities: institution.smeServicesCapabilities,
              badgeColor: const Color(0xFFEDE7F6),
              badgeTextColor: const Color(0xFF512DA8),
            ),

            const SizedBox(height: 16),

            // ── Corporate Banking Capabilities ─────────────────────────
            CapabilitySection(
              title: 'Corporate Services',
              capabilities: institution.corporateBankingCapabilities,
              badgeColor: const Color(0xFFE0E7FF),
              badgeTextColor: const Color(0xFF3949AB),
            ),

            const SizedBox(height: 16),

            // ── Agriculture Capabilities ───────────────────────────────
            CapabilitySection(
              title: 'Agriculture Services',
              capabilities: institution.agricultureCapabilities,
              badgeColor: const Color(0xFFC8E6C9),
              badgeTextColor: const Color(0xFF1B5E20),
            ),

            const SizedBox(height: 16),

            // ── Treasury Capabilities ──────────────────────────────────
            CapabilitySection(
              title: 'Treasury Services',
              capabilities: institution.treasuryCapabilities,
              badgeColor: const Color(0xFFB2DFDB),
              badgeTextColor: const Color(0xFF004D40),
            ),

            const SizedBox(height: 16),

            // ── Trade Finance Capabilities ─────────────────────────────
            CapabilitySection(
              title: 'Trade Finance',
              capabilities: institution.tradeFinanceCapabilities,
              badgeColor: const Color(0xFFE8EAF6),
              badgeTextColor: const Color(0xFF1E3A8A),
            ),

            const SizedBox(height: 28),

            // ── Source Information Footer ──────────────────────────────
            SourceInformationFooter(
              sourceName: null, // Populated in Phase 6
              sourceUrl: null,
              retrievedDate: null,
              verifiedDate: null,
              verificationStatus: null,
            ),

            const SizedBox(height: 12),

            // ── Last Updated Footer ────────────────────────────────────
            LastUpdatedFooter(
              lastUpdated: institution.lastUpdated,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
