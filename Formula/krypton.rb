class Krypton < Formula
  desc "Programming language compiler and toolchain"
  homepage "https://github.com/t3m3d/krypton"
  # 2.3.0: fully clang-free, self-hosting. Ships the Krypton-native driver
  # (kcc.ks -> kcc_driver_<os>) + frontend + native backend + stdlib + headers
  # + kweb (Krypton Web Framework CLI). kcc.sh was removed; the C path
  # (--c/--gcc/--llvm) is gone.
  #
  #   macOS: Apple Silicon arm64 Mach-O binaries (ad-hoc signed on install).
  #   Linux: x86_64 static syscall-only ELF binaries (no C compiler, no signing).
  version "2.3.0"
  license "MIT"

  on_macos do
    url "https://github.com/t3m3d/krypton/releases/download/2.3.0/krypton-2.3.0-macos-arm64.tar.gz"
    sha256 "bb69de16294a9b54e746a93c82115ccf3fb768bcef9193b367400dd90fac1faf"
    depends_on arch: :arm64
  end

  on_linux do
    url "https://github.com/t3m3d/krypton/releases/download/2.3.0/krypton-2.3.0-linux-x86_64.tar.gz"
    sha256 "e96dabbdcfa2d09c48ad5ba930883aa289dffc62d4458b29fab2e45be716a3ce"
  end

  def install
    libexec.install Dir["*"]

    if OS.mac?
      driver = "bootstrap/kcc_driver_macos_aarch64"
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
    else
      # Linux: static syscall-only ELF — no signing, no rebuild needed.
      driver = "bootstrap/kcc_driver_linux_x86_64"
    end

    # `kcc` is the kcc.ks-built driver; it finds stdlib/compiler/backend via
    # $KRYPTON_ROOT. Homebrew installs to libexec, so wrap the driver to point
    # KRYPTON_ROOT at libexec. `krypton` is an alias (matches the Windows pkg).
    %w[kcc krypton].each do |name|
      (bin/name).write <<~SH
        #!/bin/bash
        export KRYPTON_ROOT="#{libexec}"
        exec "#{libexec}/#{driver}" "$@"
      SH
      (bin/name).chmod 0755
    end

    # kweb — Krypton Web Framework CLI. Wrap so KRYPTON_ROOT resolves stdlib
    # (kweb build shells out to kcc). Present on both macOS and Linux tarballs.
    if (libexec/"web/kweb").exist?
      (bin/"kweb").write <<~SH
        #!/bin/bash
        export KRYPTON_ROOT="#{libexec}"
        exec "#{libexec}/web/kweb" "$@"
      SH
      (bin/"kweb").chmod 0755
    end

    # kls (macOS language server) — symlink if present.
    if (libexec/"compiler/macos_arm64/kls").exist?
      bin.install_symlink libexec/"compiler/macos_arm64/kls" => "kls"
    end
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
