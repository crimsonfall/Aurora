// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"

document.addEventListener('DOMContentLoaded', function() {
    // Attach click event to all like buttons
    document.querySelectorAll('.like-button').forEach(function(button) {
      button.addEventListener('click', function() {
        var postId = this.getAttribute('data-post-id');
        var likeCountElement = document.getElementById('like-count-' + postId);
        
        // Create a new FormData object to send the POST request
        var formData = new FormData();
        
        // Use the Fetch API to send the request
        fetch('/posts/' + postId + '/like', {
          method: 'POST',
          body: formData,
          headers: {
            'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
            'Accept': 'application/json'
          }
        })
        .then(response => response.json())
        .then(data => {
          // Update the like count and button text based on the response
          likeCountElement.textContent = data.like_count;
          button.textContent = data.liked ? 'Unlike' : 'Like';
        })
        .catch(error => {
          console.error('Error:', error);
          alert('An error occurred while liking the post.');
        });
      });
    });
  });