class Repo
  class << self
    def all
      Rails.cache.fetch :github_repos, expires_in: 30.seconds do
        Team.review.rels[:repositories].get.data
      end
    end
    def open_prs(repo)
      Rails.cache.fetch "github_prs_#{repo[:name]}", expires_in: 30.seconds do
        JSON.parse($github.client_without_redirects({}).get(repo.rels[:pulls].href).body) 
      end
    end
  end
end