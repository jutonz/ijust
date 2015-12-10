module Ijust
  class API < Grape::API
    version "v1", using: :header, vendor: :ijust
    format :json
    prefix :api

    resource :things do

      # GET /things
      desc "Get things"
      get do
        Thing.all
      end

      # POST /things
      desc "Add a thing"
      params do
        requires :content, type: String, desc: "e.g. 'went to the store'"
        optional :created_at, type: Time, default: Time.now, desc: "When it happened. Default is now"
      end
      post do
        Thing.create!({
          content:    params[:content],
          created_at: params[:created_at]
        })
      end

      segment "/:thing_id" do

        # GET /things/:thing_id
        desc "Get a specific thing"
        get do
          Thing.find params[:thing_id]
        end

        resource :occurrences do

          # GET /things/:thing_id/occurrences
          desc "Get occurrences of a thing"
          get do
            thing = Thing.find params[:thing_id]
            thing.occurrences
          end

          # POST /things/:thing_id/occurrences
          desc "Add an occurrence"
          params do
            optional :created_at, type: Time, default: Time.now, desc: "When it happened. Default is now"
          end
          post do
            thing = Thing.find params[:thing_id]
            occurrence = thing.occurrences.build({
              created_at: params[:created_at]
            })
            occurrence.save
          end

          # GET /things/:thing_id/occurrences/:occurrence_id
          desc "Get a specific thing occurrence"
          get "/:occurrence_id" do
            Occurrence.find params[:occurrence_id]
          end

          # DELETE /things/:thing_id/occurrences/:occurrence_id
          desc "Delete an occurrence. Also deletes thing if this is its only occurrence."
          delete "/:occurrence_id" do
            Occurrence.find(params[:occurrence_id]).destroy
            thing = Thing.find params[:thing_id]
            thing.destroy if thing.occurrences.count == 0
          end

          # PUT /things/:thing_id/occurrences/:occurrence_id
          desc "Update an occurrence's time"
          params do
            requires :created_at, type: Time, desc: "When it happened."
          end
          put "/:occurrence_id" do
            occurrence = Occurrence.find(params[:occurrence_id])
            occurrence.update!({
              created_at: params[:created_at]
            })
          end
        end
      end

    end


  end
end