class Projexnexa < Formula
  desc "Tauri application for project management"
  homepage "https://github.com/EasyCanadianGamer/ProjexNexa"
  url "https://github.com/EasyCanadianGamer/ProjexNexa/releases/download/v0.1.5/ProjexNexa.app.tar.gz"
  sha256 "fbc7dca19c031e59e47467171324d0800ddd1fea1ad0d605914b06d1e2fd6788"
  license "MIT"

  depends_on macos: :monterey

  def install
    # Explicit extraction to temp dir
    temp_dir = "#{buildpath}/temp_extract"
    mkdir_p temp_dir
    system "tar", "-xzf", "#{buildpath}/ProjexNexa.app.tar.gz", "-C", temp_dir

    # Find the app bundle (case-sensitive)
    app_bundle = Dir.glob("#{temp_dir}/**/ProjexNexa.app").first
    raise "ProjexNexa.app not found in archive!" unless app_bundle

    # Install with explicit paths
    prefix.install app_bundle => "ProjexNexa.app"
    bin.write_exec_script "#{prefix}/ProjexNexa.app/Contents/MacOS/ProjexNexa"

    # Verify installation
    ohai "Installed to: #{prefix}/ProjexNexa.app"
  end

  test do
    system "#{bin}/ProjexNexa", "--version"
  end
end
