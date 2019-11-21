
require 'httparty'

class Typeform
  include HTTParty
  base_uri 'https://api.typeform.com'

  def initialize
    key = ENV["TYPEFORM_KEY"]
    auth = "Bearer #{key}"
    @headers = { "Authorization" => auth }
  end

  def me
    Typeform.get("/me", headers: @headers)
  end

  def forms
    Typeform.get("/forms", headers: @headers)
  end

  def form(form_id)
    Typeform.get("/forms/#{form_id}", headers: @headers)
  end

  def delete_form(form_id)
    Typeform.delete("/forms/#{form_id}", headers: @headers)
  end

  def create_form(body)
    Typeform.post("/forms", headers: @headers, body: body.to_json)
  end

  def responses(form_id)
    Typeform.get("/forms/#{form_id}/responses", headers: @headers)
  end
end
