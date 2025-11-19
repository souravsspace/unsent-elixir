defmodule Unsent.Contacts do
  @moduledoc """
  Client for contact operations.
  """

  alias Unsent.Client

  def create(client, book_id, payload) do
    Client.post(client, "/contactBooks/#{book_id}/contacts", payload)
  end

  def get(client, book_id, contact_id) do
    Client.get(client, "/contactBooks/#{book_id}/contacts/#{contact_id}")
  end

  def update(client, book_id, contact_id, payload) do
    Client.patch(client, "/contactBooks/#{book_id}/contacts/#{contact_id}", payload)
  end

  def upsert(client, book_id, contact_id, payload) do
    Client.put(client, "/contactBooks/#{book_id}/contacts/#{contact_id}", payload)
  end

  def delete(client, book_id, contact_id) do
    Client.delete(client, "/contactBooks/#{book_id}/contacts/#{contact_id}")
  end
end
