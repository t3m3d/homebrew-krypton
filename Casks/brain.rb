cask "brain" do
  version "0.13.0"
  sha256 "42ed06cb3dcee1485d4f9c42e333b5bab98f6f8c9cdea9aca190eae296aa6f01"

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
