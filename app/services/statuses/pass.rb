module Statuses
  class Pass
    class << self
      def call(options={})
        pr = options[:pr]
        repo = options[:repo]
        sha = JSON.parse($github.client_without_redirects({}).get(pr["pull_request"]["url"]).body)["head"]["sha"]
        Status.create(sha: sha, repo: repo[:full_name], state: "success", message: "Approved by team.")
      end
    end
  end
end