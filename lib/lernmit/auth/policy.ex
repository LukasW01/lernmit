defmodule Lernmit.Auth.Policy do
  use LetMe.Policy

  object :task do
    action :create do
      allow role: "admin"
      allow role: "teacher"
      deny role: "student"
    end

    action :read do
      allow role: "admin"
      allow role: "teacher"
      allow role: "student"
    end

    action :update do
      allow role: "admin"
      allow role: "teacher"
      allow role: "student"
    end

    action :delete do
      allow role: "admin"
      allow role: "teacher"
      deny role: "student"
    end
  end
end
