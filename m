Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077085;
	b=lxvLOuT63QknIWsoWDX2239cTDtirxngz6zr9YVhZQngQYm8xAvmvsDcUINSZgS7zpIt
	 HS/pIchy+lHhpdWw8naoJhswQD0oxABo/pe17O7yzo5NYvYUuyv0NkSyoP94v8awboNDq
	 CSArjaK973iVjXec9zXBtvdOM5G5lcmbcY3Y5IjHRzzR4lqyCmZiJcvudjgaxe047J9nO
	 yxL24yjRyKMVZf+cCY/Mt0KLmKoHHgC8dtu4YcXqeGisbHD82LMHWdrS8MjlVBhh9yHwq
	 t8zbZ4qhGdEBrRy0KM7P8i3OQ6mKR9Jff+MQTTZsszLspxoOGUGG5NjCk7K+zSQTPCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KZ+ukhZnuLhEoTcJCFbadpKzgvv+xdEMUoSf7p2jX1E=;
	b=lN/xj2fmkdKqNswdjQY1A4gPQ01OGHQytd1j2/TPvpG9rq3R5pFc2EPNC+eK+fTvtWmb
	 GsOkfW+8NjNVPKo746HkFsDEaoFqpVIpwc5CnqUT6cS0DHW/H7sWUMksdv4P6mnaGS0aM
	 7hHVjsodcmYr2wUu8RnFo+Vk2PO2SLWZvukqjIA18827KaHlE8h6WVp34m7ArHZ8k4jy0
	 UD1A/sG+yhz7T9fFzoDZDTF9U4G/tHWJvx2Pm455B477+GZGf6yfkLKvNXTKGhj3CwFvl
	 kAoN6jGHh9mtBDo9hBNy4H8ThjZWFq73yypDaglZHg+O1pNkFPU7C62fdzCmee0P/Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=fdYjPVwt;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F5E606D803
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 18:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F5E606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=fdYjPVwt
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so2804897eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794077084; x=1794681884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KZ+ukhZnuLhEoTcJCFbadpKzgvv+xdEMUoSf7p2jX1E=;
        b=fdYjPVwtfjRAngxFK3IxmrpzQEm2aqrueU/2fJxIXkKkWai7Ca9ceI+Dd+aC0HgP7n
         c7rNS+7+YoDUspPUIoPtYaMZUTRAM3dLADmi7ux24KzCWfCIn5e0GdzOC89vgAa2Ec/C
         bcH1HhSDEb2X6FK6vB5FwqZfoLgPGVYWyolzUPrq4cwjxmQkMahUnWcYstEXTtwxEt2R
         EBx81T9GsUQDt5qEOd2WYvTwOfZGomaJMRvInTtkp9wRahOqVcVyz+kZESdAyia+my59
         kzhKDcvSYp9jG8sD6PbEFaqVOXqQroPJl7LUnt7/temfn9UuJ+AgziLsF6ZROVe3isBK
         b9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077084; x=1794681884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KZ+ukhZnuLhEoTcJCFbadpKzgvv+xdEMUoSf7p2jX1E=;
        b=Ssh5+m2wW11AryZXuQAouohMtCmsxmgR+96RIfnlsKA/UtHexvGzoL8/999wPxI9jP
         CkF05CRbJs3+j9sYHgq388ZeehP8pBDFmepw2K9GtaTW3PojuSr8G8YyjpI8x65y1Mz9
         AS0jwZ24JQNgfZxxk9p8YiMzlVShnSHtcij7NxynuSSB6Epaq7aZlc2fissw6Wl1BfNj
         l0Yvx9W16o465uXrm7KD80SXAHk8B5PaVP5gat3F5xcGYasF3BE9al8cwd5tNvo2XShx
         kx5sc8dBjOP1SvI3txI7CN/l4sxTE7C1JqhnJbPm5msx4mqPt19QJzkBCWbodNFmNfRS
         aSjQ==
X-Forwarded-Encrypted: i=1; AL+hErHdAaY+y7L7B0+dvO51KchW+K0yvIPJqBGwO+McQo3wSmNX0ElgDhw00Be97zfO7yTBXGM4uIRL2t9lpWphD3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WWNnyKqnci3EU0HDNktEgdPXYc/COmkCUY0WWy96EP45vTTuh
	si2N732ASgIRI2ZPbCP0Klhz84exZLlVJtJL16xA6jeEA1rFy5fgeFb279J6vdhZ9cA=
X-Gm-Gg: AYBFou1ziPpmx4ZYRVNgxH5tG3187OlGyyMF3eJAbePKmKP1ICbpYwaoHXk/lLW13CR
	+VYTUm6D5meS+Aq4ng0LLatlrnmfGNhDXKrAvmb4hGPP4+ZM2PaqXf24/sDTURTaArOGwZYDeVT
	tQ9UMo0WMtuzA6rLx14TfCjul3+gCFkP55g6JbgPSj+rz29fceXaKgGcYqaNVtzTtC4h0i/ad0a
	2n/rT+wDsjio6QhL3thKhKu+wyVLfZfYVpoVYM2TP3y1IhnK8S5MBF3YCeZfo3qKLVEFVM5f40y
	/UKYGZpoEVJ8Bux0Tw9ntIswdYGYhdbOhqVnKc67lJGKLLYDKSLZ2/Oy0aSP9j5YuGGYF3o1Kl0
	QEvpN9jEjeo6aBHTkfJEQvGADWTNv/FGNzDJGI4Mt8D3c6zPzHC+SQ6PEXePkqEeNG8UA3FNq4Y
	TZH8UT3VJTCsKoU+tiV1hVZfe60eCH3DWa5oA8UHSiGqfrqLVVp3MgCuyA3EM5iupWZc5TFxLp6
	cBx3WbScTtpxfHj++s8IwmybYbwUss/JHzwqCAGFUf+NnlpgOhFwtO3eRTWAVRKPdp9HwZNud8n
	pgnkEVrb5vkM0zZOLONU6OrEDmSxigishhd2TBWi6kNouM7oaudhD1eRBMK5rlw5BOv9uUHuT7f
	tOIz+qkYnW9JGC1tR
X-Received: by 2002:a05:7301:f0b:b0:366:83dd:46f7 with SMTP id 5a478bee46e88-36f75a26838mr8205255eec.17.1794077083543;
        Sat, 07 Nov 2026 10:44:43 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:44:42 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	brett.creeley@amd.com,
	sgoutham@marvell.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Ido Schimmel <idosch@nvidia.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 1/9] amt: add the relay replication offload provider header
Date: Sat,  7 Nov 2026 18:44:29 +0000
Message-ID: <20261107184437.2783174-2-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107184437.2783174-1-omar@blockcast.net>
References: <20261107184437.2783174-1-omar@blockcast.net>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

include/net/amt_offload.h: provider caps, opaque provider-owned endpoint
and group handles, struct amt_offload_ops, TX/INGRESS paths,
FALLBACK/CONSUMED/BUSY results, the per-binding u64 epoch, and the
amt_offload_register()/amt_offload_unregister() entry points. An
in-kernel interface with no ABI promise; nothing touches struct
net_device or net_device_ops.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 include/net/amt_offload.h | 263 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 263 insertions(+)
 create mode 100644 include/net/amt_offload.h

diff --git a/include/net/amt_offload.h b/include/net/amt_offload.h
new file mode 100644
index 000000000..3be5d129c
--- /dev/null
+++ b/include/net/amt_offload.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMT relay replication offload: the contract between the amt driver and
+ * a provider that replicates relay multicast data to gateways in hardware
+ * (or, for testing, in a simulated device).
+ *
+ * This is an IN-KERNEL INTERFACE WITH NO ABI PROMISE. It may change in any
+ * release, like every other in-kernel API; out-of-tree providers get no
+ * stability guarantee.
+ *
+ * Registration is keyed by the lower netdev a relay transmits on (its
+ * IFLA_AMT_LINK stream device). Nothing here adds a field or an ndo to
+ * struct net_device.
+ */
+#ifndef _NET_AMT_OFFLOAD_H_
+#define _NET_AMT_OFFLOAD_H_
+
+#include <linux/bits.h>
+#include <linux/in6.h>
+#include <linux/types.h>
+
+struct net_device;
+struct sk_buff;
+
+/* Outer transport families, for &amt_offload_caps.families. */
+#define AMT_OFFLOAD_FAMILY_V4		BIT(0)
+#define AMT_OFFLOAD_FAMILY_V6		BIT(1)
+
+/*
+ * Reserved: (S,G)-keyed forwarding. v1 forwards per (family, group) exactly
+ * as the software path does, so this bit has NO v1 semantics. A provider
+ * must not set it; amt ignores it.
+ */
+#define AMT_OFFLOAD_F_SOURCE_FILTER	BIT(0)
+
+/**
+ * enum amt_offload_path - where a provider replicates
+ * @AMT_OFFLOAD_PATH_TX: amt hands the provider each relay data packet of
+ *	a group whose commit it has published (&amt_offload_ops.group_commit),
+ *	before its software fan-out (&amt_offload_ops.xmit), while the binding
+ *	admits packets and amt has not lost its desired state. amt withdraws a
+ *	group without a callback when a member leaves, until it publishes the
+ *	recommit. Every other packet goes straight to software.
+ * @AMT_OFFLOAD_PATH_INGRESS: the provider replicates on ingress and the
+ *	host only sees punted packets. Semantics only until a real provider
+ *	exists; no simulated provider implements it.
+ */
+enum amt_offload_path {
+	AMT_OFFLOAD_PATH_TX,
+	AMT_OFFLOAD_PATH_INGRESS,
+};
+
+/**
+ * struct amt_offload_caps - what a bound provider can do
+ * @families: AMT_OFFLOAD_FAMILY_* outer families it can encapsulate. A
+ *	relay whose outer family is missing stays unbound (counted), with the
+ *	outcome of a failed &amt_offload_ops.bind, except that amt first calls
+ *	&amt_offload_ops.unbind, since that bind succeeded.
+ * @paths: BIT(enum amt_offload_path) it implements.
+ * @op_timeout_ms: longest a programming op may take before amt treats the
+ *	provider as wedged, resets it and replays from desired state.
+ * @features: AMT_OFFLOAD_F_* bits. None has v1 semantics.
+ * @max_endpoints: endpoint table size; 0 means unbounded. Informational:
+ *	amt does not read it in this version. A provider out of room fails an
+ *	&amt_offload_ops.endpoint_add for a key it does not hold, by
+ *	convention with -ENOSPC.
+ * @max_groups: group table size; 0 means unbounded. Informational: amt
+ *	does not read it in this version. A provider out of room fails the
+ *	&amt_offload_ops.group_update that needs a new group, by convention
+ *	with -ENOSPC.
+ *
+ * Filled by &amt_offload_ops.bind.
+ */
+struct amt_offload_caps {
+	u32 families;
+	u32 paths;
+	u32 op_timeout_ms;
+	u32 features;
+	u32 max_endpoints;
+	u32 max_groups;
+};
+
+/**
+ * struct amt_offload_binding - one relay device bound to one provider
+ * @lower: the registered lower netdev (the relay's stream device).
+ * @dev: the amt relay netdev.
+ * @epoch: monotonic per relay device, bumped on every bind, reset and
+ *	teardown. A completion carrying an older epoch is stale and ignored.
+ * @priv: provider-owned; amt never touches it.
+ *
+ * Allocated and freed by amt. Valid from &amt_offload_ops.bind until
+ * &amt_offload_ops.unbind returns.
+ */
+struct amt_offload_binding {
+	struct net_device *lower;
+	struct net_device *dev;
+	u64 epoch;
+	void *priv;
+};
+
+/**
+ * struct amt_offload_endpoint_key - one gateway's outer endpoint
+ * @family: AF_INET or AF_INET6, the relay's outer family.
+ * @addr: gateway outer address.
+ * @addr.ip4: IPv4 address when @family is AF_INET.
+ * @addr.ip6: IPv6 address when @family is AF_INET6.
+ * @port: gateway outer UDP port (tunnel identity is address + port).
+ */
+struct amt_offload_endpoint_key {
+	u8 family;
+	union {
+		__be32 ip4;
+		struct in6_addr ip6;
+	} addr;
+	__be16 port;
+};
+
+/**
+ * struct amt_offload_group_key - one replicated group
+ * @family: AF_INET or AF_INET6, the INNER group family.
+ * @group: group address.
+ * @group.ip4: IPv4 group when @family is AF_INET.
+ * @group.ip6: IPv6 group when @family is AF_INET6.
+ *
+ * Forwarding is per (family, group), never per source: a gateway holding
+ * an INCLUDE(S1) membership still receives S2, exactly as the software
+ * fan-out does today.
+ */
+struct amt_offload_group_key {
+	u8 family;
+	union {
+		__be32 ip4;
+		struct in6_addr ip6;
+	} group;
+};
+
+/* Provider-owned table entries. amt only stores the pointers. */
+struct amt_offload_endpoint;
+struct amt_offload_group;
+
+/**
+ * enum amt_offload_result - outcome of &amt_offload_ops.xmit
+ * @AMT_OFFLOAD_FALLBACK: skb untouched; amt runs its software fan-out.
+ * @AMT_OFFLOAD_CONSUMED: the provider handled every copy of this packet
+ *	under the generation it was given and owns the skb; amt emits none and
+ *	retries none. A copy that failed is the provider's to count, except one
+ *	amt_offload_encap_xmit() could not copy or route, which amt has already
+ *	counted in the relay's tx_dropped.
+ * @AMT_OFFLOAD_BUSY: skb untouched; amt runs one synchronous software pass
+ *	and counts it. Never NETDEV_TX_BUSY: the relay is IFF_NO_QUEUE.
+ *
+ * Exactly one actor handles each packet, so no packet is duplicated.
+ */
+enum amt_offload_result {
+	AMT_OFFLOAD_FALLBACK,
+	AMT_OFFLOAD_CONSUMED,
+	AMT_OFFLOAD_BUSY,
+};
+
+/**
+ * struct amt_offload_stats - provider-side counters
+ * @tx_packets: copies the provider emitted.
+ * @tx_bytes: bytes of those copies on the wire.
+ * @tx_dropped: copies the provider failed to emit.
+ */
+struct amt_offload_stats {
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_dropped;
+};
+
+/**
+ * struct amt_offload_ops - provider callbacks
+ * @bind: a relay transmitting on the registered lower device starts using
+ *	this provider. Fill @caps. Process context, RTNL held. Nonzero leaves
+ *	the relay unbound (counted): in software in auto mode; in required
+ *	mode refused if it is being created, else without carrier.
+ * @unbind: last call for a binding. Every endpoint and group has already
+ *	been deleted or disabled. Free @b->priv. RTNL held.
+ * @endpoint_add: program one gateway endpoint. Idempotent: an identical
+ *	key returns the existing handle. 0 means accepted and durable, not yet
+ *	forwarding. Process context, never under amt's spinlocks.
+ * @endpoint_del: remove an endpoint no group references any more.
+ * @group_update: stage the member set of one group under generation @gen,
+ *	allocating *@grp on first use. Not forwarding until @group_commit.
+ * @group_commit: start forwarding generation @gen of @grp. amt hands @gen
+ *	to @xmit only after this returns 0, and may never do so: an overrun
+ *	resets the provider, and on TX a member leaving meanwhile withholds
+ *	the commit until the next one. Until amt publishes @gen, any @xmit for
+ *	@grp carries an earlier generation this provider committed, and a call
+ *	already in flight may carry any of those or @gen itself; the provider
+ *	serves such a generation or declines it. A provider must never emit
+ *	one packet to one endpoint under two generations. On failure the group
+ *	stays in software and previously added endpoints stay valid.
+ * @group_disable: stop forwarding @grp and free it.
+ * @xmit: TX path. Replicate @skb for @grp under @gen or decline; see
+ *	&enum amt_offload_result. Softirq context, under rcu_read_lock().
+ * @flush: drop every endpoint and group (reset after a timeout). amt then
+ *	replays from its own desired state under a new epoch, except when
+ *	the op that overran was a @group_disable or @endpoint_del of amt
+ *	giving everything back -- at teardown, where @unbind follows, or
+ *	after its desired state was lost: then nothing is replayed and the
+ *	epoch does not move.
+ * @stats: fill @st. Optional; amt does not call it in this version.
+ *
+ * Teardown order, on unregistration of the lower device and on
+ * amt_offload_unregister(): amt stops admitting packets to @xmit, waits for
+ * in-flight @xmit calls, cancels its programming work, calls @group_disable
+ * for every group, @endpoint_del for every endpoint, then @unbind, then
+ * synchronize_rcu(); the relay is back in software afterwards. If one of
+ * those @group_disable/@endpoint_del calls overruns op_timeout_ms, amt
+ * calls @flush once instead of the rest, then @unbind, with no replay.
+ */
+struct amt_offload_ops {
+	int (*bind)(struct amt_offload_binding *b,
+		    struct amt_offload_caps *caps);
+	void (*unbind)(struct amt_offload_binding *b);
+	int (*endpoint_add)(struct amt_offload_binding *b,
+			    const struct amt_offload_endpoint_key *key,
+			    struct amt_offload_endpoint **ep);
+	void (*endpoint_del)(struct amt_offload_binding *b,
+			     struct amt_offload_endpoint *ep);
+	int (*group_update)(struct amt_offload_binding *b,
+			    const struct amt_offload_group_key *key,
+			    struct amt_offload_endpoint *const *members,
+			    unsigned int nr_members, u64 gen,
+			    struct amt_offload_group **grp);
+	int (*group_commit)(struct amt_offload_binding *b,
+			    struct amt_offload_group *grp, u64 gen);
+	void (*group_disable)(struct amt_offload_binding *b,
+			      struct amt_offload_group *grp);
+	enum amt_offload_result (*xmit)(struct amt_offload_binding *b,
+					struct amt_offload_group *grp,
+					struct sk_buff *skb, u64 gen);
+	void (*flush)(struct amt_offload_binding *b);
+	void (*stats)(struct amt_offload_binding *b,
+		      struct amt_offload_stats *st);
+};
+
+/**
+ * amt_offload_register - offer a provider for relays on @lower
+ * @lower: the netdev the relays transmit on.
+ * @ops: provider callbacks; must outlive the registration.
+ *
+ * Every relay already using @lower in auto or required mode tries to bind
+ * now. Caller holds RTNL.
+ *
+ * Return: 0, -EEXIST if @lower already has a provider, or -ENOMEM.
+ */
+int amt_offload_register(struct net_device *lower,
+			 const struct amt_offload_ops *ops);
+
+/**
+ * amt_offload_unregister - withdraw the provider for @lower
+ * @lower: as passed to amt_offload_register().
+ *
+ * Tears every binding down in the documented order and returns with every
+ * relay on @lower in software. Caller holds RTNL. A no-op if @lower has no
+ * provider, which is the case after @lower itself was unregistered.
+ */
+void amt_offload_unregister(struct net_device *lower);
+
+#endif /* _NET_AMT_OFFLOAD_H_ */
-- 
2.43.0

