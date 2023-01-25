defmodule LiveSelectBug.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveSelectBug.Accounts` context.
  """

  @doc """
  Generate a profile.
  """
  def profile_fixture(attrs \\ %{}) do
    {:ok, profile} =
      attrs
      |> Enum.into(%{
        country: "some country",
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> LiveSelectBug.Accounts.create_profile()

    profile
  end
end
