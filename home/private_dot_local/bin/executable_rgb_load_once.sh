#!/usr/bin/env bash
set -euo pipefail

# 平滑化(EMA) 係数: alpha = ALPHA_NUM/ALPHA_DEN
# 小さいほど滑らか（追従は遅くなる）
ALPHA_NUM=1
ALPHA_DEN=6

# 明るさレンジ (0..255)
# 低負荷でも完全に消えないように MIN を少し上げるのが実用的
MIN_BRIGHT=40
MAX_BRIGHT=255

STATE_DIR="${XDG_RUNTIME_DIR:-/run/user/$UID}"
STATE_FILE="$STATE_DIR/openrgb_load_ema"

# /proc/stat からCPU使用率を取る（短いサンプルでOK）
read -r _ u1 n1 s1 i1 io1 irq1 sirq1 st1 _ < /proc/stat
t1=$((u1+n1+s1+i1+io1+irq1+sirq1+st1))
id1=$((i1+io1))
sleep 0.20
read -r _ u2 n2 s2 i2 io2 irq2 sirq2 st2 _ < /proc/stat
t2=$((u2+n2+s2+i2+io2+irq2+sirq2+st2))
id2=$((i2+io2))

dt=$((t2 - t1))
didle=$((id2 - id1))
if [ "$dt" -le 0 ]; then
  cpu=0
else
  cpu=$(( ((dt - didle) * 100) / dt ))
fi
if [ "$cpu" -lt 0 ]; then cpu=0; fi
if [ "$cpu" -gt 100 ]; then cpu=100; fi

# 前回EMA
prev=0
if [ -f "$STATE_FILE" ]; then
  prev=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
fi
if [ -z "${prev}" ]; then prev=0; fi

# EMA更新
ema=$(( ((ALPHA_DEN-ALPHA_NUM)*prev + ALPHA_NUM*cpu) / ALPHA_DEN ))
echo "$ema" > "$STATE_FILE"

# 色: 0..50 青->緑, 50..100 緑->赤
if [ "$ema" -le 50 ]; then
  R=0
  G=$(( ema * 255 / 50 ))
  B=$(( 255 - (ema * 255 / 50) ))
else
  T=$(( ema - 50 ))
  R=$(( T * 255 / 50 ))
  G=$(( 255 - (T * 255 / 50) ))
  B=0
fi

# 明るさ: ema(0..100) を MIN_BRIGHT..MAX_BRIGHT に写像
BR=$(( MIN_BRIGHT + (ema * (MAX_BRIGHT - MIN_BRIGHT) / 100) ))
if [ "$BR" -lt 0 ]; then BR=0; fi
if [ "$BR" -gt 255 ]; then BR=255; fi

# RGBを明るさでスケール（0..255）
R=$(( R * BR / 255 ))
G=$(( G * BR / 255 ))
B=$(( B * BR / 255 ))

printf -v HEX "%02X%02X%02X" "$R" "$G" "$B"

flatpak run org.openrgb.OpenRGB -c "$HEX" >/dev/null 2>&1 || true
