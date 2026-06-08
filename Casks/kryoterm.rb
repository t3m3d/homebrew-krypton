cask "kryoterm" do
  version "1.1.0"
  sha256 "adadfcf61c11a8f2c4427bc536eaa88e5788acf1c8925b6670ecdce7449ec62e"

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
