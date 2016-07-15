class SharesController < ApplicationController
	def index
		@shares = Share.all
	end

	def new
		@share = Share.new
	end

	def create
		@share = Share.create(share_params)
		redirect_to shares_path
	end

	def show
		@share = Share.find(params[:id])
	end

	private

	def share_params
		params.require(:share).permit(:body)
	end
end
