defmodule Unsent do
  @moduledoc """
  Official Elixir SDK for the Unsent API.

  Send transactional emails, manage contacts, campaigns, and domains.
  """

  alias Unsent.Client

  @doc """
  Creates a new Unsent client.

  ## Examples

      iex> client = Unsent.new("un_xxx")
      %Unsent.Client{...}

  """
  def new(api_key, opts \\ []) do
    Client.new(api_key, opts)
  end
end
