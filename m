Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927350;
	b=fXjNHez/WHEWc5qWOmBQ2JeUnHGKjxa4YWRhrCKUNOUuyr5otVjRdeTF4EBueoeDw7Va
	 lTjLx1B28BRFXVmvP5M8DbzpLsWc4w9CZJWEirzVddhj55lm8+h/NioJyt5YWStnR/Zr3
	 7FILCi6ujb6h28UJgkLHPBKwIlsv/l4h+K1eybuQH6TsiNXbR6RBCL8Jcg7HrWnRCqL3u
	 H65keL2tZ74xNTtwfC3WwB9xJUzcSz+YkAVOSEOyVXz31HWj4QSKVv5dgwO11fp5N69p2
	 QiCMc19BCLmY2x7V1bHRzoRFwspSYEcnW3QrLPxZGkrr65oh8p0FN9J8kraoLy2Af1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=N2W1vGbTN1fxXgYMzqAEGGqqwODSJcSkIJEHTLlETcw=;
	b=oOmazSgA8IRUWNdwjSPhR9t40QjO+o5IAAcA7ztV8N2ZJ679C03zqZtw6KFs8yTq6Wmt
	 cGbVjYpGbTmpR69YlGqAHKu4vu2q0gqBU33Q3VmAvLFQxlI+E84ZQsUPM4agj0QQpHMwI
	 qQUbpZ43dnDqkSJJDt87HONdTFyA8yFQw/PGMCJ50Cw7HIU+ZI5WJHzYY3Nv3pi0f3Wiv
	 o8Zn6TbMQev0k5VS8LhS/vFTn9kUFf+gELPbaJQ5LJTSDhJH1E7D6vTdK0LR0fUHATuoV
	 udKFmgfnVim9HeVth/dbkKK/p+APa3hhaO7NWJR7v64SZ5Gh+p6M0GHQDKJ4w4uzjDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--stani.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VgDZIXUN;
	arc=none smtp.remote-ip=74.125.224.70
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51960A6F57
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 14:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A51960A6F57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stani.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VgDZIXUN
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67a781c1069so7562243d50.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 06:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794927349; x=1795532149; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2W1vGbTN1fxXgYMzqAEGGqqwODSJcSkIJEHTLlETcw=;
        b=VgDZIXUNb/v6nkklYfbI32flOuhEE4d7GwSXmQM+hLCunE+AZyMZcdCrUFW6+Mv/g1
         dnApFv8C1UGnV3UxXkCp/idcKL9WX8O2l0NNkb2a3RtfZ0Ak5fMb1SSWqT3uVkRF+xEX
         Ksa37izYL6U2uczaatstBIg4O2vVs8oPhP7jHQd7xeSLAaQ1p7haV2uL1WcCHuryu2tR
         SNFYNLl/Y+cl2YtUPmpQe6QxGUYH8W8S3IfDLYsDRnJNP/hJw8C0nrIOzjAeu5VLg9Qx
         d2EaVEU58m28IxcUkh+bCUHsAoCBKPyVyod0u8CC2tN8KZ+qIQfeJLL2BwhC8zBZL2zS
         0ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794927349; x=1795532149;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2W1vGbTN1fxXgYMzqAEGGqqwODSJcSkIJEHTLlETcw=;
        b=JOepR8zUDqqxFfKt1DBPX3pf+b091xdD5kxvQQB/8VBnD329aPHTD0kOrZslo2iVo+
         RgY1tUgXXfDG4oECt6HDFC7jeTAmY/R6UZfLvtQL1jgnNyQG6Lwnq0Bbs8L+mCy400i8
         m7X66KHnIBF1cXqJvQDb8ojOAei+xW0M42HFPrkr+tcQkcKctcqnCbEdutXSyatDqJvD
         f0A78UP7XhRcPDqzwhwYtOuVbacEaqG6vpOah8aKKMtDYgiPyWWJDk6qJlWkYDxWKKWl
         6miD7BC8QlJrkCMV18793mPS3DzjlmIkZiXtzDsQfNhHLVipy9IMnUqgOpBjEW5eRH3X
         z1Gg==
X-Forwarded-Encrypted: i=1; AL+hErG7vAL1LxHWhYZck53xtZdUq5XaghTNzLtUdJxA2K/C9rkM/9ngKZrq0/jEvqy13JOm5facIY90AVQmojoxhVY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5iQNrgKe5PIU2RfLWTIHJVsK/z0hKc20oX1iToJFcy2hDH4cT
	/38M3NQ1DeXdII8TpSY85d3ZjRkwWeh0nDgc1zMx8HVtxFPZbOX/p20NBvhfcUmltdqQGr7q+HC
	v/g==
X-Received: from yxbv18.prod.google.com ([2002:a05:690e:7d2:b0:675:604a:47fe])
 (user=stani job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690e:d8f:b0:67c:8ea:be13
 with SMTP id 956f58d0204a3-67d896a0ae3mr6694528d50.52.1794927348674; Tue, 17
 Nov 2026 06:55:48 -0800 (PST)
Date: Tue, 17 Nov 2026 14:55:17 +0000
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
Message-ID: <20261117145522.1910636-12-stani@google.com>
Subject: [PATCH iwl-next 11/15] idpf: psp: add psp tx key state
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

TX keys are inserted into the SADB asynchronously: the SA index of a
key is only known when the CP replies. Add struct idpf_psp_tx_key, the
reference counted state of a TX key, stored in the driver data of its
PSP association in a later patch:
- idpf_psp_tx_key_alloc(), idpf_psp_tx_key_get() and
  idpf_psp_tx_key_put(). The TX path reads the SA index of the key
  under RCU: the key is freed after an RCU grace period.
- The SA index is IDPF_PSP_IDX_IN_PROG while the insertion is pending,
  IDPF_PSP_IDX_ERROR if it failed and IDPF_PSP_IDX_DELETED once the key
  was deleted, see idpf_psp_idx_valid().
- idpf_psp_saidx_ok() checks the SA indexes returned by the CP against
  the SA index width negotiated for the adapter.

Signed-off-by: Stan Iliev <stani@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_psp.c    | 51 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_psp.h    | 31 +++++++++++
 .../net/ethernet/intel/idpf/idpf_psp_def.h    | 30 +++++++++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.c b/drivers/net/ethernet/intel/idpf/idpf_psp.c
index 844463754632..ef23b1699b09 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.c
@@ -128,6 +128,57 @@ void idpf_psp_free(struct idpf_adapter *adapter)
 	idpf_psp_unregister(adapter);
 }
 
+/**
+ * idpf_psp_tx_key_alloc - Allocate the state of a PSP TX key
+ *
+ * Return: the TX key with a reference, NULL if it couldn't be allocated.
+ */
+struct idpf_psp_tx_key *idpf_psp_tx_key_alloc(void)
+{
+	struct idpf_psp_tx_key *key;
+
+	key = kzalloc_obj(*key);
+	if (!key)
+		return NULL;
+
+	kref_init(&key->ref);
+	spin_lock_init(&key->lock);
+	key->idx = IDPF_PSP_IDX_IN_PROG;
+
+	return key;
+}
+
+/**
+ * idpf_psp_tx_key_free - Free the state of a PSP TX key
+ * @ref: reference count of the TX key
+ */
+static void idpf_psp_tx_key_free(struct kref *ref)
+{
+	struct idpf_psp_tx_key *key = container_of(ref, struct idpf_psp_tx_key,
+						   ref);
+
+	/* The TX path may still read the SA index of the key */
+	kfree_rcu(key, rcu);
+}
+
+/**
+ * idpf_psp_tx_key_get - Get a reference on a PSP TX key
+ * @key: the TX key
+ */
+void idpf_psp_tx_key_get(struct idpf_psp_tx_key *key)
+{
+	kref_get(&key->ref);
+}
+
+/**
+ * idpf_psp_tx_key_put - Release a reference on a PSP TX key
+ * @key: the TX key
+ */
+void idpf_psp_tx_key_put(struct idpf_psp_tx_key *key)
+{
+	kref_put(&key->ref, idpf_psp_tx_key_free);
+}
+
 /**
  * idpf_psp_set_config - Set the PSP device configuration
  * @psd: PSP device
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp.h b/drivers/net/ethernet/intel/idpf/idpf_psp.h
index 34534076da47..44ac750e2c3b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp.h
@@ -16,6 +16,37 @@ void idpf_psp_recv_late_reply(struct idpf_adapter *adapter,
 void idpf_psp_rotation_event(struct idpf_adapter *adapter,
 			     const struct libie_ctlq_msg *ctlq_msg);
 
+struct idpf_psp_tx_key *idpf_psp_tx_key_alloc(void);
+void idpf_psp_tx_key_get(struct idpf_psp_tx_key *key);
+void idpf_psp_tx_key_put(struct idpf_psp_tx_key *key);
+
+/**
+ * idpf_psp_saidx_ok - Check an SA index returned by the CP
+ * @adapter: private data struct
+ * @saidx: the SA index
+ *
+ * Return: true if @saidx fits in the SA index width negotiated for the
+ * adapter, false otherwise.
+ */
+static inline bool idpf_psp_saidx_ok(const struct idpf_adapter *adapter,
+				     u32 saidx)
+{
+	return saidx < BIT(adapter->psp.saidx_width);
+}
+
+/**
+ * idpf_psp_idx_valid - Check if the SA index of a TX key is usable
+ * @idx: SA index or state of a TX key, see struct idpf_psp_tx_key
+ *
+ * Only SA indexes checked with idpf_psp_saidx_ok() are stored in a TX key.
+ *
+ * Return: true if @idx is an SA index, false if it is a state.
+ */
+static inline bool idpf_psp_idx_valid(u32 idx)
+{
+	return idx <= IDPF_PSP_IDX_MAX;
+}
+
 #else /* !CONFIG_INET_PSP */
 
 static inline void idpf_psp_init(struct idpf_adapter *adapter) { }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
index fdd65bc5321a..9ba99e08853a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_psp_def.h
@@ -3,6 +3,8 @@
 #ifndef _IDPF_PSP_DEF_H_
 #define _IDPF_PSP_DEF_H_
 
+#include <linux/kref.h>
+#include <linux/spinlock.h>
 #include <linux/net/intel/virtchnl2.h>
 #include <net/psp.h>
 
@@ -12,6 +14,34 @@
 #define IDPF_PSP_SAIDX_WIDTH_21		21
 #define IDPF_PSP_SAIDX_WIDTH_26		26
 
+/* Largest SA index the driver supports. The SA indexes the CP returns are
+ * checked against the width negotiated for the adapter before they are used,
+ * see idpf_psp_saidx_ok().
+ */
+#define IDPF_PSP_IDX_MAX		(BIT(IDPF_PSP_SAIDX_WIDTH_26) - 1)
+/* States of a TX key without a usable SA index, see struct idpf_psp_tx_key */
+#define IDPF_PSP_IDX_NONE		(U32_MAX - 3)	/* no SA index */
+#define IDPF_PSP_IDX_IN_PROG		(U32_MAX - 2)	/* insertion pending */
+#define IDPF_PSP_IDX_ERROR		(U32_MAX - 1)	/* insertion failed */
+#define IDPF_PSP_IDX_DELETED		U32_MAX		/* key deleted */
+
+/**
+ * struct idpf_psp_tx_key - State of a PSP TX key
+ * @ref: reference count, held by the PSP association, see
+ *	 idpf_psp_tx_key_add(), and by the lists and the insert request the
+ *	 key is on
+ * @lock: protects @idx and @hw_idx updates, and @tx_queue
+ * @idx: SA index the TX path uses, or IDPF_PSP_IDX_IN_PROG,
+ *	 IDPF_PSP_IDX_ERROR or IDPF_PSP_IDX_DELETED. Read without @lock.
+ * @rcu: for freeing the key after the RCU readers of the TX path
+ */
+struct idpf_psp_tx_key {
+	struct kref ref;
+	spinlock_t lock;		/* protects the SA indexes and tx_queue */
+	u32 idx;
+	struct rcu_head rcu;
+};
+
 /**
  * struct idpf_psp_rx_key - PSP RX key allocated by the CP
  * @spi: SPI of the key
-- 
2.56.0.679.gc527c65306-goog

