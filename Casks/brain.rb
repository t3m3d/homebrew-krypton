cask "brain" do
  version "0.12.2"
  sha256 "913b123705cbf4ea9a11e7c4ddd0f38adbb9a9d98f82c6fc0d3435b0516ec89f"

  url "https://github.com/t3m3d/brain/releases/download/#{version}/brain-#{version}.dmg"
  name "brain"
  desc "Pure-Krypton macOS IDE (editor, tree, tabs, live highlighting) on the objk FFI"
  homepage "https://krypton-lang.org/programs/brain.html"

  depends_on arch: :arm64

  app "brain.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/brain.app"]
  end
end
