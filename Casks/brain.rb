cask "brain" do
  version "0.6.1"
  sha256 "9b66d1a08cfbbcf12f4579029ce0a60a51b57eae6a4a6cddb5d4e04e8ce0d57e"

  url "https://github.com/t3m3d/krypton/releases/download/brain-#{version}/brain-#{version}.dmg"
  name "brain"
  desc "Pure-Krypton macOS IDE (editor, tree, tabs, live highlighting) on the objk FFI"
  homepage "https://krypton-lang.org/programs/brain.html"

  depends_on arch: :arm64

  app "brain.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/brain.app"]
  end
end
