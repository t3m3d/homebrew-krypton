cask "brain" do
  version "0.3.0"
  sha256 "50b49b9a2478722bd92a8a4027c5b0b22e06cc0d7927e1b1b61c2bce7bbb6506"

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
