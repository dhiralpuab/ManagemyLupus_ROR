//= require modal

function openStartModal() {
    alert("Hello");
  const btn = document.getElementById('startButton');
  if (btn) btn.classList.add('hidden');

  const modal = document.getElementById('myModal');
  if (modal) modal.classList.add('show');
}

function closeStartModal() {
  const modal = document.getElementById('myModal');
  if (modal) modal.classList.remove('show');

  const btn = document.getElementById('startButton');
  if (btn) btn.classList.remove('hidden');
}

function toggleKidneyOptions() {
  const status = document.querySelector('input[name="status"]:checked')?.value;
  const kidneyDiv = document.getElementById('kidneyOptions');
  if (!kidneyDiv) return;

  if (status === 'active_kidneys') {
    kidneyDiv.style.display = 'block';
  } else {
    kidneyDiv.style.display = 'none';
    kidneyDiv.querySelectorAll('input[type="radio"]').forEach(el => el.checked = false);
  }
}
