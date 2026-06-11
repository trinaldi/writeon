class GraphqlController < ApplicationController
  include Authenticable

  protect_from_forgery with: :null_session

  def execute
    render json: execute_query
  rescue StandardError => e
    handle_error_in_development(e)
  end

  private

  def execute_query
    BlogSchema.execute(
      params[:query],
      variables: Graphql::VariablesParser.call(params[:variables]),
      context: { current_user: current_user },
      operation_name: params[:operationName]
    )
  end

  def handle_error_in_development(err)
    render json: {
      errors: [{ message: err.message, backtrace: err.backtrace }],
      data: {}
    }, status: :internal_server_error
  end
end
