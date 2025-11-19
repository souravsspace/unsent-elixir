defmodule Unsent.Emails do
  @moduledoc """
  Client for email operations.
  """

  alias Unsent.Client

  def send(client, payload), do: create(client, payload)

  def create(client, payload) do
    Client.post(client, "/emails", payload)
  end

  def batch(client, emails) do
    Client.post(client, "/emails/batch", emails)
  end

  def get(client, email_id) do
    Client.get(client, "/emails/#{email_id}")
  end

  def update(client, email_id, payload) do
    Client.patch(client, "/emails/#{email_id}", payload)
  end

  def cancel(client, email_id) do
    Client.post(client, "/emails/#{email_id}/cancel", %{})
  end
end
