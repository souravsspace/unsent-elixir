defmodule Unsent.Webhooks do
  @moduledoc """
  Client for webhook operations.

  > #### Future Feature {: .warning}
  >
  > This resource is currently in development and not fully implemented on the server side yet.
  > The methods below are placeholders/preparations for the future implementation.
  """

  alias Unsent.Client

  @doc """
  List all webhooks.

  **Note**: This is a placeholder for a future feature.

  ## Examples

      {:ok, webhooks} = Unsent.Webhooks.list(client)
  """
  def list(client) do
    Client.get(client, "/webhooks")
  end

  @doc """
  Create a new webhook.

  **Note**: This is a placeholder for a future feature.

  ## Parameters

    * `payload` - Map containing:
      * `:url` - Webhook URL endpoint
      * `:events` - List of event types to subscribe to

  ## Examples

      {:ok, webhook} = Unsent.Webhooks.create(client, %{
        url: "https://example.com/webhooks",
        events: ["email.sent", "email.delivered", "email.bounced"]
      })
  """
  def create(client, payload) do
    Client.post(client, "/webhooks", payload)
  end

  @doc """
  Update a webhook.

  **Note**: This is a placeholder for a future feature.

  ## Parameters

    * `id` - Webhook ID
    * `payload` - Map containing fields to update (`:url`, `:events`)

  ## Examples

      {:ok, webhook} = Unsent.Webhooks.update(client, "webhook_123", %{
        events: ["email.sent", "email.delivered"]
      })
  """
  def update(client, id, payload) do
    Client.patch(client, "/webhooks/#{id}", payload)
  end

  @doc """
  Delete a webhook by ID.

  **Note**: This is a placeholder for a future feature.

  ## Examples

      {:ok, _} = Unsent.Webhooks.delete(client, "webhook_123")
  """
  def delete(client, id) do
    Client.delete(client, "/webhooks/#{id}")
  end
end
