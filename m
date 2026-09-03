Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C93349CCD;
	Thu,  3 Sep 2026 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403371; cv=none; b=qNMT+cEzdOolye6upSeulQQfzan3EfAak6zs1VtL2Ksm8HtTbQnQIOX97R21T+PkV2vxjGBKzdkpwEdoVMfAOLwl0QkpMh9by4sUwrO6CYTgU9piWeoaAUFUKw+Q3v8IIqhIXIlJGHBkqo+wY98eee3RSlufkq3ct9C9aZyx4Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403371; c=relaxed/simple;
	bh=mMvO4b4n2Sf1QhTLIEzIQcY20H6QvmMIqWQIF35BWlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOdGv3f4bXRc+CzFsb1ksUU7q+cXlu8XF+mYLk8khYeESbUVSjBp2uOe4yfFb74WJ+Am+WtuMnU9G/c1pNWWOrWC4mpsCBalBWPjMs+fKfQGwJOC52q5KjAu0TpPVBvzDK2scWKSm+QT1NML7OJZlWl9qMamsNF8RttQsAjg5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VsXvQyPb; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VsXvQyPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788403359;
	bh=8+t3CYaVZfeSpwgWXkwVWrWI6AdFZrilGRE2KDHZsmg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VsXvQyPbC83Tleiy6KCEMLBsbtm00aSMTrUNC44yTIGDSyNNwDU6u0vQlUWjd/QeU
	 VigmYs/LUoH0uypbjwpIM24x6pJT6o2Be8gVnHD9qSpJcR0KFqr9mu6QH0y8e5KB84
	 A8La0AchLtuEvpyQBcJh/ipuCW7Oyrw/0kdDGhpt3M9WGy6ManoMYg0ZSrQ4hQJNBT
	 +r1df6HA1iX13dfYUeeoW1zxQ2uWiewW8uNwMbdvXL7fiBSH/uNC7HHURw/FcRMXCL
	 1lXIZMpnfOVDykxDQy86dCuPkxdkwchytkhSyf335tjX8vUZ2w9SFGRZN2I0QpQel6
	 M5Wua1T+DGyVQ==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 65CC568692; Thu,  3 Sep 2026 10:42:39 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Thu, 03 Sep 2026 10:42:19 +0800
Subject: [PATCH net-next v2 2/7] net: mctp: usblib: Add test for splits
 inside headers
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dev-mctp-usb-lib-test-v2-2-313cf15e0b56@codeconstruct.com.au>
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

Add test covering every possible split of a packet's headers between
transfers and remove parameterized tests that are now covered.

Signed-off-by: James Lee <james@codeconstruct.com.au>

---
v2:
- Replace direct calls to mctp_usblib_rx_complete()
- Fix sk_buff leak
---
 drivers/net/mctp/mctp-usblib-test.c | 71 +++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 4c27307900fb6116572bc9d89f3def6f06c30397..a2ca79f61910af129af956a6f38ad69d5dae8c10 100644
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
@@ -403,10 +399,73 @@ static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
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
+	mctp_usblib_test_rx_complete(dev->ndev, rx, offset);
+
+	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &buflen,
+				    GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+	KUNIT_ASSERT_GE(test, buflen, len);
+	KUNIT_ASSERT_EQ(test, dev->rx_pkts.qlen, 0);
+
+	memcpy(buf, packet + offset, len - offset);
+	mctp_usblib_test_rx_complete(dev->ndev, rx, len - offset);
+	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 1);
+
+	skb = __skb_dequeue(&dev->rx_pkts);
+	KUNIT_EXPECT_NOT_NULL(test, skb);
+	if (skb) {
+		KUNIT_EXPECT_EQ(test, skb->len, len - HDR_LEN);
+		kfree(skb);
+	}
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

