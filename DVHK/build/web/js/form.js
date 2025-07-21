$(document).ready(function () {
    function updateSTT() {
        $('.stt').each(function (index) {
            $(this).text(index + 1);
        });
    }

    $('#addMember').click(function () {
        $('#householdMembers tbody').append(`
            <tr class="member-item">
                <td class="text-center">
                    <span class="form-control-plaintext stt"></span>
                </td>
                <td>
                    <input type="text" class="form-control" placeholder="Họ và tên" required>
                </td>
                <td>
                    <input type="text" class="form-control" placeholder="CCCD" required>
                </td>
                <td>
                    <input type="text" class="form-control" placeholder="Quan hệ" required>
                </td>
                <td>
                    <button type="button" class="btn btn-danger w-100 remove-member">Xóa</button>
                </td>
            </tr>
        `);
        updateSTT();
    });

    $(document).on('click', '.remove-member', function () {
        $(this).closest('.member-item').remove();
        updateSTT();
    });

    updateSTT();
});