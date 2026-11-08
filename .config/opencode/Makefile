src=$(wildcard opencode.d/*.json)

opencode.json: $(src)
	@jq -s 'reduce .[] as $$obj ({}; . * $$obj)' $(src) > opencode.json
