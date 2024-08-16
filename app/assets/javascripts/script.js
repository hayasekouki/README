// 全てのいいねボタンを取得
const likeButtons = document.querySelectorAll(".likeButton");

// 各いいねボタンにクリックイベントを追加
likeButtons.forEach(button => {
  button.addEventListener("click", () => {
    const questionId = button.dataset.questionId; // 質問のidを取得
    const likeCountElement = document.getElementById(`likeCount-${questionId}`); // 対応するいいね数の要素を取得
    let count = parseInt(likeCountElement.textContent); // 現在のいいね数を取得して数値に変換

    count++; // カウントをインクリメント
    likeCountElement.textContent = count; // インクリメントしたカウントを表示する

    // サーバーにいいね数を送信
    sendLikeCountToServer(questionId, count);
  });
});

// サーバーにいいね数を送信する関数
function sendLikeCountToServer(questionId, count) {
  fetch('/update-like-count', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      questionId: questionId,
      likeCount: count
    })
  })
  .then(response => {
    if (!response.ok) {
      throw new Error('サーバーエラー');
    }
    return response.json();
  })
  .then(data => {
    console.log(data.message);
  })
  .catch(error => {
    console.error(error.message);
  });
}