class StaticsController < ApplicationController
  # for testing
  def home
    region = 'Kowloon'
    agents = Agent.where("'#{region}' = ANY (regions) ")
    render json: agents[1].id
  end
end
