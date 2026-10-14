Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF33783B4;
	Wed, 14 Oct 2026 04:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953280; cv=none; b=sv1FIco6Ucsip9O1TN1QXl9leUjGsoj6o+4fPbVNdHYZDJ7QbNcTR7Y7S6+g33Ivtxl8v1EGzTHEoI0WZvaLMOb13RuEJ3aBVzS9ICSykZCO50qFARkA+OE1jArIkmcBW3Z42TFlwHKMIoUSNJkl/gtdH8NuGuPipDPO0nXmKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953280; c=relaxed/simple;
	bh=YOcTyz/lmP3gB6X2tIleXqKkVyRZ9uIfukhKM5HcNdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VsrqyDmN18AUnXWEb/iM44yF4++rUu80SXkBmcdwDCNfgfnkrojrp8WVSzCyoE7ahInQLSvqTwl1/5NR3kSjUi+/6cIRBDP9hevnn7abUxGz0/afPk+sibv7k+8OCoDeoSK6zznrl5l2SMMzljLr/nkFC/9+jITWG2QEgWIAWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=d3ut3cbz; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="d3ut3cbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791953276;
	bh=UI+6aXwo8TPmIlUIbV8X6CK1th4XEgAsio0JTLoVMqg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d3ut3cbzdFNWTjawaM0L1wWuVi2UerCHyJzlWwUNWkM5tjUuOvjBxKRcPNM5LXv7i
	 iJS3ExcVHFMKI/TJvTeLZLsTxQPhBs2idtQDmJBt592MNxfM38cXSbP4OdYh+VUwAN
	 4D70zznEA4QYS+vz8h0rHXK4AWJDoi7tsG2TqC+8I4M5XfyWE49QU+7v2EIZtidb6H
	 qEgkGg2V4LqZIks/SQzDZ63rl0a71a8bqiIXxlInZLE0DRWI4ifn1x8HEt5CeyFFWp
	 R4CdgFveJF5yqE2ConWiKR9elJbGlGuzoqO3bgLqP1yL4BcTpp7M2D88Cg3eb44SkW
	 Rt0MN1+XOzj5Q==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 955556FD56; Wed, 14 Oct 2026 12:47:56 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Wed, 14 Oct 2026 12:47:34 +0800
Subject: [PATCH net-next v3 4/7] net: mctp: usblib: Complete rx tests
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-dev-mctp-usb-lib-test-v3-4-ee5bc3ea1db1@codeconstruct.com.au>
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

Add rx tests without spanning, covering cases where a packet is shorter
than allowed without spanning, isn't completed within one submission.

Fully cover rx functions except for memory allocation failures and
trivial functions.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 44389c0451c1c915c282bbe3881efac772d9c4e1..ba2cd432355fe130a36d4f815c40ddb915db234a 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -527,6 +527,66 @@ static void mctp_usblib_test_rx_invalid_dmtf_id(struct kunit *test)
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
@@ -534,6 +594,8 @@ static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_header_splits),
 	KUNIT_CASE(mctp_usblib_test_rx_short_packet),
 	KUNIT_CASE(mctp_usblib_test_rx_invalid_dmtf_id),
+	KUNIT_CASE(mctp_usblib_test_rx_nonspanning_tiny),
+	KUNIT_CASE(mctp_usblib_test_rx_nonspanning_partial),
 	{}
 };
 

-- 
2.47.3

