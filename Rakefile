require 'rest-client'
require 'json'
require 'naturally'

API_KEY = ENV['BINTRAY_API_KEY']
PKG_DIR = 'pkg'
BINTRAY_API_BASE = "https://marcy-terui:#{API_KEY}@api.bintray.com"

def load_versions
  JSON.parse(File.read("#{PKG_DIR}/version-manifest.json"))
end

def bintray_make_version(vers)
  version = "#{vers['build_version']}-#{ENV['CIRCLE_BUILD_NUM']}"

  payload = {
    name: version,
    desc: "Lamvery #{vers['software']['lamvery']['locked_version']} with Python #{vers['software']['python']['locked_version']}",
  }.to_json

  ['deb', 'rpm'].each do |pkg|
    RestClient.post(
      "#{BINTRAY_API_BASE}/packages/willyworks/#{pkg}/omnibus-lamvery/versions",
      payload,
      :content_type => :json,
      :accept => :json
    )
  end

  version
end

def bintray_deb_upload(version)
  path_base = "#{BINTRAY_API_BASE}/content/willyworks/deb/omnibus-lamvery/#{version}"
  Dir.glob("#{PKG_DIR}/*.deb") do |f|
    RestClient.put(
      "#{path_base}/pool/main/o/omnibus-lamvery/#{File.basename(f)};deb_distribution=trusty;deb_component=main;deb_architecture=amd64;publish=1;override=1",
      File.read(f)
    )
  end
end

def bintray_rpm_upload(version)
  path_base = "#{BINTRAY_API_BASE}/content/willyworks/rpm/omnibus-lamvery/#{version}"
  Dir.glob("#{PKG_DIR}/*.rpm") do |f|
    RestClient.put(
      "#{path_base}/centos/6/x86_64/#{File.basename(f)}",
      File.read(f)
    )
  end
end

def bintray_delete_old_pkgs
  ['deb', 'rpm'].each do |pkg|
    res = RestClient.get "#{BINTRAY_API_BASE}/packages/willyworks/#{pkg}/omnibus-lamvery"
    vers = JSON.parse(res)['versions']
    if vers.length > 3
      target = Naturally.sort(vers).first
      RestClient.delete "#{BINTRAY_API_BASE}/packages/willyworks/#{pkg}/omnibus-lamvery/versions/#{target}"
    end
  end
end

namespace :bintray do

  desc "release to bintray"
  task :release do
    vers = load_versions
    version = bintray_make_version(vers)
    bintray_deb_upload version
    bintray_rpm_upload version
    bintray_delete_old_pkgs
  end

end
