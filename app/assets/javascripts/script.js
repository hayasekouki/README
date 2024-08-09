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

    // ここでサーバーにいいね数を送信する処理を追加できます（省略可能）
  });
});
