namespace :git do
  desc 'Pushing new commits to the remote repository'
  task :push do
    on roles(:all) do
      run_locally do
        execute "git push"
      end
    end
  end
end