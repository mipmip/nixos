require "yaml"
require "colorize"

if new_version = ARGV[0]?
    shard = YAML.parse(File.read("./shard.yml"))
  name = shard["name"].as_s
  version = shard["version"].as_s

  # update additional files if project is amber.
  amber = Amber.instance
  amber.prepare_for_release if amber

  files = {
    "shard.yml" => "version: #{version}", 
    "src/#{name}/version.cr" => %Q("#{version}"),
    "src/#{name}.cr" => %Q("#{version}"),
  }

  files.each do |filename, version_str|
    begin
      puts "Updating version numbers in #{filename}.".colorize(:light_magenta)
      file_string = File.read(filename).gsub(version_str, version_str.gsub(version, new_version))
      File.write(filename, file_string)
      puts "#{filename} successfully updated."
    rescue
      puts "#{filename} doesn't exist."
    end
  end

  message = "Bumped version number to v#{new_version}." unless message = ARGV[1]?
    puts "git commit -am \"#{message}\"".colorize(:yellow)
  `git commit -am "#{message}"`
  `git push`
  puts "git tag -a v#{new_version} -m \"#{name} v#{new_version}\"".colorize(:yellow)
  `git tag -a v#{new_version} -m "#{name} v#{new_version}"`
  puts "git push origin v#{new_version}".colorize(:yellow)
  `git push origin v#{new_version}`
  if amber
    amber.return_to_master
    `git commit -am "Setting amber version lock back to master after release of v#{new_version}"`
    `git push`
    `git branch -D stable`
    `git push origin :stable`
    `git reset --hard v#{new_version}`
    `git checkout -b stable`
    `git push -u origin stable`
  end
else
  puts "Error: Version number required\n".colorize(:red)
  puts "crelease 0.1.1".colorize(:cyan)
  puts "or".colorize(:light_gray)
  puts "crelease 0.1.1 \"Commit message\"\n".colorize(:cyan)
end

class Amber
  getter master_partial = <<-SHARD
      github: amberframework/amber
      branch: master
      #version: <%= Amber::VERSION %>
  SHARD

  getter release_partial = <<-SHARD
      github: amberframework/amber
      version: <%= Amber::VERSION %>
      #branch: master
  SHARD

  getter shard_file = "./src/amber/cli/templates/app/shard.yml.ecr"
  getter release_shard_str : String? = nil

  def master_shard_str
    @master_shard_str ||= File.read(shard_file)
  end

  def release_shard_str
    @release_shard_str ||= master_shard_str.gsub(master_partial, release_partial).to_s
  end

  def prepare_for_release
    File.write(shard_file, release_shard_str)
  end

  def return_to_master
    File.write(shard_file, master_shard_str)
  end

  def amber_project?
    File.exists?(shard_file)
  end

  def self.instance
    @@instance ||= new
    @@instance.not_nil!.amber_project? ? @@instance : nil
  end
end
