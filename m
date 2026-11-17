Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927349;
	b=IhFyHXvMTULzeTeJwFYs0tjOpriz/OhLcYVesozGLQYPHR7HN/5gz9vpy8CYhgjI1jsG
	 TG17E2FBAk8BENyq/P8zKrOjY/08U7t2u1xs5tA0dcYBnysrf25W9CGHdwYEqikW6LzSA
	 KAqepLGmTZn71l5vk9TwIEMmCzbe6cdFygvqblKwRVzGhBAc4v+qILb6UVBi9GNzd8ZVs
	 +atH6APZOhEe4u1xq0CjB6mQUFs2d1EkOLJJg8WuHWz0U9h/l8OHgT1gom/7jYIfzj70Z
	 eME/Mqyi/2RFmx5XSyfPvftDkQ9nKNBN6uOMJk+18OzKm6PjLzcw1/ZCPnk/EKRV4/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Yrk3C/Qn8YI7zDrjT4eCPCundwlQjbduafoUtLob2BE=;
	b=ETYxVfiKps89RUqETHvrRbvo61WNcnSbA1p706jz/vR2uvUd1jnDwJ9pVrYPYAE2UAI3
	 E8QYxn6qFisT169XHrfRlyXJ3OcLRN3THPGc5+4Ggy/NmNJ8HTNlEruf2s2CMNbzDzQj2
	 JwGzSjV8CBTozC7bGZyZwlDMPJCggBwrVc4eAKWEsGM3u4Ywx1EYZZJAGhKGx8W0vNam2
	 PNqxJHc7BN4KBygYIVsg4c3i0E43Peds1ln/Kj9ZJbKJXBq9OWOEFFkg72upq/l0rdYGn
	 yvWWvd1n9FOSCW54yMEMBrze/CHFaJkNQ8dtmPmK/oWarns+bNLhzisrO5su44G2HZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pZABDHHR;
	arc=none smtp.remote-ip=209.85.222.200
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581D606A895
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E581D606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pZABDHHR
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94970ad532bso446400485a.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927346; x=1795532146; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yrk3C/Qn8YI7zDrjT4eCPCundwlQjbduafoUtLob2BE=;
        b=pZABDHHRbIJZWYhxsKHo85i9SDPuDUjIyNBXQtYHao0piwT5yTH5QfXsfIpbG70Yv+
         jQ9FbO/sd5D4aK+8/V2WFBIjw6ryTNeuBPTzlXOIkfGTWRd4oyCsdYOsDksnCzoeKMm3
         3mzf9udvp5iDdWvJ9gwueI/z+XyuOHZ1bdgk6trvHWvX1QwE2sinVUL17Srqo5tdDSO5
         BLO/mrCL5pwcLgsISfrLhPsUc/e2mDbY6EiuIpRjtygMQDF1q2YmJjkO8iDvrYFU/nN5
         SMwThSJZzP0y/yjx6ccHIugn2H2PPUl3e/42ClqN6iemROxrc7G79eLY2Cv/WD1KzF97
         3o6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927346; x=1795532146;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yrk3C/Qn8YI7zDrjT4eCPCundwlQjbduafoUtLob2BE=;
        b=0a4LXRuf4hYygCWEv1+DPr6V051fzRFFxXY/6ScazqPXCeKZUvX8g7YYPgF7iT7VQM
         ZtbVr0f3o5RosAigFIwjW55HfMDwvtY7UBM2yhNIsdoYzahLagNayNsX3kBbGvpfkKQd
         jtXdFMCFSwriN8kKDnTouKf34zU4fP770ZWBii+fN9fWn3+0X7tNDDvxiAuUEzpnyTN0
         N7WD1A2jtn4Zb0wXdcAoSjfPP6BVmJSgx71pShnGIZEW0veSoKb1CsEtTqARoUTcKmNC
         gAmhg4l2qfhSvu0b8tUrpm6jpbxlpc/7tHnA+bTEWkOaRp73N6MyE3NcySQ89K1nWAde
         Zgbw==
X-Forwarded-Encrypted: i=1; AL+hErHinM33ahvve4z/JxRtSgVr+psk/82ho5ZbArZLEhnBRDqfFVBqtRnHjbuXCkTuzH8DvO6rDkC3PRlGXawB25o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lhvqRnYP4Uv1JLivpQ1h9HmKRH/lqz+ZkZNq0T2DwLWcTNa7K
	xulMA/jfyZkO15ow1Fsz5hrLa51JVCEVLKYgPK7IgKCK5BhVOuq1voyHzUqSUq9VRB9BoerKFrJ
	SQw==
X-Received: from qkhx17.prod.google.com ([2002:ae9:f811:0:b0:93f:18ba:bf7a])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:6497:b0:947:7857:bb7c
 with SMTP id af79cd13be357-9494bc3834fmr2027349985a.33.1794927345501; Tue, 17
 Nov 2026 06:55:45 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:14 +0000
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
Message-ID: <20261117145522.1910636-9-stani@google.com>
Subject: [PATCH iwl-next 08/15] idpf: psp: add support for psp rx key allocation
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

Add support for allocating PSP RX keys on demand:
- Introduce VIRTCHNL2_OP_PSP_ALLOCATE_KEYS (560),
  enum virtchnl2_psp_allocate_response_flags,
  struct virtchnl2_psp_allocate_keys_request/_response and
  struct virtchnl2_allocate_psp_key_v0/_v1.
- Implement idpf_send_allocate_psp_key(), which allocates one V0 RX
  key with a synchronous request, validates the reply (key type,
  keys_size_bytes, length, and an SPI with a key ID, which the PSP core
  requires) and wipes the key from the mailbox buffer. The key, its SPI
  and its master key generation are returned in struct idpf_psp_rx_key.
- Implement the rx_spi_alloc PSP device op. It gets the adapter from
  the netdev of the PSP device, as the vports can be freed while the
  PSP device is registered.
- Keep a copy of the vport ID in adapter->psp.vport_id, for the same
  reason.
- Wipe the RX keys of late replies, which libie passes to
  idpf_recv_event_msg() after the request timed out.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 43 +++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    |  6 ++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 19 ++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 89 +++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  3 +
 include/linux/net/intel/virtchnl2.h           | 78 ++++++++++++++++
 8 files changed, 243 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 1385209519b2..062753a62f59 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1144,6 +1144,9 @@ static struct idpf_vport *idpf_vport_alloc(struct idpf_adapter *adapter,
 	/* fill vport slot in the adapter struct */
 	adapter->vports[idx] = vport;
 	adapter->vport_ids[idx] = idpf_get_vport_id(vport);
+	/* Copy for the PSP requests that can run while the vports are freed */
+	if (IS_ENABLED(CONFIG_INET_PSP) && !idx)
+		WRITE_ONCE(adapter->psp.vport_id, adapter->vport_ids[idx]);
 
 	adapter->num_alloc_vports++;
 	/* prepare adapter->next_vport for next use */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index 67f1f1d7508c..8ce390bcd617 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -106,6 +106,9 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 		dev_warn(dev, "Failed to get PSP FIPS compliance status: %d\n",
 			 err);
 
+	/* The counters cover the time since the core init */
+	atomic_set(&psp->keys_allocated, 0);
+
 	WRITE_ONCE(psp->enabled, true);
 }
 
@@ -136,9 +139,49 @@ static int idpf_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
 	return 0;
 }
 
+/**
+ * idpf_psp_rx_spi_alloc - Allocate a PSP RX SPI and key
+ * @psd: PSP device
+ * @version: PSP version
+ * @key: filled with the allocated SPI and key
+ * @extack: netlink extended ack for error reporting
+ *
+ * Allocate one RX key with a synchronous VIRTCHNL2_OP_PSP_ALLOCATE_KEYS
+ * request.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int idpf_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
+				 struct psp_key_parsed *key,
+				 struct netlink_ext_ack *extack)
+{
+	struct idpf_adapter *adapter = idpf_netdev_to_adapter(psd->main_netdev);
+	struct idpf_psp_rx_key rx_key;
+	int err;
+
+	/* Only version 0 keys are allocated, see idpf_psp_register() */
+	if (psp_key_size(version) != sizeof(rx_key.key)) {
+		NL_SET_ERR_MSG_MOD(extack, "Unsupported PSP version");
+		return -EOPNOTSUPP;
+	}
+
+	err = idpf_send_allocate_psp_key(adapter, &rx_key);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to allocate RX SPI and key");
+		return err;
+	}
+
+	key->spi = rx_key.spi;
+	memcpy(key->key, rx_key.key, sizeof(rx_key.key));
+	memzero_explicit(&rx_key, sizeof(rx_key));
+
+	return 0;
+}
+
 /* PSP device operations, see idpf_psp_register() */
 static struct psp_dev_ops idpf_psp_ops = {
 	.set_config	= idpf_psp_set_config,
+	.rx_spi_alloc	= idpf_psp_rx_spi_alloc,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.h b/drivers/net/ethernet/intel/idpf/idpf_psp.h
index 0f89dcc3b398..fcafe71d3d00 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.h
@@ -11,6 +11,8 @@ void idpf_psp_init(struct idpf_adapter *adapter);
 void idpf_psp_free(struct idpf_adapter *adapter);
 void idpf_psp_register(struct idpf_adapter *adapter);
 void idpf_psp_unregister(struct idpf_adapter *adapter);
+void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
+			      const struct libie_ctlq_msg *ctlq_msg);
 
 #else /* !CONFIG_INET_PSP */
 
@@ -19,6 +21,10 @@ static inline void idpf_psp_free(struct idpf_adapter *adapter) { }
 static inline void idpf_psp_register(struct idpf_adapter *adapter) { }
 static inline void idpf_psp_unregister(struct idpf_adapter *adapter) { }
 
+static inline void
+idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
+			 const struct libie_ctlq_msg *ctlq_msg) { }
+
 #endif /* CONFIG_INET_PSP */
 
 #endif /* !_IDPF_PSP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 0829d0bbd92b..f21bd7de5ae8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -3,6 +3,7 @@
 #ifndef _IDPF_PSP_DEF_H_
 #define _IDPF_PSP_DEF_H_
 
+#include <linux/net/intel/virtchnl2.h>
 #include <net/psp.h>
 
 /* SA index widths supported by the driver, negotiated per adapter with
@@ -11,6 +12,18 @@
 #define IDPF_PSP_SAIDX_WIDTH_21		21
 #define IDPF_PSP_SAIDX_WIDTH_26		26
 
+/**
+ * struct idpf_psp_rx_key - PSP RX key allocated by the CP
+ * @spi: SPI of the key
+ * @generation: CP master key generation of the key
+ * @key: the key
+ */
+struct idpf_psp_rx_key {
+	__be32 spi;
+	u32 generation;
+	u8 key[VIRTCHNL2_PSP_KEY_SIZE_V0];
+};
+
 /**
  * struct idpf_adapter_psp - PSP offload state of an adapter
  * @enabled: PSP was negotiated with the CP in the last core init, see
@@ -19,6 +32,10 @@
  * @saidx_width: SA index width granted by VIRTCHNL2_OP_CRYPTO_GET_CAPS
  * @psp_caps: PSP capabilities granted by VIRTCHNL2_OP_PSP_GET_CAPS, see
  *	      enum virtchnl2_psp_caps
+ * @vport_id: ID of adapter->vports[0] for the PSP requests. A copy, as the
+ *	      PSP device stays registered while the vports are freed and
+ *	      allocated again during a soft reset. Set in idpf_vport_alloc().
+ * @keys_allocated: RX keys allocated
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
  */
@@ -27,6 +44,8 @@ struct idpf_adapter_psp {
 	u32 sadb_entries;
 	u8 saidx_width;
 	u32 psp_caps;
+	u32 vport_id;
+	atomic_t keys_allocated;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
 };
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index 0502ce0b7abe..aa50948873a7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -194,3 +194,92 @@ int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter)
 	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
 	return err;
 }
+
+/**
+ * idpf_send_allocate_psp_key - Allocate a PSP RX key
+ * @adapter: Driver specific private structure
+ * @key: filled with the allocated SPI and key and their master key generation
+ *
+ * Allocate one RX key with a synchronous VIRTCHNL2_OP_PSP_ALLOCATE_KEYS
+ * request. The caller must be allowed to sleep.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
+			       struct idpf_psp_rx_key *key)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_PSP_ALLOCATE_KEYS,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	const struct virtchnl2_psp_allocate_keys_response *vc_reply;
+	struct virtchnl2_psp_allocate_keys_request key_req = { };
+	const struct virtchnl2_allocate_psp_key_v0 *v0_key;
+	size_t reply_sz;
+	u32 spi;
+	int err;
+
+	BUILD_BUG_ON(sizeof(key->key) != sizeof(v0_key->v0_key));
+
+	key_req.vport_id = cpu_to_le32(READ_ONCE(adapter->psp.vport_id));
+	key_req.num_keys = cpu_to_le32(1);
+	key_req.key_type = VIRTCHNL2_PSP_KEY_TYPE_V0;
+	/* key_req.domain stays zeroed: VIRTCHNL2_PSP_DOMAIN_NONE */
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &key_req);
+	if (err)
+		return err;
+
+	reply_sz = xn_params.recv_mem.iov_len;
+	vc_reply = xn_params.recv_mem.iov_base;
+	if (reply_sz < sizeof(*vc_reply) + sizeof(*v0_key) ||
+	    vc_reply->key_type != VIRTCHNL2_PSP_KEY_TYPE_V0 ||
+	    le32_to_cpu(vc_reply->keys_size_bytes) != sizeof(*v0_key)) {
+		net_warn_ratelimited("%s: invalid reply of %zu bytes\n",
+				     __func__, reply_sz);
+		err = -EIO;
+		goto release_rx;
+	}
+
+	v0_key = (const struct virtchnl2_allocate_psp_key_v0 *)vc_reply->keys;
+	spi = le32_to_cpu(v0_key->spi);
+	if (!(spi & PSP_SPI_KEY_ID)) {
+		net_warn_ratelimited("%s: invalid SPI %#x\n", __func__, spi);
+		err = -EIO;
+		goto release_rx;
+	}
+
+	key->spi = cpu_to_be32(spi);
+	key->generation = le32_to_cpu(vc_reply->master_key_generation);
+	memcpy(key->key, v0_key->v0_key, sizeof(key->key));
+	atomic_inc(&adapter->psp.keys_allocated);
+
+release_rx:
+	/* Don't leave the RX key in the recycled mailbox buffer */
+	memzero_explicit(xn_params.recv_mem.iov_base, reply_sz);
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
+
+/**
+ * idpf_psp_recv_late_reply - Handle a late reply to a PSP request
+ * @adapter: Driver specific private structure
+ * @ctlq_msg: reply, its receive buffer is released by the caller
+ *
+ * libie passes the replies to requests that timed out to idpf_recv_event_msg().
+ * The RX key of an allocation reply is wiped.
+ */
+void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
+			      const struct libie_ctlq_msg *ctlq_msg)
+{
+	const struct kvec *buff = &ctlq_msg->recv_mem;
+
+	switch (ctlq_msg->chnl_opcode) {
+	case VIRTCHNL2_OP_PSP_ALLOCATE_KEYS:
+		if (buff->iov_base)
+			memzero_explicit(buff->iov_base, buff->iov_len);
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
index 2ade2df2e34e..7ba86b540f2b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -12,5 +12,7 @@ int idpf_send_get_crypto_caps(struct idpf_adapter *adapter,
 int idpf_send_get_psp_caps(struct idpf_adapter *adapter,
 			   struct virtchnl2_psp_get_caps *caps);
 int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter);
+int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
+			       struct idpf_psp_rx_key *key);
 
 #endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3f669683c8c0..056fd82b3162 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -91,6 +91,9 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
 
 	adapter = container_of(ctx, struct idpf_adapter, ctlq_ctx);
 	if (ctlq_msg->chnl_opcode != VIRTCHNL2_OP_EVENT) {
+		/* Late reply to a PSP request that timed out */
+		idpf_psp_recv_late_reply(adapter, ctlq_msg);
+
 		dev_dbg(&adapter->pdev->dev,
 			"Unhandled message with opcode %u from CP\n",
 			ctlq_msg->chnl_opcode);
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index c3a0e7b1b8e2..0ae439009f44 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -85,6 +85,7 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_GET_FLOW_RULE			= 552,
 	VIRTCHNL2_OP_DEL_FLOW_RULE			= 553,
 	/* Crypto/PSP opcodes */
+	VIRTCHNL2_OP_PSP_ALLOCATE_KEYS			= 560,
 	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
 	VIRTCHNL2_OP_PSP_GET_CAPS			= 565,
 	VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS		= 567,
@@ -1891,6 +1892,15 @@ enum virtchnl2_psp_domain_type {
 	VIRTCHNL2_PSP_DOMAIN_OEM_END			= 0xffff,
 };
 
+/* VIRTCHNL2_PSP_ALLOC_KEY_EXHAUSTED: the keys derived from the current master
+ * key are exhausted and a master key rotation will be performed
+ * automatically. Only set on partial success, i.e. if fewer keys than
+ * requested, but at least one, were allocated.
+ */
+enum virtchnl2_psp_allocate_response_flags {
+	VIRTCHNL2_PSP_ALLOC_KEY_EXHAUSTED		= BIT(0),
+};
+
 /**
  * struct virtchnl2_psp_key_domain - PSP key domain
  * @type: See enum virtchnl2_psp_domain_type
@@ -1909,6 +1919,74 @@ struct virtchnl2_psp_key_domain {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_key_domain);
 
+/**
+ * struct virtchnl2_psp_allocate_keys_request - Allocate PSP RX keys request
+ * @vport_id: Virtual port ID
+ * @num_keys: Number of keys requested, 0 only reads the active master key
+ *	      generation
+ * @key_type: See enum virtchnl2_psp_key_type
+ * @pad: Reserved/padding
+ * @domain: Key domain, must be zero-filled if VIRTCHNL2_CAP_PSP_DOMAIN was
+ *	    not granted
+ */
+struct virtchnl2_psp_allocate_keys_request {
+	__le32 vport_id;
+	__le32 num_keys;
+	u8 key_type;
+	u8 pad[7];
+	struct virtchnl2_psp_key_domain domain;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_psp_allocate_keys_request);
+
+/**
+ * struct virtchnl2_allocate_psp_key_v0 - Allocated PSP V0 key entry
+ * @spi: Security parameter index
+ * @pad: Reserved/padding
+ * @v0_key: 128-bit key
+ */
+struct virtchnl2_allocate_psp_key_v0 {
+	__le32 spi;
+	u8 pad[4];
+	u8 v0_key[VIRTCHNL2_PSP_KEY_SIZE_V0];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_allocate_psp_key_v0);
+
+/**
+ * struct virtchnl2_allocate_psp_key_v1 - Allocated PSP V1 key entry
+ * @spi: Security parameter index
+ * @pad: Reserved/padding
+ * @v1_key: 256-bit key
+ */
+struct virtchnl2_allocate_psp_key_v1 {
+	__le32 spi;
+	u8 pad[4];
+	u8 v1_key[VIRTCHNL2_PSP_KEY_SIZE_V1];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(40, virtchnl2_allocate_psp_key_v1);
+
+/**
+ * struct virtchnl2_psp_allocate_keys_response - Allocate PSP RX keys response
+ * @vport_id: Virtual port ID
+ * @key_type: See enum virtchnl2_psp_key_type
+ * @allocate_response_flags: See enum virtchnl2_psp_allocate_response_flags
+ * @pad1: Reserved/padding
+ * @master_key_generation: Master key generation, increased by 1 every time
+ *			   the set of active master keys changes
+ * @keys_size_bytes: Total size of keys payload in bytes
+ * @keys: Flexible array of struct virtchnl2_allocate_psp_key_v0 or
+ *	  struct virtchnl2_allocate_psp_key_v1 entries
+ */
+struct virtchnl2_psp_allocate_keys_response {
+	__le32 vport_id;
+	u8 key_type;
+	u8 allocate_response_flags;
+	u8 pad1[2];
+	__le32 master_key_generation;
+	__le32 keys_size_bytes;
+	u8 keys[] __counted_by_le(keys_size_bytes);
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_allocate_keys_response);
+
 /**
  * struct virtchnl2_get_fips_compliance_status_resp - FIPS compliance response
  * @num_certs: Number of certificates, 0 if not FIPS compliant
-- 
2.56.0.679.gc527c65306-goog

