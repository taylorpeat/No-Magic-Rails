Rails.application.routes.draw do
  get '/posts' => 'application#list_posts'
  get '/posts/:id' => 'application#show_post'
  get '/post/new' => 'application#new_post'
  get '/posts/:id/edit' => 'application#edit_post'
  get  '/comments' => 'application#list_comments'
  post '/posts' => 'application#create_post'
  patch '/posts/:id' => 'application#update_post'
  delete '/posts/:id' => 'application#delete_post'
  post '/posts/:post_id/comments' => 'application#create_comment'
  delete '/posts/:post_id/comments/:id' => 'application#delete_comment'
end
