class MatchesController < ApplicationController
	def new
		@match = Match.new
		@title = "Create"
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

	def get_unapproved
		require 'json'
		@NOTapprovedMatches = Match.where(:approved => false)
		if @NOTapprovedMatches.count == 0
			@match_item = {"valid" => false };
		else
			index = rand(0..(@NOTapprovedMatches.count - 1))
			match = @NOTapprovedMatches[index]
			@match_item = {"valid" => true, "id" = match.id, "Lpic" => match.Lpic, "Lpic" => match.Lpic,...
			"Rpic" => match.Lpic, "Rtitle" => match.Rtitle, "Ltitle" => match.Ltitle, "title" => match.matchTitle}
		end
		respond_to do |format| 
          format.json {render :json => @match_item}
        end
	end

	def approve
		@match = Match.find(params[:id])
		@match.approved = true
		@match.save!
	end

	def destroy
		@match = Match.find(params[:id])
		@match.destroy
	end

 	private
  	def match_params
		params.require(:match).permit(:matchTitle, :Lpic, :Rpic, :Ltitle, :Rtitle)
	end
end
