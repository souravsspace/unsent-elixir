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
end
