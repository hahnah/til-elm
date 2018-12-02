# Flags

Sample code using [Flags](https://guide.elm-lang.org/interop/flags.html).

`init` function in `src/Main.elm` (`dist/main.js`) receives and handles `flags`, which is from `index.html`.

```html
<body>
  <div id="elm"></div>
  <script>
  var app = Elm.Main.init({
    node: document.getElementById('elm'),
    flags: 4  <!-- THIS IS FLAG(S) -->
  });
  </script>
</body>
```

## License

MIT © [hahnah](https://superhahnah.com)