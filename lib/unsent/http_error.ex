defmodule Unsent.HTTPError do
  @moduledoc """
  Exception raised when an HTTP request fails.
  """

  defexception [:status_code, :error, :method, :path, :message]

  @impl true
  def exception(%{status_code: status_code, error: error, method: method, path: path}) do
    code = Map.get(error, "code", "UNKNOWN_ERROR")
    error_message = Map.get(error, "message", "")

    %__MODULE__{
      status_code: status_code,
      error: error,
      method: method,
      path: path,
      message: "#{method} #{path} -> #{status_code} #{code}: #{error_message}"
    }
  end
end
