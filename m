Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB3B3B993A;
	Mon, 31 Aug 2026 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788148229; cv=none; b=NuNVmF0O+cZ0MCrubpQr4PgX9fKsHUZRd6P1owjJgzqmHqnN/tIDmqcN4s6BeM5nvd/KO74N1CMACykDFZu1grM4vsFeUs52dqPcq1pzLMoThEiSUKW7LFpEzr24J5Tm2425S6F4BngkJCrk8h9HnK5tWrkUc6/An2MxBIsJu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788148229; c=relaxed/simple;
	bh=e82kdNAHTmo5otX2pNkTZpW60n9WJy57NP28Y++r8Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TCtz49l7C2oc8svI0ST3nQ/UCRfr+h4QbGji0NvCo7b/2iaux1njJVatT9gVoYy8cMWZUx6bhqfbzApRcDUKUGIktZvVy3aBIZrk3rnAyehH8ADj0TueUk2lzOo45KYjZgETI/tYcHJf1aZiWE2ozEAVGsFfCc0PkjlnousqK0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VZi5eg3+; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VZi5eg3+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788147870;
	bh=PX3VN/N7hHR7v61uN6YmJJLT2IKvrpv5bIjy8LQXpbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VZi5eg3+Yc1zFQSprNGWSVOhlHSECKWAhW3Rsjm4d+0Rpe+3PyZsBWngWhT9/DLND
	 c+nv/gj31cH6PdHkQz0BrC9bwGfj2JMmouXZSiwVviUUCxspoiSdaioukKAgORyiNM
	 9DDH4KnJnk2LUXtzeSznL42dh+3uDo/c5MKritsGoESDBRlx8Q+L+XTcHN6+gU22ua
	 bgN054Z8WRfaaEhaVzV06f8yknRKrFuLi1EXBi4y2m5aLtzmYdUcy+x/G8LHypLe62
	 456IbmZ0FpTH+zllmKQnlnTWD2xmjSKcY0bBDJOijqqa/3ICXhsC7oDD54lP9RHPiR
	 iVaMRY2gXKzcw==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 489D96844C; Mon, 31 Aug 2026 11:44:30 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Mon, 31 Aug 2026 11:43:41 +0800
Subject: [PATCH 2/7] net: mctp: usblib: Add test for splits inside headers
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-dev-mctp-usb-lib-test-v1-2-79699bf67a18@codeconstruct.com.au>
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

Add test covering every possible split of a packet's headers between
transfers and remove parameterized tests that are now covered.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 69 +++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 4c27307900fb6116572bc9d89f3def6f06c30397..1a6dd6d10daab314f5e082477ecd3b9518f6b50e 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -14,6 +14,8 @@
 #include <net/mctpdevice.h>
 #include <linux/usb/mctp-usb.h>
 
+#define HDR_LEN sizeof(struct mctp_usb_hdr)
+
 struct mctp_usblib_test_dev {
 	struct net_device *ndev;
 	struct mctp_dev *mdev;
@@ -378,12 +380,6 @@ static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
 	{ "1p1x-complete", 1, { 8 }, 1, { 8 } },
 	/* Two small packets combined within one transfer */
 	{ "2p1x-combined", 2, { 8, 8 }, 1, { 16 } },
-	/* A packet split over two transfers, at the MCTP payload */
-	{ "1p2x-split-payload", 1, { 16 }, 2, { 8, 8 } },
-	/* A packet split over two transfers, at the USB transport header */
-	{ "1p2x-split-usbhdr", 1, { 16 }, 2, { 2, 14 } },
-	/* A packet split over two transfers, at the MCTP header */
-	{ "1p2x-split-mctphdr", 1, { 16 }, 2, { 6, 10 } },
 	/* Single packet split over 3 transfers, middle entirely continuation */
 	{ "1p3x-split", 1, { 12 }, 3, { 4, 4, 4 } },
 	/* A packet split over 5 transfers, splitting on and between each header. */
@@ -403,10 +399,71 @@ static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
 KUNIT_ARRAY_PARAM(mctp_usblib_test_rx_pkt_span, mctp_usblib_test_pkt_spans,
 		  mctp_usblib_test_pkt_span_to_desc);
 
+static void mctp_usblib_test_rx_split_header(struct kunit *test, size_t offset,
+					     struct mctp_usblib_test_dev *dev,
+					     struct mctp_usblib_rx *rx)
+{
+	struct sk_buff *skb;
+	size_t buflen, len;
+	u8 packet[16];
+	void *buf;
+	int rc;
+
+	len = sizeof(packet);
+	mctp_usblib_test_init_pkt(packet, len, len);
+
+	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+	KUNIT_ASSERT_GE(test, buflen, len);
+
+	memcpy(buf, packet, offset);
+	mctp_usblib_rx_complete(dev->ndev, rx, offset);
+
+	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen,
+				    GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+	KUNIT_ASSERT_GE(test, buflen, len);
+	KUNIT_ASSERT_EQ(test, dev->rx_pkts.qlen, 0);
+
+	memcpy(buf, packet + offset, len - offset);
+	mctp_usblib_rx_complete(dev->ndev, rx, len - offset);
+	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 1);
+
+	skb = __skb_dequeue(&dev->rx_pkts);
+	KUNIT_EXPECT_NOT_NULL(test, skb);
+	if (skb)
+		KUNIT_EXPECT_EQ(test, skb->len, len - HDR_LEN);
+}
+
+static void mctp_usblib_test_rx_header_splits(struct kunit *test)
+{
+	struct mctp_usblib_test_dev *dev;
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_rx *rx;
+	size_t i;
+
+	ctx = mctp_usblib_test_init(test);
+	rx = mctp_usblib_test_rx_init(test, true);
+	dev = ctx->dev;
+
+	/* Unrolling here so stack traces point to the invocation with the
+	 * failing length.
+	 */
+	mctp_usblib_test_rx_split_header(test, 1, dev, rx);
+	mctp_usblib_test_rx_split_header(test, 2, dev, rx);
+	mctp_usblib_test_rx_split_header(test, 3, dev, rx);
+	mctp_usblib_test_rx_split_header(test, 4, dev, rx);
+	mctp_usblib_test_rx_split_header(test, 5, dev, rx);
+	mctp_usblib_test_rx_split_header(test, 6, dev, rx);
+	mctp_usblib_test_rx_split_header(test, 7, dev, rx);
+	mctp_usblib_test_rx_split_header(test, 8, dev, rx);
+}
+
 static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_single),
 	KUNIT_CASE_PARAM(mctp_usblib_test_rx_pkt_span,
 			 mctp_usblib_test_rx_pkt_span_gen_params),
+	KUNIT_CASE(mctp_usblib_test_rx_header_splits),
 	{}
 };
 

-- 
2.47.3

