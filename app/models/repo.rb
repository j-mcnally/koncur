class Repo
  class << self
    def all
      Rails.cache.fetch :github_repos, expires: 30.minutes do
        Team.review.rels[:repositories].get.data.to_json
      end
    end
    def open_prs(repo)
      Rails.cache.fetch "github_prs_#{repo[:name]}", expires: 5.minutes do
        $github.client_without_redirects({}).get(repo.rels[:pulls].href).body  
      end
    end
  end
end