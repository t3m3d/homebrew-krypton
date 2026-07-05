class Krypton < Formula
  desc "Programming language compiler and toolchain"
  homepage "https://github.com/t3m3d/krypton"
  # macOS is 2.4.1; Linux stays on 2.3.0 until its matching artifact is cut.
  version "2.4.1"
  license "MIT"

  on_macos do
    url "https://github.com/t3m3d/krypton/releases/download/2.4.1/krypton-2.4.1-macos-arm64.tar.gz"
    sha256 "e2c2750514ddbacad6cd724bec02e976b0c0d0d3dce1f306d6a2288776b06295"
    depends_on arch: :arm64
  end

  on_linux do
    url "https://github.com/t3m3d/krypton/releases/download/2.3.0/krypton-2.3.0-linux-x86_64.tar.gz"
    sha256 "c0a7c7dac309589e1148fd2cc4861e96790a289330f63ccf8a2214bcd6e81032"
  end

  def install
    libexec.install Dir["*"]

    if OS.mac?
      driver = "bootstrap/kcc_driver_macos_aarch64"
      %w[
        bootstrap/kcc_driver_macos_aarch64
        compiler/macos_arm64/kcc-arm64
        compiler/macos_arm64/macho_host
        compiler/macos_arm64/kls
        web/kweb
        apps/kweb_gui.app/Contents/MacOS/kweb_gui
      ].each do |rel|
        f = libexec/rel
        system "codesign", "-s", "-", "-f", f.to_s if f.exist?
      end
    else
      driver = "bootstrap/kcc_driver_linux_x86_64"
    end

    %w[kcc krypton].each do |name|
      (bin/name).write <<~SH
        #!/bin/bash
        export KRYPTON_ROOT="#{libexec}"
        exec "#{libexec}/#{driver}" "$@"
      SH
      (bin/name).chmod 0755
    end

    if (libexec/"web/kweb").exist?
      (bin/"kweb").write <<~SH
        #!/bin/bash
        export KRYPTON_ROOT="#{libexec}"
        exec "#{libexec}/web/kweb" "$@"
      SH
      (bin/"kweb").chmod 0755
    end

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

    expected = OS.mac? ? "2.4.1" : "2.3.0"
    assert_match expected, shell_output("#{bin}/kcc --version")
  end
end
