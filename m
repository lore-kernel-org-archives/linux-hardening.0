Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927344;
	b=GiI/uXdnpG5n+jDJ/5TmMJo52DncIElZolssgjP1V02EcTPnIX6Rop4fja09FEKF8AYT
	 fdOO44ZtaIaHCuhkJtcmRs2qh+H2P1Q6/0qRSUhxSSGnkRqj5a7PKbrkGI7nq9b/WR1ST
	 QdMLdtNL13kN6MimTlUa5nJPoGRXu01y/L82VxqGychAiBTzV/QQgevK1T9QfTKU5QpPt
	 IeqJlgD4trv2UwcUHzTnyPSfCy6fC3twb7hg18g7siGhxn6/ciwGpaoy79Zc7ukCpsclS
	 mBABNRlaTaS5q6EUhIfmxavZIe6LEEHepj4ITcTki83qX13XZh3WxDASTuz8FpRO1Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YXN/cmE2b18TH9R1wcOBPcApNcBvXcI1LLfj/l4dFc4=;
	b=e/KmVBtckhwqlyaDFrbsd1F5BtQ6IQelU3X2+w6bx7865dr7vlnurSg+ocRLE8v6+vLA
	 3tZkZuzYbWAEUPenqTpRjQtuG75GdxlsijK5QTBa7KsaQb3LMmu7C47jlt3KGur2Qetl+
	 yDv3Zt19tyVRWMTcYFRBbobh3S2++JMW9uwfF9du2/vwn4k+ekJBF5U7Yzom30SgxYpgD
	 u0qwtSzPVyxndv8mKHMipfwGe9j+FHHjlUu7cMz15HCfD+42gBV4nQmybLSxWDxpwC+/Q
	 cr7tuMfPqrg9BmtWkR2oORm8qCvzEDRzQ+6/HZng/6Uobb7TlUxHQCZ/ecEtxB6ffxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="BJ7lQU/4";
	arc=none smtp.remote-ip=74.125.224.71
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49916606A336
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49916606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BJ7lQU/4
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67c1c64551bso7718232d50.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927343; x=1795532143; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YXN/cmE2b18TH9R1wcOBPcApNcBvXcI1LLfj/l4dFc4=;
        b=BJ7lQU/42BGKYGKWz8cYMbrWFwQtlAfuyegZD9xW9Xlv5gj4SEaiB+aBaK/LNyfYcX
         Rj7UlI/lupSs0oKgeT9a9PqqNrtEMp7lMLz2NPJnEJn1X2sTQ9cEnIt3Xl+aeYm1wo/v
         F8nfm82xEClw9Mk+gKePRIxEL80mjwLUTai5P1+E1oQ89Dk4ynnmj5i7BVxwyuQ/K8Dr
         Dtp4V2j8rN6Z/bFHXUvxJneu1uKG9AepxqS0zUg2mRIWQzJPJrp0gt81VyS8rrQfHyqW
         1v7etg3stuBD658I8kA6wnHSspusASTrinoKyPLsz0pKyV9ENeZILD0eBSDYy6y2Nlj0
         feSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927343; x=1795532143;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXN/cmE2b18TH9R1wcOBPcApNcBvXcI1LLfj/l4dFc4=;
        b=UwWCsKTNFdzFT3DIHh1nt9aNJDSpEo+mSKoPtVE8rbcfAFffbXb84L+Mv2450CwXQk
         h1XTHsEoPSdIaDYDkp53EVmzgY2tQk+rCuXR1znQ/xa/pddXE5/3rjcy3RNANguy0e3k
         BNKOs+RuzQW/sd229ZDxZCHktn68UeG5dcpVh2nqkv/Gz1nWVh6Mch/OP62/4lJ1lreN
         CKSgYVBBunxsVcZZO4Tlk4Q+1lWzIJG1Pf6SXGCmq9e9sdK5fYr1aS9Ofn41TDO4jnWt
         Tk1+kdIk4OgArEFXKgwjBeO/4Gw96tcAYaVGkxE9witDjKqtEfkR2enBut7NORYLbUh6
         NGDQ==
X-Forwarded-Encrypted: i=1; AL+hErFHpjakOKtawQHET6K6sq+VGlQN1Oe25PzhM9thYcJgEqDdmC7oWe2eLOn7otmN/V5/kOTzZasJfj6bKPp47jA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eIwHBlfH2bKuw+4TqYHNk+lrirRQUQGOz7CLUnbdGUKowLsQc
	rzxAcmsFex0Abp1t7nuJ04TGfNJFZDWNT/9eoVYe+kS0ZaNkDUTGp5D7xJSYHVg2M/odhxBDCAf
	sAg==
X-Received: from yxpq15.prod.google.com ([2002:a53:e8cf:0:b0:67d:a676:2621])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:168d:b0:679:c7d1:ffd6
 with SMTP id 956f58d0204a3-67d896a36cfmr9511324d50.36.1794927343014; Tue, 17
 Nov 2026 06:55:43 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:11 +0000
In-Reply-To: <20261117145522.1910636-1-stani@google.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117145522.1910636-1-stani@google.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
Message-ID: <20261117145522.1910636-6-stani@google.com>
Subject: [PATCH iwl-next 05/15] idpf: psp: add support for crypto capabilities
From: Stan Iliev <stani@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Madhu Chittim <madhu.chittim@intel.com>, 
	Emil Tantilov <emil.s.tantilov@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Brian Vazquez <brianvv@google.com>, Li Li <boolli@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for negotiating the crypto offload capabilities:
- Introduce VIRTCHNL2_OP_CRYPTO_GET_CAPS (564),
  enum virtchnl2_cap_crypto and struct virtchnl2_crypto_get_caps.
- Implement idpf_send_get_crypto_caps() in the new
  idpf_psp_virtchnl.c and call it from idpf_psp_negotiate_caps() in
  idpf_psp_init(). PSP stays disabled, without failing probe, unless
  PSP crypto offload and SADB entries are granted with a 21 or 26 bit
  SA index width, and the SA indexes of all the SADB entries fit in
  the width.
- Store the SADB size and the SA index width of the adapter in
  adapter->psp.sadb_entries and adapter->psp.saidx_width.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/Makefile      |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 61 ++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 10 +++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 71 +++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   | 13 ++++
 include/linux/net/intel/virtchnl2.h           | 26 +++++++
 6 files changed, 182 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h

diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 3162ea913417..8db28c228e04 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -21,7 +21,7 @@ idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_ptp.o
 idpf-$(CONFIG_PTP_1588_CLOCK)	+= idpf_virtchnl_ptp.o
 
-idpf-$(CONFIG_INET_PSP)		+= idpf_psp.o
+idpf-$(CONFIG_INET_PSP)		+= idpf_psp.o idpf_psp_virtchnl.o
 
 idpf-y				+= xdp.o
 idpf-y				+= xsk.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index c1297ec59163..c4f46f7337ef 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -3,6 +3,59 @@
 #include <net/psp.h>
 
 #include "idpf_psp.h"
+#include "idpf_psp_virtchnl.h"
+
+/**
+ * idpf_psp_negotiate_caps - Negotiate the crypto and PSP capabilities
+ * @adapter: private data struct
+ *
+ * Query the crypto and PSP capabilities granted by the CP, check that they
+ * cover what the driver implements and apply the negotiated values. Must only
+ * be called if VIRTCHNL2_CAP_CRYPTO was negotiated.
+ *
+ * Return: 0 if PSP offload can be used, negative error code otherwise.
+ */
+static int idpf_psp_negotiate_caps(struct idpf_adapter *adapter)
+{
+	struct virtchnl2_crypto_get_caps crypto_caps = { };
+	struct device *dev = &adapter->pdev->dev;
+	u32 sadb_entries;
+	int err;
+
+	err = idpf_send_get_crypto_caps(adapter, &crypto_caps);
+	if (err)
+		return err;
+
+	if (!(le32_to_cpu(crypto_caps.crypto_caps) & VIRTCHNL2_CAP_CRYPTO_PSP)) {
+		dev_notice(dev, "PSP crypto offload not granted by CP\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (crypto_caps.saidx_width != IDPF_PSP_SAIDX_WIDTH_21 &&
+	    crypto_caps.saidx_width != IDPF_PSP_SAIDX_WIDTH_26) {
+		dev_err(dev, "Unsupported PSP SA index width %u\n",
+			crypto_caps.saidx_width);
+		return -EOPNOTSUPP;
+	}
+
+	sadb_entries = le32_to_cpu(crypto_caps.num_sadb_entries);
+	if (!sadb_entries) {
+		dev_notice(dev, "No PSP SADB entries granted by CP\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* The SA indexes of all the SADB entries must fit in the width */
+	if (sadb_entries > BIT(crypto_caps.saidx_width)) {
+		dev_err(dev, "%u PSP SADB entries don't fit in %u bit SA indexes\n",
+			sadb_entries, crypto_caps.saidx_width);
+		return -EOPNOTSUPP;
+	}
+
+	adapter->psp.sadb_entries = sadb_entries;
+	adapter->psp.saidx_width = crypto_caps.saidx_width;
+
+	return 0;
+}
 
 /**
  * idpf_psp_init - Initialize PSP offload
@@ -18,6 +71,7 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 {
 	struct idpf_adapter_psp *psp = &adapter->psp;
 	struct device *dev = &adapter->pdev->dev;
+	int err;
 
 	WRITE_ONCE(psp->enabled, false);
 
@@ -26,6 +80,13 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 		return;
 	}
 
+	err = idpf_psp_negotiate_caps(adapter);
+	if (err) {
+		dev_warn(dev, "PSP disabled, capability negotiation failed: %d\n",
+			 err);
+		return;
+	}
+
 	WRITE_ONCE(psp->enabled, true);
 }
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 2edb114784c1..3a9e40284106 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -5,15 +5,25 @@
 
 #include <net/psp.h>
 
+/* SA index widths supported by the driver, negotiated per adapter with
+ * VIRTCHNL2_OP_CRYPTO_GET_CAPS, see idpf_psp_negotiate_caps().
+ */
+#define IDPF_PSP_SAIDX_WIDTH_21		21
+#define IDPF_PSP_SAIDX_WIDTH_26		26
+
 /**
  * struct idpf_adapter_psp - PSP offload state of an adapter
  * @enabled: PSP was negotiated with the CP in the last core init, see
  *	     idpf_is_psp_ena()
+ * @sadb_entries: SADB size granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
+ * @saidx_width: SA index width granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
  */
 struct idpf_adapter_psp {
 	bool enabled;
+	u32 sadb_entries;
+	u8 saidx_width;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
new file mode 100644
index 000000000000..65f7a9f63f90
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "idpf_psp_virtchnl.h"
+#include "idpf_virtchnl.h"
+
+/**
+ * idpf_print_crypto_caps - Print values inside virtchnl2_crypto_get_caps
+ * @adapter: Driver specific private structure
+ * @caps: Pointer to virtchnl2_crypto_get_caps structure
+ */
+static void idpf_print_crypto_caps(struct idpf_adapter *adapter,
+				   const struct virtchnl2_crypto_get_caps *caps)
+{
+	u32 num_sadb_entries = le32_to_cpu(caps->num_sadb_entries);
+	u32 crypto_caps = le32_to_cpu(caps->crypto_caps);
+
+	dev_dbg(&adapter->pdev->dev,
+		"virtchnl2_crypto_get_caps: crypto_caps=0x%08x (PSP=%u), num_sadb_entries=%u, saidx_width=%u\n",
+		crypto_caps, !!(crypto_caps & VIRTCHNL2_CAP_CRYPTO_PSP),
+		num_sadb_entries, caps->saidx_width);
+}
+
+/**
+ * idpf_send_get_crypto_caps - Send VIRTCHNL2_OP_CRYPTO_GET_CAPS request to CP
+ * @adapter: Driver specific private structure
+ * @caps: Output buffer for virtchnl2_crypto_get_caps
+ *
+ * Request the PSP crypto offload. Must only be sent if VIRTCHNL2_CAP_CRYPTO
+ * was granted.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
+			      struct virtchnl2_crypto_get_caps *caps)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_CRYPTO_GET_CAPS,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	struct virtchnl2_crypto_get_caps *send_caps;
+	int err;
+
+	/* Too large to be sent from the stack */
+	send_caps = kzalloc_obj(*send_caps);
+	if (!send_caps)
+		return -ENOMEM;
+
+	send_caps->crypto_caps = cpu_to_le32(VIRTCHNL2_CAP_CRYPTO_PSP);
+
+	err = idpf_send_mb_msg_kfree(adapter, &xn_params, send_caps,
+				     sizeof(*send_caps));
+	if (err) {
+		dev_err(&adapter->pdev->dev, "Failed to get crypto caps: %d\n",
+			err);
+		return err;
+	}
+
+	if (xn_params.recv_mem.iov_len < sizeof(*caps)) {
+		dev_err(&adapter->pdev->dev, "Invalid crypto caps reply size: %zu\n",
+			xn_params.recv_mem.iov_len);
+		err = -EIO;
+		goto release_rx;
+	}
+
+	memcpy(caps, xn_params.recv_mem.iov_base, sizeof(*caps));
+	idpf_print_crypto_caps(adapter, caps);
+
+release_rx:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
new file mode 100644
index 000000000000..cf82ac9182ef
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _IDPF_PSP_VIRTCHNL_H_
+#define _IDPF_PSP_VIRTCHNL_H_
+
+#include <linux/net/intel/libie/controlq.h>
+
+#include "idpf_psp.h"
+
+int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
+			      struct virtchnl2_crypto_get_caps *caps);
+
+#endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index ec1a742b6557..59c379afcb71 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -84,6 +84,8 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_ADD_FLOW_RULE			= 551,
 	VIRTCHNL2_OP_GET_FLOW_RULE			= 552,
 	VIRTCHNL2_OP_DEL_FLOW_RULE			= 553,
+	/* Crypto/PSP opcodes */
+	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
 };
 
 /**
@@ -1817,4 +1819,28 @@ struct virtchnl2_flow_rule_add_del {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_flow_rule_add_del);
 
+/* Generic crypto offload types */
+enum virtchnl2_cap_crypto {
+	VIRTCHNL2_CAP_CRYPTO_PSP			= BIT(0),
+};
+
+/**
+ * struct virtchnl2_crypto_get_caps - Crypto global capabilities
+ * @crypto_caps: See enum virtchnl2_cap_crypto
+ * @num_sadb_entries: Number of SADB entries of the function, not shared with
+ *		      the other functions of the device
+ * @saidx_width: SA index width in bits
+ * @padding: Padding to 256 bytes
+ *
+ * Request and response of VIRTCHNL2_OP_CRYPTO_GET_CAPS. On input @crypto_caps
+ * holds the requested capabilities, on output the granted ones.
+ */
+struct virtchnl2_crypto_get_caps {
+	__le32 crypto_caps;
+	__le32 num_sadb_entries;
+	u8 saidx_width;
+	u8 padding[247];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(256, virtchnl2_crypto_get_caps);
+
 #endif /* _VIRTCHNL_2_H_ */
-- 
2.56.0.679.gc527c65306-goog

