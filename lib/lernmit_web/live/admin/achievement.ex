defmodule LernmitWeb.Live.AchievementLive do
  use Backpex.LiveResource,
    layout: {LernmitWeb.Layouts, :admin},
    schema: Lernmit.Achievements.Achievement,
    repo: Lernmit.Repo,
    update_changeset: &Lernmit.Achievements.Achievement.admin_changeset/3,
    create_changeset: &Lernmit.Achievements.Achievement.admin_changeset/3,
    pubsub: Lernmit.PubSub,
    topic: "achievement",
    event_prefix: "achievement_"

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
