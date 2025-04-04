defmodule LernmitWeb.Live.UserLive do
  use Backpex.LiveResource,
    adapter_config: [
      repo: Lernmit.Repo,
      schema: Lernmit.Users.User,
      update_changeset: &Lernmit.Users.User.admin_changeset/3,
      create_changeset: &Lernmit.Users.User.admin_changeset/3
    ],
    layout: {LernmitWeb.Layouts, :admin},
    pubsub: [
      topic: "user"
    ]

  @impl Backpex.LiveResource
  def singular_name, do: "User"

  @impl Backpex.LiveResource
  def plural_name, do: "Users"

  @impl Backpex.LiveResource
  def can?(_assigns, :index, _item), do: true

  @impl Backpex.LiveResource
  def can?(_assigns, :edit, _item), do: true

  @impl Backpex.LiveResource
  def can?(_assigns, _action, _item), do: false

  @impl Backpex.LiveResource
  def fields do
    [
      name: %{
        module: Backpex.Fields.Text,
        label: "Name",
        searchable: true
      },
      email: %{
        module: Backpex.Fields.Text,
        label: "E-Mail",
        searchable: true
      },
      role: %{
        module: Backpex.Fields.Select,
        label: "Rolle",
        options: [Admin: "admin", Lehrer: "teacher", Student: "student"],
        searchable: true
      },
      locale: %{
        module: Backpex.Fields.Select,
        label: "Sprache",
        options: [Deutsch: "de", English: "en"],
        searchable: true
      },
      inserted_at: %{
        module: Backpex.Fields.Date,
        label: "Hinzugefügt",
        format: "%d.%m.%Y"
      }
    ]
  end
end
