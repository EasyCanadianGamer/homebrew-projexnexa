class Projexnexa < Formula
  desc "Tauri application for project management"
  homepage "https://github.com/EasyCanadianGamer/ProjexNexa"
  url "https://github.com/EasyCanadianGamer/ProjexNexa/releases/download/v0.1.5/ProjexNexa.app.tar.gz"
  sha256 "sha256:fbc7dca19c031e59e47467171324d0800ddd1fea1ad0d605914b06d1e2fd6788"
  license "MIT"

  depends_on macos: :monterey

  def install
    prefix.install "ProjexNexa.app"
    bin.write_exec_script prefix/"ProjexNexa.app/Contents/MacOS/ProjexNexa"
  end

  test do
    system "#{bin}/ProjexNexa", "--version"
  end
end
