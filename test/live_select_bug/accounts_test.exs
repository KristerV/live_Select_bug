defmodule LiveSelectBug.AccountsTest do
  use LiveSelectBug.DataCase

  alias LiveSelectBug.Accounts

  describe "profiles" do
    alias LiveSelectBug.Accounts.Profile

    import LiveSelectBug.AccountsFixtures

    @invalid_attrs %{country: nil, first_name: nil, last_name: nil}

    test "list_profiles/0 returns all profiles" do
      profile = profile_fixture()
      assert Accounts.list_profiles() == [profile]
    end

    test "get_profile!/1 returns the profile with given id" do
      profile = profile_fixture()
      assert Accounts.get_profile!(profile.id) == profile
    end

    test "create_profile/1 with valid data creates a profile" do
      valid_attrs = %{
        country: "some country",
        first_name: "some first_name",
        last_name: "some last_name"
      }

      assert {:ok, %Profile{} = profile} = Accounts.create_profile(valid_attrs)
      assert profile.country == "some country"
      assert profile.first_name == "some first_name"
      assert profile.last_name == "some last_name"
    end

    test "create_profile/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_profile(@invalid_attrs)
    end

    test "update_profile/2 with valid data updates the profile" do
      profile = profile_fixture()

      update_attrs = %{
        country: "some updated country",
        first_name: "some updated first_name",
        last_name: "some updated last_name"
      }

      assert {:ok, %Profile{} = profile} = Accounts.update_profile(profile, update_attrs)
      assert profile.country == "some updated country"
      assert profile.first_name == "some updated first_name"
      assert profile.last_name == "some updated last_name"
    end

    test "update_profile/2 with invalid data returns error changeset" do
      profile = profile_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_profile(profile, @invalid_attrs)
      assert profile == Accounts.get_profile!(profile.id)
    end

    test "delete_profile/1 deletes the profile" do
      profile = profile_fixture()
      assert {:ok, %Profile{}} = Accounts.delete_profile(profile)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_profile!(profile.id) end
    end

    test "change_profile/1 returns a profile changeset" do
      profile = profile_fixture()
      assert %Ecto.Changeset{} = Accounts.change_profile(profile)
    end
  end
end
