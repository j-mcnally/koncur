module Statuses
  class Fail
    class << self
      def call(options={})
        pr = options[:pr]
        repo = options[:repo]
        sha = options[:sha]
        # Get shas for a pr
        sha ||= JSON.parse($github.client_without_redirects({}).get(pr["pull_request"]["url"]).body)["head"]["sha"]
        Status.create(sha: sha, repo: repo[:full_name], state: "pending", message: "Awaiting team approval.")
      end
    end
  end
end