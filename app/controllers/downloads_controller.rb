class DownloadsController < ApplicationController
  def show
    respond_to do |format|
      format.pdf { send_estimate_pdf }
    end
  end

  private
  def estimate_pdf
    estimate = Estimate.find(params[:estimate_id])
    EstimatePdf.new(estimate)
  end

  def send_estimate_pdf
    send_file estimate_pdf.to_pdf, filename: estimate_pdf.filename, type: "application/pdf", disposition: "inline"
  end
end