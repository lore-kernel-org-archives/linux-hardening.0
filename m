Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C33A785C;
	Mon, 31 Aug 2026 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788148228; cv=none; b=XY2I1tcljXeC6rYoltD4pl9EOVhQX6/yA0DFCb8KgIUa0BvjJ7bjbhptOc9LmQaRRBdLJVtWHuI1en3CKbNC6SK9RMSE39Nfhtkdfsz3vLDoBFC8vG+tFqMU/KlWZzvgRvZAy4Sfj5W7L+U/XwmeTI2I5KFuCcvxKs14lUf6odk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788148228; c=relaxed/simple;
	bh=E8qTZ7UA+/hkKVCQs3guqOK8eccVNjrxJlYblcrQZX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRTF4mSQ/dXsEiPbXwBYhuLAtB7/CX7oJH+JpMmvaIK3MzYfozlPAiPxLGRyg6tLkYj/mwnmz0hBkhHqlATwwoOxxl9SOHsBC7up/qzAaoP8W2K0FfBTzn1fkAeaHmonXHqScxhSP7ONYQWCpERpgas23mPLdtEOXlEiQXBk7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=fu1Q2VAu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="fu1Q2VAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788147871;
	bh=BMi3+MBzg6D9zyId+2HaJdzqPa5Kt7QY4chk34FJAqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fu1Q2VAu8hOa8NNGHQe8RwaTU/vq/+EqSDGv/pbwAAxlvRQjcChm1h0aBr9JViiiE
	 xPzagvyb1vO3nmR7SB6s1jpDfRIaBJaa5Em2A6wosut2/iKLmT70ByZWXT4ylE3iXu
	 mKCGRHZGIhwnvmC/9k73QaWuPPpMOkVHH3aSfxr51DQV8VBSTD65Nu1nCsT+Gr1h67
	 8+FpMC6JmBtkcvrGk0CMVQDJSPhCCDF3WgwfdttFzbhKyp+vVpYZmSh8xYEJpSUom5
	 hLAJgOejm6FiQkihgdm2Nv1Qi+kQQ8u/Ao73FjEv1Z7I5RBlWKVvNUm9nSoWehyi10
	 zN984H+jXT7DA==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 08ACB6844F; Mon, 31 Aug 2026 11:44:31 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Mon, 31 Aug 2026 11:43:43 +0800
Subject: [PATCH 4/7] net: mctp: usblib: Complete rx tests
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-dev-mctp-usb-lib-test-v1-4-79699bf67a18@codeconstruct.com.au>
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

Add rx tests without spanning, covering cases where a packet is shorter
than allowed without spanning, isn't completed within one submission.

Fully cover rx functions except for memory allocation failures and
trivial functions.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 4f499de9a6ce4452dcc71ac38fa26b6595977f77..ab323a31161a415d93eafe4314e0e52cedfcd42e 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -524,6 +524,66 @@ static void mctp_usblib_test_rx_invalid_dmtf_id(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 0);
 }
 
+static void mctp_usblib_test_rx_nonspanning_tiny(struct kunit *test)
+{
+	struct mctp_usblib_test_dev *dev;
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_rx *rx;
+	size_t len, buflen;
+	u8 pktbuf[3];
+	void *buf;
+	int rc;
+
+	ctx = mctp_usblib_test_init(test);
+	rx = mctp_usblib_test_rx_init(test, false);
+	dev = ctx->dev;
+
+	len = sizeof(pktbuf);
+	mctp_usblib_test_init_pkt(pktbuf, len, len);
+
+	buflen = 0;
+	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+	KUNIT_ASSERT_GE(test, buflen, len);
+
+	memcpy(buf, pktbuf, len);
+
+	rc = mctp_usblib_rx_complete(dev->ndev, rx, len);
+	KUNIT_EXPECT_EQ(test, rc, -ENOMSG);
+	KUNIT_EXPECT_NULL(test, rx->skb);
+	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 0);
+}
+
+static void mctp_usblib_test_rx_nonspanning_partial(struct kunit *test)
+{
+	struct mctp_usblib_test_dev *dev;
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_rx *rx;
+	size_t len, buflen;
+	u8 pktbuf[20];
+	void *buf;
+	int rc;
+
+	ctx = mctp_usblib_test_init(test);
+	rx = mctp_usblib_test_rx_init(test, false);
+	dev = ctx->dev;
+
+	len = sizeof(pktbuf);
+	mctp_usblib_test_init_pkt(pktbuf, len, len + 1);
+
+	buflen = 0;
+	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+	KUNIT_ASSERT_GE(test, buflen, len);
+
+	memcpy(buf, pktbuf, len);
+
+	rc = mctp_usblib_rx_complete(dev->ndev, rx, len);
+	KUNIT_EXPECT_EQ(test, rc, -EPROTO);
+	KUNIT_EXPECT_NULL(test, rx->skb);
+	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 0);
+}
+
 static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_single),
 	KUNIT_CASE_PARAM(mctp_usblib_test_rx_pkt_span,
@@ -531,6 +591,8 @@ static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_header_splits),
 	KUNIT_CASE(mctp_usblib_test_rx_short_packet),
 	KUNIT_CASE(mctp_usblib_test_rx_invalid_dmtf_id),
+	KUNIT_CASE(mctp_usblib_test_rx_nonspanning_tiny),
+	KUNIT_CASE(mctp_usblib_test_rx_nonspanning_partial),
 	{}
 };
 

-- 
2.47.3

