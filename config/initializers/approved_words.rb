approved_env = ENV['APPROVAL'].split(",") rescue []
APPROVAL = approved_env + [':+1:', 'LGTM']