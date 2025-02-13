# Tutorial Renderer System

This folder contains a **modular tutorial renderer** for a Flutter application. It allows you to define a lesson using a JSON file with various "chunk" types, then automatically renders it as a linear sequence of widgets. This includes support for text, headers, images, bullet lists, charts, and even side-by-side layouts.

## Features

- **Headers**: Large, bold text chunks for titles and subheadings.
- **Text**: Standard paragraph text for main content.
- **Images**: Load from Flutter assets (or can be extended to network URLs).
- **Bullet Lists**: Display multiple items in a list format.
- **Charts**: Stubbed as placeholders here, but easy to integrate with charting libraries.
- **Side-by-Side Layout**: For horizontally placed content (e.g., text next to image, or chart next to text).

## JSON Structure

Below is an example JSON structure (`tutorial.json`):

```jsonc
{
  "lessonTitle": "Advanced Humanities Topics",
  "lessonChunks": [
    {
      "type": "header",
      "content": "Chapter 1: The Renaissance"
    },
    {
      "type": "text",
      "content": "The Renaissance was a vibrant period of European cultural, ... "
    },
    {
      "type": "image",
      "url": "assets/images/renaissance_art.png"
    },
    {
      "type": "bullet_list",
      "items": ["Leonardo da Vinci", "Michelangelo", "Raphael"]
    },
    {
      "type": "chart",
      "chartType": "bar",
      "data": {
        "labels": ["1500", "1550", "1600"],
        "values": [10, 25, 40]
      },
      "description": "Growth of Renaissance Art Over Years"
    },
    {
      "type": "side_by_side",
      "leftChunk": {
        "type": "text",
        "content": "Printing press revolution..."
      },
      "rightChunk": {
        "type": "image",
        "url": "assets/images/printing_press.png"
      }
    }
  ]
}
# semester_app_deneme
