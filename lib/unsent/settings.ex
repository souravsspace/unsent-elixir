defmodule Unsent.Settings do
  @moduledoc """
  Client for team settings operations.
  """

  alias Unsent.Client

  @doc """
  Retrieve team settings.

  ## Examples

      {:ok, settings} = Unsent.Settings.get(client)
      IO.inspect(settings)
  """
  def get(client) do
    Client.get(client, "/settings")
  end
end
