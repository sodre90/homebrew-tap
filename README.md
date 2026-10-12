# sodre90/tap

Homebrew casks for [Mirador](https://github.com/sodre90/mirador), on macOS (Apple Silicon) and Linux (x64, arm64):

```bash
brew install --cask sodre90/tap/mirador
```

The app updates itself, so `brew upgrade` leaves it alone. On Linux, install the libraries it needs first; Homebrew prints the `apt` and `dnf` commands.

`Casks/mirador.rb` is generated with `make cask` in the Mirador repository, for each release.
