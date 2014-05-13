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

	def fetch_with_ajax
	end

	def approve
	end

	def destroy
		@match = Match.find(params[:id])
		@match.destroy
		respond_to do |format|
			format.html { redirect_to about_path }
			format.json { head :no_content }
			format.js { render :layout => false }
		end
	end

 	private
  	def match_params
		params.require(:match).permit(:matchTitle, :Lpic, :Rpic, :Ltitle, :Rtitle)
	end
end