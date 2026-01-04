defmodule Unsent.Client do
  @moduledoc """
  Core HTTP client for the Unsent API.
  """

  @default_base_url "https://api.unsent.dev"

  defstruct [:api_key, :base_url, :raise_on_error]

  @doc """
  Creates a new client.
  """
  def new(api_key \\ nil, opts \\ []) do
    api_key = api_key || System.get_env("UNSENT_API_KEY")

    if is_nil(api_key) or api_key == "" do
      raise ArgumentError, "Missing API key. Pass it to Unsent.new/1 or set UNSENT_API_KEY environment variable"
    end

    base_url = Keyword.get(opts, :base_url, System.get_env("UNSENT_BASE_URL", @default_base_url))
    raise_on_error = Keyword.get(opts, :raise_on_error, true)

    %__MODULE__{
      api_key: api_key,
      base_url: "#{base_url}/v1",
      raise_on_error: raise_on_error
    }
  end

  @doc """
  Performs an HTTP request.
  """
  def request(client, method, path, body \\ nil, opts \\ []) do
    url = "#{client.base_url}#{path}"

    default_headers = [
      {"Authorization", "Bearer #{client.api_key}"},
      {"Content-Type", "application/json"}
    ]

    custom_headers = Keyword.get(opts, :headers, [])
    headers = default_headers ++ custom_headers

    request_body = if body, do: Jason.encode!(body), else: ""
    http_opts = Keyword.delete(opts, :headers)

    case HTTPoison.request(method, url, request_body, headers, http_opts) do
      {:ok, %HTTPoison.Response{status_code: status_code, body: response_body}}
      when status_code >= 200 and status_code < 300 ->
        case Jason.decode(response_body) do
          {:ok, data} -> {:ok, data}
          {:error, _} -> {:ok, nil}
        end

      {:ok, %HTTPoison.Response{status_code: status_code, body: response_body}} ->
        error = case Jason.decode(response_body) do
          {:ok, %{"error" => err}} -> err
          {:ok, data} -> data
          {:error, _} -> %{"code" => "INTERNAL_SERVER_ERROR", "message" => "Unknown error"}
        end

        if client.raise_on_error do
          raise Unsent.HTTPError, %{
            status_code: status_code,
            error: error,
            method: method,
            path: path
          }
        else
          {:error, error}
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        error = %{"code" => "INTERNAL_ERROR", "message" => inspect(reason)}

        if client.raise_on_error do
          raise Unsent.HTTPError, %{
            status_code: 500,
            error: error,
            method: method,
            path: path
          }
        else
          {:error, error}
        end
    end
  end

  def post(client, path, body, opts \\ []), do: request(client, :post, path, body, opts)
  def get(client, path, opts \\ []), do: request(client, :get, path, nil, opts)
  def put(client, path, body, opts \\ []), do: request(client, :put, path, body, opts)
  def patch(client, path, body, opts \\ []), do: request(client, :patch, path, body, opts)
  def delete(client, path, opts \\ []), do: request(client, :delete, path, nil, opts)
end
