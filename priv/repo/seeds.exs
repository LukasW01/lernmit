# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lernmit.Repo.insert!(%Lernmit.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# priv/repo/seeds.exs

alias Lernmit.Repo
alias Lernmit.Achievements.Achievement

badges = [
  %{
    image: "badge_CreatedFirstSet.svg",
    title: "Set builder",
    desc: "Awarded for creating your first set!"
  },
  %{
    image: "badge_Overachiever.svg",
    title: "Overachiever",
    desc: "Awarded for getting your first high score!"
  },
  %{
    image: "badge_EarlyBird.svg",
    title: "Early bird",
    desc: "Awarded for an early morning study session!"
  },
  %{
    image: "badge_Flashcards.svg",
    title: "Flashcard whiz",
    desc: "Awarded for studying with Flashcards for the first time!"
  },
  %{
    image: "badge_NightOwl.svg",
    title: "Night Owl",
    desc: "Awarded for a late night study session!"
  },
  %{
    image: "badge_Learner.svg",
    title: "Active learner",
    desc: "Awarded for actively learning!"
  },
  %{
    image: "badge_ActiveTester.svg",
    title: "Test acer",
    desc: "Awarded for actively testing your knowledge!"
  }
]

Enum.each(badges, fn b ->
  %Achievement{}
  |> Achievement.changeset(b)
  |> Repo.insert!()
end)
