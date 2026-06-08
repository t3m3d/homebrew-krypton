cask "kryoterm" do
  version "1.1.0"
  sha256 "23ddc10a9a6264f538dc36bf562b3f6707da78055d1c51ceca3fa4d549ca268a"

  url "https://github.com/t3m3d/kryoterm/releases/download/#{version}/kryoterm-#{version}-macos.app.zip"
  name "kryoterm"
  desc "Pure-Krypton terminal emulator (clickable .app)"
  homepage "https://github.com/t3m3d/kryoterm"

  depends_on arch: :arm64

  app "kryoterm.app"

  caveats <<~EOS
    kryoterm.app is ad-hoc signed (not notarized). First launch:
    right-click the app -> Open, or run:  xattr -dr com.apple.quarantine "/Applications/kryoterm.app"
  EOS
end
