Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7627286D4D;
	Tue,  1 Sep 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296590; cv=none; b=OMjZ0VqaYnFHYtp2dbo8rIMRflSCIM31D4T99dSDoUvu2X5PdTl+x+NMNo00MBJD0P9g8LImPnPPJFQplVB3Q+53KNZKZ641UEQn90/RbKBl5sr639pFGvyfPkrK59wlynvpdxIMYpwtAg9cglaQ5KqrmnMTbqg+KhPqxEN/cdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296590; c=relaxed/simple;
	bh=1ycvHY9jrwxBEJiElS9KgXcZkwTdzcGWMI9WMUwOVpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGJyzXcQsBZp4KlLPKLWAYTxSOZc+s2Wy4+QOPsbmcExl+F4Ch7Nf/yR5SYYenw+V34urXdXXnkx4+ATQ4Or+ZzXFATc1gyIOuhbhr76c2Raz3ScKEEJS/6tG7LZ6ELzlnWgR8iyb+MMdJagKRWJb2DcttKDps+fNxN2bI/tDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyoBuXey; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyoBuXey"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2521F00A3E;
	Tue,  1 Sep 2026 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296588;
	bh=o4y3Au5yahfVgXckmce7YK44RkvqJlP5g7zCQkT9ths=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lyoBuXeyZGkvBx5inPWIcsXUqabNkkahs7Qu6n4Y6dPU/G/Y/Zkl2qr9TY+xnVoel
	 EW4B5FP4T7BuKgfMi2GxOqrdLgyH9fWpun+30euwgIqkmLmJXuPkK6OnKixVjA3wAA
	 0J9G3treuHzt435yhD/vmNSKd29swxZI7Ksmi1pjLNtA01XfwEoT5lqFcLLpg+7hbD
	 cKOmWJh8S1+YFzumfGn4J6btnUPGlP0tAel8Zai8/MfE10WQYyB/zH00Cm6ZdaYFlL
	 3m0OX3HV4ubaj7FNIQpAfsv0wlE1D+OZKj4ZAqmgyPMFXtz3LiuWDOuQorTWT/UigS
	 rNLZDumwHeORQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Tim Bird <tim.bird@sony.com>,
	Zihan Xi <zihanx@nebusec.ai>,
	linux-kernel@vger.kernel.org,
	syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 2/3] llc: report a closed connection for out of service sockets
Date: Tue,  1 Sep 2026 14:03:04 -0700
Message-Id: <20260901210308.1173180-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901210300.i.590-kees@kernel.org>
References: <20260901210300.i.590-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2459; i=kees@kernel.org; h=from:subject; bh=1ycvHY9jrwxBEJiElS9KgXcZkwTdzcGWMI9WMUwOVpI=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnTbTuWGu9cHBXJv8pmf2fjlcflyZNPLmbWm7u0My5Ls P9N9QXZjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkwTWZkeFd/W9V6puyNs163 s5S01aV/zevpEW3dNqkykre+8bB3MCPD0YB/O28vfcwUHnPTi6GI4+2ObTo6NbMCD/b+4Iw7xCv DDQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

An unsolicited frame can move a bound PF_LLC socket from
LLC_CONN_STATE_ADM to LLC_CONN_OUT_OF_SVC while the socket stays open
from userspace's point of view. Both upper layer entry points handle
that badly:

 - llc_establish_connection() has no state check at all, so with the
   state machine now refusing the event, connect(2) would return the
   state machine's "1" failure indication as a positive syscall return
   value.

 - llc_build_and_send_pkt() special cases LLC_CONN_STATE_ADM as
   -ECONNABORTED but falls through to -EBUSY for LLC_CONN_OUT_OF_SVC.
   -EBUSY describes a connection that is momentarily unable to send, not
   one that no longer exists.

Report -ECONNABORTED from both.

There is deliberately no Fixes: tag here. The connect(2) return value
only becomes observable once the previous patch makes the state machine
refuse the event, and the llc_build_and_send_pkt() change is a
long-standing errno inaccuracy with no memory safety impact. Backporting
this on its own would fix nothing.

Build tested ARCH=x86_64 net/llc/ with GCC 14.2.0, CONFIG_LLC2=y and =m.

Assisted-by: Claude:claude-opus-5[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 net/llc/llc_if.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/llc/llc_if.c b/net/llc/llc_if.c
index 1514362e613d..f1a3f3372c4f 100644
--- a/net/llc/llc_if.c
+++ b/net/llc/llc_if.c
@@ -41,7 +41,8 @@ int llc_build_and_send_pkt(struct sock *sk, struct sk_buff *skb)
 	int rc = -ECONNABORTED;
 	struct llc_sock *llc = llc_sk(sk);
 
-	if (unlikely(llc->state == LLC_CONN_STATE_ADM))
+	if (unlikely(llc->state == LLC_CONN_STATE_ADM ||
+		     llc->state == LLC_CONN_OUT_OF_SVC))
 		goto out_free;
 	rc = -EBUSY;
 	if (unlikely(llc_data_accept_state(llc->state) || /* data_conn_refuse */
@@ -82,6 +83,15 @@ int llc_establish_connection(struct sock *sk, const u8 *lmac, u8 *dmac, u8 dsap)
 	struct llc_sock *llc = llc_sk(sk);
 	struct sock *existing;
 
+	/*
+	 * A socket parked in LLC_CONN_OUT_OF_SVC has no state machine to run,
+	 * so there is nothing to establish. Report it as a closed connection
+	 * rather than handing llc_conn_state_process() an event it can only
+	 * throw away.
+	 */
+	if (unlikely(llc->state == LLC_CONN_OUT_OF_SVC))
+		return -ECONNABORTED;
+
 	laddr.lsap = llc->sap->laddr.lsap;
 	daddr.lsap = dsap;
 	memcpy(daddr.mac, dmac, sizeof(daddr.mac));
-- 
2.34.1

