class ChooseBatchesController < ApplicationController

  def new
    @batch = ChooseBatch.new
    @batch_numbers = User.select(:batch_number).distinct.order(:batch_number).pluck(:batch_number)
    @batch_numbers.pop
  end

  def create

    @batch = ChooseBatch.new(batch_params)

    if @batch.valid?
      session[:campaign] = {
        batch_number: @batch.batch_number
      }

      redirect_to new_choose_recruiter_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def batch_params
    params.require(:choose_batch).permit(:batch_number)
  end
end
