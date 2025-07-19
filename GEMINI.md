# Gemini CLI and Flutter Tarot App Project

## 1. Project Overview & Goals

This project aims to develop a **Flutter-based Tarot card application** that provides users with insightful readings. My main goal is to create dynamic, personalized tarot card interpretations using the **Gemini API**.

### Key Features:

- **Card Shuffling & Drawing:** Users will be able to "shuffle" and draw a certain number of cards (e.g., 3-card spread, Celtic Cross).
- **Personalized Readings:** Based on the drawn cards and a user's specific question, the Gemini API will generate a unique interpretation.
- **Card Details:** Users can tap on individual cards to view their upright and reversed meanings.
- **Question Input:** A clear interface for users to input their questions before drawing cards.
- **Reading History (Optional):** Potentially save past readings for future reference.

### Gemini CLI / API Integration Plan:

I plan to use Gemini to:

- **Generate Tarot Interpretations:** Provide the drawn cards (e.g., "The Fool upright, The Magician reversed, The High Priestess upright") and the user's question as a prompt to Gemini, and receive a comprehensive interpretation.
- **Potentially Refine Meanings:** Enhance existing card meanings with more nuanced interpretations based on context.

## 2. Technical Stack & Environment

- **Flutter Version:** 3.19.6 (or latest stable)
- **Dart Version:** 3.3.4 (or latest stable)
- **IDE:** Visual Studio Code

### Planned Flutter Packages:

- `http`: For making API calls to Gemini.
- `provider` or `bloc`: For state management.
- `shared_preferences`: For local data storage (e.g., user settings, reading history).
- `carousel_slider`: For displaying cards in a horizontal scrollable format.

## 3. Data & Content Management

- **Tarot Card Data:** I will use the **Rider-Waite Tarot deck**. I plan to store card images locally within the app's assets, and card names (e.g., "The Fool"), upright meanings, and reversed meanings in a local JSON file.
- **Interpretation Data:** The primary source of interpretations will be the **Gemini API**. I will design prompts that include the specific cards drawn, their orientation (upright/reversed), and the user's question to elicit relevant and insightful readings.

### Example Gemini Prompt Idea:

"As an experienced Tarot reader, provide a concise and insightful interpretation for a 3-card spread. The user's question is: [User's Question]. The cards drawn are: [Card 1 Name (Orientation)], [Card 2 Name (Orientation)], [Card 3 Name (Orientation)]. Focus on providing guidance and clarity."

## 4. UI/UX Considerations

I aim for a **clean, intuitive, and visually appealing user interface**. Key aspects include:

- **Smooth Card Animations:** Engaging animations for shuffling and drawing cards.
- **Clear Readability:** Easy-to-read text for card meanings and interpretations.
- **Minimalist Design:** Focus on the core functionality without unnecessary clutter.

### I primarily need assistance with:

- **Gemini API Integration:** Best practices and example code for calling the Gemini API from a Flutter app, specifically for text generation.
- **Prompt Engineering:** Advice on how to structure effective prompts for generating Tarot interpretations that are both accurate and engaging.
- **App Architecture:** Guidance on structuring the Flutter project to effectively manage data, state, and API interactions.

---
