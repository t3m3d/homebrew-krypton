cask "kryoterm" do
  version "1.1.0"
  sha256 "55964c742444412bf3b796c29233439146819fd6ecdf9b24370382452dba6261"

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
