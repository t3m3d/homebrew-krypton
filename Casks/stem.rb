cask "stem" do
  version "0.8.2"
  sha256 "4acd9d7a24a1145889c8b2b596b3807332e2f56890c86c494cd3c05e1d4c9436"

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
