# frozen_string_literal: true

class ReservationsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.build(user: current_user)

    if @reservation.save
      redirect_to event_path(@event), notice: 'イベントを予約しました。'
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.find(params[:id])
    @reservation.destroy
    redirect_to event_path(@event), notice: '予約をキャンセルしました。'
  end
end
