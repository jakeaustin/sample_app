class MatchesController < ApplicationController
	def new
		@match = Match.new
		@title = "create"
	end

        def create
	  @match = Match.new(match_params) 
	  if @match.save
		  flash.keep[:notice] = "Match Submitted for Review!"
		  redirect_to root_path
	  else
		  @title = "Create"
		  render 'new'
	  end
  	end

	def fetch
	end

	def approve
	end

 	private
  	def match_params
		params.require(:match).permit(:matchTitle, :Lpic, :Rpic, :Ltitle, :Rtitle)
	end
end
