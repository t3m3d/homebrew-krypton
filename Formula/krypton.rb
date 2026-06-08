class Krypton < Formula
  desc "Programming language compiler and toolchain"
  homepage "https://github.com/t3m3d/krypton"
  # 2.3.0: fully clang-free, self-hosting. Ships the Krypton-native driver
  # (kcc.ks -> kcc_driver_macos_aarch64) + frontend + macho_host backend +
  # stdlib + headers. kcc.sh was removed; the C path (--c/--gcc/--llvm) is gone.
  # Apple Silicon only — the tarball bundles arm64 Mach-O binaries.
  url "https://github.com/t3m3d/krypton/releases/download/2.3.0/krypton-2.3.0-macos-arm64.tar.gz"
  version "2.3.0"
  sha256 "bb69de16294a9b54e746a93c82115ccf3fb768bcef9193b367400dd90fac1faf"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  def install
    libexec.install Dir["*"]

    # Ad-hoc sign the arm64 Mach-O binaries so AMFI lets them run. This also
    # bumps their mtimes above the .k sources, so the driver's ensureHost()
    # treats macho_host as up-to-date and skips its one-time clang rebuild.
    %w[
      bootstrap/kcc_driver_macos_aarch64
      compiler/macos_arm64/kcc-arm64
      compiler/macos_arm64/macho_host
      compiler/macos_arm64/kls
    ].each do |rel|
      f = libexec/rel
      system "codesign", "-s", "-", "-f", f.to_s if f.exist?
    end

    # `kcc` is the kcc.ks-built driver; it finds stdlib/compiler/backend via
    # $KRYPTON_ROOT. Homebrew installs to libexec (not /usr/local/krypton), so
    # wrap the driver to point KRYPTON_ROOT at libexec. `krypton` is an alias
    # (matches the package name on Windows).
    %w[kcc krypton].each do |name|
      (bin/name).write <<~SH
        #!/bin/bash
        export KRYPTON_ROOT="#{libexec}"
        exec "#{libexec}/bootstrap/kcc_driver_macos_aarch64" "$@"
      SH
      (bin/name).chmod 0755
    end

    bin.install_symlink libexec/"compiler/macos_arm64/kls" => "kls" if (libexec/"compiler/macos_arm64/kls").exist?
  end

  test do
    (testpath/"hello.k").write <<~KRYPTON
      just run {
        kp("hello from krypton")
      }
    KRYPTON
    output = shell_output("#{bin}/kcc #{testpath}/hello.k -o #{testpath}/hello && #{testpath}/hello")
    assert_includes output, "hello from krypton"

    assert_match "2.3.0", shell_output("#{bin}/kcc --version")
  end
end
