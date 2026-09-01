Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A419C54E;
	Tue,  1 Sep 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296590; cv=none; b=tHp/p+Zm4d/Xoai98UDyskFnnxT3HThugLsaEx/addHqFKT5OlxTNzBkf9jyrD7wWfp0eMeZYuuQDNHs+nRQMp5wNpbprwww0/85gaBcK99u2S4XTAPQSRg8TA/TbNy2e6vBNqk4fY6IDYkgZgbtUmoq81dbO1F4T8iKpBLtorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296590; c=relaxed/simple;
	bh=7cvm2vOol8idVJWZnrMP4RGnxDFZaUNOVWCm6BtCa+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PWhLD13XXg3aCuEd3TF9M4Fm6+dJRVLCCrQ6r2nKmT3gcLJzOKAgeQTGjUri5bBvlsfNRwMhkko1yDNz6hz+wBYu9LCz/8J+nTcq2vg6U8aeVpsKKwBT2ANkQpsVcSb45ey4vESFkZAX+KW/qtlyiSntSSpQYgXJ0K3zvejmtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouSAjPpQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouSAjPpQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D881F00A3A;
	Tue,  1 Sep 2026 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296588;
	bh=0RvE8748AK5qj+VB4OtV9nO1Jn4eXX0WI3dq4glcEj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouSAjPpQHHZQ1jYB7zuKTFzGgW+QXEwWCeita8hgVXuoH92aTjeURSYAayRpvwGuD
	 56BFgnwWVUyX1fp8zd8KW867XZGKuE2rqefixMf/lR7tgRVL7G7V3Fn7YKS+X8jAjQ
	 XPnAaJdWp9m01dP/2XrIF98n2uEwfpvPEcEj5gnexMUK6I9eNSnJU3zfx5zTSyH7ra
	 mV/HMJmwgOx20HJVhnUaZT3YzPXND1dvti/dMV+kR0vKqB67y3jYo7gSYf4To/wdzp
	 zWG8tznuGhrAc2eZcCyWWipXrConxUbh7G6c22GDGxFbnK8fdk3sPUUs7i9WZHPiX8
	 6CmhfNe6DldJQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Tim Bird <tim.bird@sony.com>,
	Zihan Xi <zihanx@nebusec.ai>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 1/3] llc: do not run the state machine on out of service connections
Date: Tue,  1 Sep 2026 14:03:03 -0700
Message-Id: <20260901210308.1173180-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901210300.i.590-kees@kernel.org>
References: <20260901210300.i.590-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6181; i=kees@kernel.org; h=from:subject; bh=7cvm2vOol8idVJWZnrMP4RGnxDFZaUNOVWCm6BtCa+k=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnTbTvkky85F54vKbZ59XpKk8fEhK/PTcJqb7GaT7l1N fxA7rPwjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIk8fc/IMPFHFXPU9Fyeh9+l ZI4r3YqX8HZt7/KuZ3i/uunyeTH/SYwM2625TB0ir7pYHl9VcfbwYo1tkl5qUq/v7gnzKuhuDrn DCQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

syzbot reported an out of bounds access of llc_conn_state_table[] and
llc_offset_table[] reached from the LLC receive path:

  BUG: KASAN: global-out-of-bounds in llc_qualify_conn_ev net/llc/llc_conn.c:394
  Read of size 8 at addr ffff800089e50078 by task syz.0.17/4975
  The buggy address belongs to the variable:
   llc_temp_state_transitions+0x58/0x60

  UBSAN: array-index-out-of-bounds in net/llc/llc_conn.c:681:8
  index -1 is out of range for type 'int[12][5]'

Both tables are indexed with "llc->state - 1" because connection states
are 1-based, and LLC_CONN_OUT_OF_SVC is 0, so a connection in that
pseudo state indexes them with -1.

LLC_CONN_OUT_OF_SVC is not a state of the state machine: it means the
connection component does not exist, either because it has not been
brought up or because it has been torn down, and it has no row in
llc_conn_state_table[]. A socket can nevertheless be left in it while
remaining reachable:

  llc_adm_state_trans_5 (LLC_CONN_STATE_ADM, "receive any frame")
      .next_state    = LLC_CONN_OUT_OF_SVC
      .ev_actions    = { llc_conn_disc }

llc_conn_disc() is documented as "removes connection from SAP list and
frees it", but it has been a stub returning 0 since 1da177e4c3f4
("Linux-2.6.12-rc2"). So the first unexpected frame for a socket sitting
in LLC_CONN_STATE_ADM - a bound socket, or a passive open child created
by llc_create_incoming_sock() - moves it to LLC_CONN_OUT_OF_SVC and
leaves it hashed in its SAP. Every following frame is found again by
__llc_lookup_established() and dispatched into the state machine with
state 0. That is what the reproducer does: bind a PF_LLC socket and
inject the same 802.2 frame twice.

"An out of service connection must not be given events" is already the
rule, but it is enforced at only some of the entry points:
llc_backlog_rcv() tests "llc->state > 1", and llc_process_tmr_ev() and
llc_send_disc() test LLC_CONN_OUT_OF_SVC. The direct receive path
(llc_conn_handler() -> llc_conn_rcv()) and the upper layer primitive
path (llc_establish_connection()) do not, and llc_conn_service()'s own
sanity check covers the upper bound only.

Enforce the rule once in llc_conn_state_process(), which every event
source funnels through, and drop the event there rather than let it
reach the tables. Complete llc_conn_service()'s range check as well so
that the code doing the indexing cannot underflow either.

The socket is still left bricked in LLC_CONN_OUT_OF_SVC, which is the
pre-existing behaviour of the state table, but it is no longer a memory
safety problem.

Build tested ARCH=x86_64 net/llc/ with GCC 14.2.0, CONFIG_LLC2=y and =m.

Reported-by: syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a95888b.4d659fcc.734b4.0051.GAE@google.com
Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Assisted-by: Claude:claude-opus-5[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/net/llc_c_st.h |  2 +-
 net/llc/llc_conn.c     | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/net/llc_c_st.h b/include/net/llc_c_st.h
index f52a4cc4880d..24577e0b17df 100644
--- a/include/net/llc_c_st.h
+++ b/include/net/llc_c_st.h
@@ -42,5 +42,5 @@ struct llc_conn_state {
 	const struct llc_conn_state_trans **transitions;
 };
 
-extern struct llc_conn_state llc_conn_state_table[];
+extern struct llc_conn_state llc_conn_state_table[NBR_CONN_STATES];
 #endif /* LLC_C_ST_H */
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 260460d50f54..a4ae29b42300 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -36,11 +36,38 @@ static const struct llc_conn_state_trans *llc_qualify_conn_ev(struct sock *sk,
 /* Offset table on connection states transition diagram */
 static int llc_offset_table[NBR_CONN_STATES][NBR_CONN_EV];
 
+/* Both tables are walked together with the same "state - 1" index. */
+static_assert(ARRAY_SIZE(llc_offset_table) == ARRAY_SIZE(llc_conn_state_table));
+
 int sysctl_llc2_ack_timeout = LLC2_ACK_TIME * HZ;
 int sysctl_llc2_p_timeout = LLC2_P_TIME * HZ;
 int sysctl_llc2_rej_timeout = LLC2_REJ_TIME * HZ;
 int sysctl_llc2_busy_timeout = LLC2_BUSY_TIME * HZ;
 
+/**
+ *	llc_conn_state_in_service - can this state drive the state machine?
+ *	@state: state of connection
+ *
+ *	Connection states are 1-based indexes into llc_conn_state_table[] and
+ *	llc_offset_table[]. LLC_CONN_OUT_OF_SVC is not a state of the state
+ *	machine at all: it marks a connection that has no transition table,
+ *	either because it has not been brought up yet or because it has been
+ *	torn down. Returns true if @state has a row in those tables.
+ */
+static bool llc_conn_state_in_service(u8 state)
+{
+	/*
+	 * The tables are indexed with "state - 1", so the numbering has to be
+	 * dense, start right after the LLC_CONN_OUT_OF_SVC sentinel, and end
+	 * at NBR_CONN_STATES for the bounds below to be the real ones.
+	 */
+	static_assert(LLC_CONN_OUT_OF_SVC == 0);
+	static_assert(LLC_CONN_STATE_ADM == LLC_CONN_OUT_OF_SVC + 1);
+	static_assert(LLC_CONN_STATE_TEMP == NBR_CONN_STATES);
+
+	return state > LLC_CONN_OUT_OF_SVC && state <= NBR_CONN_STATES;
+}
+
 /**
  *	llc_conn_state_process - sends event to connection state machine
  *	@sk: connection
@@ -59,6 +86,15 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
 	struct llc_sock *llc = llc_sk(skb->sk);
 	struct llc_conn_state_ev *ev = llc_conn_ev(skb);
 
+	/*
+	 * An out of service connection has no row in llc_conn_state_table[],
+	 * so it cannot be driven by any event.
+	 */
+	if (unlikely(!llc_conn_state_in_service(llc->state))) {
+		kfree_skb(skb);
+		return 1;
+	}
+
 	ev->ind_prim = ev->cfm_prim = 0;
 	/*
 	 * Send event to state machine
@@ -354,7 +390,7 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
 	struct llc_sock *llc = llc_sk(sk);
 	int rc = 1;
 
-	if (llc->state > NBR_CONN_STATES)
+	if (!llc_conn_state_in_service(llc->state))
 		goto out;
 	rc = 0;
 	trans = llc_qualify_conn_ev(sk, skb);
-- 
2.34.1

