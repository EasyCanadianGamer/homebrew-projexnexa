class Projexnexa < Formula
  desc "Tauri application for project management"
  homepage "https://github.com/EasyCanadianGamer/ProjexNexa"
  url "https://github.com/EasyCanadianGamer/ProjexNexa/releases/download/v0.1.5/ProjexNexa.app.tar.gz"
  sha256 "fbc7dca19c031e59e47467171324d0800ddd1fea1ad0d605914b06d1e2fd6788"
  license "MIT"

  depends_on macos: :monterey

def install
  # 1. Get the actual downloaded tarball path
  tarball = cached_download
  
  # 2. Create clean extraction directory
  temp_dir = "#{buildpath}/temp_extract"
  mkdir_p temp_dir
  
  # 3. Extract the tarball
  system "tar", "-xzf", tarball, "-C", temp_dir
  
  # 4. Find and verify the app bundle
  app_path = Dir.glob("#{temp_dir}/ProjexNexa.app").first
  odie "App bundle not found in archive!" unless app_path
  
  # 5. Install to Homebrew Cellar
  prefix.install app_path
  bin.write_exec_script "#{prefix}/ProjexNexa.app/Contents/MacOS/ProjexNexa"
  
  # 6. Install to User Applications (~/Applications)
  user_apps = File.expand_path("~/Applications")
  mkdir_p user_apps unless Dir.exist?(user_apps)
  cp_r app_path, user_apps
  
  ohai "App installed to Homebrew Cellar and user Applications folder"
end

def caveats
  <<~EOS
    ProjexNexa has been installed to:
      - #{prefix}/ProjexNexa.app (Homebrew managed)
      - ~/Applications/ProjexNexa.app (for easy access)

    You can launch it from:
    - Your user Applications folder
    - Spotlight (Cmd+Space then type "ProjexNexa")
    - Terminal: open ~/Applications/ProjexNexa.app
  EOS
end


  test do
    system "#{bin}/ProjexNexa", "--version"
  end
end
