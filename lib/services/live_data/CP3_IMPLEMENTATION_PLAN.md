# Phase 7 Checkpoint 3 - Real API Integration Plan

**Status:** PLANNING PHASE  
**Date:** June 2026  
**Scope:** Connect all 9 live data services to official data sources

---

## Official Data Sources & Implementation Strategy

### Service 1: Exchange Rates ✅ (ALREADY LIVE - CP2 Sprint 1)

**Status:** Live API implemented  
**API Source:** exchangerate-api.com  
**Endpoint:** https://api.exchangerate-api.com/v4/latest/USD  
**Free Tier:** 1500 requests/month  
**Currency Pairs:** USD/PKR, EUR/PKR, GBP/PKR, SAR/PKR, AED/PKR  
**Cache TTL:** 1 hour  
**Metadata:**
- Source Name: exchangerate-api.com
- Source URL: https://exchangerate-api.com
- Verification: Official public API
- Last Verified: CP2 Sprint 1

### Service 2: Gold Prices ✅ (ALREADY LIVE - CP2 Sprint 1)

**Status:** Live API implemented  
**API Source:** metals.live  
**Endpoint:** https://api.metals.live/v1/spot/gold  
**Free Tier:** Unlimited  
**Units:** Price per gram, tola, ounce (in PKR)  
**Cache TTL:** 2 hours  
**Metadata:**
- Source Name: metals.live
- Source URL: https://metals.live
- Verification: Official commodity prices
- Last Verified: CP2 Sprint 1

---

## Services Requiring Live API Implementation

### Service 3: KIBOR (Karachi Interbank Offered Rate)

**Current State:** Framework ready, placeholder active  
**Target:** Enhance with SBP data source  
**Data Source Options:**

**Option A - SBP Official Website (PRIMARY)**
- Source: https://www.sbp.org.pk/m_mrt/kibor-rates.asp
- Format: HTML page with daily rates
- Implementation: Parse HTML or use SBP RSS feed
- Update Frequency: Daily (around 1 PM PKT)
- Tenors: 1D, 1W, 1M, 3M, 6M, 12M

**Option B - Banking APIs**
- Some banks publish KIBOR rates via their developer APIs
- Would need to aggregate from multiple sources

**Selected Implementation:** Option A - SBP official HTML page parsing  
**Cache TTL:** 1 hour  
**Fallback:** Existing placeholder with 6 tenors

---

### Service 4: Banking News

**Current State:** Placeholder with 3 sample articles  
**Target:** Official banking news sources  
**Data Source Options:**

**Option A - RSS Feeds (PRIMARY)**
- SBP Press Releases: https://www.sbp.org.pk/rss/rss.xml
- Financial Times Pakistan: https://markets.ft.com/data/rss/worldmarkets
- Dawn News Business: https://www.dawn.com/feed/rss/business

**Option B - NewsAPI.org**
- Free tier: 500 requests/day
- Query: "banking Pakistan" + filters
- Cost: Free for hobby use

**Option C - Official Bank News**
- HBL: https://www.hbl.com/en/news
- UBL: https://www.ublfunds.com/News-Details
- NBP: https://www.nbp.com.pk/News.asp

**Selected Implementation:** 
1. Primary: SBP RSS feed for official circulars
2. Fallback: NewsAPI for general banking news
3. Cache TTL: 1 hour

---

### Service 5: SBP Circulars

**Current State:** Placeholder with 3 sample circulars  
**Target:** SBP official circulars  
**Data Source:**

**SBP Official Source (PRIMARY)**
- Main: https://www.sbp.org.pk/divisions/other/circulars/index.html
- RSS: https://www.sbp.org.pk/rss/rss.xml
- PDF Downloads: https://www.sbp.org.pk/divisions/other/circulars/

**Implementation Strategy:**
1. Parse SBP circulars RSS feed
2. Extract: Title, Link, Date, Content
3. Filter: Only banking-related circulars
4. Cache TTL: 6 hours (slower update frequency)

**Metadata:**
- Source: State Bank of Pakistan (Official)
- URL: https://www.sbp.org.pk
- Verification: Official regulatory source

---

### Service 6: Bank Holidays

**Current State:** Placeholder with 4 sample holidays  
**Target:** Official banking holiday calendars  
**Data Source Options:**

**Option A - SBP Official Calendar (PRIMARY)**
- Source: https://www.sbp.org.pk
- Format: Announced at year start
- Update: Annually (November for next year)

**Option B - Banking Association**
- Pakistan Banks Association: https://www.pba.org.pk/

**Option C - Government Calendar**
- Ministry of Finance: https://www.finance.gov.pk
- Contains national holidays

**Selected Implementation:**
1. Hardcode verified 2024-2026 holidays from SBP
2. Parse government calendar for future holidays
3. Cache TTL: 30 days (rarely changes)

**Data Quality:**
- All holidays verified from official SBP announcements
- Include both national and banking holidays

---

### Service 7: Bank Jobs

**Current State:** Placeholder with 3 sample jobs  
**Target:** Official bank job postings  
**Data Source Options:**

**Option A - Bank Websites (PRIMARY)**
- HBL Careers: https://careers.hbl.com
- UBL Careers: https://www.ubl.com.pk/careers
- NBP Careers: https://www.nbp.com.pk/career.asp
- Silkbank: https://silkbank.com.pk/careers/

**Option B - Job Portals**
- LinkedIn Jobs API: Requires official access
- Rozee.pk: Pakistani job portal
- Pakistan Jobs: https://www.pakistan.gov.pk (government jobs)

**Selected Implementation:**
1. Parse bank career pages (API not available)
2. Filter: Banking sector positions
3. Cache TTL: 6 hours (changes frequently)
4. Data: Title, Bank, Location, Type, Posted, Deadline

---

### Service 8: Financial Calendar

**Current State:** Placeholder with 5 sample events  
**Target:** Official economic calendar  
**Data Source Options:**

**Option A - Public Economic Calendars (PRIMARY)**
- ForexFactory: https://www.forexfactory.com/calendar.php
- Investing.com: https://www.investing.com/economic-calendar/
- TradingView: https://www.tradingview.com/economic-calendar/

**Option B - SBP Events**
- Policy Dates: https://www.sbp.org.pk
- Announcement Schedule: Predictable quarterly

**Option C - Global Events**
- Federal Reserve: https://www.federalreserve.gov/
- ECB: https://www.ecb.europa.eu/

**Selected Implementation:**
1. Parse public economic calendar for key dates
2. Focus on: SBP decisions, inflation, GDP, major Fed announcements
3. Cache TTL: 12 hours (schedule is relatively stable)

---

### Service 9: Banking Alerts

**Current State:** Placeholder with 5 sample alerts  
**Target:** Real banking system alerts  
**Data Source:**

**Official Sources:**
- SBP Notifications: https://www.sbp.org.pk/announcements/
- Bank Circulars: Already covered in Service 5
- System Alerts: Bank maintenance windows

**Implementation Strategy:**
1. Parse SBP announcements for critical alerts
2. Add system maintenance information
3. Cache TTL: 15 minutes (frequently updated)
4. Categories: Critical, High, Medium, Low severity

---

## Implementation Sequence

### Phase 1: High Priority (CP3 Sprint 1)
- KIBOR: Implement SBP page parsing
- Banking News: Implement RSS feed parsing
- Bank Holidays: Enhance with verified official data

### Phase 2: Medium Priority (CP3 Sprint 2)
- SBP Circulars: Implement RSS feed parsing
- Banking Alerts: Implement SBP announcements

### Phase 3: Low Priority (CP3 Sprint 3)
- Bank Jobs: Bank website parsing (if feasible)
- Financial Calendar: Calendar API integration

---

## Metadata Implementation

Every response will include:

```dart
{
  "sourceName": "State Bank of Pakistan",
  "sourceUrl": "https://www.sbp.org.pk",
  "retrievedDate": "2026-06-27T14:30:00Z",
  "lastVerifiedDate": "2026-06-27T14:30:00Z",
  "verificationStatus": "verified",
  "isCached": false,
  "lastUpdatedTimestamp": "2026-06-27T14:30:00Z",
  "cacheDuration": 3600,
  "notes": "Data from official SBP regulatory source"
}
```

---

## Error Handling & Fallback Strategy

```
Request Flow:
1. Check Cache (TTL-based expiration)
   ├─ If Fresh: Return cached data
   └─ If Expired: Try live API

2. Attempt Live API Call
   ├─ On Success: Update cache, return data
   ├─ On Timeout (10s): Try cache fallback
   ├─ On Network Error: Try cache fallback
   ├─ On Parse Error: Try cache fallback
   └─ On API Error: Try cache fallback

3. Try Cache (Without TTL check)
   ├─ If Available: Return stale cached data with flag
   └─ If None: Use placeholder

4. Ultimate Fallback: Placeholder Data
   ├─ Always succeeds
   ├─ Indicates placeholder state
   └─ App continues working
```

---

## Validation Checklist

### Code Quality
- [ ] 0 issues in `flutter analyze --no-pub`
- [ ] All tests pass: `flutter test --no-pub`
- [ ] 100% null safety maintained
- [ ] 100% type safety maintained
- [ ] Zero code duplication

### API Integration
- [ ] All 9 services have live API framework
- [ ] Fallback chain complete for all services
- [ ] Metadata included in all responses
- [ ] Source tracking working correctly
- [ ] Cache invalidation working

### Backward Compatibility
- [ ] No breaking changes
- [ ] Existing screens unmodified
- [ ] Dashboard integration maintained
- [ ] Premium UI preserved
- [ ] Navigation unchanged

### Documentation
- [ ] All sources documented
- [ ] API endpoints documented
- [ ] Metadata structure documented
- [ ] Error handling documented

---

## Success Criteria

✅ All 9 services connected to official data sources  
✅ Comprehensive metadata included  
✅ Complete fallback chain maintained  
✅ 0 issues in flutter analyze  
✅ All tests passing  
✅ 100% backward compatible  
✅ Production-ready code

---

**Next Step:** Begin Phase 1 implementation with KIBOR, News, and Holidays services.
