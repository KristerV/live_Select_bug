defmodule LiveSelectBugWeb.ProfileLive.Index do
  use LiveSelectBugWeb, :live_view
  import LiveSelect

  alias LiveSelectBug.Accounts
  alias LiveSelectBug.Accounts.Profile
  alias LiveSelectBug.PredefinedOptions

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :profiles, list_profiles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Profile")
    |> assign(:profile, Accounts.get_profile!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Profile")
    |> assign(:profile, %Profile{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Profiles")
    |> assign(:profile, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    profile = Accounts.get_profile!(id)
    {:ok, _} = Accounts.delete_profile(profile)

    {:noreply, assign(socket, :profiles, list_profiles())}
  end

  defp list_profiles do
    Accounts.list_profiles()
  end

  @impl true
  def handle_info(%LiveSelect.ChangeMsg{} = change_msg, socket) do
    countries = PredefinedOptions.countries(change_msg.text)
    IO.inspect(countries, label: "countries")

    update_options(change_msg, countries)

    {:noreply, socket}
  end

  @impl true
  def handle_event(
        "change",
        %{"my_form" => %{"city_search_text_input" => city_name, "city_search" => city_coords}},
        socket
      ) do
    IO.puts("You selected city #{city_name} located at: #{city_coords}")

    {:noreply, socket}
  end
end
