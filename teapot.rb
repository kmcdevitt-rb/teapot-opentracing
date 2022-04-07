teapot_version "3.0"

define_target "opentracing" do |target|
  target.depends :platform

  target.depends "Build/Make"
  target.depends "Build/CMake"

  target.provides "Library/opentracing" do
    source_files = target.package.path + "libopentracing"
    cache_prefix = environment[:build_prefix] / environment.checksum + "libopentracing"
    package_files = cache_prefix / "lib/libopentracing.a"

    cmake source: source_files, install_prefix: cache_prefix, arguments: [
      "-DBUILD_SHARED_LIBS=OFF",
    ], package_files: package_files

    #append linkflags [
    #  ->{"#{install_prefix}lib/libopentracing.a"},
    #]
    append linkflags package_files
    append header_search_paths cache_prefix + "include"
  end
end

define_configuration "opentracing" do |configuration|
  configuration[:source] = "https://github.com/kurocha/"

  configuration.require "platforms"
  configuration.require "build-make"
  configuration.require "build-cmake"
end
