defmodule Lernmit.ParticipantsTest do
  use Lernmit.DataCase

  alias Lernmit.Participants

  describe "participant" do
    alias Lernmit.Participants.Participant

    import Lernmit.ParticipantsFixtures

    @invalid_attrs %{}

    test "list_participant/0 returns all participant" do
      participant = participant_fixture()
      assert Participants.list_participant() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = participant_fixture()
      assert Participants.get_participant!(participant.id) == participant
    end

    test "create_participant/1 with valid data creates a participant" do
      valid_attrs = %{}

      assert {:ok, %Participant{} = participant} = Participants.create_participant(valid_attrs)
    end

    test "create_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Participants.create_participant(@invalid_attrs)
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = participant_fixture()
      update_attrs = %{}

      assert {:ok, %Participant{} = participant} =
               Participants.update_participant(participant, update_attrs)
    end

    test "update_participant/2 with invalid data returns error changeset" do
      participant = participant_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Participants.update_participant(participant, @invalid_attrs)

      assert participant == Participants.get_participant!(participant.id)
    end

    test "delete_participant/1 deletes the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{}} = Participants.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Participants.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = participant_fixture()
      assert %Ecto.Changeset{} = Participants.change_participant(participant)
    end
  end
end