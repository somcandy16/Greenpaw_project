/**
 * delete modal
 */


let seq = document.getElementById('seq').value;
console.log(seq);

let deleteBtn = document.getElementById('delete');

deleteBtn.addEventListener('click', ()=>{
	console.log('delete click!')
	Swal.fire({
	  title: '정말 삭제하시겠습니까?',
	  text: "삭제하시면 되돌릴 수 없습니다.",
	  icon: 'warning',
	  showCancelButton: true,
	  confirmButtonColor: '#3085d6',
	  cancelButtonColor: '#d33',
	  confirmButtonText: '네 삭제할래요!',
	  cancelButtonText: '취소',
	  showLoaderOnConfirm: true,
	  backdrop: true,
	  preConfirm: () => {
	    return fetch(`../personal_album/personal_album_delete_ok.jsp?seq=${seq}`)
	      .then(response => {
	        if (!response.ok) {
	          throw new Error(response.statusText)
	        }
	        return response.json()
	      })
	      .catch(error => {
	        Swal.showValidationMessage(
	          '시스템 에러'
	        )
	      })
	  },
	  allowOutsideClick: () => !Swal.isLoading()
	}).then((result) => {
		console.log(result);
	  if (result.isConfirmed == true) {
	    Swal.fire({
	      title: '삭제되었습니다.'
	    }).then((result)=>{
			if (result.isConfirmed) {
				location.href='./personal_album_list.jsp' //list 페이지로 이동						
				}
	  		})
		}
	})
});

