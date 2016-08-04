json.array! @agents do |agent|
  json.partial! 'agent_template', agent: agent
end
