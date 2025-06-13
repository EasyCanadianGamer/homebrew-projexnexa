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
    
    # 3. Explicit extraction command
    system "tar", "-xzf", tarball, "-C", temp_dir
    
    # 4. Find and verify the app bundle
    app_path = Dir.glob("#{temp_dir}/ProjexNexa.app").first
    odie "App bundle not found in archive!" unless app_path
    
    # 5. Install to both Homebrew Cellar and Applications
    prefix.install app_path
    bin.write_exec_script "#{prefix}/ProjexNexa.app/Contents/MacOS/ProjexNexa"
    
    # Create Applications symlink (for Launchpad visibility)
    apps_dir = "/Applications"
    if Dir.exist?(apps_dir)
      app_name = "ProjexNexa.app"
      installed_path = "#{prefix}/#{app_name}"
      applications_path = "#{apps_dir}/#{app_name}"
      
      # Remove old symlink if exists
      FileUtils.rm_f(applications_path)
      # Create new symlink
      FileUtils.ln_sf(installed_path, applications_path)
    end
    
    ohai "Successfully installed ProjexNexa.app to #{prefix} and linked to Applications"
  end

  def caveats
    <<~EOS
      The application has been linked to your /Applications folder.
      You can launch it from:
      - Launchpad
      - Spotlight (Cmd+Space then type "ProjexNexa")
      - Terminal: open #{prefix}/ProjexNexa.app
      
      To unlink from Applications while keeping the Homebrew installation:
        brew unlink projexnexa
    EOS
  end

  test do
    system "#{bin}/ProjexNexa", "--version"
  end
end
