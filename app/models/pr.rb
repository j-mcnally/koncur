class Pr
  class << self
    def comments(pr)
      Rails.cache.fetch "github_comments_#{pr["id"]}", expires_in: 10.seconds do
        JSON.parse($github.client_without_redirects({}).get(pr["comments_url"]).body)
      end
    end
    
    def approvers(pr)
      comments = comments(pr).keep_if{|c| APPROVAL.find{|a| c["body"].include?(a)}.present? }.collect{|p| p["user"]["login"]}.uniq
    end

    def awaiting(pr)
      all = Team.get_members.collect{|u| u["login"]}.uniq
      all.reject{|u| approvers(pr).include?(u) }.reject{|u| pr["user"]["login"] == u }
    end

    def owner(pr)
      pr["user"]["login"]
    end

    def is_owner(pr, user)
      owner(pr) == user.github_username
    end

    def has_approved?(pr, user)
      approvers(pr).include?(user.github_username)
    end

    def everyone_approved?(pr)
      awaiting(pr).empty?
    end


  end
end