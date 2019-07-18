class JobsController < ApplicationController
  def new

  end
  def index
    @jobs = Job.all
  end
  def create
    @job = Job.new(job_params)
    if (@job.save)
    redirect_to jobs_path
    else
      render 'new'
      end
  end
  def show

  end
  private
  def job_params
    params.require(:job).permit(:company_name, :title, :description, :experience)
  end
end
