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
  fetch('/update_like_count', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    },
    body: JSON.stringify({
      question_id: questionId,
      like_count: count
    })
  })
  .then(response => response.json())
  .then(data => {
    console.log('サーバーからのレスポンス:', data);
  })
  .catch(error => {
    console.error('エラー:', error);
  });
}