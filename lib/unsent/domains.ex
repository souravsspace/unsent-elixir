defmodule Unsent.Domains do
  @moduledoc """
  Client for domain operations.
  """

  alias Unsent.Client

  def list(client) do
    Client.get(client, "/domains")
  end

  def create(client, payload) do
    Client.post(client, "/domains", payload)
  end

  def verify(client, domain_id) do
    Client.put(client, "/domains/#{domain_id}/verify", %{})
  end

  def get(client, domain_id) do
    Client.get(client, "/domains/#{domain_id}")
  end

  def delete(client, domain_id) do
    Client.delete(client, "/domains/#{domain_id}")
  end
end
