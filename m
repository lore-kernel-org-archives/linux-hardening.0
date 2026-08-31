Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440523A7F75;
	Mon, 31 Aug 2026 03:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788148229; cv=none; b=Pm8ri8wX+WOqrnEIoXCRtJPMlNEWyBFcQ5Io/LDiNGgC38dOMpR8JA+Q79wDHKCk+mUHbTNeKxX/fFMoQJDr+1rR+zhUhaMk+Oen0rzruSn8vLhOVmneXdvUu41aP52/PLk6Fy9LeOm95wSk0s7mGVALE4MPSUj6uw8mU2E5UVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788148229; c=relaxed/simple;
	bh=131K7gA8Vn3rnDLZncN1xWvIz6Muu3Par0/X49DY8Os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdJ1/qd/RI26+7VOxSgFLGZ9jK6dN97e2cIV8M/rftWN5kYBDUI91lMr1+kpj/WMqKALu1FpK9MdtRld+F4TRqu6TKbHC68jipZfn1Mw8XS1Yd7/cT4WKJ1xYNnsjr3zMQaZITXb82bgL3k+H1gXDiHUnoRAX79lNNtSMi4wBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=chWune1B; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="chWune1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788147870;
	bh=roJc+Z7MppuQ35gj9+HGSIqbkcKMOueqfabKB3B3kKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=chWune1BGAWelCCASy4z2Mw/z4ohSHxLM9a6pFZ4Ul/QbsoGLz2Sz1zSUzu7KXNf4
	 yuKpXFZ1qBJLKYwfV8LfGEMSCXfYkcmWkyGoP2TG6Nmg22/v/FBPz7dQnqhtSRWFQe
	 D5+ENTFpVrdyWxjiFNY4Caz+W4u3qdD2Mypxx8bNtl9gpsPMgQ5umqU89nrH8ANmYp
	 x5Yi1ss9dOUq8SFEK5fqAyz6M9gS0b0DSo5fajjzbTpK+8CTVwk0QFgP2i8iTYsce6
	 RJF8nx9bWzmFQQ6uYFCZl1Tfs0QpA18thuFMV0FMrOEWL0tvp8w26Fq7du9OxeQlid
	 9uGNBz64l5W6g==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 9C4D86844E; Mon, 31 Aug 2026 11:44:30 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Mon, 31 Aug 2026 11:43:42 +0800
Subject: [PATCH 3/7] net: mctp: usblib: Add tests of invalid headers
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-dev-mctp-usb-lib-test-v1-3-79699bf67a18@codeconstruct.com.au>
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

Add tests where the length field of the USB transport header is below
the minimum value, and where the DMTF ID is invalid.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 69 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 1a6dd6d10daab314f5e082477ecd3b9518f6b50e..4f499de9a6ce4452dcc71ac38fa26b6595977f77 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -440,7 +440,6 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
 	struct mctp_usblib_test_dev *dev;
 	struct mctp_usblib_test_ctx *ctx;
 	struct mctp_usblib_rx *rx;
-	size_t i;
 
 	ctx = mctp_usblib_test_init(test);
 	rx = mctp_usblib_test_rx_init(test, true);
@@ -459,11 +458,79 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
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

