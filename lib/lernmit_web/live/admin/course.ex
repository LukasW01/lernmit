defmodule LernmitWeb.Live.CourseLive do
  use Backpex.LiveResource,
    layout: {LernmitWeb.Layouts, :admin},
    schema: Lernmit.Courses.Course,
    repo: Lernmit.Repo,
    update_changeset: &Lernmit.Courses.Course.admin_changeset/3,
    create_changeset: &Lernmit.Courses.Course.admin_changeset/3,
    pubsub: Lernmit.PubSub,
    topic: "course",
    event_prefix: "course_"

  @impl Backpex.LiveResource
  def singular_name, do: "Kurs"

  @impl Backpex.LiveResource
  def plural_name, do: "Kurs"

  @impl Backpex.LiveResource
  def fields do
    [
      teacher_id: %{
        module: Backpex.Fields.Number,
        label: "Lehrer",
        searchable: true
      },
      class: %{
        module: Backpex.Fields.Select,
        label: "Klasse",
        options: [
          "Klasse 4 & 5": "Klasse 4 & 5",
          "Klasse 6": "Klasse 6",
          "Klasse 7": "Klasse 7",
          "Klasse 8": "Klasse 8",
          "Klasse 9": "Klasse 9"
        ],
        searchable: true
      },
      subject: %{
        module: Backpex.Fields.Select,
        label: "Fach",
        options: [
          English: "English",
          Mathe: "Mathe",
          Deutsch: "Deutsch",
          Französisch: "Französisch",
          Realien: "Realien"
        ],
        searchable: true
      }
    ]
  end
end
