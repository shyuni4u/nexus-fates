# CLAUDE - AI Tarot Mobile App

## Project Overview

CLAUDE is a Flutter-based cross-platform mobile application that provides in-depth tarot card interpretations powered by Gemini AI. The app combines an advertising monetization model with a premium subscription service to generate stable revenue streams, utilizing Supabase's fully serverless architecture to deliver fast and reliable services.

## Core Features

### Tarot Reading System

**Spread Configuration**

- **Spread Type**: Celtic Cross (fixed)
- **Card Count**: 10 cards (fixed)

**User Interaction Flow**

- **Question Input**: Users can enter their questions within a 200-token limit, with input examples and character counter provided
- **Card Shuffling & Selection**: Users automatically draw 10 cards from a shuffled deck, arranged in Celtic Cross positions
- **AI Interpretation**: Based on selected cards and user questions, Supabase Edge Functions call the Gemini API to generate comprehensive interpretations displayed in the app

### Monetization & Advertising

**Revenue Streams**

- **Rewarded Video Ads**: Primary revenue source using "Watch Ad to View Reading" model
- **Interstitial Ads**: Secondary exposure after reading completion or app exit
- **Native Ads**: Naturally integrated into card description pages and supplementary content
- **Premium Subscription**: Ad-free unlimited readings through in-app purchases

### Data Management

**Authentication & Storage**

- **Supabase Auth**: Support for email, social login, and anonymous login
- **Supabase Database**: User-specific reading history (questions, card arrangements, AI interpretations) and subscription status storage

## Technical Stack

### Frontend

- **Framework**: Flutter (Dart)
- **Key Packages**:
  - `google_mobile_ads` (advertising)
  - `supabase_flutter` (authentication/database)
  - `dio` or `http` (Edge Function calls)

### Backend (Serverless)

- **Supabase Edge Functions**: Handle Gemini API calls while maintaining API key security
- **Supabase Database**: Store user reading records and subscription information
- **Supabase Auth**: Manage user authentication

### Advertising & Payments

- **Google AdMob SDK**: Rewarded, Interstitial, and Native Ads
- **In-App Purchases**: Google Play Billing & Apple In-App Purchase for premium subscriptions

## Success Metrics

### User Engagement

- App installations and active users (DAU/MAU)
- App store ratings and review scores

### Revenue Performance

- Video Completion Rate (VCR) and eCPM for advertisements
- Total revenue from advertising and subscriptions
- Premium subscription conversion rate

## Constraints & Considerations

### Compliance & Policy

- Adherence to Google AdMob policies and app store review guidelines
- Privacy policy establishment and data encryption implementation

### Cost Management

- Monitoring Supabase and Gemini API usage costs
- Optimizing serverless function calls

## Initial Development Plan

### Phase 1: Foundation Setup

1. Create Flutter project and set up development environment
2. Build Supabase project: Design Auth and Database schema
3. Develop Supabase Edge Functions: Implement Gemini API call logic

### Phase 2: Integration & Monetization

4. Integrate AdMob SDK and implement test advertisements
5. Implement in-app purchase integration and subscription management logic

### Phase 3: UI/UX & Deployment

6. Design Celtic Cross 10-card spread UI/UX (Figma)
7. Develop MVP and deploy beta version to app stores

## Architecture Benefits

- **Serverless Architecture**: Reduced infrastructure management overhead
- **Cross-Platform**: Single codebase for iOS and Android
- **Scalable**: Supabase handles backend scaling automatically
- **Secure**: API keys protected through Edge Functions
- **Cost-Effective**: Pay-per-use model with Supabase and Gemini API
