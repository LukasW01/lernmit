defmodule Lernmit.Auth.Policy do
  @moduledoc """
  Authorization Policies (CRUD)

  @docs: https://hexdocs.pm/let_me/LetMe.Policy.html
  """
  use LetMe.Policy

  object :task do
    action [:create, :delete, :update] do
      allow role: "admin"
      allow role: "teacher"
      deny role: "student"
    end

    action [:read] do
      allow role: "admin"
      allow role: "teacher"
      allow role: "student"
    end
  end
end
