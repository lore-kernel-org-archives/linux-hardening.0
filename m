Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077102;
	b=P1MPAemDrLgs45yNu+hn8JdFUJYLSXMiXHw7Sx0EYb9X+abNUXKxNC67unXigSCF+2KT
	 BcCE+iXZRgEikkFcYIdYwElqtl04KplduEn90/cdPprLQaNviAasdvjVT9xpRyQ/S9zOT
	 PxCLxc+kWglCHGBGMjWEoVoVbGlD1KcZoarmvFuPOGqrC0A4HY1rPN2Y5zEbEpJpFxMEB
	 lpnM201yvHMmsQVyIwoLYiUwWPuJQ5mF43f/ZoRxoGB5kF1yNF9153zwp6EA2Qa+uPIpJ
	 k09gXk3gDzU4WC2g6ReuVa5lxxj4XZiHMmKFYHJzYGkF2qnMNoc4dpx0/So8d3ZRgbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u3pF9cSG2s2OvUiOff2e3lsOipUwDDFyl2aM5L15+sk=;
	b=VeHLXliaIzYPBWv3HKO0dLq6mOt85UZT0XZkcRTeJF09J4u7jCJL1VCvc3COARP8IY3I
	 Fvfxz2OyxG5SJzneLsI3MFwAgbuwDnKjsj4erW4ShLYC0TaN6le0PvElmPKLPsUopmNia
	 0KGNAyyKALucNGMgL/XL7pthZ6UJ8hllubhl2N5DguGhWgB5RYoV9NaxQaVq9C1JfdYb1
	 lhywRlphCrSEFcYFHwACzq5ZfWDbYrMxsKoNxKyd0gVtMz0f3thqJmksNOPkCEAoWE3rb
	 AVelJRP/HN0CELpfsZM7a2mFYuB1rlEGKBaSJjCqoJnGYzwstyZ9QV70AkGYpi9QSeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=v223FkNi;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6FA606EEB0
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 18:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA6FA606EEB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=v223FkNi
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2805136eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794077100; x=1794681900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u3pF9cSG2s2OvUiOff2e3lsOipUwDDFyl2aM5L15+sk=;
        b=v223FkNijesrgNpTUfmBe6Qu54+NRmuf0tnJdnKwuFzr+Lv4YB2EnGU52GX/Ldm6Z2
         dLtexW34puVcO52oSJTijenVjq55fO/dMZg3Fh8WOL7GNtFHzffluF62CqOXnVb8LPtj
         WBpUUCG+Wd0bhtZciAA6aTZej13YWY+ZFFmwIMu8q9AAyuFMhmSBes2n53yaYipv97b6
         BjtVUrCx50MZpkmho9WxqU02v4oUqIgfpSiNz75rPZg8Rc043hgmXP/0DfGm48lEffiU
         n0ZPL/Uahn9qnb3H4q+Fjo1cSVK9tvNZRkiLGQvcMnBuBcIP5pd18vXHqNOzKYozxUzU
         3w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077100; x=1794681900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u3pF9cSG2s2OvUiOff2e3lsOipUwDDFyl2aM5L15+sk=;
        b=d4g+kFWDZRM6CnSP6iMndNInNCaA4gSfuX43PeFlVxOdRg5NdYcHcVTWSuW/aqOjq7
         Fxjt23MGx5Zxs1ElbpjYhhZlhnue8DDvt99Cui/ShxKTQLCoWxfwKr0VKXnDOWzAwARb
         fL33dsOOFbgARWosM6hridNVQ3wh2mgBOXScJIotVFGR/TdJb1xfaHt3X0wjSTCRY0d8
         1OU5JypLvsYGOFhCWnYFJtOwK8i6dU5H9DFCEZuyb6VSRo5eE3YGq2rar471l/e3SfGh
         j7451JlZj2pWF7s0JOY0qJBZVJGYyHziqPPW1A0tKhkiGxOp/AjCkJgW0f7+wRzrLTVF
         x1Iw==
X-Forwarded-Encrypted: i=1; AL+hErE92kOt9a4UmtHkQZm1yTNDBw7GEfM9uACmgzyHQcdxc8PNZ4sVGADOA+fBc4NBtc4nBkb7TWAJzYtXoFXT+pE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LR4ldSRrRdrG/mm078M1VZlhcvQbJguRSr/VLxKbiaonAWY4R
	DicBDIzddZL+/8tnykmJP3HqdadrqmftFcdY6m74yjEWU58E51YU8a3tWx17LiezZJs=
X-Gm-Gg: AYBFou10LnglzaPZjkyqM2rvsrS4YdQE15YAWYytKNTU5OXTcZP2ph9n8w7GSc51nNA
	ct6FoMTU1izaHVWCPNxlRfLyPXXj86JpuPD6QBayef+/O3i92gUHBbDtZJvrkFY8lfJUvW7BKof
	AS6q3rjiZtjTGv8smY5Iuig36YxVkxiAEjjU7gbVJFiRCJGWfpO8PhhYR9mhxexlGSCq5zi33br
	6jUFjUPMyutb3tz5VqicZuexCl8VOnBR2831eoFWs2M4pn7ja5hHTceCS7g7T9iIiH780rM3a6e
	Fl5W/m7vZqhEg9aMjk11BwYGvRVHlIoNjixlH+PWcIfuWcnRKSGpzJg3spDq70MStNNj5SW7C2M
	9l0BAqwLoTAkAnkiBpYEUYuCE1R3lpTEq+mUsB/lXTlvDj18iSI5nrj4FInTdkjhKETBxRRjXup
	WQDIz4eDG5fBls0pI/dyQ++Pb5ht4WDwnYvc/Mhe7JClN/CX/Y00k595PTwyx3SGrL9zDmGWc3P
	Xulzx76GbHZu9vMZOreL7oJmRz9t06FqxqK8aQEq+AlObZE76CdP3u/kX0ElIKC6eLdkzq2JLQC
	fURPQXXJKm42WEDrNBl7aidTNI8dEMZk9KuQMRA94p731HxEHduu8ZZ9PbhJzNXMwHoob+g=
X-Received: by 2002:a05:7300:b0aa:b0:36f:4d62:2884 with SMTP id 5a478bee46e88-36f7691a412mr8340188eec.30.1794077099785;
        Sat, 07 Nov 2026 10:44:59 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:44:58 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	brett.creeley@amd.com,
	sgoutham@marvell.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Ido Schimmel <idosch@nvidia.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 8/9] selftests: net: add amt_offload.sh for AMT relay offload
Date: Sat,  7 Nov 2026 18:44:36 +0000
Message-ID: <20261107184437.2783174-9-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107184437.2783174-1-omar@blockcast.net>
References: <20261107184437.2783174-1-omar@blockcast.net>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise the AMT relay replication offload contract against netdevsim's
TX reference provider. A relay in offload auto mode transmits on one
netdevsim port; four in-tree AMT gateways, each in its own netns (an amt
device binds relay_port on INADDR_ANY, so two gateways cannot share
one), reach its peer through a bridge. Copies are counted per gateway on
the decapsulating amtg device, and hardware copies on the provider's own
counter, so the eleven assertions are about what actually reached each
gateway:

 1. no membership: no copy anywhere
 2. one copy per committed endpoint per packet, all from the provider,
    and the provider's devlink resources agree
 3. members joining under traffic (generation replace): stable members
    get exactly one copy of every packet, and every copy comes from the
    provider
 4. xmit BUSY: exactly one software copy set, counted
 5. forwarding is per group: an INCLUDE(S1) member still receives S2
 6. a programming op overruns op_timeout_ms: amt resets the provider,
    ignores the stale result, replays, and copies stay at one; the
    provider's health reporter records it
 7. partial commit (group_update succeeds, group_commit fails): no
    hardware copy, the group is served in software
 8. every member leaves: once the relay times their sources out, the
    group is disabled, no copy anywhere
 9. offload required with no provider: refused with an extack, counted
10. the peer unlinked under traffic, relinked, then the relay's netdevsim
    deleted under traffic: ordered teardown, no splat
11. a lower carrying two amt devices deleted: both go with it, no splat
    (runs first, in its own netns, independent of the offload setup;
    one dmesg snapshot after its netns teardown ends its splat scan
    and starts case 10's)

No IGMPv3 leave takes effect at once on this base: a BLOCK or TO_IN
leaves the timer of each source it drops alone, so the relay keeps the
source until that timer expires, at least a GMI (260 s by default)
after the last report that refreshed it. So case 3 drives its
generation replaces with joins alone, and case 8 waits out the GMI.

The test SKIPs, loudly, when ip cannot set the offload mode or the
netdevsim has no provider, rather than silently testing software only.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/amt_offload.sh | 608 +++++++++++++++++++++
 tools/testing/selftests/net/config         |   2 +
 3 files changed, 611 insertions(+)
 create mode 100755 tools/testing/selftests/net/amt_offload.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5db68de0b..2d6c6de0d 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -11,6 +11,7 @@ TEST_PROGS := \
 	amt.sh \
 	amt_v6.sh \
 	amt_gw_v6.sh \
+	amt_offload.sh \
 	amt_scale.sh \
 	arp_ndisc_evict_nocarrier.sh \
 	arp_ndisc_untracked_subnets.sh \
diff --git a/tools/testing/selftests/net/amt_offload.sh b/tools/testing/selftests/net/amt_offload.sh
new file mode 100755
index 000000000..4e00fba0b
--- /dev/null
+++ b/tools/testing/selftests/net/amt_offload.sh
@@ -0,0 +1,608 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# AMT relay replication offload, against netdevsim's TX reference provider.
+#
+# netdevsim keeps its own endpoint and group tables and emits each copy
+# through amt_offload_encap_xmit() out of the relay's stream device to its
+# peer, so a divergence between what amt wants and what the provider
+# committed shows up as a wrong copy count at the gateways. Copies are
+# counted per gateway on the decapsulating amtg device (AF_PACKET), and
+# hardware copies on the provider's own counter in debugfs.
+#
+#   RELAY netns                                GATEWAY netns
+#   src0 (S1 172.17.0.2, S2 172.17.0.3)
+#     | sender, IP_MULTICAST_IF amtr
+#   amtr (relay, offload auto)
+#     | stream_dev
+#   nsim_r 10.0.0.2/24  <== netdevsim peer link ==>  nsim_g -- br0
+#                                                              |
+#                                     veth to GATEWAY netns i = 1..4:
+#                                     gw<i> 10.0.0.1<i>/24, amtg<i>
+#
+# One gateway per netns: an amt device binds its UDP socket to relay_port
+# on INADDR_ANY in its netns, gateways included, so a second gateway in
+# the same netns fails to come up with EADDRINUSE.
+#
+# The source sits in the relay netns and transmits on amtr directly: how
+# multicast reaches amtr (mroute) is not under test, amt_dev_xmit is.
+#
+# Eleven assertions, each printing one "TEST: ... [ OK ]" line; the run
+# passes only if all eleven printed OK.
+
+source "$(dirname "$0")"/lib.sh
+
+readonly RELAY=$(mktemp -u amtofl-r-XXXXXXXX)
+readonly GW=$(mktemp -u amtofl-g-XXXXXXXX)
+readonly TMP=$(mktemp -d)
+readonly G1=239.1.1.1 G2=239.1.1.2 G3=239.1.1.3 G4=232.1.1.4 G5=239.1.1.5
+readonly S1=172.17.0.2 S2=172.17.0.3
+readonly K=50
+NSIM_R_ID=$((256 + RANDOM % 256))
+NSIM_G_ID=$((NSIM_R_ID + 256))
+readonly NSIM_SYS=/sys/bus/netdevsim
+readonly DFS=/sys/kernel/debug/netdevsim/netdevsim$NSIM_R_ID/ports/0/amt
+readonly DL=netdevsim/netdevsim$NSIM_R_ID
+ERR=$ksft_skip
+OKS=0
+PIDS=()
+gwns() { echo "$GW-$1"; }
+declare -A JOIN
+
+cleanup()
+{
+	for p in "${PIDS[@]}" "${JOIN[@]}"; do
+		kill "$p" 2>/dev/null
+	done
+	wait 2>/dev/null
+	ip netns del "$RELAY" 2>/dev/null
+	ip netns del "$GW" 2>/dev/null
+	for i in 1 2 3 4 mu; do
+		ip netns del "$(gwns $i)" 2>/dev/null
+	done
+	echo "$NSIM_R_ID" > $NSIM_SYS/del_device 2>/dev/null
+	echo "$NSIM_G_ID" > $NSIM_SYS/del_device 2>/dev/null
+	rm -rf "$TMP"
+	exit $ERR
+}
+
+skip()
+{
+	echo "SKIP: $*"
+	# A failure already printed (assertion 11 runs before the provider
+	# checks) must not be reported as a skip.
+	[ "$ERR" = 1 ] || ERR=$ksft_skip
+	exit $ERR
+}
+
+ok()
+{
+	printf "TEST: %-62s  [ OK ]\n" "$1"
+	OKS=$((OKS + 1))
+}
+
+fail()
+{
+	printf "TEST: %-62s  [FAIL]\n" "$1"
+	shift
+	[ $# -gt 0 ] && echo "      $*"
+	ERR=1
+	return 0
+}
+
+# --- helpers --------------------------------------------------------------
+
+cat > "$TMP/join.py" <<'EOF'
+# join.py IFNAME GROUP [SOURCE]: hold an ASM or SSM membership on IFNAME
+# until killed; leaving is closing the socket.
+import signal, socket, struct, sys, time
+ifn, grp = sys.argv[1], sys.argv[2]
+src = sys.argv[3] if len(sys.argv) > 3 else None
+def sin(a):
+    return struct.pack('=HH4s120x', socket.AF_INET, 0, socket.inet_aton(a))
+s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+req = struct.pack('=I4x', socket.if_nametoindex(ifn)) + sin(grp)
+if src:
+    s.setsockopt(socket.IPPROTO_IP, 46, req + sin(src)) # MCAST_JOIN_SOURCE_GROUP
+else:
+    s.setsockopt(socket.IPPROTO_IP, 42, req)            # MCAST_JOIN_GROUP
+signal.signal(signal.SIGTERM, lambda *a: sys.exit(0))
+while True:
+    time.sleep(3600)
+EOF
+
+cat > "$TMP/send.py" <<'EOF'
+# send.py IFNAME SRC GROUP COUNT INTERVAL: COUNT UDP datagrams to GROUP:5000
+# from SRC out of IFNAME. Send errors (the device going away) are ignored.
+import socket, struct, sys, time
+ifn, src, grp, n, ivl = sys.argv[1:6]
+s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+s.bind((src, 0))
+s.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_IF,
+             struct.pack('=4s4si', bytes(4), bytes(4),
+                         socket.if_nametoindex(ifn)))
+s.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_TTL, 8)
+s.setsockopt(socket.IPPROTO_IP, socket.IP_MULTICAST_LOOP, 0)
+for i in range(int(n)):
+    try:
+        s.sendto(b'%08d' % i + bytes(56), (grp, 5000))
+    except OSError:
+        pass
+    time.sleep(float(ivl))
+EOF
+
+cat > "$TMP/count.py" <<'EOF'
+# count.py IFNAME...: count received UDP datagrams to port 5000 per
+# (interface, source, group) until SIGTERM, then read what is already
+# queued and print one line per key.
+import collections, select, signal, socket, sys
+socks = {}
+for ifn in sys.argv[1:]:
+    s = socket.socket(socket.AF_PACKET, socket.SOCK_DGRAM, socket.htons(0x0800))
+    s.bind((ifn, 0x0800))
+    socks[s] = ifn
+cnt = collections.Counter()
+done = False
+def stop(*a):
+    global done
+    done = True
+signal.signal(signal.SIGTERM, stop)
+sys.stdout.write('READY\n'); sys.stdout.flush()
+while True:
+    r = select.select(list(socks), [], [], 0 if done else 0.1)[0]
+    if not r and done:
+        break
+    for s in r:
+        d, a = s.recvfrom(4096)
+        if a[2] == socket.PACKET_OUTGOING or len(d) < 28 or d[9] != 17:
+            continue
+        hl = (d[0] & 15) * 4
+        if int.from_bytes(d[hl + 2:hl + 4], 'big') != 5000:
+            continue
+        cnt[(socks[s], socket.inet_ntoa(d[12:16]),
+             socket.inet_ntoa(d[16:20]))] += 1
+for (ifn, src, grp), n in sorted(cnt.items()):
+    print(ifn, src, grp, n)
+EOF
+
+dfs() { cat "$DFS/$1"; }
+dfs_set() { echo "$2" > "$DFS/$1"; }
+rsys() { ip netns exec "$RELAY" cat "/sys/class/net/amtr/offload/$1"; }
+
+# Committed member count of group $1 in the provider's own table, or 0.
+hw_members()
+{
+	awk -v g="group $1" '
+		$0 == g { in_g = 1; next }
+		/^group / || /^endpoint / || /^binding / { in_g = 0 }
+		in_g && $1 == "committed" { n = $5; sub(":", "", n); print n; f = 1; exit }
+		END { if (!f) print 0 }' "$DFS/tables"
+}
+
+hw_group_present()
+{
+	grep -qx "group $1" "$DFS/tables"
+}
+
+# wait_for SECONDS CMD...: poll CMD every 0.2s.
+wait_for()
+{
+	local t=$(( $1 * 5 ))
+
+	shift
+	while [ $t -gt 0 ]; do
+		"$@" && return 0
+		sleep 0.2
+		t=$((t - 1))
+	done
+	return 1
+}
+
+members_eq() { [ "$(hw_members "$1")" = "$2" ]; }
+group_gone() { ! hw_group_present "$1"; }
+sysfs_ge() { [ "$(rsys "$1")" -ge "$2" ]; }
+
+# Members that later leave join source-specific, so a relay that applies
+# INCLUDE leaves at once drops the group at once. This base does not: a
+# BLOCK or TO_IN leaves the timer of each source it drops alone, so the
+# relay keeps the source until that timer expires, at least a GMI after
+# the last report that refreshed it, and deletes the group with its last
+# source (an ASM leave waits out the group timer the same way). So case 8
+# waits out the GMI, and case 3 drives its generation replaces with joins
+# alone.
+join()	# join KEY IFNAME GROUP [SOURCE]
+{
+	local key=$1
+
+	shift
+	ip netns exec "$(gwns "${1#amtg}")" python3 "$TMP/join.py" "$@" &
+	JOIN[$key]=$!
+}
+
+leave()
+{
+	kill "${JOIN[$1]}" 2>/dev/null
+	wait "${JOIN[$1]}" 2>/dev/null
+	unset "JOIN[$1]"
+}
+
+# measure SRC GROUP COUNT INTERVAL [HOOK]: send, count per gateway, and
+# the provider's hardware copies. Fills CNT[amtgN] (copies from SRC to
+# GROUP) and HW (tx_copies delta). The counters run until a second after
+# the last packet is sent, however long sending takes. HOOK, a function
+# that must not block, runs once every counter is ready, just before the
+# first packet.
+declare -A CNT
+HW=0
+measure()
+{
+	local src=$1 grp=$2 n=$3 ivl=$4 hw0 line i cpids=()
+
+	hw0=$(dfs tx_copies)
+	for i in 1 2 3 4; do
+		ip netns exec "$(gwns $i)" python3 "$TMP/count.py" amtg$i \
+			> "$TMP/count$i.out" &
+		cpids+=($!)
+	done
+	for i in 1 2 3 4; do
+		wait_for 5 grep -q READY "$TMP/count$i.out"
+	done
+	[ -z "${5:-}" ] || "$5"
+	ip netns exec "$RELAY" python3 "$TMP/send.py" amtr "$src" "$grp" "$n" \
+		"$ivl"
+	sleep 1
+	kill -TERM "${cpids[@]}" 2>/dev/null
+	wait "${cpids[@]}"
+	HW=$(( $(dfs tx_copies) - hw0 ))
+	CNT=([amtg1]=0 [amtg2]=0 [amtg3]=0 [amtg4]=0)
+	while read -r ifn s g c; do
+		[ "$s" = "$src" ] && [ "$g" = "$grp" ] && CNT[$ifn]=$c
+	done < <(cat "$TMP"/count[1-4].out | grep -v READY)
+}
+
+counts() { echo "amtg1..4=${CNT[amtg1]},${CNT[amtg2]},${CNT[amtg3]},${CNT[amtg4]} hw=$HW"; }
+
+dl_occ()
+{
+	devlink -j resource show "$DL" | jq -r --arg r "$1" \
+		'.resources[][] | select(.name == "amt") | .resources[] |
+		 select(.name == $r) | .occ'
+}
+
+# --- preflight ------------------------------------------------------------
+
+[ "$(id -u)" -eq 0 ] || skip "needs root"
+for c in python3 jq devlink; do
+	command -v $c > /dev/null || skip "$c not found"
+done
+# A guest whose ip cannot set the mode would silently test software only.
+ip link help amt 2>&1 | grep -q 'offload OFFLOAD' ||
+	skip "ip lacks IFLA_AMT_OFFLOAD_MODE (iproute2 amt offload patch)"
+modprobe amt 2>/dev/null
+modprobe netdevsim 2>/dev/null
+[ -w $NSIM_SYS/new_device ] || skip "netdevsim not available"
+
+trap cleanup EXIT
+DMESG0=$(dmesg | wc -l)
+
+# --- 11. a lower carrying two amt devices is deleted ------------------------
+# Not offload, so it runs first, in its own netns, and is not lost when
+# the offload setup below fails: the amt notifier must take down every
+# amt device on an unregistering lower, not just the first.
+# One left linked trips the upper-dev WARN in
+# unregister_netdevice_many_notify() and a kernfs upper_* splat. The
+# devices stay down: two gateways cannot both bind relay_port in one
+# netns, and linking is all this needs.
+MU=$(gwns mu)
+ip netns add "$MU"
+ip -n "$MU" link add mu0 type dummy
+ip -n "$MU" addr add 10.9.0.1/24 dev mu0
+for d in mu_a mu_b; do
+	ip -n "$MU" link add $d type amt mode gateway local 10.9.0.1 \
+		discovery 10.9.0.2 dev mu0
+done
+made=$(ip -n "$MU" -o link show type amt | wc -l)
+ip -n "$MU" link del mu0
+left=$(ip -n "$MU" -o link show type amt | wc -l)
+ip netns del "$MU"
+# The netns teardown is asynchronous: give it a second. Then one dmesg
+# snapshot ends this case's scan and starts case 10's, so the two scans
+# tile and a splat this case provokes fails this case only.
+sleep 1
+dm=$(dmesg)
+DMESG1=$(printf '%s\n' "$dm" | wc -l)
+splat=$(printf '%s\n' "$dm" | tail -n +$((DMESG0 + 1)) |
+	grep -E 'WARNING:|BUG:|Oops|kernfs: can not remove|refcount_t|use-after-free')
+if [ "$made" -eq 2 ] && [ "$left" -eq 0 ] && [ -z "$splat" ]; then
+	ok "lower carrying two amt devices deleted: both gone"
+else
+	fail "lower carrying two amt devices deleted" \
+		"made=$made left=$left splat: $splat"
+fi
+
+echo "$NSIM_R_ID" > $NSIM_SYS/new_device
+echo "$NSIM_G_ID" > $NSIM_SYS/new_device
+udevadm settle 2>/dev/null
+[ -d "$DFS" ] || skip "netdevsim has no AMT offload provider ($DFS)"
+NR=$(ls $NSIM_SYS/devices/netdevsim$NSIM_R_ID/net)
+NG=$(ls $NSIM_SYS/devices/netdevsim$NSIM_G_ID/net)
+
+set -e
+ip netns add "$RELAY"
+ip netns add "$GW"
+ip link set "$NR" netns "$RELAY"
+ip link set "$NG" netns "$GW"
+ip -n "$RELAY" link set "$NR" name nsim_r
+ip -n "$GW" link set "$NG" name nsim_g
+for ns in "$RELAY" "$GW"; do
+	ip -n "$ns" link set lo up
+done
+ip -n "$RELAY" addr add 10.0.0.2/24 dev nsim_r
+ip -n "$RELAY" link set nsim_r up
+ip -n "$GW" link set nsim_g up
+
+exec {FD_R}<"/var/run/netns/$RELAY"
+exec {FD_G}<"/var/run/netns/$GW"
+IFX_R=$(ip netns exec "$RELAY" cat /sys/class/net/nsim_r/ifindex)
+IFX_G=$(ip netns exec "$GW" cat /sys/class/net/nsim_g/ifindex)
+echo "$FD_R:$IFX_R $FD_G:$IFX_G" > $NSIM_SYS/link_device
+
+ip -n "$RELAY" link add src0 type dummy
+ip -n "$RELAY" addr add $S1/24 dev src0
+ip -n "$RELAY" addr add $S2/24 dev src0
+ip -n "$RELAY" link set src0 up
+ip -n "$RELAY" link add amtr type amt mode relay local 10.0.0.2 dev nsim_r \
+	relay_port 2268 offload auto
+ip -n "$RELAY" link set amtr up
+ip -n "$GW" link add br0 type bridge
+ip -n "$GW" link set nsim_g master br0
+ip -n "$GW" link set br0 up
+for i in 1 2 3 4; do
+	ns=$(gwns $i)
+	ip netns add "$ns"
+	# No IPv6 on the gateways: amtg would join solicited-node groups over
+	# the tunnel and the relay would offload them alongside G1..G4.
+	ip netns exec "$ns" sysctl -qw net.ipv6.conf.default.disable_ipv6=1 \
+		2>/dev/null || true
+	ip -n "$ns" link set lo up
+	ip -n "$GW" link add br_g$i type veth peer name gw$i netns "$ns"
+	ip -n "$GW" link set br_g$i master br0 up
+	ip -n "$ns" addr add 10.0.0.1$i/24 dev gw$i
+	ip -n "$ns" link set gw$i up
+	ip -n "$ns" link add amtg$i type amt mode gateway local 10.0.0.1$i \
+		discovery 10.0.0.2 dev gw$i gateway_port 2268 relay_port 2268
+	ip -n "$ns" addr add 192.168.$i.1/32 dev amtg$i
+	ip -n "$ns" link set amtg$i up
+done
+set +e
+
+discovered()
+{
+	local i
+
+	for i in 1 2 3 4; do
+		[ "$(ip -n "$(gwns $i)" -d -j link show amtg$i |
+		     jq -r '.[0].linkinfo.info_data.remote')" = 10.0.0.2 ] ||
+			return 1
+	done
+}
+wait_for 30 discovered || { fail "setup" "gateways never discovered the relay"; exit; }
+
+mode=$(ip -n "$RELAY" -d -j link show amtr | jq -r '.[0].linkinfo.info_data.offload')
+[ "$mode" = auto ] && [ "$(rsys bound)" = 1 ] ||
+	{ fail "setup" "relay offload mode '$mode', bound $(rsys bound)"; exit; }
+ERR=0
+
+# --- 1. no membership, nothing committed: no copies anywhere ----------------
+measure $S1 $G1 $K 0.01
+if [ "$HW" -eq 0 ] && [ $((CNT[amtg1] + CNT[amtg2] + CNT[amtg3] + CNT[amtg4])) -eq 0 ]; then
+	ok "0 copies before any group is committed"
+else
+	fail "0 copies before any group is committed" "$(counts)"
+fi
+
+# --- 2. one hardware copy per committed endpoint per packet -----------------
+for i in 1 2 3; do
+	join a$i amtg$i $G1 $S1
+done
+if ! wait_for 40 members_eq $G1 3; then
+	fail "1 copy per endpoint per packet" \
+		"G1 never committed with 3 members: $(cat "$DFS/tables")"
+else
+	measure $S1 $G1 $K 0.01
+	if [ "${CNT[amtg1]}" -eq $K ] && [ "${CNT[amtg2]}" -eq $K ] &&
+	   [ "${CNT[amtg3]}" -eq $K ] && [ "${CNT[amtg4]}" -eq 0 ] &&
+	   [ "$HW" -eq $((3 * K)) ] && [ "$(dl_occ endpoints)" = 3 ] &&
+	   [ "$(dl_occ groups)" = 1 ] && [ "$(dl_occ members)" = 3 ]; then
+		ok "1 copy per endpoint per packet, all from the provider"
+	else
+		fail "1 copy per endpoint per packet" "$(counts)" \
+			"devlink endpoints/groups/members:" \
+			"$(dl_occ endpoints)/$(dl_occ groups)/$(dl_occ members)"
+	fi
+fi
+
+# --- 3. generation replace under traffic: no duplicate, no loss --------------
+# G5 has two stable members; two more join while it is sent, 3 s and 6 s
+# into a 12 s stream, so each join is a generation replace under traffic.
+late_joins()
+{
+	ip netns exec "$(gwns 3)" bash -c \
+		"sleep 3; exec python3 $TMP/join.py amtg3 $G5 $S1" &
+	JOIN[l3]=$!
+	ip netns exec "$(gwns 4)" bash -c \
+		"sleep 6; exec python3 $TMP/join.py amtg4 $G5 $S1" &
+	JOIN[l4]=$!
+}
+join l1 amtg1 $G5 $S1
+join l2 amtg2 $G5 $S1
+if ! wait_for 40 members_eq $G5 2; then
+	fail "generation replace under traffic" \
+		"G5 never committed with 2 members: $(cat "$DFS/tables")"
+else
+	c0=$(dfs commits)
+	st0=$(dfs tx_stale_gen)
+	measure $S1 $G5 600 0.02 late_joins
+	gens=$(( $(dfs commits) - c0 ))
+	stale=$(( $(dfs tx_stale_gen) - st0 ))
+	# The stable members got every packet once, the late members some
+	# but not all of them, and every copy came from the provider (HW is
+	# their sum), none from a software fallback on a stale generation.
+	if [ "${CNT[amtg1]}" -eq 600 ] && [ "${CNT[amtg2]}" -eq 600 ] &&
+	   [ "${CNT[amtg3]}" -gt 0 ] && [ "${CNT[amtg3]}" -lt 600 ] &&
+	   [ "${CNT[amtg4]}" -gt 0 ] && [ "${CNT[amtg4]}" -lt 600 ] &&
+	   [ "$HW" -eq $((CNT[amtg1] + CNT[amtg2] + CNT[amtg3] + CNT[amtg4])) ] &&
+	   [ $gens -ge 2 ] && [ $stale -eq 0 ]; then
+		ok "generation replace: stable members get exactly 1 copy"
+	else
+		fail "generation replace under traffic" \
+			"$(counts) generations=$gens stale_gen=+$stale"
+	fi
+fi
+
+# --- 4. BUSY: exactly one software copy set -----------------------------------
+b0=$(rsys busy_fallback)
+t0=$(dfs tx_busy)
+dfs_set busy 1
+measure $S1 $G1 $K 0.01
+dfs_set busy 0
+if [ "${CNT[amtg1]}" -eq $K ] && [ "${CNT[amtg2]}" -eq $K ] &&
+   [ "${CNT[amtg3]}" -eq $K ] && [ "$HW" -eq 0 ] &&
+   [ $(( $(rsys busy_fallback) - b0 )) -eq $K ] && [ $(( $(dfs tx_busy) - t0 )) -eq $K ]; then
+	ok "BUSY: exactly one software copy set per packet"
+else
+	fail "BUSY: exactly one software copy set" "$(counts)" \
+		"busy_fallback +$(( $(rsys busy_fallback) - b0 ))"
+fi
+
+# --- 5. forwarding is per group: INCLUDE(S1) still receives S2 ----------------
+join s1 amtg1 $G4 $S1
+if ! wait_for 40 members_eq $G4 1; then
+	fail "INCLUDE(S1) member receives S2" "G4 never committed: $(cat "$DFS/tables")"
+else
+	measure $S2 $G4 $K 0.01
+	if [ "${CNT[amtg1]}" -eq $K ] && [ "$HW" -eq $K ]; then
+		ok "INCLUDE(S1) member still receives S2, in hardware"
+	else
+		fail "INCLUDE(S1) member receives S2" "$(counts)"
+	fi
+fi
+
+# --- 6. op overruns op_timeout_ms: reset, stale results ignored, no dup -------
+r0=$(rsys resets)
+s0=$(rsys stale_completions)
+f0=$(dfs flushes)
+h0=$(devlink -j health show "$DL" reporter amt | jq '.health[][0].error')
+dfs_set stall_ms 1500
+join r2 amtg2 $G3
+wait_for 30 sysfs_ge resets $((r0 + 1))
+dfs_set stall_ms 0
+if ! wait_for 40 members_eq $G3 1; then
+	fail "reset: stale completion ignored" \
+		"G3 never committed after reset: $(cat "$DFS/tables")"
+else
+	measure $S1 $G3 $K 0.01
+	h1=$(devlink -j health show "$DL" reporter amt | jq '.health[][0].error')
+	if [ "${CNT[amtg2]}" -eq $K ] && [ "$HW" -eq $K ] &&
+	   [ "$(rsys resets)" -gt "$r0" ] && [ "$(rsys stale_completions)" -gt "$s0" ] &&
+	   [ "$(dfs flushes)" -gt "$f0" ] && [ "$h1" -gt "$h0" ]; then
+		ok "reset: stale completion ignored, replay gives 1 copy"
+	else
+		fail "reset: stale completion ignored" "$(counts)" \
+			"resets $r0->$(rsys resets)" \
+			"stale $s0->$(rsys stale_completions) health $h0->$h1"
+	fi
+fi
+
+# --- 7. partial commit: group staged, commit refused -> software -------------
+w0=$(rsys sw_remainder)
+dfs_set fail_commit 1
+for i in 1 2 3; do
+	join p$i amtg$i $G2 $S1
+done
+wait_for 40 sysfs_ge sw_remainder $((w0 + 1))
+sleep 2
+measure $S1 $G2 $K 0.01
+dfs_set fail_commit 0
+if [ "${CNT[amtg1]}" -eq $K ] && [ "${CNT[amtg2]}" -eq $K ] &&
+   [ "${CNT[amtg3]}" -eq $K ] && [ "$HW" -eq 0 ] && [ "$(hw_members $G2)" = 0 ]; then
+	ok "partial commit: 0 hardware copies, software remainder"
+else
+	fail "partial commit: software remainder" "$(counts) sw_remainder $w0->$(rsys sw_remainder)"
+fi
+for i in 1 2 3; do
+	leave p$i
+done
+
+# --- 8. every member leaves: group disabled, no copies ------------------------
+# The relay drops S1, and G1 with it, at least a GMI after the last
+# report that refreshed it: qrv * 125 s query interval + 10 s response
+# interval. The timer wheel can fire it up to 8/63 of its delay late
+# (32.8 s of a 260 s GMI at HZ=1000), so wait a seventh more, and 10 s.
+gmi=$(( $(ip netns exec "$RELAY" sysctl -n net.ipv4.igmp_qrv) * 125 + 10 ))
+for i in 1 2 3; do
+	leave a$i
+done
+if wait_for $((gmi + gmi / 7 + 10)) group_gone $G1; then
+	measure $S1 $G1 $K 0.01
+	if [ "$HW" -eq 0 ] && [ $((CNT[amtg1] + CNT[amtg2] + CNT[amtg3] + CNT[amtg4])) -eq 0 ]; then
+		ok "0 copies after the group is disabled"
+	else
+		fail "0 copies after the group is disabled" "$(counts)"
+	fi
+else
+	fail "0 copies after the group is disabled" "G1 still in the provider: $(cat "$DFS/tables")"
+fi
+
+# --- 9. required mode with no provider: refused with extack -----------------
+ip -n "$RELAY" link add dum0 type dummy
+ip -n "$RELAY" addr add 10.0.1.2/24 dev dum0
+q0=$(cat /sys/module/amt/parameters/offload_required_refused)
+msg=$(ip -n "$RELAY" link add amtx type amt mode relay local 10.0.1.2 \
+	dev dum0 offload required 2>&1)
+rc=$?
+q1=$(cat /sys/module/amt/parameters/offload_required_refused)
+if [ $rc -ne 0 ] && echo "$msg" | grep -q '^Error: ' && [ $((q1 - q0)) -eq 1 ] &&
+   ! ip -n "$RELAY" link show amtx > /dev/null 2>&1; then
+	ok "required with no provider: refused with extack, counted"
+else
+	fail "required refuses with extack" "rc=$rc refused $q0->$q1 msg: $msg"
+fi
+
+# --- 10. lower device torn away under traffic: ordered teardown ---------------
+# Unlink the peer mid-stream (copies stop, the binding survives), relink
+# (copies resume at 1 per packet), then delete the relay's netdevsim under
+# traffic: amt tears the binding down before the relay goes, with no splat.
+# The unlink-phase stream is from S1, so copies queued while unlinked and
+# released on relink are not counted as the relinked (S2, G4) copies.
+ip netns exec "$RELAY" python3 "$TMP/send.py" amtr $S1 $G4 100 0.02 &
+PIDS+=($!)
+sleep 0.5
+echo "$FD_R:$IFX_R" > $NSIM_SYS/unlink_device
+wait "${PIDS[-1]}"
+bound_after_unlink=$(rsys bound)
+echo "$FD_R:$IFX_R $FD_G:$IFX_G" > $NSIM_SYS/link_device
+wait_for 20 members_eq $G4 1
+measure $S2 $G4 $K 0.01
+relinked=${CNT[amtg1]}
+relinked_hw=$HW
+ip netns exec "$RELAY" python3 "$TMP/send.py" amtr $S2 $G4 200 0.01 &
+PIDS+=($!)
+sleep 0.5
+echo "$NSIM_R_ID" > $NSIM_SYS/del_device
+wait "${PIDS[-1]}"
+splat=$(dmesg | tail -n +$((DMESG1 + 1)) |
+	grep -E 'WARNING:|BUG:|Oops|refcount_t|use-after-free|list_(add|del) corruption')
+if [ "$bound_after_unlink" = 1 ] && [ "$relinked" -eq $K ] && [ "$relinked_hw" -eq $K ] &&
+   ! ip -n "$RELAY" link show amtr > /dev/null 2>&1 && [ ! -d "$DFS" ] &&
+   [ -z "$splat" ]; then
+	ok "lower device unlinked and deleted under traffic: ordered teardown"
+else
+	fail "ordered teardown under traffic" \
+		"bound=$bound_after_unlink relinked=$relinked hw=$relinked_hw splat: $splat"
+fi
+
+if [ $OKS -ne 11 ]; then
+	echo "only $OKS of 11 assertions passed"
+	ERR=1
+fi
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 94d722770..88eb75060 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -11,6 +11,7 @@ CONFIG_CRYPTO_ARIA=y
 CONFIG_CRYPTO_CHACHA20POLY1305=m
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_SM4_GENERIC=y
+CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_INFO_BTF_MODULES=n
 CONFIG_DUMMY=y
@@ -117,6 +118,7 @@ CONFIG_OPENVSWITCH=m
 CONFIG_OPENVSWITCH_GENEVE=m
 CONFIG_OPENVSWITCH_GRE=m
 CONFIG_OPENVSWITCH_VXLAN=m
+CONFIG_PACKET=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_PSAMPLE=m
 CONFIG_RPS=y
-- 
2.43.0

