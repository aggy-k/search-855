class PagesController < ApplicationController
  def home
    # @documents => array of PgSearch::Document instances, not Movie, not TV Show instances
    @documents = PgSearch::Document.all

    if params[:query].present?
      @documents = PgSearch.multisearch(params[:query])
    end
  end
end
# TvShow => Tv Show
