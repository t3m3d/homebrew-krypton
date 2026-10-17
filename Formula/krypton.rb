class Krypton < Formula
  desc "Programming language compiler and toolchain"
  homepage "https://github.com/t3m3d/krypton"
  # macOS is 2.4.8. Linux x86_64 remains on 2.4.4. Windows remains on 2.3.0.
  license "MIT"

  if OS.mac?
    url "https://github.com/t3m3d/krypton/releases/download/v2.4.8/krypton-2.4.8-macos-arm64.tar.gz"
    sha256 "e32b3396bfb2d14ac036609a75408cc85da7640689dd08b8dfbb338957625ea2"
    depends_on arch: :arm64
  elsif OS.linux?
    url "https://github.com/t3m3d/krypton/releases/download/2.4.4/krypton-2.4.4-linux-x86_64.tar.gz"
    sha256 "98f020363334c8166b1e7a6e617ba046d4505164862b9f0b95214c59b57b3dad"
  end

  def install
    libexec.install Dir["*"]

    driver = if OS.mac?
      "bootstrap/kcc_driver_macos_aarch64"
    else
      "bootstrap/kcc_driver_linux_x86_64"
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

    if OS.mac? && (libexec/"apps/kweb.app").exist?
      (bin/"kweb-gui").write <<~SH
        #!/bin/bash
        open "#{libexec}/apps/kweb.app" "$@"
      SH
      (bin/"kweb-gui").chmod 0755
    end

    bin.install_symlink libexec/"compiler/macos_arm64/kls" => "kls" if (libexec/"compiler/macos_arm64/kls").exist?
  end

  def caveats
    on_macos do
      <<~EOS
        Open the kweb GUI with:
          kweb-gui
      EOS
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

    expected = OS.mac? ? "2.4.8" : "2.4.4"
    assert_match expected, shell_output("#{bin}/kcc --version")
  end
end
