home_dir     = File.expand_path('~')
dotfiles_dir = File.expand_path(File.dirname(__FILE__))

ignored_files  = %w(LICENSE Rakefile Session.vim install.sh)
ignored_files += File.readlines("#{dotfiles_dir}/.gitignore")
dotfiles       = Dir['*'] - ignored_files

task :backup do
  puts yellow "Backing up old dotfiles..."

  backup_dir = "#{home_dir}/dotfiles_backup"
  mkdir_p backup_dir

  dotfiles.each do |file|
    source      = "#{home_dir}/.#{file}"
    destination = "#{backup_dir}/#{file}"

    next unless File.exists? source

    rm_rf destination if File.exists? destination
    cp_r source, destination
  end

  puts yellow "Done."
end

task :install => [:backup] do
  puts yellow "Installing new dotfiles..."

  dotfiles.each do |file|
    source      = "#{dotfiles_dir}/#{file}"
    destination = "#{home_dir}/.#{file}"

    rm_rf destination if File.exists? destination
    ln_s source, destination
  end

  puts yellow "Done."
end

def colorize(text, color_code)
  "\033[#{color_code}m#{text}\033[0m"
end

{
  :black    => 30,
  :red      => 31,
  :green    => 32,
  :yellow   => 33,
  :blue     => 34,
  :magenta  => 35,
  :cyan     => 36,
  :white    => 37
}.each do |key, color_code|
  define_method key do |text|
    colorize(text, color_code)
  end
end
