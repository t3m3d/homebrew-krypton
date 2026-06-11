cask "stem" do
  version "0.11.11"
  sha256 "4a790f5fb0430f3774a6ed7b3cac781b0166c5b58fb41f82b4b26dc8cf4c9277"

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
