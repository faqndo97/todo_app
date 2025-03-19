module CustomTurboStreamActions
  def redirect_to(url = nil, turbo_action: "advance", turbo_frame: nil, flash: {})
    flash = render_template("shared/toast", nil, allow_inferred_rendering: true, partial: flash[:partial], locals: flash[:locals]).to_s

    turbo_stream_action_tag :redirect_to, url:, "turbo-action": turbo_action, turbo_frame:, toast: flash
  end

  def reset_form(target, **attributes)
    turbo_stream_action_tag :reset_form, target:, **attributes
  end
end

Turbo::Streams::TagBuilder.prepend(CustomTurboStreamActions)
