Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927348;
	b=AgIH23f4DYmCjK2dggZcEMQ4Vp3WJql0nFDu89LTTsyumAp3wYg1HJBkoeqF8ETfq3du
	 RDOieKh8ApdfEdrnaQgBmkWkSxmmCR1WqlT4xnPGrM8FQ+cQHA5RM+QHVc/oXbcRXhFys
	 3ZlEH89TArBE2GBIHnmE6j9k03deEymNi7AM0lzMGseI57bQ6juzqFGvo2J4C+4/3ZO0K
	 U052gJOr/ZTboU2+lwc1WIxsuYDZepk+7RfC7bn/tay1K1kyh/3dCdMVR7fle1CJ95vDT
	 DOJUhH81TyxhYFeHqX2oYUmRDZxk2NOubb1fNQNd36HGKoPEgdo8xd08YMmkPkGm46g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fCjsxvLvDqNAhuuyphXheko6IGHWuFB4ZrRzdmRJqpI=;
	b=ND8ri7FNWfJ4iST6l7FrQad0Y34ZnnXmZZTeRDHPPUQPeKma+h8xB/8+ehpXcy0pze3H
	 FQBpa6sNLrf1UKF8d8UoPEZo3D6XTAIrbbyz3wojmmr5AkkSZ0caDvfB2TPKg0f/eSIHA
	 NsMYsd1Fvbgi1jQw8yGU1EtjsOymt3OGtKD5jLvFbVoju1efSisbRBmgqwdbZTNi8gvZy
	 B2Ra7j2K4a8Cgr2wYHBmUUTCcKfIQUInXagH9e9mbPnKf7LQJF69NuiUPpg/L6qVRsCU/
	 lLGrYrYFucAlhy/E1hu52gfypHusWlAfmw8wVSo6gaFQ+gDuS5oodDA2loJHkYjfhNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hl59UCoa;
	arc=none smtp.remote-ip=209.85.128.199
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDE60A383A
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05EDE60A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hl59UCoa
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b37869f851so73040027b3.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927347; x=1795532147; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fCjsxvLvDqNAhuuyphXheko6IGHWuFB4ZrRzdmRJqpI=;
        b=Hl59UCoa9cEoiZGnMQByF69Qouam7ijpD8tyz37uR/viDg/G7WzzVQd1DOcybxdM+b
         3J/t7enzv2rezq5zM4lTL5dt5krVyXeHJJ3gsd4qIR3e6w8wIvX/PytSaBIZV2DuSHlI
         +PMrFwm4a+yZCTZd56CMJP/Eaz9BjC2nBoL+NgczevmBeROqAq83anUPfAUsh1gwzjsQ
         YxvObPB/J+OOn7wvrnKWSAsyIk56UjpypxFFQkVasCprQq8iS4+g50YMOdN14xOkCrUF
         AbxB48gbvTxq+pF/FA4jHarjSaGGqu9kWdj0Y2HE2xTrFzVLyCGHX7GlrVc/nhlNlbEo
         pH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927347; x=1795532147;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fCjsxvLvDqNAhuuyphXheko6IGHWuFB4ZrRzdmRJqpI=;
        b=zpAm+4fpZkyrHQ4NVjo+W2sYTHnCImbba25h3wMGBlmx7rqFBLHitq2fh43hjPKoR1
         dB/SgEbJxwSLixSJz81IGSJdQAkMFU/sFhKgVTJXJ9A64SE7UWXFoz2smuYFG5kQLxgs
         JtHGUuIfTD3n77Pr0LlZr5nO5K6zwZEcoKJtWmLYOrXlFlBaNfbffaorKxuGTY35OjdS
         1rSO0g86EpWJOSuMafc9hL6ENd/p4L/baLGsNl1dmdIQYlADu06LaYzuoUMEO+7J0auk
         hrvY0ua1CreXPTNnzPT62IXZ5JeUg088AUIiiSH9KSffGJiMlNQmetWGs5ammnCEi1+i
         Xk5Q==
X-Forwarded-Encrypted: i=1; AL+hErHdNXsbWU7A5CkEs3tgaymIV7zKVKR2bRIInS7InoyIYSUJwfYZTOp+Y6gmDRFI4POoPzJ4uVEFfBMGoc9gKYc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qBj6lSQBeLFLeBY3wdtwCkpwh5+1IGHKfHNOTKR4XHQ8iANTS
	87KYUHyLWbDh6Ms5G3X5cBH2MD8KJDCeeLuxv1j/ipvR2FYYPo3lxLB3wwQokvcw2ydhoHkh4SR
	l4A==
X-Received: from yxwr8.prod.google.com ([2002:a53:adc8:0:b0:675:468d:a8e2])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:138f:b0:67d:b3b0:e00e
 with SMTP id 956f58d0204a3-67db3b0e39amr2293513d50.58.1794927346597; Tue, 17
 Nov 2026 06:55:46 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:15 +0000
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
Message-ID: <20261117145522.1910636-10-stani@google.com>
Subject: [PATCH iwl-next 09/15] idpf: psp: add support for psp key rotation
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

Add support for PSP master key rotation:
- Introduce VIRTCHNL2_OP_PSP_ROTATE_KEYGEN_REQUEST (563),
  struct virtchnl2_psp_rotate_keygen_request/_response,
  VIRTCHNL2_EVENT_PSP_ROTATE_KEY (4) and
  struct virtchnl2_psp_rotation_event/_data.
- Implement the key_rotate PSP device op with
  idpf_psp_rotation_request(), which fails with -EOPNOTSUPP if
  VIRTCHNL2_CAP_PSP_REQUEST_ROTATION was not granted. The PSP core
  increments the PSP device generation before calling the op and
  doesn't restore it if the op fails: the op restores it then.
- Track the master key of the allocated RX SPIs, to report their
  generation on receive in a later patch: bit 31 of an SPI selects one
  of the two master keys of the CP, and the CP master key generation
  of the allocation tells when a master key was replaced. The packets
  of a master key get the PSP device generation that was current when
  its first SPI was allocated, which is the generation of the
  associations using it. Associations then survive one rotation, as the
  PSP core expects.
- Handle VIRTCHNL2_EVENT_PSP_ROTATE_KEY in idpf_recv_event_msg() with
  idpf_psp_rotation_event(), which logs the new master key generation.
  The PSP core can't be told about rotations it didn't request, like
  in mlx5: document the limitation and a possible solution.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 72 +++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    |  6 ++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 23 +++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.c   | 89 +++++++++++++++++++
 .../ethernet/intel/idpf/idpf_psp_virtchnl.h   |  1 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  3 +
 include/linux/net/intel/virtchnl2.h           | 53 +++++++++++
 7 files changed, 247 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index 8ce390bcd617..cf0216640ddc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -106,6 +106,11 @@ void idpf_psp_init(struct idpf_adapter *adapter)
 		dev_warn(dev, "Failed to get PSP FIPS compliance status: %d\n",
 			 err);
 
+	/* The master keys are tracked again for the new PSP device */
+	psp->generation = 0;
+	psp->rx_gen[0].gen = IDPF_PSP_GEN_UNKNOWN;
+	psp->rx_gen[1].gen = IDPF_PSP_GEN_UNKNOWN;
+
 	/* The counters cover the time since the core init */
 	atomic_set(&psp->keys_allocated, 0);
 
@@ -139,6 +144,36 @@ static int idpf_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
 	return 0;
 }
 
+/**
+ * idpf_psp_rx_gen_update - Track the master key of an allocated SPI
+ * @adapter: private data struct
+ * @psd: PSP device, locked
+ * @spi: SPI allocated by the CP
+ * @cp_gen: CP master key generation of @spi
+ *
+ * Bit 31 of an SPI selects one of the two master keys of the CP, a rotation
+ * replaces the older one. The HW doesn't tell which master key decrypted a
+ * packet: report the PSP device generation that was current when the first
+ * SPI of the master key was allocated, which is the generation of the
+ * associations using it, see idpf_psp_rx_process_skb(). The CP master key
+ * generation tells when a master key was replaced, including by a rotation
+ * the PSP core didn't request, see idpf_psp_rotation_event().
+ */
+static void idpf_psp_rx_gen_update(struct idpf_adapter *adapter,
+				   struct psp_dev *psd, __be32 spi, u32 cp_gen)
+{
+	struct idpf_psp_rx_gen *rx_gen;
+
+	lockdep_assert_held(&psd->lock);
+
+	rx_gen = &adapter->psp.rx_gen[be32_to_cpu(spi) >> 31];
+	if (rx_gen->gen != IDPF_PSP_GEN_UNKNOWN && rx_gen->cp_gen == cp_gen)
+		return;
+
+	rx_gen->cp_gen = cp_gen;
+	WRITE_ONCE(rx_gen->gen, psd->generation);
+}
+
 /**
  * idpf_psp_rx_spi_alloc - Allocate a PSP RX SPI and key
  * @psd: PSP device
@@ -171,6 +206,8 @@ static int idpf_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
 		return err;
 	}
 
+	idpf_psp_rx_gen_update(adapter, psd, rx_key.spi, rx_key.generation);
+
 	key->spi = rx_key.spi;
 	memcpy(key->key, rx_key.key, sizeof(rx_key.key));
 	memzero_explicit(&rx_key, sizeof(rx_key));
@@ -178,10 +215,45 @@ static int idpf_psp_rx_spi_alloc(struct psp_dev *psd, u32 version,
 	return 0;
 }
 
+/**
+ * idpf_psp_key_rotate - Rotate the PSP master keys
+ * @psd: PSP device
+ * @extack: netlink extended ack for error reporting
+ *
+ * The PSP core increments the PSP device generation before calling this op
+ * and doesn't restore it if the op fails, see psp_nl_key_rotate_doit(): restore
+ * it then, the master keys didn't change.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int idpf_psp_key_rotate(struct psp_dev *psd,
+			       struct netlink_ext_ack *extack)
+{
+	struct idpf_adapter *adapter = idpf_netdev_to_adapter(psd->main_netdev);
+	int err;
+
+	err = idpf_psp_rotation_request(adapter);
+	if (err) {
+		psd->generation = adapter->psp.generation;
+
+		if (err == -EOPNOTSUPP)
+			NL_SET_ERR_MSG_MOD(extack, "PSP key rotation request not granted by CP");
+		else
+			NL_SET_ERR_MSG_MOD(extack, "PSP key rotation request failed");
+
+		return err;
+	}
+
+	adapter->psp.generation = psd->generation;
+
+	return 0;
+}
+
 /* PSP device operations, see idpf_psp_register() */
 static struct psp_dev_ops idpf_psp_ops = {
 	.set_config	= idpf_psp_set_config,
 	.rx_spi_alloc	= idpf_psp_rx_spi_alloc,
+	.key_rotate	= idpf_psp_key_rotate,
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.h b/drivers/net/ethernet/intel/idpf/idpf_psp.h
index fcafe71d3d00..34534076da47 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.h
@@ -13,6 +13,8 @@ void idpf_psp_register(struct idpf_adapter *adapter);
 void idpf_psp_unregister(struct idpf_adapter *adapter);
 void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
 			      const struct libie_ctlq_msg *ctlq_msg);
+void idpf_psp_rotation_event(struct idpf_adapter *adapter,
+			     const struct libie_ctlq_msg *ctlq_msg);
 
 #else /* !CONFIG_INET_PSP */
 
@@ -25,6 +27,10 @@ static inline void
 idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
 			 const struct libie_ctlq_msg *ctlq_msg) { }
 
+static inline void
+idpf_psp_rotation_event(struct idpf_adapter *adapter,
+			const struct libie_ctlq_msg *ctlq_msg) { }
+
 #endif /* CONFIG_INET_PSP */
 
 #endif /* !_IDPF_PSP_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index f21bd7de5ae8..3132efe00559 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -24,6 +24,23 @@ struct idpf_psp_rx_key {
 	u8 key[VIRTCHNL2_PSP_KEY_SIZE_V0];
 };
 
+/* PSP device generation of an SPI phase whose master key isn't known */
+#define IDPF_PSP_GEN_UNKNOWN		0xff
+
+/**
+ * struct idpf_psp_rx_gen - Generation of the master key of an SPI phase
+ * @cp_gen: CP master key generation of the SPIs allocated in the phase
+ * @gen: PSP device generation reported for the packets of the phase,
+ *	 IDPF_PSP_GEN_UNKNOWN if no SPI was allocated in the phase
+ *
+ * Bit 31 of an SPI selects one of the two master keys of the CP, see
+ * idpf_psp_rx_gen_update().
+ */
+struct idpf_psp_rx_gen {
+	u32 cp_gen;
+	u8 gen;
+};
+
 /**
  * struct idpf_adapter_psp - PSP offload state of an adapter
  * @enabled: PSP was negotiated with the CP in the last core init, see
@@ -35,6 +52,10 @@ struct idpf_psp_rx_key {
  * @vport_id: ID of adapter->vports[0] for the PSP requests. A copy, as the
  *	      PSP device stays registered while the vports are freed and
  *	      allocated again during a soft reset. Set in idpf_vport_alloc().
+ * @generation: PSP device generation after the last key rotation, protected
+ *		by the PSP device lock, see idpf_psp_key_rotate()
+ * @rx_gen: generation of the master key of each SPI phase, protected by the
+ *	    PSP device lock, see idpf_psp_rx_gen_update()
  * @keys_allocated: RX keys allocated
  * @psp_dev: the PSP device, see idpf_psp_register()
  * @caps: capabilities of @psp_dev
@@ -45,6 +66,8 @@ struct idpf_adapter_psp {
 	u8 saidx_width;
 	u32 psp_caps;
 	u32 vport_id;
+	u8 generation;
+	struct idpf_psp_rx_gen rx_gen[2];
 	atomic_t keys_allocated;
 	struct psp_dev *psp_dev;
 	struct psp_dev_caps caps;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
index aa50948873a7..ddb9fd90291f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.c
@@ -261,6 +261,95 @@ int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
 	return err;
 }
 
+/**
+ * idpf_psp_rotation_request - Request a PSP master key rotation
+ * @adapter: Driver specific private structure
+ *
+ * Return: 0 on success, -EOPNOTSUPP if VIRTCHNL2_CAP_PSP_REQUEST_ROTATION was
+ * not granted, other negative error code on failure.
+ */
+int idpf_psp_rotation_request(struct idpf_adapter *adapter)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.chnl_opcode	= VIRTCHNL2_OP_PSP_ROTATE_KEYGEN_REQUEST,
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+	};
+	const struct virtchnl2_psp_rotate_keygen_response *resp;
+	struct virtchnl2_psp_rotate_keygen_request req = { };
+	int err;
+
+	if (!(adapter->psp.psp_caps & VIRTCHNL2_CAP_PSP_REQUEST_ROTATION))
+		return -EOPNOTSUPP;
+
+	req.vport_id = cpu_to_le32(READ_ONCE(adapter->psp.vport_id));
+	/* req.domain stays zeroed: VIRTCHNL2_PSP_DOMAIN_NONE */
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &req);
+	if (err) {
+		net_warn_ratelimited("%s: err %d\n", __func__, err);
+		return err;
+	}
+
+	resp = xn_params.recv_mem.iov_base;
+	if (xn_params.recv_mem.iov_len >= sizeof(*resp))
+		dev_dbg(&adapter->pdev->dev,
+			"PSP master key generation %u after rotation\n",
+			le32_to_cpu(resp->master_key_generation));
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+
+	return 0;
+}
+
+/**
+ * idpf_psp_rotation_event - Handle a VIRTCHNL2_EVENT_PSP_ROTATE_KEY event
+ * @adapter: Driver specific private structure
+ * @ctlq_msg: event message, its receive buffer is released by the caller
+ *
+ * The CP rotated the master keys, it reports the generation of the new active
+ * master key. The driver tracks the master keys of the RX SPIs it allocates,
+ * see idpf_psp_rx_gen_update(): the next SPIs of the new master key are
+ * reported with the PSP device generation of their associations.
+ *
+ * The PSP core is not told about a rotation that it didn't request: the
+ * associations whose master key the rotation discarded can't receive anymore,
+ * but they aren't marked stale and no key rotation notification is sent. mlx5
+ * has the same limitation, see "no support for protecting against external
+ * rotations" in mlx5e_psp_key_rotate(). The PSP device lock can't be taken
+ * here, as it is held across synchronous mailbox requests that are completed
+ * by the mailbox task running this handler.
+ *
+ * A possible solution, not implemented: a PSP core helper for drivers, e.g.
+ * psp_dev_key_rotated(psd, generation), doing what psp_nl_key_rotate_doit()
+ * does after the ->key_rotate() op succeeded: set the generation, mark the
+ * associations of the discarded master key stale with psp_assocs_key_rotated()
+ * and send the key rotation notification. idpf would call it with the PSP
+ * device lock held from a work item queued here, for the events whose
+ * generation is not the one returned by idpf_psp_rotation_request(): the CP
+ * also sends the event for the rotations the driver requested.
+ */
+void idpf_psp_rotation_event(struct idpf_adapter *adapter,
+			     const struct libie_ctlq_msg *ctlq_msg)
+{
+	const struct virtchnl2_psp_rotation_event *rt_event;
+	const struct kvec *buff = &ctlq_msg->recv_mem;
+
+	if (!idpf_is_psp_ena(adapter)) {
+		net_warn_ratelimited("PSP not enabled, ignoring PSP rotation event.\n");
+		return;
+	}
+
+	if (!buff->iov_base || buff->iov_len < sizeof(*rt_event)) {
+		net_warn_ratelimited("Invalid payload size for PSP rotation event, payload size: %zu, expected min: %zu\n",
+				     buff->iov_len, sizeof(*rt_event));
+		return;
+	}
+
+	rt_event = buff->iov_base;
+
+	net_info_ratelimited("PSP Rotation Event processed, active master key generation %u.\n",
+			     le32_to_cpu(rt_event->psp_rotate_event.active_master_key_generation));
+}
+
 /**
  * idpf_psp_recv_late_reply - Handle a late reply to a PSP request
  * @adapter: Driver specific private structure
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
index 7ba86b540f2b..f1b4f7747908 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_virtchnl.h
@@ -14,5 +14,6 @@ int idpf_send_get_psp_caps(struct idpf_adapter *adapter,
 int idpf_send_get_fips_compliance_status(struct idpf_adapter *adapter);
 int idpf_send_allocate_psp_key(struct idpf_adapter *adapter,
 			       struct idpf_psp_rx_key *key);
+int idpf_psp_rotation_request(struct idpf_adapter *adapter);
 
 #endif /* !_IDPF_PSP_VIRTCHNL_H_ */
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 056fd82b3162..90fe5212095d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -114,6 +114,9 @@ void idpf_recv_event_msg(struct libie_ctlq_ctx *ctx,
 	case VIRTCHNL2_EVENT_LINK_CHANGE:
 		idpf_handle_event_link(adapter, v2e);
 		break;
+	case VIRTCHNL2_EVENT_PSP_ROTATE_KEY:
+		idpf_psp_rotation_event(adapter, ctlq_msg);
+		break;
 	default:
 		dev_err(&adapter->pdev->dev,
 			"Unknown event %d from PF\n", event);
diff --git a/include/linux/net/intel/virtchnl2.h b/include/linux/net/intel/virtchnl2.h
index 0ae439009f44..29dfa075e169 100644
--- a/include/linux/net/intel/virtchnl2.h
+++ b/include/linux/net/intel/virtchnl2.h
@@ -86,6 +86,7 @@ enum virtchnl2_op {
 	VIRTCHNL2_OP_DEL_FLOW_RULE			= 553,
 	/* Crypto/PSP opcodes */
 	VIRTCHNL2_OP_PSP_ALLOCATE_KEYS			= 560,
+	VIRTCHNL2_OP_PSP_ROTATE_KEYGEN_REQUEST		= 563,
 	VIRTCHNL2_OP_CRYPTO_GET_CAPS			= 564,
 	VIRTCHNL2_OP_PSP_GET_CAPS			= 565,
 	VIRTCHNL2_OP_GET_FIPS_COMPLIANCE_STATUS		= 567,
@@ -302,6 +303,7 @@ enum virtchnl2_event_codes {
 	VIRTCHNL2_EVENT_UNKNOWN			= 0,
 	VIRTCHNL2_EVENT_LINK_CHANGE		= 1,
 	/* Event type 2, 3 are reserved */
+	VIRTCHNL2_EVENT_PSP_ROTATE_KEY		= 4,
 };
 
 /* Transmit and Receive queue types are valid in legacy as well as split queue
@@ -1987,6 +1989,57 @@ struct virtchnl2_psp_allocate_keys_response {
 };
 VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_psp_allocate_keys_response);
 
+/**
+ * struct virtchnl2_psp_rotate_keygen_request - Request master key rotation
+ * @vport_id: Virtual port ID
+ * @pad: Reserved/padding
+ * @domain: Key domain, must be zero-filled if VIRTCHNL2_CAP_PSP_DOMAIN was
+ *	    not granted
+ */
+struct virtchnl2_psp_rotate_keygen_request {
+	__le32 vport_id;
+	u8 pad[4];
+	struct virtchnl2_psp_key_domain domain;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_psp_rotate_keygen_request);
+
+/**
+ * struct virtchnl2_psp_rotate_keygen_response - Master key rotation response
+ * @vport_id: Virtual port ID
+ * @master_key_generation: Master key generation
+ */
+struct virtchnl2_psp_rotate_keygen_response {
+	__le32 vport_id;
+	__le32 master_key_generation;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(8, virtchnl2_psp_rotate_keygen_response);
+
+/**
+ * struct virtchnl2_psp_rotation_data - Master key rotation async event payload
+ * @active_master_key_generation: Active master key generation
+ * @pad: Reserved/padding
+ * @domain: Key domain
+ */
+struct virtchnl2_psp_rotation_data {
+	__le32 active_master_key_generation;
+	u8 pad[4];
+	struct virtchnl2_psp_key_domain domain;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(24, virtchnl2_psp_rotation_data);
+
+/**
+ * struct virtchnl2_psp_rotation_event - Master key rotation async event
+ * @event: Event opcode (VIRTCHNL2_EVENT_PSP_ROTATE_KEY = 4)
+ * @pad: Reserved/padding, aligns @psp_rotate_event to 8 bytes
+ * @psp_rotate_event: Rotation event payload
+ */
+struct virtchnl2_psp_rotation_event {
+	__le32 event;
+	u8 pad[4];
+	struct virtchnl2_psp_rotation_data psp_rotate_event;
+};
+VIRTCHNL2_CHECK_STRUCT_LEN(32, virtchnl2_psp_rotation_event);
+
 /**
  * struct virtchnl2_get_fips_compliance_status_resp - FIPS compliance response
  * @num_certs: Number of certificates, 0 if not FIPS compliant
-- 
2.56.0.679.gc527c65306-goog

