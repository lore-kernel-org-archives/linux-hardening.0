Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9A19E97B;
	Thu,  3 Sep 2026 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403370; cv=none; b=UYGPPsGuS8/Ha9jAFSX3oT0uC94h2L3KPjVzhPShyOSQl59QhceO/NN4joUFMrwNIZ14OhooYaNWENAYAubaMBk7tw9sc9C2nQIxg4MZay7PZh1fIa8yxQ6k/2BQ0HTM6Si0WfEeeUR2/QuXWt3Jnqn+aQi7ZJFqXsX/Sb4mcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403370; c=relaxed/simple;
	bh=tk6ZrQpBluSr4n3qB5Wk1r0PjpZDCcUfDE4f0xeGZNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1gkXCuPismEWP+qhZD5Lwr97bSdGBQbL9YF70npB1QgzxNkFS64VxsmpUG3U6lujCqouuNNGNbX3hyTsD10r6Nov+gky1QX0aMqakH+MNhGBKkjJtfYf5H5FUQnv/4/QppIE0XJziewHP2B97lDsmfJGzGn2VFsDKPIBeMdoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LZctovix; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LZctovix"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788403359;
	bh=+Q8Ci2BqhDAB+rnn+iPJ8rjqbPzcO6kXStVqFYnGwHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LZctovixlGOjCkUxvPPspiuZSrfxJl4skdjectOCjLh3YkflJDshLxZaOYTOz2Pu4
	 b8PSQrCnB1tjff7aXlmbe2hHHXpOxmJMCstqR0tKnDY8mJdrnDzgh4DoMD9xXutM4Z
	 8aD8ejip/Lc6JP+b37prGYKGVFNsgjyIjV1ogpv95jdRpaT/CuHuMTAv7ju/OM0SIS
	 USZKj3BZb+Boo1KxqpvqL4aZRh97lim7Sahe0uLtmo8S2Bf+LplAAAeDl+ZT1Uznk0
	 e22t+K0wFipf8VNblWuB+XBBwMolizftLFfPbk0r4jhtwZg6cIKMJYZKdOFzzB0X48
	 NngqZP5szJoGw==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id C8E4D68693; Thu,  3 Sep 2026 10:42:39 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Thu, 03 Sep 2026 10:42:20 +0800
Subject: [PATCH net-next v2 3/7] net: mctp: usblib: Add tests of invalid
 headers
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dev-mctp-usb-lib-test-v2-3-313cf15e0b56@codeconstruct.com.au>
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

Add tests where the length field of the USB transport header is below
the minimum value, and where the DMTF ID is invalid.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 69 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index a2ca79f61910af129af956a6f38ad69d5dae8c10..b0266be79e94c5adb1cf4286d5aeef9768d28b34 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -442,7 +442,6 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
 	struct mctp_usblib_test_dev *dev;
 	struct mctp_usblib_test_ctx *ctx;
 	struct mctp_usblib_rx *rx;
-	size_t i;
 
 	ctx = mctp_usblib_test_init(test);
 	rx = mctp_usblib_test_rx_init(test, true);
@@ -461,11 +460,79 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
 	mctp_usblib_test_rx_split_header(test, 8, dev, rx);
 }
 
+/* Test the submission of a packet with an impossibly small value in the
+ * header's length field. Values less than HDR_LEN are invalid.
+ */
+static void mctp_usblib_test_rx_short_packet(struct kunit *test)
+{
+	struct mctp_usblib_test_dev *dev;
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_rx *rx;
+	size_t len, buflen;
+	u8 pktbuf[12];
+	void *buf;
+	int rc;
+
+	ctx = mctp_usblib_test_init(test);
+	rx = mctp_usblib_test_rx_init(test, true);
+	dev = ctx->dev;
+
+	len = sizeof(pktbuf);
+	mctp_usblib_test_init_pkt(pktbuf, len, HDR_LEN - 1);
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
+static void mctp_usblib_test_rx_invalid_dmtf_id(struct kunit *test)
+{
+	struct mctp_usblib_test_dev *dev;
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_rx *rx;
+	size_t len, buflen;
+	u8 pktbuf[12];
+	void *buf;
+	int rc;
+
+	ctx = mctp_usblib_test_init(test);
+	rx = mctp_usblib_test_rx_init(test, true);
+	dev = ctx->dev;
+
+	len = sizeof(pktbuf);
+	mctp_usblib_test_init_pkt(pktbuf, len, len);
+
+	// Make packet DMTF ID invalid
+	pktbuf[1] = ~pktbuf[1];
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
 			 mctp_usblib_test_rx_pkt_span_gen_params),
 	KUNIT_CASE(mctp_usblib_test_rx_header_splits),
+	KUNIT_CASE(mctp_usblib_test_rx_short_packet),
+	KUNIT_CASE(mctp_usblib_test_rx_invalid_dmtf_id),
 	{}
 };
 

-- 
2.47.3

