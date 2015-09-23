class Team
  class << self
    def review
      $github.org_teams(ENV['GITHUB_ORGANIZATION']).find{|o| o[:slug] == ENV['GITHUB_REVIEW_TEAM']}
    end

    def get_members
      Rails.cache.fetch :github_team, expires: 30.minutes do
        Team.review.rels[:members].get.data
      end
    end

    def is_member?(nickname)
      self.get_members.find{|m| m["login"] == nickname}
    end
  end
end