Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870733A6F1B;
	Mon, 31 Aug 2026 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147897; cv=none; b=u+asHK2YPiZfGXpNqkosN/oIXcjlwXKhdRJL9xntPGFUHhl8OJPN17YqzfnnYIzU+MlZB43JsnhxSRbuL9sJ2pfVQssDToVZpQyvAGGbnqqbMnvmCU+rlJceDSAuJi9QKsPhI5uRhwwHkaScKpjZieEgFlBc1HQ7brJ3HpnN/M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147897; c=relaxed/simple;
	bh=+BkdD5eC3Hp6UHH6ztBtLCKcezhYUQWiO5tEFxsoK5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzIy3N7VtnZAblOUPmwqq/QWbhCNNsiRrP7dyzgOFvyXZEYvqUJmchyRmJa3wFN6qVzjTcjTsmvteQA/f/Q+p6jft5vshd8g6HrdXUuBD04wOUql2RHoBLFlabhPg0Iauy0eCTwNfhYjTh1qzbZ6mjuKAxdC2Aple9/CBm/l/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Q8uXOHDt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Q8uXOHDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788147872;
	bh=3rfQrxzu7Qf878wkK4gzC32M3ksdn/bsvmrudPevC7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q8uXOHDtaGgudD7jUjfUT4be+V1h4asBDl8ZZ2cGw9jQUGO92vUynoAC/mcll0Jua
	 TGSNP5+4EHx5Qi7XNw2kssrrdjXwThi3JdZypf593IJyS5d9duE6eJDdmKPF4uQ3X3
	 27yt2Ff7rqvi+1a2zGfpRGv1LqlbAn1colqTv2/nAsAxce8gI/6owNkuQJdOwYbGf+
	 mHxkfimuM1ovei5Wgmksd/YMi95tZp3oeiXyEmmD0fjrvS9wbQDFdRs9PHA47SoE5+
	 LF43lIYDoFozeQMAwQlR2Lj7ZM5w7Lb14wnF3dL3tIFfMY2VIibUGnjL+7CL60Rcx4
	 pBZ9PO1fecQmw==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 4B52B68452; Mon, 31 Aug 2026 11:44:32 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Mon, 31 Aug 2026 11:43:46 +0800
Subject: [PATCH 7/7] net: mctp: usblib: Add test for failing append
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-dev-mctp-usb-lib-test-v1-7-79699bf67a18@codeconstruct.com.au>
References: <20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18@codeconstruct.com.au>
In-Reply-To: <20260831-dev-mctp-usb-lib-test-v1-0-79699bf67a18@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, James Lee <james@codeconstruct.com.au>
X-Mailer: b4 0.14.2

Add test ensuring that network device stats are updated appropriately
when a previously pushed packet fails to send during a subsequent push.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 7dc382caffc17644dd616f78df332201d412f709..b3a2cc5cbd99defde308cf23a1b559dbdc73ca22 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2026 Code Construct Pty Ltd
  */
 
+#include "linux/percpu-defs.h"
 #include <linux/array_size.h>
 #include <uapi/linux/netdevice.h>
 #include <linux/netdevice.h>
@@ -871,6 +872,46 @@ static void mctp_usblib_test_tx_multi_push(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(sends));
 }
 
+static void mctp_usblib_test_tx_overflow(struct kunit *test)
+{
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_tx_ops ops;
+	struct pcpu_dstats *dstats;
+	struct mctp_usblib_tx *tx;
+	struct net_device *ndev;
+	struct sk_buff *skb;
+	unsigned int start;
+	size_t len, i;
+	u64 stats;
+	u8 *buf;
+	int rc;
+
+	len = 200;
+
+	ctx = mctp_usblib_test_init(test);
+	ndev = ctx->dev->ndev;
+
+	ops.send = mctp_usblib_test_tx_send_fail;
+
+	tx = mctp_usblib_test_tx_init(test, &ops, ctx, false);
+	buf = mctp_usblib_test_init_buf(test, len);
+
+	for (i = 0; i < 3; i++) {
+		skb = mctp_usblib_test_init_skb(test, len, ndev, buf);
+
+		rc = mctp_usblib_tx_push(ndev, tx, skb, i != 2);
+		KUNIT_EXPECT_EQ(test, rc, 0);
+	}
+
+	dstats = get_cpu_ptr(ndev->dstats);
+	do {
+		start = u64_stats_fetch_begin(&dstats->syncp);
+		stats = u64_stats_read(&dstats->tx_drops);
+	} while (u64_stats_fetch_retry(&dstats->syncp, start));
+
+	KUNIT_EXPECT_EQ(test, stats, 3);
+}
+
 static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_single),
 	KUNIT_CASE_PARAM(mctp_usblib_test_rx_pkt_span,
@@ -883,6 +924,7 @@ static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_tx_pkt_span),
 	KUNIT_CASE(mctp_usblib_test_tx_multi_push),
 	KUNIT_CASE(mctp_usblib_test_tx_failing_send),
+	KUNIT_CASE(mctp_usblib_test_tx_overflow),
 	{}
 };
 

-- 
2.47.3

