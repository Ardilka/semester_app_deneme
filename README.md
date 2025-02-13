# 📖 Tutorial Renderer System  
*A Modular System for Displaying Educational Content in Flutter*

## 🚀 Introduction
The **Tutorial Renderer System** is a **flexible, JSON-driven** solution for presenting **educational lessons** inside a Flutter application.  

This system allows **dynamic tutorials** with text, images, bullet lists, charts, and side-by-side layouts without needing to modify the app’s code.  

With this approach:
- **Lessons are fetched dynamically from an API or online JSON source**, rather than being stored locally.
- The system **renders lessons dynamically**, meaning **no hardcoded UI elements**.
- It follows a **modular structure**, making it **expandable** (quizzes, videos, interactive content, etc.).
- Lessons are organized into a **course pathway**, guiding users through structured learning.

---

## 📜 1. JSON Format for Tutorials
Each tutorial follows a **structured JSON format** consisting of:
- A **lesson title**  
- A **list of chunks** (different content types)

### 📌 Supported JSON Chunk Types
| **Type**        | **Description**                                        | **Example JSON** |
|----------------|--------------------------------------------------------|-------------|
| `header`       | Section titles                                          | `{ "type": "header", "content": "Introduction" }` |
| `text`         | Paragraphs of explanation                              | `{ "type": "text", "content": "This is a paragraph..." }` |
| `image`        | Image from a URL                                        | `{ "type": "image", "url": "https://example.com/image.jpg" }` |
| `bullet_list`  | A list of bullet points                                | `{ "type": "bullet_list", "items": ["Item 1", "Item 2"] }` |
| `chart`        | Line, bar, or pie chart with numerical data            | `{ "type": "chart", "chartType": "bar", "data": {...}, "description": "Some chart", "unit": "Millions" }` |
| `side_by_side` | Two elements displayed next to each other (text + image, text + chart, etc.) | `{ "type": "side_by_side", "leftChunk": {...}, "rightChunk": {...} }` |

---

## 📘 2. Example JSON for a Tutorial

### 🎯 Lesson: "Introduction to the Renaissance"
This example includes **headers, text, images, bullet lists, and charts**.

```json
{
  "lessonTitle": "Introduction to the Renaissance",
  "lessonChunks": [
    {
      "type": "header",
      "content": "What is the Renaissance?"
    },
    {
      "type": "text",
      "content": "The Renaissance was a period of immense cultural growth..."
    },
    {
      "type": "image",
      "url": "https://example.com/images/renaissance_intro.jpg"
    },
    {
      "type": "bullet_list",
      "items": [
        "Started in the 14th century",
        "Revival of Greek and Roman knowledge",
        "Major figures: Da Vinci, Michelangelo"
      ]
    },
    {
      "type": "chart",
      "chartType": "bar",
      "data": {
        "labels": ["15th", "16th", "17th", "18th", "19th"],
        "values": [20, 175, 500, 1000, 2500]
      },
      "description": "Estimated Number of Books Produced (Millions per Century)",
      "unit": "Millions"
    }
  ]
}
📑 3. Expanding the System
📌 Adding More Content Types
This system is modular and can be expanded to support more interactive elements such as:

Quizzes (multiple-choice, true/false, fill-in-the-blank)
Embedded videos (YouTube links, local files)
Code examples (for coding-related lessons)
📘 Example: Adding a Multiple-Choice Question

{
  "type": "quiz",
  "quizType": "multiple_choice",
  "question": "Who painted the Mona Lisa?",
  "options": [
    "Leonardo da Vinci",
    "Michelangelo",
    "Raphael",
    "Donatello"
  ],
  "correctAnswer": "Leonardo da Vinci"
}
This will allow users to select an answer and receive feedback.

📖 4. Organizing Lessons into a Course Pathway
A course consists of multiple tutorials. These tutorials are fetched from an online API or remote JSON source.

📘 Example JSON for Course Pathway

[
  {
    "file": "https://example.com/api/tutorials/tutorial1.json",
    "title": "Introduction to the Renaissance"
  },
  {
    "file": "https://example.com/api/tutorials/tutorial2.json",
    "title": "Key Figures and Artists"
  },
  {
    "file": "https://example.com/api/tutorials/tutorial3.json",
    "title": "Science and Technology"
  },
  {
    "file": "https://example.com/api/tutorials/tutorial4.json",
    "title": "Cultural and Societal Shifts"
  },
  {
    "file": "https://example.com/api/tutorials/tutorial5.json",
    "title": "The Renaissance Legacy"
  }
]
This allows the lesson titles to be dynamically displayed instead of manually written.

📜 5. Summary
JSON-based tutorials for easy content updates
Modular system (headers, text, images, charts, quizzes, and more)
Lessons are fetched dynamically from an API or remote storage
Course pathway to navigate lessons sequentially
Expandable (quizzes, interactive elements, videos, and more)

This version maintains **consistent Markdown formatting** and ensures that all content is **clearly structured and properly formatted for `README.md`**. 🚀