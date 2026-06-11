cask "stem" do
  version "0.12.2"
  sha256 "806d963c7b15940b08c3a8ae34b4e6c770cbc4a7c9c1e455a1f7ade3802415ed"

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
