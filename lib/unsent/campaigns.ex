defmodule Unsent.Campaigns do
  @moduledoc """
  Client for campaign operations.
  """

  alias Unsent.Client

  def create(client, payload) do
    Client.post(client, "/campaigns", payload)
  end

  def get(client, campaign_id) do
    Client.get(client, "/campaigns/#{campaign_id}")
  end

  def schedule(client, campaign_id, payload) do
    Client.post(client, "/campaigns/#{campaign_id}/schedule", payload)
  end

  def pause(client, campaign_id) do
    Client.post(client, "/campaigns/#{campaign_id}/pause", %{})
  end

  def resume(client, campaign_id) do
    Client.post(client, "/campaigns/#{campaign_id}/resume", %{})
  end
end
