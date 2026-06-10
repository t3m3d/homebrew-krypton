cask "brain" do
  version "0.8.2"
  sha256 "be7a0ac613a9b86e5430dd96553e66dcd109068d4472437d4fcbfa8a4876aaf6"

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
