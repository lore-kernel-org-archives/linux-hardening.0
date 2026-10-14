Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B84371CE3;
	Wed, 14 Oct 2026 04:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953279; cv=none; b=UHYivyJ7+KGWmOcDS52jlnrgQZbszJl8+BWfqv0SfpP5XIdMcCIsl3MQHTrYR20TiB1+lGXcnTkK261Ya1xGo54WbqLDDvQC3ETH53SP0PtWXT+kie45WcU3VlI3sEVJxudMjF5aFLyiSCB6FcXXTEyX1ljeOdY39MRwXnMjIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953279; c=relaxed/simple;
	bh=0YCN4dSx6CQ2crkPBUWeLgQp37HyQbhNBbHqc6dWyaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ADMF88lFLWkCkPiqhjHwpWc/6YPaEY+kja6c6tcm4KvA49CrT+OuCFInLI1/ON8CzJyn9hS3v+y8vXFH6FOI2tDtcXJzK9QZREuJiOO99POySfFn7Mc5j/WPA7zYboBJ6EwQENtgtFW6I2VHjvPf4N17bTVAf8GEvbYZnIc/mzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ae8e2+yD; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ae8e2+yD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791953276;
	bh=y5ethWPSlLBqMK+cC99Av8kof/Z3H1L0sa42l0hp+GY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ae8e2+yDdmw0lMBPTqgS5OjgIk1ApGw81RDkciWGQXmnPrwT19apAkb2yFBEZJT0S
	 xw9Hpc+rOJs/lKrwLjX2sVDOiMcl00jPc1Ux8LiOxtPbUDHGVZ4ley95t1ElzR2bzQ
	 3ekg2hlIs5HJOeCSd1FdDBC5o4kWHFJONGzadPR0xlzHwJgiGWhHaVBuYHF53PBdLc
	 CF3AC90Iz+IfktOJjzZeCLETy9X8qH3laKoSarAmtYIBOOMX7F8vWf6qQbtYAq0XzF
	 OeYc4RH6813a4HEbTtVY9Pok5p6hk88Aomp7fnofLL9IAIqP/vW6TWI8sRzgdsl52S
	 m0Ws3cF2F1+FQ==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 3268F6FD54; Wed, 14 Oct 2026 12:47:56 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Wed, 14 Oct 2026 12:47:33 +0800
Subject: [PATCH net-next v3 3/7] net: mctp: usblib: Add tests of invalid
 headers
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-dev-mctp-usb-lib-test-v3-3-ee5bc3ea1db1@codeconstruct.com.au>
References: <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
In-Reply-To: <20261014-dev-mctp-usb-lib-test-v3-0-ee5bc3ea1db1@codeconstruct.com.au>
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
v3:
- Replace C99 comment with block comment
---
 drivers/net/mctp/mctp-usblib-test.c | 68 +++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 2d91cba9efeea55e15b2d13a0debd4586072b83c..44389c0451c1c915c282bbe3881efac772d9c4e1 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -461,11 +461,79 @@ static void mctp_usblib_test_rx_header_splits(struct kunit *test)
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
+	/* Make packet DMTF ID invalid */
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

