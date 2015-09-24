class WebhooksController < ActionController::Base

  def check

    # Parse webhook to see if its an issue
    webhook = params

    if webhook["issue"].present?
      # Check if its a PR
      if webhook["issue"]["pull_request"].present?
        pr = webhook["issue"]
        # Is this PR tracked?
        repo = webhook["repository"]
        if Repo.tracked?(repo)
          puts "THIS IS A PULL REQUEST TO TRACKED REPO!"
          # Has everyone approved?
          if Pr.everyone_approved?(pr)
            Statuses::Pass.call(pr: pr, repo: repo)  
          else
            Statuses::Fail.call(pr: pr, repo: repo)  
          end
        else
          puts "Repo is not tracked!!!!"
        end
      end

    end


    render nothing: true, status: :ok
  end

end
