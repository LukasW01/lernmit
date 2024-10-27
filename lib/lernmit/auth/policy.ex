defmodule Lernmit.Auth.Policy do
  @moduledoc """
  Authorization Policies (CRUD)

  @docs: https://hexdocs.pm/let_me/LetMe.Policy.html
  """
  use LetMe.Policy

  object :task do
    action [:create, :delete] do
      allow role: "admin"
      allow role: "teacher"
      deny role: "student"
    end

    action [:read, :update] do
      allow role: "admin"
      allow role: "teacher"
      allow role: "student"
    end
  end
end
