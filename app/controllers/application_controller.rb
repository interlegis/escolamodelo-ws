class ApplicationController < ActionController::Base
  def admin_access
    verify_permission(params[:key], 4)
  end

  def basic_api_access
    @api = verify_permission(params[:key], 3)
    @school = if @api['level'] < 4
                School.find_by_initials(@api['ext_id'])
              else
                School.find_by_initials(params[:school])
              end
    unless @school.present?
      render status: 400, json: {
          message: 'Escola não encontrada, verifique se você possui a sigla da escola correta.'
      }.to_json
    end
  end

  def user_data_access
    @api = verify_permission(params[:key], 2)
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
        {'cpf': response[:api][:cpf], 'ext_id': response[:api][:ext_id], 'level': response[:api][:level]}
      end
    else
      render status: 400, json: {
          message: 'Chave não encontrada'
      }.to_json
    end
  end
end
