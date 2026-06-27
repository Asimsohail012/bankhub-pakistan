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
