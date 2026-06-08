cask "kryoterm" do
  version "1.1.0"
  sha256 "55964c742444412bf3b796c29233439146819fd6ecdf9b24370382452dba6261"

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
