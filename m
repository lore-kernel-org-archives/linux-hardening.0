Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81F41F378;
	Wed, 14 Oct 2026 04:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953282; cv=none; b=kUU/siFed0CKiq7u5oO3RqmF0H6BoKxmkzebzL9Jz8kJDjCzgaLHqsBm8MYpYkE41EQfArOzBRsV2+YjM5CE4/0+WtgiLACpNPOE4tIJ9a4ILjDhJMA9OUvrrAL6lNtq4felpI+f1dKao3ZkBvfU0oXJUFfgefh2XXJp+344IXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953282; c=relaxed/simple;
	bh=3CewnfJjBLNCz8iUBY5RR8bH1vyAl7u1kgB+P/0e898=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jEyg4ipHCjUydGyF6xf/VXgH44h99gEoI+Zvzqa1pfVcaiD+8OUFWUTzH2MV9vgyamrBLNm5C8sLJ35XcrGNT7cnEaMzX4JEY+qaEgmm8QFOnOGjNFkJ6xzjZFjter9tPI7L3oy+uv6JUcjsbtCCUAtVyscaOwdEbvOb1taXDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mWSBVeXR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mWSBVeXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1791953277;
	bh=QI1WwrvTUqFlZxn7M8A465KJ/faCZRWN6/FkUzEdZl8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mWSBVeXRmob9K3p52s5ffUFF85xlgVUfIFT6QqmB/oJ+5Zku3hSzaqygx658c87Gz
	 LxO8qwwMltHPbJkM5rcvY2iDHlwuBKayzICO3eHxQd7wxno46WMzl2vrJ4VJEtTBy6
	 0WdSmbf8/+AUMmu1Wmz0FN7rWetCEgZSTJH0Tk9zyp1a/b6bHYyAqWDmTtyuYaMazF
	 OQBvMhdG17sAmotTygHRb/DsZ5xYVfu/lkMXFJsbFFf7zz1AOrfYf1mP87Jth7c1zr
	 VTSNfOt3MVBE2osrntjfWH+09RWvJ4XAVTAOxBnBtqhLEnJgOwabpyloj6ZS8/hKB7
	 syKkJUfDePSFA==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id B3A6A6FD5C; Wed, 14 Oct 2026 12:47:57 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Wed, 14 Oct 2026 12:47:37 +0800
Subject: [PATCH net-next v3 7/7] net: mctp: usblib: Add test for failing
 append
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-dev-mctp-usb-lib-test-v3-7-ee5bc3ea1db1@codeconstruct.com.au>
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

Add test ensuring that network device stats are updated appropriately
when a previously pushed packet fails to send during a subsequent push.

Signed-off-by: James Lee <james@codeconstruct.com.au>

---
v2:
- Fix preemption management
v3:
- Rename mctp_usblib_test_tx_overflow()
- Correct stats collection
- Remove magic numbers from mctp_usblib_test_append_failure()
---
 drivers/net/mctp/mctp-usblib-test.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 16c2c9963d2d4493268687764a1e9209f8c9a901..b7e8743c561f948a9528fccfaa5a50cd78b3320e 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -868,6 +868,47 @@ static void mctp_usblib_test_tx_multi_push(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(sends));
 }
 
+static void mctp_usblib_test_append_failure(struct kunit *test)
+{
+	struct mctp_usblib_test_ctx *ctx;
+	struct rtnl_link_stats64 stats;
+	struct mctp_usblib_tx_ops ops;
+	struct mctp_usblib_tx *tx;
+	struct net_device *ndev;
+	struct sk_buff *skb;
+	u64 tx_dropped;
+	size_t i;
+	u8 *buf;
+	int rc;
+
+	const size_t packet_count = 3;
+	const size_t len = (MCTP_USB_1_0_XFER_SIZE / packet_count) + 1
+			   - sizeof(struct mctp_usb_hdr);
+	static_assert(len >= MCTP_USB_BTU);
+
+	ctx = mctp_usblib_test_init(test);
+	ndev = ctx->dev->ndev;
+
+	ops.send = mctp_usblib_test_tx_send_fail;
+
+	tx = mctp_usblib_test_tx_init(test, &ops, ctx, false);
+	buf = mctp_usblib_test_init_buf(test, len);
+
+	for (i = 0; i < packet_count; i++) {
+		tx_dropped = dev_get_stats(ndev, &stats)->tx_dropped;
+		KUNIT_EXPECT_EQ(test, tx_dropped, 0);
+		skb = mctp_usblib_test_init_skb(test, len, ndev, buf);
+
+		rc = mctp_usblib_tx_push(ndev, tx, skb, i != packet_count - 1);
+		KUNIT_EXPECT_EQ(test, rc, 0);
+		KUNIT_EXPECT_TRUE(test, list_empty(&ctx->tx_xfers));
+	}
+
+	tx_dropped = dev_get_stats(ndev, &stats)->tx_dropped;
+	KUNIT_EXPECT_EQ(test, tx_dropped, packet_count);
+	KUNIT_EXPECT_NULL(test, tx->cur_ctx);
+}
+
 static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_single),
 	KUNIT_CASE_PARAM(mctp_usblib_test_rx_pkt_span,
@@ -880,6 +921,7 @@ static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_tx_pkt_span),
 	KUNIT_CASE(mctp_usblib_test_tx_multi_push),
 	KUNIT_CASE(mctp_usblib_test_tx_failing_send),
+	KUNIT_CASE(mctp_usblib_test_append_failure),
 	{}
 };
 

-- 
2.47.3

