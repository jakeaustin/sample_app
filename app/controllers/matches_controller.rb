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
			@match_item = {"valid" => false }
		else
			index = rand(0..(@NOTapprovedMatches.count - 1))
			match = @NOTapprovedMatches[index]
			@match_item = Hash.new()
			@match_item["valid"] = true
			@match_item["id"] = match.id
			@match_item["Lpic"] = match.Lpic
			@match_item["Rpic"] = match.Rpic
			@match_item["Ltitle"] = match.Ltitle
			@match_item["Rtitle"] = match.Rtitle
			@match_item["title"] = match.matchTitle
		end
		respond_to do |format|
			format.json { render json: @match_item.to_json }
		end
	end
	
	def get_approved
		require 'json'
		@approvedMatches = Match.where(:approved => true)
		if @approvedMatches.count == 0
			@match_item = {"valid" => false }
		else
			index = rand(0..(@approvedMatches.count - 1))
			match = @approvedMatches[index]
			@match_item = Hash.new()
			@match_item["valid"] = true
			@match_item["id"] = match.id
			@match_item["Lpic"] = match.Lpic
			@match_item["Rpic"] = match.Rpic
			@match_item["Ltitle"] = match.Ltitle
			@match_item["Rtitle"] = match.Rtitle
			@match_item["title"] = match.matchTitle
			@match_item["Rvotes"] = match.Rvotes
			@match_item["Lvotes"] = match.Lvotes
		end
		respond_to do |format|
			format.json { render json: @match_item.to_json }
		end
	end

	def approve
		require 'json'
		@match = Match.find(params[:id])
		@match.approved = true
		@match.save!
		@match_item = {"valid" => true }
		respond_to do |format|
			format.json { render json: @match_item.to_json }
		end
	end

	def destroy
		require 'json'
		@match = Match.find(params[:id])
		@match.destroy
		@match_item = {"valid" => true }
		respond_to do |format|
			format.json { render json: @match_item.to_json }
		end
	end

	def leftVote
		require 'json'
		@match = Match.find(params[:id])
		@match.Lvotes = @match.Lvotes + 1
		@match.save!
		@match_item = {"valid" => true}
		respond_to do |format|
			format.json {render json: @match_item.to_json }
		end	
	end
	
	def rightVote
		require 'json'
		@match = Match.find(params[:id])
		@match.Rvotes = @match.Rvotes + 1
		@match.save!
		@match_item = {"valid" => true}
		respond_to do |format|
			format.json {render json: @match_item.to_json }
		end
	end

 	private
  	def match_params
		params.require(:match).permit(:matchTitle, :Lpic, :Rpic, :Ltitle, :Rtitle)
	end
end
