defmodule LernmitWeb.Live.ParticipantLive do
  use Backpex.LiveResource,
    adapter_config: [
      repo: Lernmit.Repo,
      schema: Lernmit.Participants.Participant,
      update_changeset: &Lernmit.Participants.Participant.admin_changeset/3,
      create_changeset: &Lernmit.Participants.Participant.admin_changeset/3
    ],
    layout: {LernmitWeb.Layouts, :admin},
    pubsub: [
      name: Lernmit.PubSub,
      topic: "participant",
      event_prefix: "participant_"
    ]

  @impl Backpex.LiveResource
  def singular_name, do: "Teilnehmer"

  @impl Backpex.LiveResource
  def plural_name, do: "Teilnehmer"

  @impl Backpex.LiveResource
  def fields do
    [
      course_id: %{
        module: Backpex.Fields.Number,
        label: "Kurs",
        options: [English_KL9: 1],
        searchable: true
      },
      student_id: %{
        module: Backpex.Fields.Number,
        label: "Student",
        options: [Admin: 1, User: 1],
        searchable: true
      }
    ]
  end
end
