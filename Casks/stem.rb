cask "stem" do
  version "0.12.5"
  sha256 "244ac9ce658c16805097695de39c01fd29b7ee1498ce2352632dce63f3a2b530"

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
