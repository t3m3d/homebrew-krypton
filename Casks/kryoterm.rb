cask "kryoterm" do
  version "1.4.0"
  sha256 "b5020995c648544c9e34df91fe805310ef32e5902c95ac539d95775e8c54e9f5"

  url "https://github.com/t3m3d/kryoterm/releases/download/#{version}/kryoterm-#{version}-macos.app.zip"
  name "kryoterm"
  desc "Pure-Krypton terminal emulator (clickable .app)"
  homepage "https://github.com/t3m3d/kryoterm"

  depends_on arch: :arm64

  app "kryoterm.app"

  # Ad-hoc signed (not notarized) -> on macOS Sequoia/Tahoe the Gatekeeper popup
  # has no "Open" button. Strip the quarantine flag on install so it just launches.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/kryoterm.app"]
  end

  caveats <<~EOS
    kryoterm.app is ad-hoc signed (not notarized). The installer strips the
    quarantine flag so it launches directly. If macOS still blocks it:
    System Settings -> Privacy & Security -> "Open Anyway", or run:
      xattr -dr com.apple.quarantine "/Applications/kryoterm.app"
  EOS
end
