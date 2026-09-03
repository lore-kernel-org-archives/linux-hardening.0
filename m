Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A18345EDA;
	Thu,  3 Sep 2026 02:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788403371; cv=none; b=eTUWMGIeCC0wRrrspibVgi5nlkw79pvKJG6mHCUz8Y5fpISoStMd89H7gSCY2U14nCyjN+Ly/P7m7Ymka80ljsqqDzNYkXqw6aesrmtj+u4bmr39uUxJfcplgijtLAwmVg9lyxmX3n+H5gUAq6f09PS/zIejaaus3Ktg6MZYl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788403371; c=relaxed/simple;
	bh=IQpo3Ur+po/SknYNiFMjOiB665k3pLezpQs8wXnobgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCFgtNvWYM1kExbu6GVqV7wtmXg8vz1egmf/AoPwrnlbiBdMNyifbFh7B9AhvRMjwRjUaCGDMBpMSoLeApcd2RrjjQKvRwfjyZNJ1Ktnjng1n0x8PUQBNILKf/OTr4oURxgk4kbgyiOiFHTVmmuyaO0S0LHxhip23Lk80pLJ/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=kCBdQRrL; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="kCBdQRrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788403360;
	bh=33Wab9uvJ9ffHBxVA+YFiRSUKBQ8KhuCxK3Ce4oR/nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kCBdQRrLLAoH/lSgdEmNUlmCMef2zXbfghAJcGXPdG6c7xIAtYbRDFnGnrWML2Rje
	 q1LTms+RhQCq/hsvKL6cYtDPz+Ts4IfyuFj2jRj0zfjDxL+EleKlOu9xT2MOj9vNVG
	 jt0eZNNdWzXMe+jKEVJY8FkzcVOTKIzQe/VRrgffTPXMwepZNA/LPw2h9wTlqFbMhQ
	 IjRAukQwWfzedrYBbIw9a8i68HVrkRs93/7uDBnGuJViIObPFq2SjC8z18Z0WEnixU
	 7Q7IQKGFCeEac1lY+yd4pY7GVpiehEaNNSJNi4yOjfOuNvSQAref+vOb1+38vNgd3H
	 RWJZRtMmetzbA==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id 38A0D68694; Thu,  3 Sep 2026 10:42:40 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Thu, 03 Sep 2026 10:42:21 +0800
Subject: [PATCH net-next v2 4/7] net: mctp: usblib: Complete rx tests
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dev-mctp-usb-lib-test-v2-4-313cf15e0b56@codeconstruct.com.au>
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

Add rx tests without spanning, covering cases where a packet is shorter
than allowed without spanning, isn't completed within one submission.

Fully cover rx functions except for memory allocation failures and
trivial functions.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index b0266be79e94c5adb1cf4286d5aeef9768d28b34..22aaa4795cbdd13432a3c1e7cc85ecbb3a30fe88 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -526,6 +526,66 @@ static void mctp_usblib_test_rx_invalid_dmtf_id(struct kunit *test)
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
@@ -533,6 +593,8 @@ static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_header_splits),
 	KUNIT_CASE(mctp_usblib_test_rx_short_packet),
 	KUNIT_CASE(mctp_usblib_test_rx_invalid_dmtf_id),
+	KUNIT_CASE(mctp_usblib_test_rx_nonspanning_tiny),
+	KUNIT_CASE(mctp_usblib_test_rx_nonspanning_partial),
 	{}
 };
 

-- 
2.47.3

