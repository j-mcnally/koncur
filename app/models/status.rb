class Status
  class << self
    def create(options)
      repo = options[:repo]
      state = options[:state]
      sha = options[:sha]
      msg = options[:message]
      $github.create_status(repo, sha, state, {target_url: "http://koncur.io", description: msg, context: "koncur.io"})
    end
  end
end