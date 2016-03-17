require 'rest-client'

PKG_DIR = 'omnibus/local/omnibus/pkg'
BINTRAY_API_BASE = "https://marcy-terui:#{ENV['BINTRAY_API_KEY']}@#{BINTRAY_API}"

def load_versions
  JSON.parse(File.read("#{PKG_DIR}/version-manifest.json"))
end

def bintray_make_version(vers)
  version = "#{vers['build_version']}-#{ENV['CIRCLE_BUILD_NUM']}"

  payload = {
    name: version,
    desc: "Lamvery #{software['lamvery']['locked_version']} with Python #{software['python']['locked_version']}",
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
      path = "#{path_base}/#{File.basename(f)};deb_distribution=trusty;deb_component=main;deb_architecture=amd64;publish=1;override=1",
      File.read(f)
    )
  end
end

namespace :bintray do
  vers = load_versions

  desc "release to bintray"
  task :release do
    version = bintray_make_version(vers)
    bintray_deb_upload version
  end
end
