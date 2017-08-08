Rails.application.routes.draw do
  get '/list_posts' => 'application#list_posts'
  get '/show_post/:id' => 'application#show_post'
  get '/new_post' => 'application#new_post'
  get '/edit_post/:id' => 'application#edit_post'
  post '/create_post' => 'application#create_post'
  post '/update_post' => 'application#update_post'
  post '/delete_post/:id' => 'application#delete_post'
  post '/create_comment_for_post/:post_id' => 'application#create_comment'
  post '/list_posts/:post_id/delete_comment/:comment_id' => 'application#delete_comment'
end
