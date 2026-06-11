cask "stem" do
  version "0.3.0"
  sha256 "1e5a72fb71772943346e04284cf41fbabc6d6223cd5f9390dbabdc4972ca9739"

  url "https://github.com/t3m3d/stem/releases/download/#{version}/stem-#{version}.dmg"
  name "stem"
  desc "Pure-Krypton terminal (zsh, p10k, true color) on the objk FFI"
  homepage "https://github.com/t3m3d/stem"

  depends_on arch: :arm64

  app "stem.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/stem.app"]
  end
end
