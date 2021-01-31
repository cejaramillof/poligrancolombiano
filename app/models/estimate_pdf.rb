require "render_anywhere"

class EstimatePdf
  include RenderAnywhere

  def initialize(estimate)
    @estimate = estimate
  end

  def to_pdf
    kit = PDFKit.new(as_html, page_size: 'A4')
    kit.stylesheets << "#{Rails.root}/app/assets/stylesheets/pdf.css"
    kit.to_file("#{Rails.root}/public/estimate.pdf")
  end

  def filename
    "plan_#{estimate.id}.pdf"
  end

  private

  attr_reader :estimate

  def as_html
    render template: "estimates/pdf", layout: "estimate_pdf", locals: { estimate: estimate }
  end
end