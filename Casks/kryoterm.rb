cask "kryoterm" do
  version "1.0.0"
  sha256 "ba8e7c2e05f283b708ca747f6bdac83f30cb6911e5ba408b12f802120c7c2bfc"

  url "https://github.com/t3m3d/kryoterm/releases/download/#{version}/kryoterm-#{version}-macos.app.zip"
  name "kryoterm"
  desc "Pure-Krypton terminal emulator (clickable .app)"
  homepage "https://github.com/t3m3d/kryoterm"

  depends_on arch: :arm64

  app "kryoterm.app", target: "/Applications/Utilities/kryoterm.app"

  caveats <<~EOS
    kryoterm.app is ad-hoc signed (not notarized). First launch:
    right-click the app -> Open, or run:  xattr -dr com.apple.quarantine "/Applications/kryoterm.app"
  EOS
end
