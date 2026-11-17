Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927349;
	b=3i9aOcrJXZielTuI3TuBq11EG4LFXBozHyjVx6HT7RSv47/RBanbZmJPK1yJDpbqnURd
	 RytOUx6W85Hm1i7UbUtlLVPqDdMtzc94EAeWOiEl1fJ6SSel5XvwGxfu9G0X+4TPJGRX9
	 YwqxYQ76zyfJ0XgTOg/MQAqr4FCcj/y9/kcUqfOezB3eIG1yazVF0bpwBGVub+POPjPON
	 QzykxumO62y8e7a05OGvQTTQTD6UNbfaLcDgR81K9zg8kZyV7IYRP3RTG8Bxs5X+KYKNB
	 MjnG/amuIPhGZMHlwuk8o4M7NX1w98vovB+GHN6tkVUkip73nRYsXIGkRERAfIFukMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=wt+9JWcwL2nVatIor+f5wPjDE3yZm0NfWPflpZZJfb0=;
	b=I63CZmFBycLmHHKsWb1DdeiZBpDTNhNesm/MNoEwHxDMqUeYBs9/Bb7EfBnbhSYmoTw0
	 CR9yGg8GNGm7km8cgrPIMjcoMWZB3hDhpipXLjp/fKeOOeebzldZMHfIWcSFacfABW19W
	 oMJQUBG8D26r3qONgtuJoT3tD8nSooMs9mlzt35VtsnzLLzAsl1ZKciixCxfWg5QVQxGR
	 lJx53wuKhgEp6fbZWAsfRb/cRKK9lrmjTUKRbOC8HuuTOql4X3WNCxkD2Kh02TYWMw09V
	 aJxj8OUTxh8xJhayoBpnD4Z0qf3w7SOPQChuNnRfi1dWYoLITRkIg67ks8TPxdvQ+2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZNWC3ICD;
	arc=none smtp.remote-ip=209.85.128.197
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B44460A5BD2
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B44460A5BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZNWC3ICD
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b2fb1f981fso74057587b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927348; x=1795532148; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wt+9JWcwL2nVatIor+f5wPjDE3yZm0NfWPflpZZJfb0=;
        b=ZNWC3ICDF9qjM8Z4UYFQGU2TnH04ksAEYOdiV9QmDxHjI9EQM4h2MChrOKc3TTHpuD
         Zmk5I85RQ+4INeFoTigZhueVoxAK/97dS4mWXw3L627X46vBaWULfpUgskIbuznhXY6q
         tolTonUwuagYmq52okHCu5yR4Be5CYG2ey0bzjzXkHDaGcZIe+b2H4s+arcyymOrVJ8V
         aLyYMMTNaV4GC9oHEQKFPrfQ/7wvNV/fqSi4GCXhvbS/lbt2cqe8YdDf94AjLIOajP/i
         H1CyHcXKlmPUPdUsfBA4O8YS5hYZUaIF1RJF/oAatJ6vJwY4oq3uKxQmhTZjr+wWnQ+C
         ktOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927348; x=1795532148;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wt+9JWcwL2nVatIor+f5wPjDE3yZm0NfWPflpZZJfb0=;
        b=yFCHTs8Mn9a+fAzcNsO+8g47Im8MXACKyOIGYMyFja/9MHc5oXcMFHzh8E7dXdFePF
         De43N+DrL3zhJZ2OHBGIBIArij983bhL2q6mchj1vwyRrZh+kefie+viLukO6XC8/kwS
         d7XXa22bvECelnqjNev+cNsk+cpkK+x4boCGIvyZ9PYieH19B4LbltmPHoo9dNjtPSGb
         sz7PZZTnhaXRylyYsdzpemT0Ul/iPknBaVh8TYewsQ4hTrEQQiWD9j2iIGkS8Tx3sWGp
         pct+Dp4eAHId2x9c+YzcaDOPeWiPOhyNwHXYH0GXQAUb8YMScbIikDwVOdKl70V+OvUY
         zueQ==
X-Forwarded-Encrypted: i=1; AL+hErG7Fr2mb0GGvvRz43uDYtObFqU3CPc0kt8iTO6VsgITc4nt/7opOKVqFYd/NGfCmv7IVO2EQAEilUmQATo4tW4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DemkjEn39SL/jfIxsMPqslJewcpUA1TLf+ahNGgrSiRo1EpqK
	mAtSKOVmqX07bd0TaMTgsk19dDP+Lqklm6dfWVyQQmkxSs1RRF0VlhUplJD0jW2yYWtVK3OMyfF
	7dQ==
X-Received: from yxvo14.prod.google.com ([2002:a53:ce8e:0:b0:67d:8220:1db9])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:1382:b0:67d:aee7:a138
 with SMTP id 956f58d0204a3-67daee7bce3mr4616821d50.89.1794927347672; Tue, 17
 Nov 2026 06:55:47 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:16 +0000
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
Message-ID: <20261117145522.1910636-11-stani@google.com>
Subject: [PATCH iwl-next 10/15] idpf: psp: add support for psp statistics
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

Add support for the PSP device statistics:
- Introduce VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS (566),
  enum virtchnl2_psp_global_stats_type,
  struct virtchnl2_psp_global_stats_request/_response,
  struct virtchnl2_psp_global_common_stats and
  struct virtchnl2_psp_global_addon_stats.
- Implement idpf_send_get_psp_global_stats(): only the requested stat
  groups present in the reply are reported as supported.
- Implement the get_stats PSP device op. The last statistics read are
  kept in adapter->psp.stats and reported when they can't be read,
  e.g. during a reset.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 51 +++++++++++++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 13 ++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 52 +++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  2 +
 include/linux/net/intel/virtchnl2.h           | 75 +++++++++++++++++++
 5 files changed, 193 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index cf0216640ddc..844463754632 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -249,11 +249,62 @@ static int idpf_psp_key_rotate(struct psp_dev *psd,
 	return 0;
 }
 
+/**
+ * idpf_psp_get_stats - Get the PSP device statistics
+ * @psd: PSP device
+ * @stats: statistics to fill in
+ *
+ * Read the PSP global statistics with VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS. The
+ * last statistics read are reported if they can't be read, e.g. during reset.
+ */
+static void idpf_psp_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
+{
+	struct idpf_adapter *adapter = idpf_netdev_to_adapter(psd->main_netdev);
+	struct idpf_psp_dev_stats *cur = &adapter->psp.stats;
+	struct virtchnl2_psp_global_stats_response resp;
+	u32 supported;
+
+	if (!idpf_send_get_psp_global_stats(adapter, &resp)) {
+		supported = le32_to_cpu(resp.supported_stats);
+
+		if (supported & VIRTCHNL2_PSP_STAT_COMMON) {
+			const struct virtchnl2_psp_global_common_stats *cs =
+				&resp.common_stats;
+
+			cur->rx_packets = le64_to_cpu(cs->rx_decrypted_packets);
+			cur->rx_bytes = le64_to_cpu(cs->rx_decrypted_bytes);
+			cur->rx_auth_fail = le32_to_cpu(cs->rx_auth_failures);
+			/* PSP spec: rx_error counts length/framing errors,
+			 * rx_bad miscellaneous errors.
+			 */
+			cur->rx_error = le32_to_cpu(cs->rx_bad_packets);
+			cur->rx_bad = le32_to_cpu(cs->rx_misc_errors);
+			cur->tx_packets = le64_to_cpu(cs->tx_encrypted_packets);
+			cur->tx_bytes = le64_to_cpu(cs->tx_encrypted_bytes);
+			cur->tx_error = (u64)le32_to_cpu(cs->tx_misc_errors) +
+					le32_to_cpu(cs->tx_bad_packets);
+			if (supported & VIRTCHNL2_PSP_STAT_ADDON)
+				cur->tx_error +=
+					le32_to_cpu(resp.addon_stats.tx_inv_sa_packets);
+		}
+	}
+
+	stats->rx_packets = cur->rx_packets;
+	stats->rx_bytes = cur->rx_bytes;
+	stats->rx_auth_fail = cur->rx_auth_fail;
+	stats->rx_error = cur->rx_error;
+	stats->rx_bad = cur->rx_bad;
+	stats->tx_packets = cur->tx_packets;
+	stats->tx_bytes = cur->tx_bytes;
+	stats->tx_error = cur->tx_error;
+}
+
 /* PSP device operations, see idpf_psp_register() */
 static struct psp_dev_ops idpf_psp_ops = {
 	.set_config	= idpf_psp_set_config,
 	.rx_spi_alloc	= idpf_psp_rx_spi_alloc,
 	.key_rotate	= idpf_psp_key_rotate,
+	.get_stats	= idpf_psp_get_stats,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index 3132efe00559..fdd65bc5321a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -56,6 +56,9 @@ struct idpf_psp_rx_gen {
  *		by the PSP device lock, see idpf_psp_key_rotate()
  * @rx_gen: generation of the master key of each SPI phase, protected by the
  *	    PSP device lock, see idpf_psp_rx_gen_update()
+ * @stats: last PSP device statistics read with
+ *	   VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS, protected by the PSP device
+ *	   lock, see idpf_psp_get_stats()
  * @keys_allocated: RX keys allocated
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
@@ -68,6 +71,16 @@ struct idpf_adapter_psp {
 	u32 vport_id;
 	u8 generation;
 	struct idpf_psp_rx_gen rx_gen[2];
+	struct idpf_psp_dev_stats {
+		u64 rx_packets;
+		u64 rx_bytes;
+		u64 rx_auth_fail;
+		u64 rx_error;
+		u64 rx_bad;
+		u64 tx_packets;
+		u64 tx_bytes;
+		u64 tx_error;
+	} stats;
 	atomic_t keys_allocated;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index ddb9fd90291f..d36f46a46cfd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -350,6 +350,58 @@ void idpf_psp_rotation_event(struct idpf_adapter *adapter,
 			     le32_to_cpu(rt_event->psp_rotate_event.active_master_key_generation));
 }
 
+/**
+ * idpf_send_get_psp_global_stats - Send VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS
+ * @adapter: Driver specific private structure
+ * @stats: Output buffer for virtchnl2_psp_global_stats_response
+ *
+ * Request the common and add-on PSP statistics. Only the stat groups set in
+ * @stats->supported_stats are valid: a group is only reported as supported if
+ * it was requested and is present in the reply, which may leave out trailing
+ * groups that are not supported.
+ *
+ * Return: 0 on success, negative on failure.
+ */
+int idpf_send_get_psp_global_stats(struct idpf_adapter *adapter,
+				   struct virtchnl2_psp_global_stats_response *stats)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	const u32 requested = VIRTCHNL2_PSP_STAT_COMMON | VIRTCHNL2_PSP_STAT_ADDON;
+	struct virtchnl2_psp_global_stats_request req = {
+		.requested_stats = cpu_to_le32(requested),
+	};
+	size_t reply_sz;
+	u32 supported;
+	int err;
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &req);
+	if (err)
+		return err;
+
+	reply_sz = xn_params.recv_mem.iov_len;
+	if (reply_sz < offsetof(typeof(*stats), common_stats)) {
+		err = -EIO;
+		goto release_rx;
+	}
+
+	memset(stats, 0, sizeof(*stats));
+	memcpy(stats, xn_params.recv_mem.iov_base, min(reply_sz, sizeof(*stats)));
+
+	supported = le32_to_cpu(stats->supported_stats) & requested;
+	if (reply_sz < offsetofend(typeof(*stats), common_stats))
+		supported &= ~VIRTCHNL2_PSP_STAT_COMMON;
+	if (reply_sz < offsetofend(typeof(*stats), addon_stats))
+		supported &= ~VIRTCHNL2_PSP_STAT_ADDON;
+	stats->supported_stats = cpu_to_le32(supported);
+
+release_rx:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+	return err;
+}
+
 /**
  * idpf_psp_recv_late_reply - Handle a late reply to a PSP request
  * @adapter: Driver specific private structure
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
index f1b4f7747908..b7261385adf6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -15,5 +15,7 @@ int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter);
 int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
 			       struct idpf_psp_rx_key *key);
 int idpf_psp_rotation_request(struct idpf_adapter *adapter);
+int idpf_send_get_psp_global_stats(struct idpf_adapter *adapter,
+				   struct virtchnl2_psp_global_stats_response *stats);
 
 #endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 29dfa075e169..ca07c32b0f1a 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -89,6 +89,7 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_PSP_ROTATE_KEYGEN_REQUEST		= 563,
 	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
 	VIRTCHNL2_OP_PSP_GET_CAPS			= 565,
+	VIRTCHNL2_OP_GET_PSP_GLOBAL_STATS		= 566,
 	VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS		= 567,
 };
 
@@ -2040,6 +2041,80 @@ struct virtchnl2_psp_rotation_event {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_psp_rotation_event);
 
+enum virtchnl2_psp_global_stats_type {
+	VIRTCHNL2_PSP_STAT_COMMON			= BIT(0),
+	VIRTCHNL2_PSP_STAT_ADDON			= BIT(1),
+};
+
+/**
+ * struct virtchnl2_psp_global_stats_request - PSP global stats request
+ * @requested_stats: Bitmask of requested stats (enum virtchnl2_psp_global_stats_type)
+ * @pad: Reserved/padding
+ *
+ * Stat groups that are not requested are not supported in the response.
+ */
+struct virtchnl2_psp_global_stats_request {
+	__le32 requested_stats;
+	u8 pad[4];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_psp_global_stats_request);
+
+/**
+ * struct virtchnl2_psp_global_common_stats - PSP global common stats
+ * @rx_decrypted_packets: Number of RX decrypted packets
+ * @rx_decrypted_bytes: Number of RX decrypted bytes
+ * @rx_auth_failures: Number of RX auth failures
+ * @rx_misc_errors: Number of RX misc errors
+ * @rx_bad_packets: Number of RX bad packets
+ * @pad1: Reserved/padding
+ * @tx_encrypted_packets: Number of TX encrypted packets
+ * @tx_encrypted_bytes: Number of TX encrypted bytes
+ * @tx_misc_errors: Number of TX misc errors
+ * @tx_bad_packets: Number of TX bad packets
+ */
+struct virtchnl2_psp_global_common_stats {
+	__le64 rx_decrypted_packets;
+	__le64 rx_decrypted_bytes;
+	__le32 rx_auth_failures;
+	__le32 rx_misc_errors;
+	__le32 rx_bad_packets;
+	u8 pad1[4];
+	__le64 tx_encrypted_packets;
+	__le64 tx_encrypted_bytes;
+	__le32 tx_misc_errors;
+	__le32 tx_bad_packets;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(56, virtchnl2_psp_global_common_stats);
+
+/**
+ * struct virtchnl2_psp_global_addon_stats - PSP global addon stats
+ * @tx_inv_sa_packets: Number of TX invalid SA packets
+ * @pad: Reserved/padding
+ */
+struct virtchnl2_psp_global_addon_stats {
+	__le32 tx_inv_sa_packets;
+	u8 pad[4];
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_psp_global_addon_stats);
+
+/**
+ * struct virtchnl2_psp_global_stats_response - PSP global stats response
+ * @supported_stats: Bitmask of supported stats returned
+ * @pad1: Reserved/padding
+ * @common_stats: Common stats structure
+ * @addon_stats: Addon stats structure
+ *
+ * An unsupported stat group followed by a supported one is zero-filled,
+ * trailing unsupported stat groups may be left out of the response.
+ */
+struct virtchnl2_psp_global_stats_response {
+	__le32 supported_stats;
+	u8 pad1[4];
+	struct virtchnl2_psp_global_common_stats common_stats;
+	struct virtchnl2_psp_global_addon_stats addon_stats;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(72, virtchnl2_psp_global_stats_response);
+
 /**
  * struct virtchnl2_get_fips_compliance_status_resp - FIPS compliance response
  * @num_certs: Number of certificates, 0 if not FIPS compliant
-- 
2.56.0.679.gc527c65306-goog

