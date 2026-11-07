# vhub — tệp cài (bản 2.3.8)

vhub thay VirtualHere: chia sẻ máy in, máy quét USB cắm ở box TV (Armbian) cho máy tính Windows và điện thoại
(AirPrint, Mopria). Mã nguồn ở repo riêng tư; ở đây chỉ có tệp cài.

## Cài / nâng cấp box (một lệnh, chạy lại nhiều lần vẫn an toàn)

```sh
curl -fsSL https://raw.githubusercontent.com/quannh/quannh/main/vhub/cai-box.sh | sudo bash
```

Box ở chi nhánh khác (nối qua Internet): thêm `-s -- --tailscale-authkey <khóa>` sau `sudo bash`.
Script tải gói `vhub-box-arm64-2.3.8.tar.gz` từ [Releases](https://github.com/quannh/quannh/releases/tag/vhub-2.3.8), **kiểm SHA-256 ghim sẵn** (`5b1053a70276485a15860e11ae194c028bef652c5550521af7080873b992906c`) rồi mới cài.
Cài xong màn hình in **mã ghép 6 số** cho máy tính đầu tiên (dùng trong 15 phút).

## Cài trên máy tính Windows

**Tải [`vhub.exe`](https://github.com/quannh/quannh/releases/download/vhub-2.3.8/vhub.exe) (~35 MB), bấm là chạy** — không có trình cài nhiều bước,
không cần Internet lúc cài (driver USB/IP đã nằm sẵn trong tệp). Lần đầu mở, vhub hiện màn chào: bấm **Cài đặt**,
đồng ý **một lần** hộp hỏi quyền của Windows ⇒ vhub tự cài driver, chạy nền khi bật máy, có ở menu Start và
Settings → Apps. Bấm «Không» ở hộp hỏi quyền thì vhub vẫn mở như ứng dụng (ghép box được, chưa gắn được máy in).
Đã có vhub mà mở `vhub.exe` bản mới hơn ⇒ vhub hỏi «Cập nhật lên 2.3.8?».

Windows/Avast có thể hiện «Windows đã bảo vệ PC của bạn» hoặc «đang phân tích tệp» (tệp chưa ký số):
bấm **Thông tin thêm → Vẫn chạy**, hoặc chờ Avast quét xong rồi mở lại.

Cài hàng loạt / im lặng: [`vhub-setup-2.3.8.exe`](https://github.com/quannh/quannh/releases/download/vhub-2.3.8/vhub-setup-2.3.8.exe)
`/VERYSILENT /SUPPRESSMSGBOXES /NORESTART` (mã thoát 100: chưa có driver; 101: dịch vụ không chạy), hoặc
`vhub.exe setup install` trong cửa sổ lệnh quyền quản trị (cùng mã thoát).

## Kiểm toàn vẹn

`SHA256SUMS` trong release. Giấy phép thành phần bên thứ ba: usbip-win2 (GPL-3.0 — bộ cài chính thức của tác giả
nằm sẵn trong `vhub.exe`/`vhub-setup-2.3.8.exe`, mã nguồn https://github.com/vadimgrn/usbip-win2), AirSane (GPL-3.0), Epson Scan 2
(LGPL) — nguồn ghi trong `NGUON.txt` của gói box.
