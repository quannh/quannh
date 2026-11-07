# vhub — tệp cài (bản 2.3.5)

vhub thay VirtualHere: chia sẻ máy in, máy quét USB cắm ở box TV (Armbian) cho máy tính Windows và điện thoại
(AirPrint, Mopria). Mã nguồn ở repo riêng tư; ở đây chỉ có tệp cài.

## Cài / nâng cấp box (một lệnh, chạy lại nhiều lần vẫn an toàn)

```sh
curl -fsSL https://raw.githubusercontent.com/quannh/quannh/main/vhub/cai-box.sh | sudo bash
```

Box ở chi nhánh khác (nối qua Internet): thêm `-s -- --tailscale-authkey <khóa>` sau `sudo bash`.
Script tải gói `vhub-box-arm64-2.3.5.tar.gz` từ [Releases](https://github.com/quannh/quannh/releases/tag/vhub-2.3.5), **kiểm SHA-256 ghim sẵn** (`3dbc56eb03c111d0002abe5298dd3872ba2515ff75586ae017bb35f3c83ed5b1`) rồi mới cài.
Cài xong màn hình in **mã ghép 6 số** cho máy tính đầu tiên (dùng trong 15 phút).

## Cài trên máy tính Windows

Tải [`vhub-setup-2.3.5.exe`](https://github.com/quannh/quannh/releases/download/vhub-2.3.5/vhub-setup-2.3.5.exe), chạy, bấm Tiếp theo → Cài đặt.
Windows có thể hiện «Windows đã bảo vệ PC của bạn» (bộ cài chưa ký số): bấm **Thông tin thêm → Vẫn chạy**.
Cài im lặng cho nhiều máy: `vhub-setup-2.3.5.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART`.

## Kiểm toàn vẹn

`SHA256SUMS` trong release. Giấy phép thành phần bên thứ ba: usbip-win2 (GPL-3.0, bộ cài Windows tải từ
GitHub của tác giả), AirSane (GPL-3.0), Epson Scan 2 (LGPL) — nguồn ghi trong `NGUON.txt` của gói box.
