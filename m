Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0538B14B;
	Mon, 31 Aug 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147888; cv=none; b=rmNqXq/y6lZF9j81LKUp9UddRaVChwcs4f53fAPDnDJy3UixfQrAa+MU7aUZ41AcQevCUbu93iXYu39OcMhNSz1SapaDIJS0LLuiSwh+NacMKOvNtsSCloABp47RP4hjhsvVt+2pgvk5dYVtWLQeuT0IS+IKEj8h0zb4BoBaSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147888; c=relaxed/simple;
	bh=uKH15B5187BJx0Svq0172WuxvKgr+VueTe9NWaQhigc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZxCbHaHdy1dqCdBDzK2lU5APsBp7ZR3+dsUTIsNPxAGRiQSnx2cXTN/6ENdIj/4UtVcruIOf4+Ga9THf9NuMLVZdnqRb8P2gUSA9PILkXFHaeMb9FN4oyCuvlOoFQsbLGIbWMMWsBvlCcJF/aCRGHQZ1r+3xgc2mmeDgYCEVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XUegohNV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XUegohNV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1788147871;
	bh=VQpKLCmW4XxE0X+8IaJe5AOkNtk48jbUrUIj5PwR7rE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XUegohNVQ1uzixQdwBe43DjEtNseBrtGrzHvJXU8vtok5Yudom8z1xVoUZ4Fqxcb6
	 thcIwCrS1rWp8+/446DZ0exxNFgK1jfqwOhOmQjZrshZkklOKhY2MDjMrpO091CvIM
	 Ow6pTyhgsba9VEzYdCHgmx3WQTT4/hbv0+jAtwJbA3ZFgSxF3+rTn1d2zyLNNdPlJd
	 mIG6BKxodSgkDX/6OtFL+mlnIZaP8cwS1mntzwRKXxL4FRDYPLnwsmS+PH1x3hne8Z
	 kQGeAagqhKNfwoUueIJYaZagDYb3jo6jQgMxGU+u1iqQ8Zqm14s2idk+Lrla63UWat
	 AHo0DNXqxnqtA==
Received: by codeconstruct.com.au (Postfix, from userid 10004)
	id D787B68451; Mon, 31 Aug 2026 11:44:31 +0800 (AWST)
From: James Lee <james@codeconstruct.com.au>
Date: Mon, 31 Aug 2026 11:43:45 +0800
Subject: [PATCH 6/7] net: mctp: usblib: Add initial kunit tx tests
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-dev-mctp-usb-lib-test-v1-6-79699bf67a18@codeconstruct.com.au>
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

Add tests for the transmit path, where MCTP packets are handed to
outgoing USB transfer data. Testing a spanning transfer that is expected
to succeed, the failure paths when sends fail, and large sequential
sends.

Signed-off-by: James Lee <james@codeconstruct.com.au>
---
 drivers/net/mctp/mctp-usblib-test.c | 292 ++++++++++++++++++++++++++++++++++++
 1 file changed, 292 insertions(+)

diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
index 772484df32a7d7b4d30e51808e06853febe272b6..7dc382caffc17644dd616f78df332201d412f709 100644
--- a/drivers/net/mctp/mctp-usblib-test.c
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2026 Code Construct Pty Ltd
  */
 
+#include <linux/array_size.h>
 #include <uapi/linux/netdevice.h>
 #include <linux/netdevice.h>
 #include <kunit/test.h>
@@ -16,6 +17,13 @@
 
 #define HDR_LEN sizeof(struct mctp_usb_hdr)
 
+struct tx_buff {
+	struct list_head list;
+
+	size_t length;
+	u8 data[] __counted_by(length);
+};
+
 struct mctp_usblib_test_dev {
 	struct net_device *ndev;
 	struct mctp_dev *mdev;
@@ -24,9 +32,110 @@ struct mctp_usblib_test_dev {
 
 struct mctp_usblib_test_ctx {
 	struct mctp_usblib_test_dev *dev;
+	struct list_head tx_xfers;
 	struct mctp_route rt;
 };
 
+static int mctp_usblib_test_tx_send(struct mctp_usblib_tx_ctx *tx_ctx,
+				    void *data, size_t len)
+{
+	struct mctp_usblib_test_ctx *ctx;
+	struct tx_buff *new_node;
+	struct net_device *ndev;
+	int rc;
+
+	ctx = mctp_usblib_tx_ctx_priv(tx_ctx);
+	ndev = ctx->dev->ndev;
+	rc = 0;
+
+	new_node = kzalloc_flex(*new_node, data, len, GFP_KERNEL);
+	if (!new_node) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	new_node->length = len;
+	memcpy(&new_node->data, data, len);
+	list_add_tail(&new_node->list, &ctx->tx_xfers);
+
+exit:
+	mctp_usblib_tx_send_complete(tx_ctx, ndev, rc == 0);
+	return rc;
+}
+
+static int mctp_usblib_test_tx_send_fail(struct mctp_usblib_tx_ctx *tx_ctx,
+					 void *data, size_t len)
+{
+	return -ENOMEM;
+}
+
+static u8 *mctp_usblib_test_flatten_tx_buff(struct kunit *test,
+					    struct list_head *in,
+					    size_t *length_out)
+{
+	struct tx_buff *pos;
+	size_t length;
+	u8 *buf, *tail;
+
+	KUNIT_ASSERT_TRUE(test, length_out);
+	KUNIT_ASSERT_TRUE(test, in);
+
+	length = 0;
+	list_for_each_entry(pos, in, list)
+		length = size_add(length, pos->length);
+
+	KUNIT_ASSERT_NE(test, length, 0);
+	KUNIT_ASSERT_NE(test, length, SIZE_MAX);
+
+	buf = kunit_kzalloc(test, length, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+
+	tail = buf;
+	list_for_each_entry(pos, in, list) {
+		memcpy(tail, pos->data, pos->length);
+		tail += pos->length;
+	}
+
+	*length_out = length;
+	return buf;
+}
+
+static u8 *mctp_usblib_test_init_buf(struct kunit *test, size_t length)
+{
+	u8 *buffer;
+	size_t i;
+
+	buffer = kunit_kzalloc(test, length, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buffer);
+
+	for (i = 0; i < length; i++)
+		buffer[i] = i % 256;
+
+	return buffer;
+}
+
+static void mctp_usblib_test_fill_head(struct mctp_usb_hdr *head, size_t len)
+{
+	len += HDR_LEN;
+	head->id = cpu_to_be16(MCTP_USB_DMTF_ID);
+	head->len = cpu_to_be16(len & MCTP_USB_1_1_PKTLEN_MAX);
+}
+
+static struct sk_buff *mctp_usblib_test_init_skb(struct kunit *test,
+						 unsigned int length,
+						 struct net_device *ndev,
+						 void *data)
+{
+	struct sk_buff *skb;
+
+	skb = __netdev_alloc_skb(ndev, length, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, skb);
+
+	skb->len = length;
+	memcpy(skb->data, data, length);
+	return skb;
+}
+
 static netdev_tx_t mctp_usblib_dev_tx(struct sk_buff *skb,
 				      struct net_device *ndev)
 {
@@ -119,6 +228,7 @@ static int mctp_usblib_test_dst_output(struct mctp_dst *dst,
 static void mctp_usblib_test_fini_action(void *data)
 {
 	struct mctp_usblib_test_ctx *ctx = data;
+	struct tx_buff *curr, *temp;
 
 	/* The device will have been destroyed, so ->rt will be unlinked.
 	 * Just ensure that the refcount is as expected.
@@ -126,6 +236,8 @@ static void mctp_usblib_test_fini_action(void *data)
 	KUNIT_EXPECT_TRUE(current->kunit_test,
 			  refcount_dec_and_test(&ctx->rt.refs));
 
+	list_for_each_entry_safe(curr, temp, &ctx->tx_xfers, list)
+		kfree(curr);
 	kfree(ctx);
 }
 
@@ -141,6 +253,7 @@ static struct mctp_usblib_test_ctx *mctp_usblib_test_init(struct kunit *test)
 	INIT_LIST_HEAD(&ctx->rt.list);
 	rt = &ctx->rt;
 	refcount_set(&rt->refs, 1);
+	INIT_LIST_HEAD(&ctx->tx_xfers);
 
 	rc = kunit_add_action_or_reset(test, mctp_usblib_test_fini_action, ctx);
 	KUNIT_ASSERT_EQ(test, rc, 0);
@@ -227,6 +340,32 @@ static int mctp_usblib_test_rx_complete(struct net_device *netdev,
 	return rc;
 }
 
+static void action_tx_fini(void *data)
+{
+	struct mctp_usblib_tx *tx = data;
+
+	mctp_usblib_tx_fini(tx);
+	kfree(tx);
+}
+
+static struct mctp_usblib_tx *
+mctp_usblib_test_tx_init(struct kunit *test,
+			 const struct mctp_usblib_tx_ops *ops,
+			 void *priv, bool span)
+{
+	struct mctp_usblib_tx *tx;
+	int rc;
+
+	tx = kzalloc_obj(*tx);
+	KUNIT_ASSERT_NOT_NULL(test, tx);
+	rc = kunit_add_action_or_reset(test, action_tx_fini, tx);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	mctp_usblib_tx_init(tx, ops, priv, true);
+
+	return tx;
+}
+
 /* Single packet, starting on a transfer boundary, contained entirely within
  * the transfer
  */
@@ -582,6 +721,156 @@ static void mctp_usblib_test_rx_nonspanning_partial(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, 0);
 }
 
+static void mctp_usblib_test_tx_pkt_span(struct kunit *test)
+{
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_tx_ops ops;
+	struct mctp_usblib_tx *tx;
+	struct mctp_usb_hdr head;
+	struct net_device *ndev;
+	struct sk_buff *skb;
+	size_t len, tx_len;
+	u8 *buf, *flat_tx;
+	int rc;
+
+	len = 1000;
+
+	ctx = mctp_usblib_test_init(test);
+	ndev = ctx->dev->ndev;
+
+	ops.send = mctp_usblib_test_tx_send;
+
+	tx = mctp_usblib_test_tx_init(test, &ops, ctx, true);
+
+	buf = mctp_usblib_test_init_buf(test, len);
+	mctp_usblib_test_fill_head(&head, len);
+
+	skb = mctp_usblib_test_init_skb(test, len, ndev, buf);
+
+	rc = mctp_usblib_tx_push(ndev, tx, skb, false);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+	KUNIT_ASSERT_FALSE(test, list_empty(&ctx->tx_xfers));
+
+	flat_tx = mctp_usblib_test_flatten_tx_buff(test, &ctx->tx_xfers,
+						   &tx_len);
+	KUNIT_ASSERT_NOT_NULL(test, flat_tx);
+
+	KUNIT_EXPECT_EQ(test, tx_len, len + HDR_LEN);
+	KUNIT_EXPECT_MEMEQ(test, flat_tx, &head, HDR_LEN);
+	KUNIT_EXPECT_MEMEQ(test, flat_tx + HDR_LEN, buf, len);
+}
+
+static void mctp_usblib_test_tx_failing_send(struct kunit *test)
+{
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_tx_ops ops;
+	struct mctp_usblib_tx *tx;
+	struct net_device *ndev;
+	struct sk_buff *skb;
+	size_t len;
+	u8 *buf;
+	int rc;
+
+	len = 100;
+
+	ctx = mctp_usblib_test_init(test);
+	ndev = ctx->dev->ndev;
+
+	ops.send = mctp_usblib_test_tx_send_fail;
+
+	tx = mctp_usblib_test_tx_init(test, &ops, ctx, false);
+	buf = mctp_usblib_test_init_buf(test, len);
+	skb = mctp_usblib_test_init_skb(test, len, ndev, buf);
+
+	/* Doesn't call ops.send as more packets are expected,
+	 * so the push shouldn't fail.
+	 */
+	rc = mctp_usblib_tx_push(ndev, tx, skb, true);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	skb = mctp_usblib_test_init_skb(test, len, ndev, buf);
+
+	/* Calls ops.send as no further packets are expected. */
+	rc = mctp_usblib_tx_push(ndev, tx, skb, false);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_NULL(test, tx->cur_ctx);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->tx_xfers));
+}
+
+/* Test sending multiple packets in the same transfer, followed by one that
+ * spans multiple subsequent transfers.
+ */
+static void mctp_usblib_test_tx_multi_push(struct kunit *test)
+{
+	struct mctp_usblib_test_ctx *ctx;
+	size_t i, max_length, tx_length;
+	struct mctp_usblib_tx_ops ops;
+	u8 *buf, *flat_tx, *index;
+	struct mctp_usblib_tx *tx;
+	struct net_device *ndev;
+	struct sk_buff *skb;
+	const struct {
+		size_t len;
+		bool more;
+	} sends[] = {
+		{ 1000, true  },
+		{  500, false },
+		{ 5000, false },
+	};
+	int rc;
+
+	static_assert(!sends[ARRAY_SIZE(sends) - 1].more,
+		      "The last push must claim there will be no more");
+
+	max_length = 0;
+	for (i = 0; i < ARRAY_SIZE(sends); i++) {
+		if (sends[i].len > max_length)
+			max_length = sends[i].len;
+	}
+
+	ctx = mctp_usblib_test_init(test);
+	ndev = ctx->dev->ndev;
+
+	ops.send = mctp_usblib_test_tx_send;
+
+	tx = mctp_usblib_test_tx_init(test, &ops, ctx, true);
+	buf = mctp_usblib_test_init_buf(test, max_length);
+
+	for (i = 0; i < ARRAY_SIZE(sends); i++) {
+		skb = mctp_usblib_test_init_skb(test, sends[i].len, ndev, buf);
+
+		rc = mctp_usblib_tx_push(ndev, tx, skb, sends[i].more);
+		KUNIT_ASSERT_EQ(test, rc, 0);
+	}
+	KUNIT_ASSERT_FALSE(test, list_empty(&ctx->tx_xfers));
+
+	flat_tx = mctp_usblib_test_flatten_tx_buff(test, &ctx->tx_xfers,
+						   &tx_length);
+
+	for (i = 0, index = flat_tx; i < ARRAY_SIZE(sends); i++) {
+		size_t length_to_check, remaining_bytes;
+		struct mctp_usb_hdr head;
+
+		if (index - flat_tx >= tx_length - HDR_LEN)
+			break;
+
+		mctp_usblib_test_fill_head(&head, sends[i].len);
+		KUNIT_EXPECT_MEMEQ(test, index, &head, HDR_LEN);
+		index += HDR_LEN;
+		remaining_bytes = tx_length - (index - flat_tx);
+
+		length_to_check = sends[i].len;
+		KUNIT_EXPECT_GE(test, remaining_bytes, length_to_check);
+		length_to_check = min(remaining_bytes, length_to_check);
+
+		KUNIT_EXPECT_MEMEQ(test, index,
+				   buf, length_to_check);
+
+		index += length_to_check;
+	}
+	KUNIT_EXPECT_EQ(test, i, ARRAY_SIZE(sends));
+}
+
 static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_single),
 	KUNIT_CASE_PARAM(mctp_usblib_test_rx_pkt_span,
@@ -591,6 +880,9 @@ static struct kunit_case mctp_usblib_test_cases[] = {
 	KUNIT_CASE(mctp_usblib_test_rx_invalid_dmtf_id),
 	KUNIT_CASE(mctp_usblib_test_rx_nonspanning_tiny),
 	KUNIT_CASE(mctp_usblib_test_rx_nonspanning_partial),
+	KUNIT_CASE(mctp_usblib_test_tx_pkt_span),
+	KUNIT_CASE(mctp_usblib_test_tx_multi_push),
+	KUNIT_CASE(mctp_usblib_test_tx_failing_send),
 	{}
 };
 

-- 
2.47.3

