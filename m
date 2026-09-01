Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D5303A04;
	Tue,  1 Sep 2026 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296590; cv=none; b=PYO5SsIwEAuWwbtOXAj+jZuK2EpX73GZcfeo6tSljLJkJGrFCnWr6aZEqR9jXfFrdonjshNH1WqokKLUNbll3KROYXtPLzsuVTyESN3qRhFB9O9vSmiA/yXJjY2hNOxn8VJX5aIDh08WGdfTIM2UshGjZ0gZ90puUcnEPaOExY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296590; c=relaxed/simple;
	bh=HNU76bQ6klmPij1w/3RPifphGIswGZzN/mqmhOZiQ/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fwm7hpXoN13LUteindCdpBd4CkUFRcdbRRhrDg2Wky9LBmjZ2MV0GiGItLNHaQNeYwIN+xZlQtTuT3DBH9k3fwc03dsJR2qarMzymY2Z5V9ct+cdTdwRvXIdYsJOUfQdt+CGex56LfKXPU3O5Fn48dmU/VP29cLtf/SYILuMzQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQTSaNt+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQTSaNt+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5F31F00A3D;
	Tue,  1 Sep 2026 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296588;
	bh=FKylBELlw5xNn5/cbFbsdT+XUM4vHMkeZv/IlwgO01s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bQTSaNt+MpfqH8AfmbyE7u+FPdMp3OgZtQufn8MPdrYsoEGtQ6Vrne7X0aP/ZpZqk
	 DFBKQFA5/Is5/MCasUNLv5JfabkJvO8iVOtPJ7o0PomMv4jg84SgZnjjQgf3ARd+GE
	 yt/QfeizTkH1HPbf0+cEJ2dpxo7+R/kx0ofjlOo4DrXydfpQz+92zChG6MKjdF7kvS
	 2j1YGooYpvvaLWadsapJ4oW3RTSmuzp7FIvMidSwDTzJAca0iAyl0PF7Y2lHTM4y+W
	 HcEqD9SkKWkw8TilehKapfI4qFOXkemUElhSa9gwl9bZ+dDTg3Czv0R+SHtXapYcWu
	 /3JcXzAAopQQw==
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
Subject: [PATCH net-next 3/3] llc: add KUnit tests for the connection state machine bounds
Date: Tue,  1 Sep 2026 14:03:05 -0700
Message-Id: <20260901210308.1173180-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901210300.i.590-kees@kernel.org>
References: <20260901210300.i.590-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7965; i=kees@kernel.org; h=from:subject; bh=HNU76bQ6klmPij1w/3RPifphGIswGZzN/mqmhOZiQ/Q=; b=owGbwMvMwCVmps19z/KJym7G02pJDFnTbTuUV/kG3g3nY+fXEJ87rfrE66eLJ5ZpdTnzM/2X9 lf8kC3YUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJGwDQx/OOum5qQffqJ8rHLH r95/AZfM2Dzzsp899Yi+4SSntNG5hJGhvWXXAUHpYxwS84ysJHTSNqwqso6UNDHUKs5WSdXfosk LAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add a KUnit suite for the LLC type 2 connection state machine. The test
file is #included by llc_conn.c so that it can reach the static state
machine helpers.

llc_conn_state_process_out_of_svc() is the regression test for the
syzbot report: it feeds a PF_LLC socket sitting in LLC_CONN_STATE_ADM
an I format command PDU with the P bit clear, which matches only the
catch-all llc_adm_state_trans_5 transition and parks the socket in
LLC_CONN_OUT_OF_SVC, then feeds it a second one.

Without the preceding fixes, on a CONFIG_UBSAN_BOUNDS=y plus
CONFIG_KASAN=y kernel that case prints both halves of the reported splat
and then dies:

  UBSAN: array-index-out-of-bounds in net/llc/llc_conn.c:712:24
  index -1 is out of range for type 'int [12][5]'
  BUG: KASAN: global-out-of-bounds in llc_conn_state_process

The other cases cover the 1-based indexing invariant of
llc_conn_state_table[], the bounds of llc_conn_state_in_service(), and an
event delivered with a state past the end of the table.

  $ ./tools/testing/kunit/kunit.py run --arch=x86_64 \
        --kconfig_add CONFIG_NET=y --kconfig_add CONFIG_LLC2=y llc2_conn
  [PASSED] llc_conn_state_table_is_one_based
  [PASSED] llc_conn_state_in_service_bounds
  [PASSED] llc_conn_state_process_out_of_svc
  [PASSED] llc_conn_state_process_bad_state

Build tested ARCH=x86_64 net/llc/ with GCC 14.2.0 at CONFIG_LLC2=y and
CONFIG_LLC2=m (the suite needs CONFIG_LLC2=y). Tests run 4/4 passing on
ARCH=um and on ARCH=x86_64 under qemu, and confirmed to fail with the
two preceding patches reverted, both with CONFIG_KASAN=y and
CONFIG_UBSAN_BOUNDS=y.

Assisted-by: Claude:claude-opus-5[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 net/llc/Kconfig            |  14 ++++
 net/llc/llc_conn.c         |   4 +
 net/llc/tests/conn_kunit.c | 146 +++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 net/llc/tests/conn_kunit.c

diff --git a/net/llc/Kconfig b/net/llc/Kconfig
index 7f79f5e134f9..19bd101d6329 100644
--- a/net/llc/Kconfig
+++ b/net/llc/Kconfig
@@ -8,3 +8,17 @@ config LLC2
 	help
 	  This is a Logical Link Layer type 2, connection oriented support.
 	  Select this if you want to have support for PF_LLC sockets.
+
+config LLC2_CONN_KUNIT_TEST
+	bool "KUnit tests for the LLC type 2 connection state machine" if !KUNIT_ALL_TESTS
+	depends on KUNIT=y && LLC2=y
+	default KUNIT_ALL_TESTS
+	help
+	  This builds the KUnit tests for the LLC type 2 connection state
+	  machine, covering the bounds of the state transition tables and the
+	  handling of events delivered to an out of service connection.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index a4ae29b42300..07f077a30c30 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -1059,3 +1059,7 @@ void llc_sk_reset(struct sock *sk)
 	llc->failed_data_req	= 0 ;
 	llc->last_nr		= 0;
 }
+
+#if IS_ENABLED(CONFIG_LLC2_CONN_KUNIT_TEST)
+#include "tests/conn_kunit.c"
+#endif
diff --git a/net/llc/tests/conn_kunit.c b/net/llc/tests/conn_kunit.c
new file mode 100644
index 000000000000..86d3f122df0a
--- /dev/null
+++ b/net/llc/tests/conn_kunit.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the LLC type 2 connection state machine.
+ *
+ * This file is #included by llc_conn.c so that the tests can reach the
+ * static helpers of the state machine.
+ */
+#include <kunit/test.h>
+#include <linux/net.h>
+#include <net/net_namespace.h>
+
+/*
+ * Build the smallest event that reaches the LLC_CONN_STATE_ADM catch-all
+ * transition: an I format command PDU with the P bit clear. It matches
+ * neither llc_conn_ev_rx_sabme_cmd_pbit_set_x(),
+ * llc_conn_ev_rx_disc_cmd_pbit_set_x() nor
+ * llc_conn_ev_rx_xxx_cmd_pbit_set_1(), so llc_adm_state_trans_5 wins.
+ */
+static struct sk_buff *llc_conn_test_rx_pdu(struct kunit *test, struct sock *sk)
+{
+	struct llc_conn_state_ev *ev;
+	struct llc_pdu_sn *pdu;
+	struct sk_buff *skb;
+
+	skb = alloc_skb(sizeof(*pdu), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+
+	skb_reset_network_header(skb);
+	pdu = skb_put(skb, sizeof(*pdu));
+	pdu->dsap   = 0x42;
+	pdu->ssap   = LLC_PDU_CMD;
+	pdu->ctrl_1 = LLC_PDU_TYPE_I;
+	pdu->ctrl_2 = 0;
+
+	skb->sk = sk;
+	ev = llc_conn_ev(skb);
+	memset(ev, 0, sizeof(*ev));
+	ev->type = LLC_CONN_EV_TYPE_PDU;
+
+	return skb;
+}
+
+static struct socket *llc_conn_test_socket(struct kunit *test)
+{
+	struct socket *sock;
+	int rc;
+
+	rc = sock_create_kern(&init_net, PF_LLC, SOCK_DGRAM, 0, &sock);
+	if (rc)
+		kunit_skip(test, "cannot create a PF_LLC socket: %d", rc);
+
+	return sock;
+}
+
+/*
+ * llc_conn_state_table[] and llc_offset_table[] are indexed with "state - 1",
+ * which only works while every state is its own 1-based index.
+ */
+static void llc_conn_state_table_is_one_based(struct kunit *test)
+{
+	u8 state;
+
+	for (state = LLC_CONN_STATE_ADM; state <= LLC_CONN_STATE_TEMP; state++)
+		KUNIT_EXPECT_EQ(test, llc_conn_state_table[state - 1].current_state,
+				state);
+}
+
+static void llc_conn_state_in_service_bounds(struct kunit *test)
+{
+	KUNIT_EXPECT_FALSE(test, llc_conn_state_in_service(LLC_CONN_OUT_OF_SVC));
+	KUNIT_EXPECT_TRUE(test, llc_conn_state_in_service(LLC_CONN_STATE_ADM));
+	KUNIT_EXPECT_TRUE(test, llc_conn_state_in_service(LLC_CONN_STATE_TEMP));
+	KUNIT_EXPECT_FALSE(test, llc_conn_state_in_service(LLC_CONN_STATE_TEMP + 1));
+	KUNIT_EXPECT_FALSE(test, llc_conn_state_in_service(U8_MAX));
+}
+
+/*
+ * Regression test for the syzbot report below: an unsolicited frame moves a
+ * socket sitting in LLC_CONN_STATE_ADM to LLC_CONN_OUT_OF_SVC, and the next
+ * frame for the same socket used to index llc_conn_state_table[-1] and
+ * llc_offset_table[-1][] before it was dropped.
+ *
+ * Link: https://lore.kernel.org/all/6a95888b.4d659fcc.734b4.0051.GAE@google.com
+ */
+static void llc_conn_state_process_out_of_svc(struct kunit *test)
+{
+	struct sk_buff *first, *second;
+	struct socket *sock;
+	struct sock *sk;
+
+	sock = llc_conn_test_socket(test);
+	sk = sock->sk;
+
+	first = llc_conn_test_rx_pdu(test, sk);
+	second = llc_conn_test_rx_pdu(test, sk);
+
+	lock_sock(sk);
+	KUNIT_EXPECT_EQ(test, llc_sk(sk)->state, LLC_CONN_STATE_ADM);
+
+	/* The catch-all ADM transition parks the socket out of service. */
+	KUNIT_EXPECT_EQ(test, llc_conn_state_process(sk, first), 0);
+	KUNIT_EXPECT_EQ(test, llc_sk(sk)->state, LLC_CONN_OUT_OF_SVC);
+
+	/* The next event must be refused rather than indexed with -1. */
+	KUNIT_EXPECT_NE(test, llc_conn_state_process(sk, second), 0);
+	KUNIT_EXPECT_EQ(test, llc_sk(sk)->state, LLC_CONN_OUT_OF_SVC);
+	release_sock(sk);
+
+	sock_release(sock);
+}
+
+/* The same refusal has to cover states past the end of the state table. */
+static void llc_conn_state_process_bad_state(struct kunit *test)
+{
+	struct socket *sock;
+	struct sk_buff *skb;
+	struct sock *sk;
+
+	sock = llc_conn_test_socket(test);
+	sk = sock->sk;
+
+	skb = llc_conn_test_rx_pdu(test, sk);
+
+	lock_sock(sk);
+	llc_sk(sk)->state = LLC_CONN_STATE_TEMP + 1;
+	KUNIT_EXPECT_NE(test, llc_conn_state_process(sk, skb), 0);
+	llc_sk(sk)->state = LLC_CONN_STATE_ADM;
+	release_sock(sk);
+
+	sock_release(sock);
+}
+
+static struct kunit_case llc_conn_test_cases[] = {
+	KUNIT_CASE(llc_conn_state_table_is_one_based),
+	KUNIT_CASE(llc_conn_state_in_service_bounds),
+	KUNIT_CASE(llc_conn_state_process_out_of_svc),
+	KUNIT_CASE(llc_conn_state_process_bad_state),
+	{}
+};
+
+static struct kunit_suite llc_conn_test_suite = {
+	.name = "llc2_conn",
+	.test_cases = llc_conn_test_cases,
+};
+
+kunit_test_suite(llc_conn_test_suite);
-- 
2.34.1

