# module to manage session token and expiration
module Sessionable
  extend ActiveSupport::Concern

  # start the expiration date for session, 30 days
  def start_session
    generate_token(:session_token)
    setup_session
    update_last_session
  end

  def setup_session
    if self.type.include?("Administration::Collaborator")
      raise_has_no_access if access.blank?
      now = Time.now.to_a
      time = Time.new(now[5], now[4], now[3], access.end_time.hour, access.end_time.min, 0, "-03:00")
      update_session(time)
    else
      update_session(30.days.from_now)
    end
  end

  # end the expiration date for session
  def end_session
    update_session(Time.now)
  end

  # refrash the expiration date giving more 30 days
  def refresh_session
    update_session(30.days.from_now)
    update_last_session
  end

  def current_session
    session_expires_at
  end

  def expired_session?
    current_session < Time.now
  end

  def update_session(time)
    update_column(:session_expires_at, time)
  end

  def update_last_session
    update_column(:last_session, Time.now)
  end

  def raise_has_no_access
    raise Exceptions::Simple.build(field: "Acesso", message: "ainda não foi registrado ao seu usuário, solicitar ao seu gestor.")
  end
end
