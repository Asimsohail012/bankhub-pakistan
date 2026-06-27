/// Exchange rate data for currency pairs.
class ExchangeRateData {
  final String currency;
  final double rate;
  final double change;
  final String lastUpdated;

  const ExchangeRateData({
    required this.currency,
    required this.rate,
    required this.change,
    required this.lastUpdated,
  });
}

/// Gold price data in Pakistani rupees.
class GoldPriceData {
  final double pricePerGram;
  final double pricePerTola;
  final double pricePerOunce;
  final double dailyChange;
  final String lastUpdated;

  const GoldPriceData({
    required this.pricePerGram,
    required this.pricePerTola,
    required this.pricePerOunce,
    required this.dailyChange,
    required this.lastUpdated,
  });
}

/// KIBOR (Karachi Interbank Offered Rate) data.
class KiborData {
  final double rate;
  final String tenor; // 1D, 1W, 1M, 3M, 6M, 12M
  final double change;
  final String lastUpdated;

  const KiborData({
    required this.rate,
    required this.tenor,
    required this.change,
    required this.lastUpdated,
  });
}

/// Banking news article.
class BankingNewsArticle {
  final String id;
  final String title;
  final String summary;
  final String source;
  final String publishedAt;
  final String? imageUrl;

  const BankingNewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.source,
    required this.publishedAt,
    this.imageUrl,
  });
}

/// Bank holiday information.
class BankHoliday {
  final String date;
  final String name;
  final String description;
  final bool isNational;

  const BankHoliday({
    required this.date,
    required this.name,
    required this.description,
    required this.isNational,
  });
}

/// Bank circular or regulatory announcement.
class BankCircular {
  final String id;
  final String title;
  final String content;
  final String source;
  final String issuedDate;
  final String? effectiveDate;

  const BankCircular({
    required this.id,
    required this.title,
    required this.content,
    required this.source,
    required this.issuedDate,
    this.effectiveDate,
  });
}

/// Bank job posting.
class BankJob {
  final String id;
  final String title;
  final String bank;
  final String location;
  final String jobType;
  final String postedDate;
  final String? deadline;

  const BankJob({
    required this.id,
    required this.title,
    required this.bank,
    required this.location,
    required this.jobType,
    required this.postedDate,
    this.deadline,
  });
}

/// Financial calendar event.
class FinancialCalendarEvent {
  final String id;
  final String name;
  final String category;
  final String scheduledDate;
  final String importance; // High, Medium, Low
  final String? description;

  const FinancialCalendarEvent({
    required this.id,
    required this.name,
    required this.category,
    required this.scheduledDate,
    required this.importance,
    this.description,
  });
}

/// Banking alert or notification.
class BankingAlert {
  final String id;
  final String title;
  final String message;
  final String type; // Warning, Info, Error, Important, Maintenance
  final String severity; // Critical, High, Medium, Low
  final String sourceBank; // Bank name or 'SBP' or 'System'
  final String issuedDate;
  final String? expiryDate;
  final bool read;
  final String? action; // URL or action to take

  const BankingAlert({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.severity,
    required this.sourceBank,
    required this.issuedDate,
    this.expiryDate,
    required this.read,
    this.action,
  });
}

/// State Bank of Pakistan Monetary Policy Rate data
class MonetaryPolicyRateData {
  final double rate; // Current MPR
  final double? previous; // Previous rate
  final double? change; // Change from previous
  final String effectiveDate; // When rate takes effect
  final String? announcedDate; // When rate was announced
  final String? nextReviewDate; // When next rate decision
  final String? policyStatement; // URL or brief of policy
  final String lastUpdated;

  const MonetaryPolicyRateData({
    required this.rate,
    this.previous,
    this.change,
    required this.effectiveDate,
    this.announcedDate,
    this.nextReviewDate,
    this.policyStatement,
    required this.lastUpdated,
  });
}

/// Graduate program/scheme information from banks and financial institutions.
class GraduateProgram {
  final String id;
  final String title;
  final String bank;
  final String description;
  final String? duration; // e.g., "2 years"
  final String? salary;
  final List<String>? eligibility; // List of eligibility criteria
  final String postedDate;
  final String? deadline;
  final String? applyUrl; // Link to apply

  const GraduateProgram({
    required this.id,
    required this.title,
    required this.bank,
    required this.description,
    this.duration,
    this.salary,
    this.eligibility,
    required this.postedDate,
    this.deadline,
    this.applyUrl,
  });
}

/// Internship program information from banks.
class InternshipProgram {
  final String id;
  final String title;
  final String bank;
  final String description;
  final String duration; // e.g., "3 months", "6 months"
  final String? stipend; // Optional stipend
  final List<String>? requirements; // List of requirements
  final String? department; // Target department
  final String postedDate;
  final String? deadline;
  final String? applyUrl; // Link to apply

  const InternshipProgram({
    required this.id,
    required this.title,
    required this.bank,
    required this.description,
    required this.duration,
    this.stipend,
    this.requirements,
    this.department,
    required this.postedDate,
    this.deadline,
    this.applyUrl,
  });
}

/// Money Transfer Organization (MTO) information and services.
class MoneyTransferOrganization {
  final String id;
  final String name;
  final String? logo;
  final String? website;
  final List<String> countries; // List of countries supported
  final String? minAmount;
  final String? maxAmount;
  final String? fee;
  final String? exchangeRate;
  final String? transferTime; // e.g., "Within 1 hour", "1-2 business days"
  final String? registeredWith; // e.g., "State Bank of Pakistan"
  final String lastUpdated;

  const MoneyTransferOrganization({
    required this.id,
    required this.name,
    this.logo,
    this.website,
    required this.countries,
    this.minAmount,
    this.maxAmount,
    this.fee,
    this.exchangeRate,
    this.transferTime,
    this.registeredWith,
    required this.lastUpdated,
  });
}

