cask "stem" do
  version "0.2.2"
  sha256 "be471cc57cde41db07a959e56613b00a435388cb6178a1105d0d1e1a48f70eec"

  url "https://github.com/t3m3d/stem/releases/download/#{version}/stem-#{version}-macos.app.zip"
  name "stem"
  desc "Pure-Krypton terminal (zsh, p10k, true color) on the objk FFI"
  homepage "https://github.com/t3m3d/stem"

  depends_on arch: :arm64

  app "stem.app"

  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/stem.app"]
  end

  caveats <<~CAV
    stem.app is ad-hoc signed (not notarized). The installer strips the quarantine
    flag so it launches directly. If macOS still blocks it: System Settings ->
    Privacy & Security -> "Open Anyway", or:
      xattr -dr com.apple.quarantine "/Applications/stem.app"
  CAV
end
