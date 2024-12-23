defmodule LernmitWeb.Router do
  use LernmitWeb, :router
  use Pow.Phoenix.Router
  use PowAssent.Phoenix.Router

  import Backpex.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LernmitWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :skip_csrf_protection do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  scope "/" do
    pipe_through :skip_csrf_protection

    pow_assent_authorization_post_callback_routes()
  end

  scope "/" do
    pipe_through :browser

    pow_session_routes()
    pow_assent_routes()
  end

  scope "/", LernmitWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", LernmitWeb do
    pipe_through [:browser, :protected]

    live "/achievement", AchievementLive.Index, :index

    live "/task", TaskLive.Index, :index
    live "/task/new", TaskLive.Index, :new
    live "/task/:id/edit", TaskLive.Index, :edit
    live "/task/:id", TaskLive.Show, :show

    live "/learnset", LearnsetLive.Index, :index
    live "/learnset/new", LearnsetLive.Index, :new
    live "/learnset/:id/edit", LearnsetLive.Index, :edit
    live "/learnset/:id", LearnsetLive.Show, :show
    live "/learnset/:id/flashcard", LearnsetLive.Flashcard, :show
    live "/learnset/:id/multiple_choice", LearnsetLive.MultipleChoice, :show

    live "/calendar/month", CalendarLive.Month, :index
    live "/calendar/week", CalendarLive.Week, :index

    resources "/cards", CardController, only: [:show, :index]
  end

  scope "/admin", LernmitWeb do
    pipe_through [:browser, :protected]

    backpex_routes()

    live_session :default, on_mount: Backpex.InitAssigns do
      live_resources "/achievement", Live.AchievementLive
      live_resources "/participant", Live.ParticipantLive
      live_resources "/course", Live.CourseLive
      live_resources "/", Live.UserLive
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", LernmitWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:lernmit, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: LernmitWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
