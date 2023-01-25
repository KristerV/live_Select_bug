defmodule LiveSelectBugWeb.ProfileLive.FormComponent do
  use LiveSelectBugWeb, :live_component

  import LiveSelect
  alias LiveSelectBug.Accounts

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage profile records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="profile-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={{f, :first_name}} type="text" label="First name" />
        <.input field={{f, :last_name}} type="text" label="Last name" />
        <%= live_select(f, :country) %>
        <:actions>
          <.button phx-disable-with="Saving...">Save Profile</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{profile: profile} = assigns, socket) do
    changeset = Accounts.change_profile(profile)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"profile" => profile_params}, socket) do
    changeset =
      socket.assigns.profile
      |> Accounts.change_profile(profile_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"profile" => profile_params}, socket) do
    save_profile(socket, socket.assigns.action, profile_params)
  end

  defp save_profile(socket, :edit, profile_params) do
    case Accounts.update_profile(socket.assigns.profile, profile_params) do
      {:ok, _profile} ->
        {:noreply,
         socket
         |> put_flash(:info, "Profile updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_profile(socket, :new, profile_params) do
    case Accounts.create_profile(profile_params) do
      {:ok, _profile} ->
        {:noreply,
         socket
         |> put_flash(:info, "Profile created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
