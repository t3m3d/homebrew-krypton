cask "brain" do
  version "0.5.3"
  sha256 "4096ba3c107d86c56adb7b648af891c56beb80f4d668db5670f9fcbfc6d33cfb"

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
