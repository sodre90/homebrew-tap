cask "mirador" do
  version "0.15.2"
  sha256 arm:          "972658d75f053c301f490ad8f09163ec3e7ca3ddfec0cc7f8d43af1923968365",
         arm64_linux:  "f6fc6b57e936fbc6d366dfd3e59a4c510f904782e8e1ee1e772cf03235eda194",
         x86_64_linux: "48cde1e3432e36e7a8296069239c8f0977bd64405316c3b981fd4f03664c0588"

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
