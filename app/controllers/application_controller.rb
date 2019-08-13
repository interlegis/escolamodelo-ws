class ApplicationController < ActionController::Base
  def admin_access
    verify_permission(params[:key], 4)
  end

  def basic_api_access
    verify_permission(params[:key], 3)
  end

  def user_data_access
    verify_permission(params[:key], 2)
  end

  private

  def verify_permission(key, level)
    if key.present?
      response = HTTParty.get(ENV['ESCOLA_MODELO_WS_Central_Auth'].present? ? ENV['ESCOLA_MODELO_WS_Central_Auth'] + '/api/level?key=' + key : 'http://localhost:3001/api/level?key=' + key, format: :plain) # TODO Alterar essa URL para produção
      response = JSON.parse response, symbolize_names: true
      if response[:error].present?
        render status: 400, json: {
            message: response[:error]
        }.to_json
      elsif response[:api][:level] < level
        render status: 401, json: {
            message: 'Não foi possível realizar essa ação'
        }.to_json
      else
        response[:api][:cpf]
      end
    else
      render status: 400, json: {
          message: 'Chave não encontrada'
      }.to_json
    end
  end
end
