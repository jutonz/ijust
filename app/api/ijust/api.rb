module Ijust
  class API < Grape::API
    version "v1", using: :header, vendor: :ijust
    format :json
    formatter :json, Grape::Formatter::ActiveModelSerializers

    resource :occurrences do

      desc "Create an occurrence"
      params do
        requires :occurrence, type: Hash do
          requires :thing_id, type: Integer, desc: "ID of the associated thing"
          optional :created_at, type: Time, default: Time.now, desc: "When it happened. Default is now"
        end
      end
      post do
        occurrence = params[:occurrence]
        thing      = Thing.find occurrence.thing_id
        occurrence = thing.occurrences.build({
          created_at: params[:created_at]
        }).save
      end
      route_param :id do

        # GET /occurrences/:id
        desc "Get an occurrence"
        get do
          Occurrence.find params[:id]
        end

      end
    end

    resource :things do

      # GET /things
      desc "Get things"
      get do
        if (qs = request.query_string).empty?
          Thing.take(20)
        else
          qs = Rack::Utils.parse_nested_query qs
          if content = qs["content"]

            # If someone searches for "store went", we want to return the
            # thing "went to the store".
            #
            # Achieve this by splitting the search on space and having one big
            # "content LIKE %{term1} AND content LIKE ${term2}" query

            words      = content.split " "
            subqueries = words.map { |word| "content LIKE '%#{word}%'" }
            big_query  = subqueries * " AND "

            Thing.where(big_query).take(20)
          end
        end
      end

      # POST /things
      desc "Add a thing"
      params do
        requires :thing, type: Hash do
          requires :content, type: String, desc: "e.g. 'went to the store'"
          optional :created_at, type: Time, default: Time.now, desc: "When it happened. Default is now"
        end
      end
      post do
        thing = params[:thing]

        if existing_thing = Thing.find_by(content: thing.content)
          occurrence = existing_thing.occurrences.build({
            created_at: thing.created_at
          })
          occurrence.save
        else
          new_thing = Thing.create!({
            content:    thing.content,
            created_at: thing.created_at
          })

          new_thing.occurrences.build({
            created_at: thing.created_at
          })

          new_thing.save
        end
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
