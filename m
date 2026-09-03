Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9E378824;
	Thu,  3 Sep 2026 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403374; cv=none; b=O860HLtcDt9k2DmyboN1rLRy6QT0CqvDMM3ucAHENTmYn3QiDNiSce6sggMBGPlrGyi7ECOOmsIgOgP16Jc9KRjOug5AgsSwUsy4Ewqg85GAhEooMZ+9QboJvGSnkf06VFTIoG1AAmZlQVlVGxWyWSDJBKELb50HiiYj1bwaNow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403374; c=relaxed/simple;
	bh=5rdqYpRjHKQgLUsJduiAGoo12p/VCrnSrAA1xfJnwLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCTZsyyT6zJjoHG3hV666OJYeP+SaePDj+tdrpz+3XQ45lABiADYLUKmPLzrNCo+lBHy+nBGfQvJxlU1bFBq0vZoU63RAVChuYHav1UcY1B+A/1eaQ9ugR9wlKT/w6xPKkaCMzd4tznUffaOpSQuNIJf5cGHEXUdG7pHt09w9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZoEFlRvB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZoEFlRvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788403361;
	bh=PlTn3I9kXfPLw7BlbtROwprK/Ezk0JfYuxV+O8GWhsw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZoEFlRvB8IzB36oByjXQ4XOu/gJE0W6Q/1HUjzf11NRG7R+SwjjrdJcWrwWfGbT4T
	 PpvdVoJ5VE/szK4vqmOWf+fBc3+WMqqFKiffCDZeKi1kai+XZ+N7A9OdwPsNShET76
	 TsIdfGEk7gNfOIkGs5OR/cuuF0G5ERQ0XU9jg1b1bEA/hdtLnGJJwLDAD8FWqzRis9
	 vHXcmOM5OxiUPR1sbM/NmdOyFG/ZkAamCo2OhtxylYXcYHUzSlT/0vvhhACXZCWOkI
	 LYIqdUQnHT0rE+2c4glepMfUgqXlx4eXqI4OsiBmMRQ9axmps8l2lmvqkx0rWs7nx9
	 jUK6gf0194bDw==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 63FE068697; Thu,  3 Sep 2026 10:42:41 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Thu, 03 Sep 2026 10:42:24 +0800
Subject: [PATCH net-next v2 7/7] net: mctp: usblib: Add test for failing
 append
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dev-mctp-usb-lib-test-v2-7-313cf15e0b56@codeconstruct.com.au>
References: <20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56@codeconstruct.com.au>
In-Reply-To: <20260903-dev-mctp-usb-lib-test-v2-0-313cf15e0b56@codeconstruct.com.au>
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
v2:
- Fix preemption management
---
 drivers/net/mctp/mctp-usblib-test.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 73bda4745433f689504e65685b73da2117f1d3db..25eac80db3e2d12aabdabbe234261dc335d653b8 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -867,6 +867,47 @@ static void mctp_usblib_test_tx_multi_push(struct kunit *test)
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
+	dstats = get_cpu_ptr(ndev->dstats);
+	for (i = 0; i < 3; i++) {
+		skb = mctp_usblib_test_init_skb(test, len, ndev, buf);
+
+		rc = mctp_usblib_tx_push(ndev, tx, skb, i != 2);
+		KUNIT_EXPECT_EQ(test, rc, 0);
+	}
+
+	do {
+		start = u64_stats_fetch_begin(&dstats->syncp);
+		stats = u64_stats_read(&dstats->tx_drops);
+	} while (u64_stats_fetch_retry(&dstats->syncp, start));
+	put_cpu_ptr(dstats);
+
+	KUNIT_EXPECT_EQ(test, stats, 3);
+}
+
 static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_single),
 	KUNIT_CASE_PARAM(mctp_usblib_test_rx_pkt_span,
@@ -879,6 +920,7 @@ static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_tx_pkt_span),
 	KUNIT_CASE(mctp_usblib_test_tx_multi_push),
 	KUNIT_CASE(mctp_usblib_test_tx_failing_send),
+	KUNIT_CASE(mctp_usblib_test_tx_overflow),
 	{}
 };
 

-- 
2.47.3

