defmodule LernmitWeb.Live.AchievementLive do
  use Backpex.LiveResource,
    adapter_config: [
      repo: Lernmit.Repo,
      schema: Lernmit.Achievements.Achievement,
      update_changeset: &Lernmit.Achievements.Achievement.admin_changeset/3,
      create_changeset: &Lernmit.Achievements.Achievement.admin_changeset/3
    ],
    layout: {LernmitWeb.Layouts, :admin},
    pubsub: [
      topic: "achievement"
    ]

  @impl Backpex.LiveResource
  def singular_name, do: "Erfolge"

  @impl Backpex.LiveResource
  def plural_name, do: "Erfolge"

  @impl Backpex.LiveResource
  def fields do
    [
      image: %{
        module: Backpex.Fields.Text,
        label: "Image"
      },
      title: %{
        module: Backpex.Fields.Text,
        label: "Title",
        searchable: true
      },
      desc: %{
        module: Backpex.Fields.Text,
        label: "Description",
        searchable: true
      }
    ]
  end
end
