cask "mirador" do
  version "0.11.0"
  sha256 arm:          "083c1fcf646cc74c6ee0a8eaa43f9a47bde03ea68fc8251b142a746826ad40f2",
         arm64_linux:  "e505bd0e035e394ab756a313e4e46db97f18a7bd11cabf381773287cd417a8f1",
         x86_64_linux: "cc0f0e25e1a857d4f9d74474c75a536d7be6bf810c8e2bd7594ee36eaac75673"

  on_macos do
    url "https://github.com/sodre90/mirador/releases/download/v#{version}/Mirador-macos-arm64.zip"

    depends_on arch: :arm64

    app "Mirador.app"

    uninstall launchctl: [
                "com.sodre90.mirador.host.4600",
                "com.sodre90.mirador.open-at-login.4600",
              ],
              quit:      "com.sodre90.mirador"

    zap trash: [
      "~/Library/Application Support/com.sodre90.mirador",
      "~/Library/Preferences/com.sodre90.mirador.plist",
      "~/Library/WebKit/com.sodre90.mirador",
    ]
  end
  on_linux do
    arch arm: "arm64", intel: "x64"

    url "https://github.com/sodre90/mirador/releases/download/v#{version}/Mirador-linux-#{arch}-Setup.tar.gz"

    installer script: {
      executable: "installer",
    }

    uninstall script: {
                executable:   "pkill",
                args:         ["-f", "#{Dir.home}/.local/share/com.sodre90.mirador/stable/app/bin/"],
                must_succeed: false,
              },
              trash:  [
                "~/.config/autostart/mirador-*.desktop",
                "~/.local/share/applications/Mirador.desktop",
                "~/.local/share/com.sodre90.mirador/stable/.electrobun-uninstall.json",
                "~/.local/share/com.sodre90.mirador/stable/app",
                "~/.local/share/com.sodre90.mirador/stable/self-extraction",
                "~/.local/share/com.sodre90.mirador/stable/uninstall",
              ]

    zap trash: [
      "~/.cache/com.sodre90.mirador",
      "~/.local/share/com.sodre90.mirador",
    ]

    caveats <<~EOS
      Mirador needs glibc 2.36 or newer (Ubuntu 24.04, Debian 12, Fedora 37 or later),
      and GTK 3, WebKitGTK 4.1, Ayatana AppIndicator and librsvg:
        sudo apt install libgtk-3-0 libwebkit2gtk-4.1-0 libayatana-appindicator3-1 librsvg2-2   # Debian, Ubuntu
        sudo dnf install gtk3 webkit2gtk4.1 libayatana-appindicator-gtk3 librsvg2              # Fedora

      Before you uninstall, turn off Run host in the background in the app's tray menu.
    EOS
  end

  name "Mirador"
  desc "Canvas for coding agents to draw, ask and review beside the conversation"
  homepage "https://mirador.sodre90.com/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
end
