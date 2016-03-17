require 'rest-client'
require 'json'
require 'naturally'

API_KEY = ENV['BINTRAY_API_KEY']
PKG_DIR = 'omnibus/pkg'
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

  RestClient.post(
    "#{BINTRAY_API_BASE}/packages/willyworks/deb/omnibus-lamvery/versions",
    payload,
    :content_type => :json,
    :accept => :json
  )
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

def bintray_delete_old_pkgs
  res = RestClient.get "#{BINTRAY_API_BASE}/packages/willyworks/deb/omnibus-lamvery"
  vers = JSON.parse(res)['versions']
  if vers.length > 3
    target = Naturally.sort(vers).first
    RestClient.delete "#{BINTRAY_API_BASE}/packages/willyworks/deb/omnibus-lamvery/versions/#{target}"
  end
end

namespace :bintray do

  desc "release to bintray"
  task :release do
    vers = load_versions
    version = bintray_make_version(vers)
    bintray_deb_upload version
    bintray_delete_old_pkgs
  end

end
