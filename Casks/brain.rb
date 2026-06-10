cask "brain" do
  version "0.8.3"
  sha256 "d909274375243784de5912774344be1b25ce036ac19821e586dec095721f048d"

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
