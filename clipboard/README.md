# Clipboard

TIL how to copy to clipboard in Elm.

## Make

```bash
elm make src/Main.elm --output=dist/main.js
```

## How it work

Use ports and call javascript to copy to clipboard.
The `copyInput` copies the text in the `input` (or `textarea` is available).
The `copyString` copies any text by creating a temporalry DOM element.