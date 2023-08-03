defmodule GraphqlApiAssignment.ErrorUtils do 
  require Logger

  def not_found(error_message, details) do
    message = "#{inspect(error_message)} not found"
    Logger.info(message <> ", params: #{inspect(details)}")
    IO.inspect(details, label: "details param")
    %{details: %{id: id}} = details

    %{
      code: :not_found,
      details: %{id: id}
    }
  end

  def internal_server_error_found(message, details) do 
  end

  def not_acceptable(message, details) do 
  end

  def conflict(message, details) do 
  end
end
