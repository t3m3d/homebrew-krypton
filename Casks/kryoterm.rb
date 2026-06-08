cask "kryoterm" do
  version "1.1.0"
  sha256 "d04029b69724843e4d3f2b3fc7ac78f91e13d0b9db56231511b8f8498122018d"

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
