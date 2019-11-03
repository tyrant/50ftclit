# From http://dylanmarkow.com/blog/2014/01/08/capistrano-3-setting-a-default-stage/

namespace :load do
  task :defaults do
    load 'capistrano/defaults.rb'
  end
end

stages.each do |stage|
  Rake::Task.define_task(stage) do
    set(:stage, stage.to_sym)

    invoke 'load:defaults'
    load deploy_config_path
    load stage_config_path.join("#{stage}.rb")
    load "capistrano/#{fetch(:scm)}.rb"
    I18n.locale = fetch(:locale, :en)
    configure_backend
  end
end