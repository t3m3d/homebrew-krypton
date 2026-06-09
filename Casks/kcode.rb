cask "kcode" do
  version "0.3.0"
  sha256 "99876f6ec09dc5af08a207331356f6c82fa72d41de5441f6445b2ca2ac239e7f"

  url "https://github.com/t3m3d/kcode/releases/download/#{version}/kcode-#{version}-macos.app.zip"
  name "kcode"
  desc "Native macOS IDE for Krypton + 80+ languages"
  homepage "https://github.com/t3m3d/kcode"

  depends_on arch: :arm64

  app "kcode.app"

  # ad-hoc signed (not notarized) -> strip quarantine so it launches on Tahoe
  postflight do
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "/Applications/kcode.app"]
  end

  caveats <<~CAV
    kcode.app is ad-hoc signed (not notarized). The installer strips the quarantine
    flag so it launches directly. If macOS still blocks it: System Settings ->
    Privacy & Security -> "Open Anyway", or:
      xattr -dr com.apple.quarantine "/Applications/kcode.app"
  CAV
end
