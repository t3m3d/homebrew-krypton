cask "brain" do
  version "0.11.0"
  sha256 "bdf465cbede9a937a12e58424f85ee495ee0059dd69a9cdcba9df7ffd8209a09"

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
