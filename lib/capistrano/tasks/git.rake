namespace :git do

  desc 'Run `git add -A .` in a Cap hook instead of manually'
  task :add do
    on roles :all do
      run_locally do
        execute "git add -A ."
      end
    end
  end

  desc 'Run `git commit -m "Moar"` in a Cap hook instead of manually'
  task :commit do
    on roles :all do
      run_locally do
        execute 'git commit -m "Moar"'
      end
    end
  end

  desc 'Run `git push [origin master]` in a Cap hook instead of manually'
  task :push do
    on roles :all do
      run_locally do
        execute "git push"
      end
    end
  end
end