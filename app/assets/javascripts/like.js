function likeBulletin(bulletinId) {
    const likeButton = document.querySelector(`.like-button[data-bulletin-id="${bulletinId}"]`);
  
    fetch(`/bulletins/${bulletinId}/like`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content,
      },
    })
      .then((response) => response.json())
      .then((data) => {
      
        updateLikeCount(bulletinId, data.likes_count);
        updateLikeButtonStyle(bulletinId, likeButton);
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }
  

  function updateLikeCount(bulletinId, newLikeCount) {
    const likeCountElement = document.querySelector(`#like-count-${bulletinId}`);
    if (likeCountElement) {
      likeCountElement.textContent = `${newLikeCount} いいね`;
    }
  }
  

  function updateLikeButtonStyle(bulletinId, likeButton) {
    if (likeButton) {
      likeButton.classList.toggle("liked");
  
      likeButton.style.transform = "scale(1.2)"; 
      setTimeout(() => {
        likeButton.style.transform = "scale(1)";
      }, 100); 
    }
  }