defmodule Unsent.Emails do
  @moduledoc """
  Client for email operations.
  """

  alias Unsent.Client

  def send(client, payload, opts \\ []), do: create(client, payload, opts)

  def create(client, payload, opts \\ []) do
    payload = normalize_payload(payload)
    Client.post(client, "/emails", payload, opts)
  end

  def batch(client, emails, opts \\ []) do
    emails = Enum.map(emails, &normalize_payload/1)
    Client.post(client, "/emails/batch", emails, opts)
  end

  @doc """
  List sent emails.

  ## Parameters

    * `query` - Optional query parameters:
      * `:page` - Page number (default: 1)
      * `:limit` - Items per page (default: 50)
      * `:startDate` - Filter by start date (ISO 8601 format)
      * `:endDate` - Filter by end date (ISO 8601 format)
      * `:domainId` - Filter by domain ID (string or list of strings)

  ## Examples

      {:ok, emails} = Unsent.Emails.list(client)
      {:ok, emails} = Unsent.Emails.list(client, page: 2, limit: 100)
      {:ok, emails} = Unsent.Emails.list(client, domainId: "domain_123")
      {:ok, emails} = Unsent.Emails.list(client, domainId: ["domain_123", "domain_456"])
  """
  def list(client, query \\ []) do
    params = build_list_query_params(query)
    path = build_path("/emails", params)
    Client.get(client, path)
  end

  @doc """
  Retrieve list of bounced emails.

  ## Parameters

    * `query` - Optional query parameters:
      * `:page` - Page number (default: 1)
      * `:limit` - Items per page (default: 20, max: 100)

  ## Examples

      {:ok, bounces} = Unsent.Emails.get_bounces(client)
      {:ok, bounces} = Unsent.Emails.get_bounces(client, page: 2, limit: 50)
  """
  def get_bounces(client, query \\ []) do
    params = build_query_params(query, [:page, :limit])
    path = build_path("/emails/bounces", params)
    Client.get(client, path)
  end

  @doc """
  Retrieve list of spam complaints.

  ## Parameters

    * `query` - Optional query parameters:
      * `:page` - Page number (default: 1)
      * `:limit` - Items per page (default: 20, max: 100)

  ## Examples

      {:ok, complaints} = Unsent.Emails.get_complaints(client)
      {:ok, complaints} = Unsent.Emails.get_complaints(client, page: 2, limit: 50)
  """
  def get_complaints(client, query \\ []) do
    params = build_query_params(query, [:page, :limit])
    path = build_path("/emails/complaints", params)
    Client.get(client, path)
  end

  @doc """
  Retrieve list of unsubscribed emails.

  ## Parameters

    * `query` - Optional query parameters:
      * `:page` - Page number (default: 1)
      * `:limit` - Items per page (default: 20, max: 100)

  ## Examples

      {:ok, unsubscribes} = Unsent.Emails.get_unsubscribes(client)
      {:ok, unsubscribes} = Unsent.Emails.get_unsubscribes(client, page: 2, limit: 50)
  """
  def get_unsubscribes(client, query \\ []) do
    params = build_query_params(query, [:page, :limit])
    path = build_path("/emails/unsubscribes", params)
    Client.get(client, path)
  end

  def get(client, email_id) do
    Client.get(client, "/emails/#{email_id}")
  end

  def update(client, email_id, payload) do
    # update payload might have scheduled_at, but no from
    Client.patch(client, "/emails/#{email_id}", payload)
  end

  def cancel(client, email_id) do
    Client.post(client, "/emails/#{email_id}/cancel", %{})
  end

  defp normalize_payload(payload) do
    payload
    |> Map.new()
    |> handle_from_alias()
  end

  defp handle_from_alias(payload) do
    cond do
      Map.has_key?(payload, :from_) and not Map.has_key?(payload, :from) ->
        {val, payload} = Map.pop(payload, :from_)
        Map.put(payload, :from, val)
      Map.has_key?(payload, "from_") and not Map.has_key?(payload, "from") ->
        {val, payload} = Map.pop(payload, "from_")
        Map.put(payload, "from", val)
      true ->
        payload
    end
  end

  # Private helper functions

  defp build_list_query_params(query) do
    # Handle domainId specially - it can be a string or array
    domain_id = Keyword.get(query, :domainId)
    other_params = query |> Keyword.take([:page, :limit, :startDate, :endDate]) |> Enum.filter(fn {_k, v} -> v != nil end)

    case domain_id do
      nil -> other_params
      ids when is_list(ids) -> other_params ++ Enum.map(ids, fn id -> {:domainId, id} end)
      id -> other_params ++ [{:domainId, id}]
    end
  end

  defp build_query_params(query, allowed_keys) do
    query
    |> Keyword.take(allowed_keys)
    |> Enum.filter(fn {_k, v} -> v != nil end)
  end

  defp build_path(base_path, []), do: base_path
  defp build_path(base_path, params) do
    query_string = URI.encode_query(params, :www_form)
    "#{base_path}?#{query_string}"
  end
end
