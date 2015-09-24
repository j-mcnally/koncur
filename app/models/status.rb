class Status
  class << self
    def create(options)
      repo = params[:repo]
      state = params[:state]
      sha = params[:sha]
      msg = params[:message]
      $github.create_status(repo, sha, state, {target_url: "http://koncur.io", description: msg, context: "koncur.io"})
    end
  end
end