class Projexnexa < Formula
  desc "Tauri application for project management"
  homepage "https://github.com/EasyCanadianGamer/ProjexNexa"
  url "https://github.com/EasyCanadianGamer/ProjexNexa/releases/download/v0.1.5/ProjexNexa.app.tar.gz"
  sha256 "fbc7dca19c031e59e47467171324d0800ddd1fea1ad0d605914b06d1e2fd6788"
  license "MIT"

  depends_on macos: :monterey

  def install
    # 1. Get exact downloaded path
    tarball = cached_download
    ohai "Using tarball at: #{tarball}"
    
    # 2. Create extraction directory
    temp_dir = buildpath/"temp_extract"
    temp_dir.mkpath
    
    # 3. Extract with full path output
    system "tar", "-xzvf", tarball, "-C", temp_dir, "--strip-components", "0"
    
    # 4. Verify extraction
    extracted = Dir.glob(temp_dir/"ProjexNexa.app")
    odie "App bundle not found in #{temp_dir}" if extracted.empty?
    
    # 5. Install to Homebrew prefix
    prefix.install extracted.first => "ProjexNexa.app"
    
    # 6. Create launcher script
    bin.write_exec_script prefix/"ProjexNexa.app/Contents/MacOS/ProjexNexa"
  end

  test do
    system "#{bin}/ProjexNexa", "--version"
  end
end
