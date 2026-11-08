#!/bin/bash
# vhub — cài / nâng cấp box (Armbian, Debian 11/12 arm64) bằng MỘT lệnh:
#
#   curl -fsSL https://raw.githubusercontent.com/quannh/quannh/main/vhub/cai-box.sh | sudo bash
#
# Box ở chi nhánh khác (nối qua Internet bằng Tailscale):
#
#   curl -fsSL https://raw.githubusercontent.com/quannh/quannh/main/vhub/cai-box.sh | sudo bash -s -- --tailscale-authkey <khóa>
#
# Script này chỉ tải gói cài đúng phiên bản bên dưới từ GitHub Releases, KIỂM SHA-256 ghim sẵn
# (gói bị tráo ⇒ dừng, không cài), giải nén rồi chạy vhub-box.sh (cài lại nhiều lần vẫn an toàn).
# Tệp này do scripts/phat-hanh.sh của repo mã nguồn sinh ra — đừng sửa tay.

vhub_cai_box() {
  set -euo pipefail
  local ver="2.3.13"
  local url="https://github.com/quannh/quannh/releases/download/vhub-2.3.13/vhub-box-arm64-2.3.13.tar.gz"
  local sha="4f7985fa1b1899210941ceb80b53eab7a30afaea9f36a5b25e13ce36e84a5b65"

  if [ "$(id -u)" != 0 ]; then
    echo "[LỖI] Cần quyền root — chạy: curl -fsSL … | sudo bash" >&2
    return 1
  fi
  case "$(uname -m)" in
    aarch64|arm64) ;;
    *) echo "[LỖI] Gói này cho box arm64 (máy này: $(uname -m))" >&2; return 1 ;;
  esac
  command -v curl >/dev/null || { echo "[LỖI] Thiếu curl: apt-get install -y curl" >&2; return 1; }

  local tmp
  tmp="$(mktemp -d /tmp/vhub-box.XXXXXX)"
  # Ghi SẴN đường dẫn vào lệnh dọn: trap EXIT chạy sau khi hàm đã thoát ⇒ biến cục bộ `tmp` không còn,
  # với `set -u` lệnh dọn báo «tmp: unbound variable», thoát mã 1 và bỏ lại thư mục tạm (đo 07/11/2026).
  trap "rm -rf -- '$tmp'" EXIT

  echo "[vhub] tải gói cài box $ver …"
  curl -fsSL --retry 3 --retry-delay 2 -o "$tmp/goi.tar.gz" "$url"
  if ! printf '%s  %s\n' "$sha" "$tmp/goi.tar.gz" | sha256sum -c - >/dev/null 2>&1; then
    echo "[LỖI] Gói tải về KHÔNG khớp SHA-256 ghim sẵn — dừng, không cài gì." >&2
    return 1
  fi
  echo "[vhub] gói khớp SHA-256 — giải nén và cài"
  tar xzf "$tmp/goi.tar.gz" -C "$tmp" --no-same-owner --no-same-permissions
  chown -R root:root "$tmp"
  chmod -R u+rwX,go+rX,go-w "$tmp"
  chmod 0755 "$tmp/vhub-box.sh" "$tmp"/*-arm64

  # </dev/null: script đang được bash đọc từ đường ống `curl | bash` — chương trình con đọc stdin
  # sẽ «nuốt» phần còn lại của script. vhub-box.sh không hỏi gì khi không có bàn phím.
  "$tmp/vhub-box.sh" "$@" </dev/null
}

# Gọi ở dòng CUỐI: bash phải đọc hết tệp trước khi chạy (tải dở giữa chừng ⇒ không chạy nửa script).
vhub_cai_box "$@"
