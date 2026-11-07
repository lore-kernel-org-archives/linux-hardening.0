Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077090;
	b=NWmIeNXOogVBDuNY2MD3Y+xiE4UGhQW9jH6GtZjBzz7fidDoBU/Q6pVxVzG3VbZKGcAd
	 l58nIvA5iIJtvI7855bC6juHrALUmW9OwuKFpuLJcRQSM9YOf4TEQMTHCXmKd/aRqBya9
	 8KwexFst/sw2ipqgair7uTKbJMt+eYvZ8WyQE1bzH2dR9wkEqJN4Ci0rUhpQP1ytUD7Cv
	 i0c3uIVnrH5dEoGhtLiK4Fh1S0+nsWpyqpEW1XGEf3ZCQF5gTzXmyPQkYKljIXW3ryID4
	 BgbGE9AjFCQk/fJCHdrXRsOkUt6WnHl8Ikdz5zJwicugrRr+FBUSBsIi2DctnXQz66w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JuLpMa1SsARbLX+VgT8lDkaksHzgOIaqTQ9JsfA99F0=;
	b=UTltIifBL8eZAc+hrXreF5aafGC1U7mHwvv/KuWL3e5RSWzf4k8rL9rJihtOImBso//0
	 QccQsaTHeCkwK828hSrdiOBbeQs+3zmMWRggBIlxj9wuTTNi7wUEfd6mhfmby/z0Zk/ty
	 OHLXrXZBXO80IPYQ+evG9eK0gCb7LOBR4wh6mh+8wZF6XQeQZ3MUctOkUjR+fmw6e4euF
	 RTP0lHBb3sKO0EdCLEX6OMDeQ4157QnACUINnpuUhlBtW7uq+lBZ3ix5mlnJFgB6+mcOZ
	 lxL4Qy8OSZi8AiO/aO8rPBuGKslJTmdsQ0jCRIP+w2BLyjSY5thgUqSbhq+BRFcKbQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=tlsK2cNm;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5468606D808
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 18:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5468606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=tlsK2cNm
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36dbde64409so2340607eec.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 10:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794077089; x=1794681889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JuLpMa1SsARbLX+VgT8lDkaksHzgOIaqTQ9JsfA99F0=;
        b=tlsK2cNmxgleA0eb/d3tuW0pniK+AnkTM0t5/VJRi0Jlz0PqbUxUU56OzFTdRtg93d
         mVuXVYvfC6K+W9Dzsv5ZlMApk558yA88TdBo8+rJH7JWMgLBrOqzUwOZrrTtBHqIjeMD
         Qdb5aIV7oJtFCPzuea3X5WPs7D91aGFXDOvFC02Wa04IKdDxjVIqPA+Q8B+0+ice6Uo0
         hxPAoLpry9k404ECppcuO08rHBi7eJWSJR1FuS2fPXbklRiQ/zWxJSedEY7YmIOJ08Ua
         zHZASUcqA6FuJ7ZoYLQaYnTmw8y24doEqvqMCeAJpIybB17B+hUc8kZztfk9BKJDu0a6
         oPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077089; x=1794681889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JuLpMa1SsARbLX+VgT8lDkaksHzgOIaqTQ9JsfA99F0=;
        b=0u8/fXnQr7hEg4/+I656Agl2PKpqnIKDL66CprGhp50y31gQliYyHHpYLlMbGDjNRW
         vUk39DLKFvxcU1zy72HiIHsrycxb4tnYHyZxNxpzP/TQ/Ou60bQK+i3oOMEUFWcdm2/U
         2Y7+sg3ZNi9BEFAKmSj9gfvLyj+8CKVgmXCnTxUzzdsJ3lSRrVIlpgtYA5YOjVs0/wep
         ohUGIaaBwIi0lPi8PIJc+wqbnu56kjalXUo5fw5Bpok1i8n49N+O2iopPdOF+4LtgYnf
         G6Uij7lP/mcO3J6o2S0UzfmHJHDEKerzYc/5x4Cxi5wrx6gUjJBI8IR+9DozNu+GEJa9
         qiQQ==
X-Forwarded-Encrypted: i=1; AL+hErGOCG/38/c41Al/m/AihJqtU8S9S8ebiPTX1Ozy4Jg30/qWC4s+D56dCexH/BkAzOGL/cOXs3xIK479lsiZDoI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+yLaGrW4zBly42tWsp78cwj0PtS8JNIrKUf+bs+/ASP7Vg8HH6
	hqwVbl06ZXhQwh64DQg1dP4/b8poRX2uj7KQF/GIPPCPiY+gDBcppjcbyqIQqq1Vg8k=
X-Gm-Gg: AYBFou1AWmEbCUQpwP+Jh3Wdsi3Pmg0hwLLQaiATkQWCbRBbjldxT1pZjRV3wiJo4Jw
	leF51t30XnpbjnL2pI74KjMyqsqN1tya1DRbYDPs/VjL7AvRgDjFIuOKu8EBwI0XNo1E3oLtsne
	kUHs0pOz2qdmItvfVgljpIPBViF4kMHLFRIDyC94AqGKNuc3pIQ5QKShyY4HOIglPpNxKy1PUW6
	WWDuktLTZhphVg9/7OONEyh7jEsQ1RpIzyjgWOfkT2wEkajYtsxnJayJz7NYsoTUY/ZtGFKX8DK
	9R56nVD2ruMdDUF1w9zvVuQzYmN0AaOj0dYPHHdlaRyeqT7dDQHbKgYjAkpMUwEA7+BgNKF/dGT
	Jv+0QAIx2KsjvSFcKN1aRSNauOq6K45XBsDPO56nukJOPqRZCUxTVOgHutSKGEFdXhr+/D18fHJ
	iURdl7tv+9A18V5tAhtEZqnCUCGj8WTwUwMZ5dePx3jpsxzBQVtl2lDFL+A4vm/2BFkjaTnb0lC
	S54y+u776wRm/Kmp7n9gVQLX7m5ENrGNnHLvhSThNBoX3PLt7KNEGYC6stEW4d5kFZP0erXHikS
	nq+N++cZOGhDgrSpDUZgdxw/jUpQMa6qYKdo1k3VCWdo+uTMzb0Keus3iog37meuN1gXqlc=
X-Received: by 2002:a05:7301:4283:b0:36c:c434:b6b8 with SMTP id 5a478bee46e88-36f7681bb02mr7877247eec.26.1794077088158;
        Sat, 07 Nov 2026 10:44:48 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:44:47 -0800 (PST)
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
Subject: [RFC PATCH net-next 3/9] amt: offload group object, desired state and reconciler
Date: Sat,  7 Nov 2026 18:44:31 +0000
Message-ID: <20261107184437.2783174-4-omar@blockcast.net>
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

One group object per (family, group) carries its members (the gateway
endpoints joined to it), a generation and hw_active. Desired state
changes under a leaf bh spinlock: the first gnode of a group on a
tunnel adds the tunnel's endpoint as a member, the last removes it,
and a tunnel's unlink removes it from every group at once.
Forwarding stays per (family, group) and never per source, exactly as
the software fan-out: a gateway holding INCLUDE(S1) still receives S2.

A reconciler in process context, never under amt->lock or a tunnel lock,
converges the provider to desired state: endpoint_add for new endpoints,
group_update and group_commit at the group's generation, then hw_active;
group_disable for emptied groups and endpoint_del for unused endpoints
once no committed group can name them. Each endpoint counts the
committed groups naming it, so its deletion does not wait for every
dirty group to be reprogrammed. A pass starts no new group once it has
spent offload_op_budget ops (default 1000, an estimate), so it can
overrun the budget by one group's ops; if the budget left no room for
one, it still makes one endpoint_del, so a group re-dirtied on every
pass cannot starve endpoint collection. The pass that gives everything
back once desired state is lost is not budgeted. Changes between passes
coalesce into one update per group. A group the provider refuses is
served by software and retried with hysteresis (once the provider holds
an eighth fewer objects), after a reset or on a new binding; its
endpoints stay programmed. An op overrunning op_timeout_ms flushes the
provider, bumps the epoch and replays from desired state; a result from
an older epoch is ignored. A pass ends at a reset and at a teardown, and
checks for teardown before every endpoint_add, group_update,
group_commit and endpoint_del. A teardown under RTNL therefore waits out
at most one of those ops plus the cleanup it triggers or the pass has
already queued: a flush after an overrun, the group_disable that parks a
group it could not program, the group_disable calls for groups the pass
emptied, and, on the pass that gives everything back once desired state
is lost, the rest of that release. The group_disable and endpoint_del
calls that give everything back are timed too: the first to overrun
flushes the provider once and the remaining handles are forgotten, so a
wedged provider costs one op plus one flush, with no replay and no new
epoch (at teardown, unbind follows). The overrun is sampled as the
provider call returns, so amt's own bookkeeping is not charged to it.

The endpoint and group tables are sized once from max_tunnels and
max_tunnels * max_groups respectively, and hashed with the device's
hash_seed: gateways choose their groups and ports. Removing a member
withdraws its group from hardware at once (hw_active), so no packet
admitted after that is replicated to the departed endpoint; software
serves the group until the reconciler commits the new member set, and
hw_active is published only if no member was removed since the snapshot
the commit was built from. A join meanwhile does not withhold it: the
committed set is a subset that names no departed endpoint. A group
re-created for an emptied group's key waits, within the pass, for the
old provider object's group_disable, so a provider never holds two
groups for one key. Parking a group that holds a provider object always
waits out ops->xmit, since removing a member clears hw_active with no
grace period. The table size is clamped in 64 bits before
order_base_2(), which would truncate the product on 32-bit.

Binding replays desired state; teardown takes the reconciler mutex to
cancel programming, then gives every group and endpoint back in the
documented order. Desired state is freed at ndo_uninit, after the
tunnels. amt_tunnel_unlink() now carries the unlink that
amt_tunnel_expire() and amt_dev_stop() each open-coded, so the hook
runs on both. Software mode allocates nothing and runs no hook.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c         | 1166 +++++++++++++++++++++++++++++++++++--
 include/net/amt.h         |   35 +-
 include/net/amt_offload.h |   74 ++-
 3 files changed, 1225 insertions(+), 50 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 034221e1c..17337989a 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -7,6 +7,7 @@
 #include <linux/skbuff.h>
 #include <linux/udp.h>
 #include <linux/jhash.h>
+#include <linux/hashtable.h>
 #include <linux/if_tunnel.h>
 #include <linux/net.h>
 #include <linux/igmp.h>
@@ -33,6 +34,8 @@
 #include <net/inet_dscp.h>
 #include <net/ip6_checksum.h>
 
+#include <kunit/static_stub.h>
+
 static struct workqueue_struct *amt_wq;
 
 static HLIST_HEAD(source_gc_list);
@@ -304,6 +307,19 @@ static void amt_destroy_source(struct amt_source_node *snode)
 	spin_unlock_bh(&source_gc_lock);
 }
 
+/* Offload desired-state hooks, defined with the rest of the offload code.
+ * Each is a no-op on a relay in software mode.
+ */
+static void amt_ofl_member_add(struct amt_dev *amt,
+			       struct amt_tunnel_list *tunnel,
+			       const union amt_addr *group, bool v6);
+static void amt_ofl_member_del(struct amt_dev *amt,
+			       struct amt_tunnel_list *tunnel,
+			       const union amt_addr *group, bool v6);
+static void amt_ofl_tunnel_gone(struct amt_dev *amt,
+				struct amt_tunnel_list *tunnel);
+static void amt_ofl_state_free(struct amt_dev *amt);
+
 static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 {
 	struct amt_source_node *snode;
@@ -315,6 +331,8 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 	rhltable_remove(&amt->groups_rhl, &gnode->rhlnode, amt_gnode_params);
 	list_del(&gnode->tunnel_node);
 	gnode->tunnel_list->nr_groups--;
+	amt_ofl_member_del(amt, gnode->tunnel_list, &gnode->group_addr,
+			   gnode->v6);
 
 	if (!gnode->v6)
 		netdev_dbg(amt->dev, "Leave group %pI4\n",
@@ -569,6 +587,7 @@ static struct amt_group_node *amt_add_group(struct amt_dev *amt,
 	}
 	list_add(&gnode->tunnel_node, &tunnel->groups);
 	tunnel->nr_groups++;
+	amt_ofl_member_add(amt, tunnel, group, v6);
 
 	if (!gnode->v6)
 		netdev_dbg(amt->dev, "Join group %pI4\n",
@@ -1542,6 +1561,17 @@ static void amt_clear_groups(struct amt_tunnel_list *tunnel)
 	spin_unlock_bh(&tunnel->lock);
 }
 
+/* Unlink @tunnel from the relay. Caller holds amt->lock, or RTNL with the
+ * device stopping (amt_dev_stop). The groups stay until amt_clear_groups.
+ */
+static void amt_tunnel_unlink(struct amt_dev *amt,
+			      struct amt_tunnel_list *tunnel)
+{
+	list_del_rcu(&tunnel->list);
+	amt->nr_tunnels--;
+	amt_ofl_tunnel_gone(amt, tunnel);
+}
+
 static void amt_tunnel_expire(struct work_struct *work)
 {
 	struct amt_tunnel_list *tunnel = container_of(to_delayed_work(work),
@@ -1551,8 +1581,7 @@ static void amt_tunnel_expire(struct work_struct *work)
 
 	spin_lock_bh(&amt->lock);
 	rcu_read_lock();
-	list_del_rcu(&tunnel->list);
-	amt->nr_tunnels--;
+	amt_tunnel_unlink(amt, tunnel);
 	amt_clear_groups(tunnel);
 	rcu_read_unlock();
 	spin_unlock_bh(&amt->lock);
@@ -3445,8 +3474,7 @@ static int amt_dev_stop(struct net_device *dev)
 	amt->remote_ip = 0;
 
 	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
-		list_del_rcu(&tunnel->list);
-		amt->nr_tunnels--;
+		amt_tunnel_unlink(amt, tunnel);
 		cancel_delayed_work_sync(&tunnel->gc_wq);
 		amt_clear_groups(tunnel);
 		kfree_rcu(tunnel, rcu);
@@ -3996,6 +4024,7 @@ static void amt_dev_uninit(struct net_device *dev)
 	/* amt_dev_stop() has removed every tunnel and its groups. */
 	rhltable_destroy(&amt->groups_rhl);
 	gro_cells_destroy(&amt->gro_cells);
+	amt_ofl_state_free(amt);
 }
 
 static const struct net_device_ops amt_netdev_ops = {
@@ -4054,20 +4083,141 @@ struct amt_offload_provider {
 	struct rcu_head			rcu;
 };
 
-/* One provider-owned handle amt must give back on teardown. */
-struct amt_offload_ref {
-	struct list_head		node;
-	void				*handle;
-};
-
 struct amt_offload_bound {
 	struct amt_offload_binding	pub;
 	const struct amt_offload_ops	*ops;
 	struct amt_offload_caps		caps;
 	/* Cleared first on teardown; ops->xmit is only called while set. */
 	bool				admitting;
-	struct list_head		groups;		/* amt_offload_ref */
-	struct list_head		endpoints;	/* amt_offload_ref */
+};
+
+/* Desired state and its reconciler.
+ *
+ *   amt_add_group / amt_del_group      tunnel unlink
+ *   (first / last gnode of a group)    (every group of the tunnel)
+ *                 |                              |
+ *                 v                              v
+ *   +-- desired state, st->lock (bh, a leaf) -------------------------+
+ *   |  grp (family, group) --< member (grp, tunnel) >-- ep (addr,port) |
+ *   |  a member change bumps grp->gen and queues grp on st->dirty      |
+ *   +------------------------------------------------------------------+
+ *                 |  st->work, process context
+ *                 v
+ *   reconciler, st->mutex, never under amt->lock or a tunnel lock:
+ *     per dirty grp: endpoint_add each new ep, group_update(gen),
+ *     group_commit(gen), then publish hw_gen and hw_active; a grp
+ *     with no members is disabled; then unused eps get endpoint_del
+ *                 |
+ *                 v
+ *   provider tables; amt_dev_xmit reads grp->hw_active and hw_gen
+ *
+ * A tick starts no new group once st->budget ops are spent, so one
+ * group may overrun it by its own ops, and endpoint GC runs one
+ * endpoint_del past it when the budget left none, so a group re-dirtied
+ * on every tick cannot starve collection. Changes that land between ticks
+ * coalesce: a group is queued at most once and programmed at its latest
+ * generation. A group whose programming fails is parked and served by
+ * software (the remainder); parked groups are retried only when the
+ * provider holds an eighth fewer objects than when it refused one
+ * (hysteresis), after a reset, or on a new binding. A programming, gone
+ * or GC op overrunning op_timeout_ms resets the provider (flush) and
+ * replays every group from desired state under a new epoch; a result
+ * from an older epoch is ignored. A release op that overruns while amt
+ * gives everything back (teardown, or desired state lost) flushes once
+ * and forgets the remaining handles, with no new epoch and no replay.
+ * Only the reconciler frees grp and ep records, so it may use them
+ * without st->lock between ops.
+ *
+ * Forwarding is per (family, group) and never per source, exactly as the
+ * software fan-out in amt_dev_xmit: a gateway with an INCLUDE(S1)
+ * membership still receives S2. AMT_OFFLOAD_F_SOURCE_FILTER has no v1
+ * meaning.
+ */
+/* Both tables are sized once, from the caps, at state allocation: eps
+ * from max_tunnels, grps from max_tunnels * max_groups. Neither cap has a
+ * changelink, so a load factor of about one holds without a resize; the
+ * upper bound only matters past 64k entries.
+ */
+#define AMT_OFL_HASH_MIN_BITS	4
+#define AMT_OFL_HASH_MAX_BITS	16
+
+/* Default ops per reconciler tick. [estimated]: not measured on hardware. */
+static unsigned int amt_offload_op_budget = 1000;
+module_param_named(offload_op_budget, amt_offload_op_budget, uint, 0444);
+MODULE_PARM_DESC(offload_op_budget,
+		 "Offload programming ops per reconciler tick (default 1000)");
+
+enum amt_ofl_grp_state {
+	AMT_OFL_IDLE,
+	AMT_OFL_DIRTY,		/* on st->dirty */
+	AMT_OFL_PARKED,		/* on st->parked: served by software */
+};
+
+struct amt_ofl_ep {
+	struct hlist_node		hnode;		/* st->eps */
+	struct list_head		gc_node;	/* st->ep_gc */
+	struct amt_offload_endpoint_key	key;
+	u32				refs;		/* members using it */
+	u32				committed;	/* committed grps naming it */
+	bool				on_gc;
+	/* Reconciler-owned, under st->mutex. */
+	struct list_head		hw_node;	/* st->hw_eps */
+	struct amt_offload_endpoint	*hw;
+};
+
+struct amt_ofl_grp {
+	struct hlist_node		hnode;		/* st->grps, RCU */
+	struct list_head		q_node;	/* st->dirty or st->parked */
+	struct amt_offload_group_key	key;
+	struct list_head		members;
+	u32				nr_members;
+	u8				state;
+	u64				gen;		/* desired */
+	u32				left;		/* members removed */
+	/* Reconciler-owned, under st->mutex; the data path reads hw and
+	 * hw_gen once it has read hw_active true (acquire).
+	 */
+	struct list_head		hw_node;	/* st->hw_grps */
+	struct amt_offload_group	*hw;
+	/* The endpoints the last successful group_commit named; each counts
+	 * in its ep->committed, under st->lock.
+	 */
+	struct amt_ofl_ep		**ceps;
+	u32				nr_ceps;
+	u64				hw_gen;
+	bool				hw_active;
+	struct rcu_head			rcu;
+};
+
+struct amt_ofl_member {
+	struct list_head		grp_node;	/* grp->members */
+	struct hlist_node		tun_node;	/* tunnel->offload_members */
+	struct amt_ofl_grp		*grp;
+	struct amt_ofl_ep		*ep;
+	u32				gnodes;	/* the tunnel's gnodes for grp */
+};
+
+struct amt_offload_state {
+	struct amt_dev			*amt;
+	/* Desired state, written from the softirq decap path. */
+	spinlock_t			lock;
+	struct hlist_head		*grps;		/* RCU */
+	struct hlist_head		*eps;
+	u32				grp_bits;
+	u32				ep_bits;
+	struct list_head		dirty;
+	struct list_head		parked;
+	struct list_head		ep_gc;
+	bool				desync;
+	/* Reconciler. bind and teardown also take the mutex. */
+	struct mutex			mutex;
+	struct work_struct		work;
+	struct list_head		hw_grps;
+	struct list_head		hw_eps;
+	u32				hw_objs;
+	bool				enospc;
+	u32				enospc_at;
+	u32				budget;
 };
 
 static LIST_HEAD(amt_offload_providers);
@@ -4146,21 +4296,948 @@ amt_offload_tx_admit(struct amt_dev *amt)
 	return b && READ_ONCE(b->admitting) ? b : NULL;
 }
 
-/* Record a handle the provider handed back; the later reconciler is the
- * production caller.
+static void amt_ofl_grp_key(struct amt_offload_group_key *key,
+			    const union amt_addr *group, bool v6)
+{
+	memset(key, 0, sizeof(*key));
+#if IS_ENABLED(CONFIG_IPV6)
+	if (v6) {
+		key->family = AF_INET6;
+		key->group.ip6 = group->ip6;
+		return;
+	}
+#endif
+	key->family = AF_INET;
+	key->group.ip4 = group->ip4;
+}
+
+static void amt_ofl_ep_key(struct amt_offload_endpoint_key *key,
+			   const struct amt_dev *amt,
+			   const struct amt_tunnel_list *tunnel)
+{
+	memset(key, 0, sizeof(*key));
+	key->port = tunnel->source_port;
+#if IS_ENABLED(CONFIG_IPV6)
+	if (amt_v6(amt)) {
+		key->family = AF_INET6;
+		key->addr.ip6 = tunnel->addr.ip6;
+		return;
+	}
+#endif
+	key->family = AF_INET;
+	key->addr.ip4 = tunnel->addr.ip4;
+}
+
+/* Keys are built zeroed, so memcmp() over the padding is sound. Seeded
+ * per device: gateways choose their groups and ports, so an unseeded hash
+ * lets them pile entries into one chain under st->lock.
+ */
+static u32 amt_ofl_hash(const struct amt_offload_state *st,
+			const void *key, size_t len, u32 bits)
+{
+	return hash_32(jhash(key, len, st->amt->hash_seed), bits);
+}
+
+static struct hlist_head *
+amt_ofl_grp_bucket(const struct amt_offload_state *st,
+		   const struct amt_offload_group_key *key)
+{
+	return &st->grps[amt_ofl_hash(st, key, sizeof(*key), st->grp_bits)];
+}
+
+static struct hlist_head *
+amt_ofl_ep_bucket(const struct amt_offload_state *st,
+		  const struct amt_offload_endpoint_key *key)
+{
+	return &st->eps[amt_ofl_hash(st, key, sizeof(*key), st->ep_bits)];
+}
+
+/* Caller holds st->lock, or rcu_read_lock() for the data path. */
+static struct amt_ofl_grp *
+amt_ofl_grp_find(struct amt_offload_state *st,
+		 const struct amt_offload_group_key *key)
+{
+	struct amt_ofl_grp *g;
+
+	hlist_for_each_entry_rcu(g, amt_ofl_grp_bucket(st, key), hnode,
+				 lockdep_is_held(&st->lock))
+		if (!memcmp(&g->key, key, sizeof(*key)))
+			return g;
+	return NULL;
+}
+
+static struct amt_ofl_ep *
+amt_ofl_ep_find(struct amt_offload_state *st,
+		const struct amt_offload_endpoint_key *key)
+{
+	struct amt_ofl_ep *ep;
+
+	hlist_for_each_entry(ep, amt_ofl_ep_bucket(st, key), hnode)
+		if (!memcmp(&ep->key, key, sizeof(*key)))
+			return ep;
+	return NULL;
+}
+
+/* Queue @g for the reconciler. A parked group stays parked, served by
+ * software, until its retry is due -- unless it lost its last member,
+ * which the reconciler must see to free it. Caller holds st->lock.
+ */
+static void amt_ofl_grp_dirty(struct amt_offload_state *st,
+			      struct amt_ofl_grp *g)
+{
+	if (g->state == AMT_OFL_DIRTY)
+		return;
+	if (g->state == AMT_OFL_PARKED) {
+		if (g->nr_members)
+			return;
+		list_del(&g->q_node);
+	}
+	list_add_tail(&g->q_node, &st->dirty);
+	g->state = AMT_OFL_DIRTY;
+}
+
+static void amt_ofl_kick(struct amt_offload_state *st)
+{
+	queue_work(system_unbound_wq, &st->work);
+}
+
+/* Desired state could not record a change. Hardware would forward to a
+ * stale member set, so the relay leaves offload for good: the data path
+ * stops consulting the provider, and the next reconciler pass gives every
+ * provider object back (group_disable, endpoint_del; the binding stays,
+ * with no unbind). Desync does not schedule that pass: a pass already
+ * queued or a later removal of a recorded member (by a leave, a timer or
+ * a tunnel removal) does, and a teardown gives everything back itself
+ * and unbinds. Caller holds st->lock.
+ */
+static void amt_ofl_desync(struct amt_offload_state *st)
+{
+	if (st->desync)
+		return;
+	WRITE_ONCE(st->desync, true);
+	amt_offload_count(st->amt, AMT_OFFLOAD_CNT_DESYNC);
+}
+
+/* The first gnode of (@group, @v6) on @tunnel makes the tunnel's
+ * endpoint a member; later ones only count. Caller holds tunnel->lock.
+ */
+static void amt_ofl_member_add(struct amt_dev *amt,
+			       struct amt_tunnel_list *tunnel,
+			       const union amt_addr *group, bool v6)
+{
+	struct amt_offload_state *st = amt->offload_st;
+	struct amt_ofl_grp *g, *new_g = NULL;
+	struct amt_ofl_ep *ep, *new_ep = NULL;
+	struct amt_offload_endpoint_key ekey;
+	struct amt_offload_group_key gkey;
+	struct amt_ofl_member *m;
+
+	if (!st)
+		return;
+	amt_ofl_grp_key(&gkey, group, v6);
+	spin_lock_bh(&st->lock);
+	if (st->desync)
+		goto out;
+	hlist_for_each_entry(m, &tunnel->offload_members, tun_node) {
+		if (!memcmp(&m->grp->key, &gkey, sizeof(gkey))) {
+			m->gnodes++;
+			goto out;
+		}
+	}
+
+	g = amt_ofl_grp_find(st, &gkey);
+	if (!g) {
+		new_g = kzalloc_obj(*new_g, GFP_ATOMIC);
+		if (!new_g)
+			goto nomem;
+		g = new_g;
+		g->key = gkey;
+		INIT_LIST_HEAD(&g->members);
+		INIT_LIST_HEAD(&g->hw_node);
+	}
+	amt_ofl_ep_key(&ekey, amt, tunnel);
+	ep = amt_ofl_ep_find(st, &ekey);
+	if (!ep) {
+		new_ep = kzalloc_obj(*new_ep, GFP_ATOMIC);
+		if (!new_ep)
+			goto nomem;
+		ep = new_ep;
+		ep->key = ekey;
+		INIT_LIST_HEAD(&ep->hw_node);
+	}
+	m = kzalloc_obj(*m, GFP_ATOMIC);
+	if (!m)
+		goto nomem;
+
+	if (new_g)
+		hlist_add_head_rcu(&g->hnode, amt_ofl_grp_bucket(st, &gkey));
+	if (new_ep)
+		hlist_add_head(&ep->hnode, amt_ofl_ep_bucket(st, &ekey));
+	m->grp = g;
+	m->ep = ep;
+	m->gnodes = 1;
+	ep->refs++;
+	list_add_tail(&m->grp_node, &g->members);
+	hlist_add_head(&m->tun_node, &tunnel->offload_members);
+	g->nr_members++;
+	g->gen++;
+	amt_ofl_grp_dirty(st, g);
+	spin_unlock_bh(&st->lock);
+	amt_ofl_kick(st);
+	return;
+nomem:
+	/* One lost allocation takes the relay out of offload for good (see
+	 * amt_ofl_desync()). Rebuilding desired state from the tunnel walk
+	 * would avoid that, if GFP_ATOMIC failures ever show up here.
+	 */
+	kfree(new_g);
+	kfree(new_ep);
+	amt_ofl_desync(st);
+out:
+	spin_unlock_bh(&st->lock);
+}
+
+/* The reconciler's member arrays: up to max_tunnels entries, so not one
+ * contiguous block.
+ */
+static void *amt_ofl_alloc_array(u32 n, size_t size)
+{
+#if IS_ENABLED(CONFIG_AMT_KUNIT_TEST)
+	KUNIT_STATIC_STUB_REDIRECT(amt_ofl_alloc_array, n, size);
+#endif
+	return kvmalloc_array(n, size, GFP_KERNEL);
+}
+
+static void amt_ofl_free_array(void *p)
+{
+#if IS_ENABLED(CONFIG_AMT_KUNIT_TEST)
+	KUNIT_STATIC_STUB_REDIRECT(amt_ofl_free_array, p);
+#endif
+	kvfree(p);
+}
+
+/* @ep may be deleted once no member uses it and no committed group names
+ * it: queue it for endpoint GC. Caller holds st->lock.
+ */
+static void amt_ofl_ep_unused(struct amt_offload_state *st,
+			      struct amt_ofl_ep *ep)
+{
+	if (ep->refs || ep->committed || ep->on_gc)
+		return;
+	list_add_tail(&ep->gc_node, &st->ep_gc);
+	ep->on_gc = true;
+}
+
+/* @g's committed member set no longer reaches hardware: its provider
+ * object is disabled or flushed. Caller holds st->mutex.
+ */
+static void amt_ofl_grp_uncommit(struct amt_offload_state *st,
+				 struct amt_ofl_grp *g)
+{
+	struct amt_ofl_ep **ceps = g->ceps;
+	u32 i;
+
+	if (!ceps)
+		return;
+	spin_lock_bh(&st->lock);
+	for (i = 0; i < g->nr_ceps; i++) {
+		ceps[i]->committed--;
+		amt_ofl_ep_unused(st, ceps[i]);
+	}
+	g->ceps = NULL;
+	g->nr_ceps = 0;
+	spin_unlock_bh(&st->lock);
+	amt_ofl_free_array(ceps);
+}
+
+/* Caller holds st->lock. */
+static void amt_ofl_member_unlink(struct amt_offload_state *st,
+				  struct amt_ofl_member *m)
+{
+	struct amt_ofl_grp *g = m->grp;
+	struct amt_ofl_ep *ep = m->ep;
+
+	hlist_del(&m->tun_node);
+	list_del(&m->grp_node);
+	g->nr_members--;
+	g->gen++;
+	g->left++;
+	/* The committed member set still names this endpoint: stop handing
+	 * the group to hardware now, not when the reconciler recommits, so
+	 * no packet admitted after this is replicated to it. Software serves
+	 * the group meanwhile.
+	 */
+	WRITE_ONCE(g->hw_active, false);
+	amt_ofl_grp_dirty(st, g);
+	ep->refs--;
+	amt_ofl_ep_unused(st, ep);
+	kfree(m);
+}
+
+/* The last gnode of (@group, @v6) on @tunnel is gone: the endpoint
+ * leaves the group. Caller holds tunnel->lock.
+ */
+static void amt_ofl_member_del(struct amt_dev *amt,
+			       struct amt_tunnel_list *tunnel,
+			       const union amt_addr *group, bool v6)
+{
+	struct amt_offload_state *st = amt->offload_st;
+	struct amt_offload_group_key gkey;
+	struct amt_ofl_member *m;
+	bool kick = false;
+
+	if (!st)
+		return;
+	amt_ofl_grp_key(&gkey, group, v6);
+	spin_lock_bh(&st->lock);
+	hlist_for_each_entry(m, &tunnel->offload_members, tun_node) {
+		if (memcmp(&m->grp->key, &gkey, sizeof(gkey)))
+			continue;
+		if (!--m->gnodes) {
+			amt_ofl_member_unlink(st, m);
+			kick = true;
+		}
+		break;
+	}
+	spin_unlock_bh(&st->lock);
+	if (kick)
+		amt_ofl_kick(st);
+}
+
+/* @tunnel is torn down or unlinked: its endpoint leaves every group at
+ * once. The gnodes deleted afterwards find no member and do nothing.
+ * Caller holds amt->lock, or RTNL with the device stopping (amt_dev_stop).
+ */
+static void amt_ofl_tunnel_gone(struct amt_dev *amt,
+				struct amt_tunnel_list *tunnel)
+{
+	struct amt_offload_state *st = amt->offload_st;
+	struct amt_ofl_member *m;
+	struct hlist_node *tmp;
+	bool kick;
+
+	if (!st)
+		return;
+	spin_lock_bh(&st->lock);
+	kick = !hlist_empty(&tunnel->offload_members);
+	hlist_for_each_entry_safe(m, tmp, &tunnel->offload_members, tun_node)
+		amt_ofl_member_unlink(st, m);
+	spin_unlock_bh(&st->lock);
+	if (kick)
+		amt_ofl_kick(st);
+}
+
+/* Queue every group with members, parked ones included, for a full
+ * replay: on a new binding and after a reset.
+ */
+static void amt_ofl_requeue_all(struct amt_offload_state *st)
+{
+	struct amt_ofl_grp *g;
+	u32 bkt;
+
+	spin_lock_bh(&st->lock);
+	for (bkt = 0; bkt < 1U << st->grp_bits; bkt++) {
+		hlist_for_each_entry(g, &st->grps[bkt], hnode) {
+			if (g->state == AMT_OFL_PARKED) {
+				list_del(&g->q_node);
+				g->state = AMT_OFL_IDLE;
+			}
+			amt_ofl_grp_dirty(st, g);
+		}
+	}
+	st->enospc = false;
+	spin_unlock_bh(&st->lock);
+}
+
+/* Wait out every ops->xmit admitted before the caller cleared hw_active or
+ * admitting.
+ */
+static void amt_ofl_sync_net(void)
+{
+#if IS_ENABLED(CONFIG_AMT_KUNIT_TEST)
+	KUNIT_STATIC_STUB_REDIRECT(amt_ofl_sync_net);
+#endif
+	synchronize_net();
+}
+
+/* Forget every provider handle; the provider was flushed. Each group is
+ * unpublished too, so a later binding never sees hw_active over a NULL
+ * handle. Caller holds st->mutex.
+ */
+static void amt_ofl_hw_forget(struct amt_offload_state *st)
+{
+	struct amt_ofl_grp *g, *gt;
+	struct amt_ofl_ep *ep, *et;
+
+	list_for_each_entry_safe(g, gt, &st->hw_grps, hw_node) {
+		WRITE_ONCE(g->hw_active, false);
+		amt_ofl_grp_uncommit(st, g);
+		g->hw = NULL;
+		list_del_init(&g->hw_node);
+	}
+	list_for_each_entry_safe(ep, et, &st->hw_eps, hw_node) {
+		ep->hw = NULL;
+		list_del_init(&ep->hw_node);
+	}
+	st->hw_objs = 0;
+}
+
+/* An op issued at @t0 overran op_timeout_ms: the provider is wedged. */
+static bool amt_ofl_op_overran(struct amt_offload_bound *b, ktime_t t0)
+{
+	u32 tmo = b->caps.op_timeout_ms;
+
+#if IS_ENABLED(CONFIG_AMT_KUNIT_TEST)
+	KUNIT_STATIC_STUB_REDIRECT(amt_ofl_op_overran, b, t0);
+#endif
+	return tmo && ktime_ms_delta(ktime_get(), t0) > tmo;
+}
+
+/* Give every provider object back with group_disable and endpoint_del,
+ * groups first. A release op that overruns op_timeout_ms ends it: the
+ * provider is flushed once and the remaining handles are forgotten, so
+ * a wedged provider costs one op plus one flush, not one op per object,
+ * under RTNL at teardown. @quiesced: the caller already stopped
+ * admission and waited out ops->xmit. Caller holds st->mutex.
  */
-static int __maybe_unused amt_offload_track(struct list_head *list,
-					    void *handle)
+static void amt_ofl_hw_release(struct amt_offload_state *st,
+			       struct amt_offload_bound *b, bool quiesced)
 {
-	struct amt_offload_ref *ref = kzalloc(sizeof(*ref), GFP_KERNEL);
+	struct amt_ofl_grp *g, *gt;
+	struct amt_ofl_ep *ep, *et;
+	bool overran;
+	ktime_t t0;
+
+	lockdep_assert_held(&st->mutex);
+	if (!quiesced && !list_empty(&st->hw_grps)) {
+		list_for_each_entry(g, &st->hw_grps, hw_node)
+			WRITE_ONCE(g->hw_active, false);
+		amt_ofl_sync_net();
+	}
+	list_for_each_entry_safe(g, gt, &st->hw_grps, hw_node) {
+		WRITE_ONCE(g->hw_active, false);
+		t0 = ktime_get();
+		b->ops->group_disable(&b->pub, g->hw);
+		overran = amt_ofl_op_overran(b, t0);
+		amt_ofl_grp_uncommit(st, g);
+		g->hw = NULL;
+		list_del_init(&g->hw_node);
+		if (overran)
+			goto wedged;
+	}
+	list_for_each_entry_safe(ep, et, &st->hw_eps, hw_node) {
+		t0 = ktime_get();
+		b->ops->endpoint_del(&b->pub, ep->hw);
+		overran = amt_ofl_op_overran(b, t0);
+		ep->hw = NULL;
+		list_del_init(&ep->hw_node);
+		if (overran)
+			goto wedged;
+	}
+	st->hw_objs = 0;
+	return;
+wedged:
+	b->ops->flush(&b->pub);
+	amt_ofl_hw_forget(st);
+	amt_offload_count(st->amt, AMT_OFFLOAD_CNT_RESET);
+}
+
+/* An op overran op_timeout_ms: the provider is treated as wedged. Stop
+ * forwarding through it, flush its tables, forget every handle, bump the
+ * epoch so anything it still returns is stale, and replay. Caller holds
+ * st->mutex.
+ */
+static void amt_ofl_reset(struct amt_offload_state *st,
+			  struct amt_offload_bound *b)
+{
+	struct amt_ofl_grp *g;
+
+	lockdep_assert_held(&st->mutex);
+	list_for_each_entry(g, &st->hw_grps, hw_node)
+		WRITE_ONCE(g->hw_active, false);
+	amt_ofl_sync_net();
+	b->ops->flush(&b->pub);
+	amt_ofl_hw_forget(st);
+	b->pub.epoch = ++st->amt->offload_epoch;
+	amt_offload_count(st->amt, AMT_OFFLOAD_CNT_RESET);
+	amt_ofl_requeue_all(st);
+}
+
+/* Completion check for an op issued under @epoch; @overran was sampled
+ * right after the provider call returned, so amt's own bookkeeping is not
+ * charged to the provider. False means its result must be ignored -- the
+ * op overran op_timeout_ms (the provider is reset here) or the epoch moved
+ * under it.
+ */
+static bool amt_ofl_op_done(struct amt_offload_state *st,
+			    struct amt_offload_bound *b, u64 epoch, bool overran)
+{
+	if (overran)
+		amt_ofl_reset(st, b);
+	if (b->pub.epoch == epoch)
+		return true;
+	amt_offload_count(st->amt, AMT_OFFLOAD_CNT_STALE);
+	return false;
+}
+
+/* Stop forwarding @g in hardware and free its provider object. The caller
+ * cleared hw_active and waited out ops->xmit, or the group never had it.
+ * Returns whether group_disable overran op_timeout_ms.
+ */
+static bool amt_ofl_grp_hw_free(struct amt_offload_state *st,
+				struct amt_offload_bound *b,
+				struct amt_ofl_grp *g)
+{
+	ktime_t t0 = ktime_get();
+	bool overran;
+
+	b->ops->group_disable(&b->pub, g->hw);
+	overran = amt_ofl_op_overran(b, t0);
+	amt_ofl_grp_uncommit(st, g);
+	g->hw = NULL;
+	list_del_init(&g->hw_node);
+	st->hw_objs--;
+	return overran;
+}
 
-	if (!ref)
+/* Retry parked groups once the provider holds an eighth fewer objects
+ * than when it refused one. Refused with nothing programmed, only a
+ * reset or a new binding retries them. Caller holds st->mutex.
+ */
+static void amt_ofl_unpark(struct amt_offload_state *st)
+{
+	struct amt_ofl_grp *g, *t;
+
+	if (!st->enospc || !st->enospc_at ||
+	    st->hw_objs + max(st->enospc_at / 8, 1U) > st->enospc_at)
+		return;
+	spin_lock_bh(&st->lock);
+	list_for_each_entry_safe(g, t, &st->parked, q_node) {
+		list_del(&g->q_node);
+		g->state = AMT_OFL_IDLE;
+		amt_ofl_grp_dirty(st, g);
+	}
+	st->enospc = false;
+	spin_unlock_bh(&st->lock);
+}
+
+/* Programming @g failed: software serves it from now until a retry. Its
+ * endpoints stay programmed; they may serve other groups.
+ */
+static unsigned int amt_ofl_grp_park(struct amt_offload_state *st,
+				     struct amt_offload_bound *b,
+				     struct amt_ofl_grp *g)
+{
+	unsigned int ops = 0;
+
+	if (g->hw) {
+		/* Wait out ops->xmit even when hw_active already reads false:
+		 * amt_ofl_member_unlink() clears it from softirq with no grace
+		 * period, so a reader admitted before may still hold g->hw.
+		 */
+		WRITE_ONCE(g->hw_active, false);
+		amt_ofl_sync_net();
+		amt_ofl_grp_hw_free(st, b, g);
+		ops++;
+	}
+	if (!st->enospc) {
+		st->enospc = true;
+		st->enospc_at = st->hw_objs;
+	}
+	amt_offload_count(st->amt, AMT_OFFLOAD_CNT_SW_REMAINDER);
+	spin_lock_bh(&st->lock);
+	if (g->state == AMT_OFL_DIRTY && !g->nr_members) {
+		/* Emptied meanwhile: let the reconciler free it. */
+	} else {
+		if (g->state == AMT_OFL_DIRTY)
+			list_del(&g->q_node);
+		list_add_tail(&g->q_node, &st->parked);
+		g->state = AMT_OFL_PARKED;
+	}
+	spin_unlock_bh(&st->lock);
+	return ops;
+}
+
+/* Program @g at its current generation: add its endpoints that are not
+ * in hardware yet, stage the member set, commit, publish. Returns the
+ * ops spent. Caller holds st->mutex; @g is off every queue.
+ */
+static unsigned int amt_ofl_grp_program(struct amt_offload_state *st,
+					struct amt_offload_bound *b,
+					struct amt_ofl_grp *g)
+{
+	struct amt_offload_endpoint **hws = NULL;
+	struct amt_ofl_ep **eps = NULL;
+	struct amt_offload_group *hw;
+	struct amt_ofl_member *m;
+	unsigned int ops = 0;
+	u32 n, i;
+	ktime_t t0;
+	u64 epoch;
+	u32 left;
+	u64 gen;
+	int err;
+
+	for (;;) {
+		spin_lock_bh(&st->lock);
+		n = g->nr_members;
+		spin_unlock_bh(&st->lock);
+		if (!n)
+			goto requeue;
+		eps = amt_ofl_alloc_array(n, sizeof(*eps));
+		hws = amt_ofl_alloc_array(n, sizeof(*hws));
+		if (!eps || !hws)
+			goto park;
+		spin_lock_bh(&st->lock);
+		if (g->nr_members == n)
+			break;
+		spin_unlock_bh(&st->lock);
+		/* Membership moved under the allocation. The next pass may
+		 * find none and leave through out:, which frees both again.
+		 */
+		amt_ofl_free_array(eps);
+		amt_ofl_free_array(hws);
+		eps = NULL;
+		hws = NULL;
+	}
+	i = 0;
+	list_for_each_entry(m, &g->members, grp_node)
+		eps[i++] = m->ep;
+	gen = g->gen;
+	left = g->left;
+	spin_unlock_bh(&st->lock);
+
+	if (g->hw && READ_ONCE(g->hw_active) && g->hw_gen == gen)
+		goto out;	/* a replay of what is already committed */
+
+	for (i = 0; i < n; i++) {
+		struct amt_offload_endpoint *ehw = NULL;
+
+		if (!eps[i]->hw) {
+			if (!READ_ONCE(b->admitting))
+				goto out;	/* teardown gives it all back */
+			epoch = b->pub.epoch;
+			t0 = ktime_get();
+			err = b->ops->endpoint_add(&b->pub, &eps[i]->key, &ehw);
+			ops++;
+			if (!amt_ofl_op_done(st, b, epoch, amt_ofl_op_overran(b, t0)))
+				goto out;	/* reset: replayed */
+			if (err)
+				goto park;
+			eps[i]->hw = ehw;
+			list_add_tail(&eps[i]->hw_node, &st->hw_eps);
+			st->hw_objs++;
+		}
+		hws[i] = eps[i]->hw;
+	}
+
+	if (!READ_ONCE(b->admitting))
+		goto out;
+	hw = g->hw;
+	epoch = b->pub.epoch;
+	t0 = ktime_get();
+	err = b->ops->group_update(&b->pub, &g->key, hws, n, gen, &hw);
+	ops++;
+	if (!amt_ofl_op_done(st, b, epoch, amt_ofl_op_overran(b, t0)))
+		goto out;
+	if (!g->hw && hw) {
+		g->hw = hw;
+		list_add_tail(&g->hw_node, &st->hw_grps);
+		st->hw_objs++;
+	}
+	if (err)
+		goto park;
+
+	if (!READ_ONCE(b->admitting))
+		goto out;
+	epoch = b->pub.epoch;
+	t0 = ktime_get();
+	err = b->ops->group_commit(&b->pub, g->hw, gen);
+	ops++;
+	if (!amt_ofl_op_done(st, b, epoch, amt_ofl_op_overran(b, t0)))
+		goto out;
+	if (err)
+		goto park;
+
+	/* Generation rule: packets submitted from here on carry @gen.
+	 * Release pairs with the acquire in amt_offload_tx(): a reader that
+	 * sees hw_active also sees hw and hw_gen. Publish only if no member
+	 * was removed since the snapshot: it is still in what was just
+	 * committed, and amt_ofl_member_unlink() already withdrew the group.
+	 * A join meanwhile does not hold the publication back: the committed
+	 * set is a subset that names no departed endpoint. Either change
+	 * re-queued @g; the next pass commits it.
+	 */
+	spin_lock_bh(&st->lock);
+	for (i = 0; i < n; i++)
+		eps[i]->committed++;
+	for (i = 0; i < g->nr_ceps; i++) {
+		g->ceps[i]->committed--;
+		amt_ofl_ep_unused(st, g->ceps[i]);
+	}
+	swap(g->ceps, eps);	/* out: frees the old set */
+	g->nr_ceps = n;
+	WRITE_ONCE(g->hw_gen, gen);
+	if (g->left == left)
+		smp_store_release(&g->hw_active, true);
+	spin_unlock_bh(&st->lock);
+	goto out;
+park:
+	ops += amt_ofl_grp_park(st, b, g);
+	goto out;
+requeue:
+	spin_lock_bh(&st->lock);
+	amt_ofl_grp_dirty(st, g);
+	spin_unlock_bh(&st->lock);
+out:
+	amt_ofl_free_array(eps);
+	amt_ofl_free_array(hws);
+	return ops;
+}
+
+/* Disable the unhashed groups on @gone: one grace period per flush, then
+ * disable. A group holds hw only while bound, so @b is set when any does.
+ */
+static void amt_ofl_gone_flush(struct amt_offload_state *st,
+			       struct amt_offload_bound *b,
+			       struct list_head *gone)
+{
+	struct amt_ofl_grp *g, *gt;
+	u64 e;
+
+	if (list_empty(gone))
+		return;
+	amt_ofl_sync_net();
+	list_for_each_entry_safe(g, gt, gone, q_node) {
+		list_del(&g->q_node);
+		/* A reset earlier in this flush or tick already flushed it. */
+		if (g->hw) {
+			e = b->pub.epoch;
+			amt_ofl_op_done(st, b, e, amt_ofl_grp_hw_free(st, b, g));
+		}
+		kfree_rcu(g, rcu);
+	}
+}
+
+/* Is a group with @key on @gone, its provider object still live? */
+static bool amt_ofl_gone_has(struct list_head *gone,
+			     const struct amt_offload_group_key *key)
+{
+	struct amt_ofl_grp *g;
+
+	list_for_each_entry(g, gone, q_node)
+		if (!memcmp(&g->key, key, sizeof(*key)))
+			return true;
+	return false;
+}
+
+/* One reconciler tick. Returns true while work remains. */
+static bool amt_ofl_reconcile(struct amt_dev *amt)
+{
+	struct amt_offload_state *st = amt->offload_st;
+	struct amt_ofl_grp *g;
+	struct amt_offload_bound *b;
+	LIST_HEAD(gone);
+	unsigned int spent = 0;
+	unsigned int budget;
+	struct amt_ofl_ep *ep;
+	bool gc_del = false;
+	u64 epoch = 0, e;
+	ktime_t t0;
+	bool more;
+
+	budget = max(READ_ONCE(st->budget), 1U);
+	mutex_lock(&st->mutex);
+	b = rcu_dereference_protected(amt->offload,
+				      lockdep_is_held(&st->mutex));
+	if (b && !READ_ONCE(b->admitting)) {
+		/* Teardown is under way and gives everything back. */
+		mutex_unlock(&st->mutex);
+		return false;
+	}
+	if (b && READ_ONCE(st->desync)) {
+		amt_ofl_hw_release(st, b, false);
+		b = NULL;
+	}
+	if (b)
+		epoch = b->pub.epoch;
+
+	while (spent < budget) {
+		/* A teardown waiting on st->mutex holds RTNL, and a reset
+		 * replays everything anyway: end the pass at either, and let
+		 * the work re-kick, rather than spend the whole budget
+		 * against a provider that may be wedged.
+		 */
+		if (b && (!READ_ONCE(b->admitting) || b->pub.epoch != epoch))
+			break;
+		spin_lock_bh(&st->lock);
+		g = list_first_entry_or_null(&st->dirty, struct amt_ofl_grp,
+					     q_node);
+		if (!g) {
+			spin_unlock_bh(&st->lock);
+			break;
+		}
+		list_del(&g->q_node);
+		g->state = AMT_OFL_IDLE;
+		if (!g->nr_members) {
+			hlist_del_init_rcu(&g->hnode);
+			spin_unlock_bh(&st->lock);
+			if (g->hw) {
+				WRITE_ONCE(g->hw_active, false);
+				list_add_tail(&g->q_node, &gone);
+				spent++;
+			} else {
+				kfree_rcu(g, rcu);
+			}
+			continue;
+		}
+		spin_unlock_bh(&st->lock);
+		if (!b)
+			continue;
+		/* A rejoin of a group emptied earlier in this tick hashed a
+		 * new object for the same key while the old one's provider
+		 * group is still live: disable that one first, or the
+		 * provider would hold two groups for one (family, group).
+		 */
+		if (amt_ofl_gone_has(&gone, &g->key)) {
+			amt_ofl_gone_flush(st, b, &gone);
+			/* A reset in that flush requeued @g: replay it. */
+			if (b->pub.epoch != epoch)
+				break;
+		}
+		spent += amt_ofl_grp_program(st, b, g);
+	}
+
+	amt_ofl_gone_flush(st, b, &gone);
+
+	/* Unused endpoints: no member uses one and no committed group names
+	 * it (ep->committed), so it goes whatever is still dirty. At least
+	 * one endpoint_del per tick, or a group re-dirtied on every pass
+	 * would spend the budget and starve it.
+	 */
+	for (;;) {
+		if (b && !READ_ONCE(b->admitting))
+			break;
+		spin_lock_bh(&st->lock);
+		ep = spent < budget || !gc_del ?
+		     list_first_entry_or_null(&st->ep_gc, struct amt_ofl_ep,
+					      gc_node) : NULL;
+		if (!ep) {
+			spin_unlock_bh(&st->lock);
+			break;
+		}
+		list_del(&ep->gc_node);
+		ep->on_gc = false;
+		if (ep->refs || ep->committed) {
+			/* Queued again when both reach zero. */
+			spin_unlock_bh(&st->lock);
+			continue;
+		}
+		hlist_del_init(&ep->hnode);
+		spin_unlock_bh(&st->lock);
+		if (ep->hw) {
+			list_del_init(&ep->hw_node);
+			st->hw_objs--;
+			e = b->pub.epoch;
+			t0 = ktime_get();
+			b->ops->endpoint_del(&b->pub, ep->hw);
+			spent++;
+			gc_del = true;
+			amt_ofl_op_done(st, b, e, amt_ofl_op_overran(b, t0));
+		}
+		kfree(ep);
+	}
+
+	if (b)
+		amt_ofl_unpark(st);
+	spin_lock_bh(&st->lock);
+	more = !list_empty(&st->dirty) || !list_empty(&st->ep_gc);
+	spin_unlock_bh(&st->lock);
+	mutex_unlock(&st->mutex);
+	return more;
+}
+
+static void amt_ofl_work(struct work_struct *work)
+{
+	struct amt_offload_state *st = container_of(work,
+						    struct amt_offload_state,
+						    work);
+
+	if (amt_ofl_reconcile(st->amt))
+		amt_ofl_kick(st);
+}
+
+static int amt_ofl_state_alloc(struct amt_dev *amt)
+{
+	struct amt_offload_state *st;
+
+	st = kzalloc_obj(*st, GFP_KERNEL);
+	if (!st)
 		return -ENOMEM;
-	ref->handle = handle;
-	list_add_tail(&ref->node, list);
+	st->ep_bits = clamp_t(u32, order_base_2(amt->max_tunnels),
+			      AMT_OFL_HASH_MIN_BITS, AMT_OFL_HASH_MAX_BITS);
+	/* Clamp in 64 bits: order_base_2() takes an unsigned long, which
+	 * would truncate the product on a 32-bit kernel.
+	 */
+	st->grp_bits = clamp_t(u32, order_base_2(min_t(u64,
+					(u64)amt->max_tunnels * amt->max_groups,
+					1U << AMT_OFL_HASH_MAX_BITS)),
+			       AMT_OFL_HASH_MIN_BITS, AMT_OFL_HASH_MAX_BITS);
+	st->grps = kvcalloc(1U << st->grp_bits, sizeof(*st->grps), GFP_KERNEL);
+	st->eps = kvcalloc(1U << st->ep_bits, sizeof(*st->eps), GFP_KERNEL);
+	if (!st->grps || !st->eps) {
+		kvfree(st->grps);
+		kvfree(st->eps);
+		kfree(st);
+		return -ENOMEM;
+	}
+	st->amt = amt;
+	spin_lock_init(&st->lock);
+	INIT_LIST_HEAD(&st->dirty);
+	INIT_LIST_HEAD(&st->parked);
+	INIT_LIST_HEAD(&st->ep_gc);
+	mutex_init(&st->mutex);
+	INIT_WORK(&st->work, amt_ofl_work);
+	INIT_LIST_HEAD(&st->hw_grps);
+	INIT_LIST_HEAD(&st->hw_eps);
+	st->budget = READ_ONCE(amt_offload_op_budget);
+	amt->offload_st = st;
 	return 0;
 }
 
+/* ndo_uninit: every tunnel is gone and the binding with it, so nothing
+ * here is in hardware. Members are freed without touching their tunnels.
+ */
+static void amt_ofl_state_free(struct amt_dev *amt)
+{
+	struct amt_offload_state *st = amt->offload_st;
+	struct amt_ofl_member *m, *mt;
+	struct hlist_node *tmp;
+	struct amt_ofl_grp *g;
+	struct amt_ofl_ep *ep;
+	u32 bkt;
+
+	if (!st)
+		return;
+	cancel_work_sync(&st->work);
+	for (bkt = 0; bkt < 1U << st->grp_bits; bkt++) {
+		hlist_for_each_entry_safe(g, tmp, &st->grps[bkt], hnode) {
+			list_for_each_entry_safe(m, mt, &g->members, grp_node)
+				kfree(m);
+			amt_ofl_free_array(g->ceps);
+			kfree(g);
+		}
+	}
+	for (bkt = 0; bkt < 1U << st->ep_bits; bkt++)
+		hlist_for_each_entry_safe(ep, tmp, &st->eps[bkt], hnode)
+			kfree(ep);
+	mutex_destroy(&st->mutex);
+	kvfree(st->grps);
+	kvfree(st->eps);
+	kfree(st);
+	amt->offload_st = NULL;
+}
+
 static void amt_offload_set_carrier(struct amt_dev *amt, bool on)
 {
 	if (amt->offload_mode != AMT_OFFLOAD_MODE_REQUIRED)
@@ -4191,10 +5268,10 @@ static int amt_offload_bind(struct amt_dev *amt,
 		return -ENOMEM;
 	b->pub.lower = p->lower;
 	b->pub.dev = amt->dev;
-	b->pub.epoch = ++amt->offload_epoch;
 	b->ops = p->ops;
-	INIT_LIST_HEAD(&b->groups);
-	INIT_LIST_HEAD(&b->endpoints);
+	mutex_lock(&amt->offload_st->mutex);
+	b->pub.epoch = ++amt->offload_epoch;
+	mutex_unlock(&amt->offload_st->mutex);
 
 	err = b->ops->bind(&b->pub, &b->caps);
 	if (err) {
@@ -4210,7 +5287,12 @@ static int amt_offload_bind(struct amt_dev *amt,
 	}
 
 	b->admitting = true;
+	mutex_lock(&amt->offload_st->mutex);
 	rcu_assign_pointer(amt->offload, b);
+	/* Replay desired state: every group is programmed afresh. */
+	amt_ofl_requeue_all(amt->offload_st);
+	mutex_unlock(&amt->offload_st->mutex);
+	amt_ofl_kick(amt->offload_st);
 	amt_offload_count(amt, AMT_OFFLOAD_CNT_BIND);
 	if (on_register)
 		amt_offload_count(amt, AMT_OFFLOAD_CNT_BIND_ON_REGISTER);
@@ -4225,7 +5307,7 @@ static void amt_offload_teardown(struct amt_dev *amt,
 				 enum amt_offload_counter cnt)
 {
 	struct amt_offload_bound *b = rtnl_dereference(amt->offload);
-	struct amt_offload_ref *ref, *tmp;
+	struct amt_offload_state *st = amt->offload_st;
 
 	if (!b)
 		return;
@@ -4234,21 +5316,14 @@ static void amt_offload_teardown(struct amt_dev *amt,
 	WRITE_ONCE(b->admitting, false);
 	synchronize_net();
 
-	/* 2. Programming work is cancelled here once the reconciler exists
-	 *    (next patch); nothing can program the provider past this point.
+	/* 2. Cancel programming: a reconciler tick holds st->mutex
+	 *    throughout, so taking it waits one out; a later tick finds
+	 *    admission stopped, then no binding, and programs nothing.
 	 */
+	mutex_lock(&st->mutex);
 
 	/* 3. Disable every group, then 4. delete every endpoint. */
-	list_for_each_entry_safe(ref, tmp, &b->groups, node) {
-		b->ops->group_disable(&b->pub, ref->handle);
-		list_del(&ref->node);
-		kfree(ref);
-	}
-	list_for_each_entry_safe(ref, tmp, &b->endpoints, node) {
-		b->ops->endpoint_del(&b->pub, ref->handle);
-		list_del(&ref->node);
-		kfree(ref);
-	}
+	amt_ofl_hw_release(st, b, true);
 
 	/* 5. Unbind, then 6. unpublish and let RCU readers drain. */
 	b->ops->unbind(&b->pub);
@@ -4256,8 +5331,10 @@ static void amt_offload_teardown(struct amt_dev *amt,
 	synchronize_rcu();
 	kfree(b);
 
-	/* 7. Software. */
+	/* 7. Software. Desired state stays for the next binding. */
 	amt->offload_epoch++;
+	mutex_unlock(&st->mutex);
+	amt_ofl_kick(st);
 	if (cnt < AMT_OFFLOAD_CNT_MAX) {
 		amt_offload_count(amt, cnt);
 		if (amt->offload_mode == AMT_OFFLOAD_MODE_REQUIRED) {
@@ -4275,7 +5352,9 @@ int amt_offload_register(struct net_device *lower,
 
 	ASSERT_RTNL();
 	if (!lower || !ops || !ops->bind || !ops->unbind ||
-	    !ops->group_disable || !ops->endpoint_del)
+	    !ops->endpoint_add || !ops->endpoint_del ||
+	    !ops->group_update || !ops->group_commit ||
+	    !ops->group_disable || !ops->flush)
 		return -EINVAL;
 	if (amt_offload_provider_find(lower))
 		return -EEXIST;
@@ -4338,6 +5417,9 @@ static int amt_offload_attach(struct amt_dev *amt,
 	INIT_LIST_HEAD(&amt->offload_node);
 	if (amt->mode != AMT_MODE_RELAY)
 		return 0;
+	if (amt->offload_mode != AMT_OFFLOAD_MODE_SOFTWARE &&
+	    !amt->offload_st && amt_ofl_state_alloc(amt))
+		return -ENOMEM;
 	list_add_tail(&amt->offload_node, &amt_offload_devs);
 	if (amt->offload_mode == AMT_OFFLOAD_MODE_SOFTWARE)
 		return 0;
@@ -4420,6 +5502,10 @@ AMT_OFFLOAD_CNT_ATTR(family_unsupported, AMT_OFFLOAD_CNT_FAMILY_UNSUPPORTED);
 AMT_OFFLOAD_CNT_ATTR(teardown_lower, AMT_OFFLOAD_CNT_TEARDOWN_LOWER);
 AMT_OFFLOAD_CNT_ATTR(teardown_provider, AMT_OFFLOAD_CNT_TEARDOWN_PROVIDER);
 AMT_OFFLOAD_CNT_ATTR(required_unbound, AMT_OFFLOAD_CNT_REQUIRED_UNBOUND);
+AMT_OFFLOAD_CNT_ATTR(sw_remainder, AMT_OFFLOAD_CNT_SW_REMAINDER);
+AMT_OFFLOAD_CNT_ATTR(resets, AMT_OFFLOAD_CNT_RESET);
+AMT_OFFLOAD_CNT_ATTR(stale_completions, AMT_OFFLOAD_CNT_STALE);
+AMT_OFFLOAD_CNT_ATTR(desync, AMT_OFFLOAD_CNT_DESYNC);
 
 static struct attribute *amt_offload_attrs[] = {
 	&dev_attr_offload_mode.attr,
@@ -4431,6 +5517,10 @@ static struct attribute *amt_offload_attrs[] = {
 	&dev_attr_offload_teardown_lower.attr,
 	&dev_attr_offload_teardown_provider.attr,
 	&dev_attr_offload_required_unbound.attr,
+	&dev_attr_offload_sw_remainder.attr,
+	&dev_attr_offload_resets.attr,
+	&dev_attr_offload_stale_completions.attr,
+	&dev_attr_offload_desync.attr,
 	NULL,
 };
 
diff --git a/include/net/amt.h b/include/net/amt.h
index 7d70f30e6..0c746e4be 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -312,6 +312,11 @@ struct amt_tunnel_list {
 	struct rcu_head		rcu;
 	/* This tunnel's entries in amt->groups_rhl, under lock */
 	struct list_head	groups;
+	/* Offload desired state: one amt_ofl_member per group this tunnel
+	 * is joined to, under amt_offload_state.lock. Empty unless the
+	 * relay's offload mode is auto or required.
+	 */
+	struct hlist_head	offload_members;
 };
 
 /* RFC 3810
@@ -380,6 +385,7 @@ struct amt_events {
 };
 
 struct amt_offload_bound;
+struct amt_offload_state;
 
 /* Per-relay offload counters, exported under offload/ in sysfs. */
 enum amt_offload_counter {
@@ -399,6 +405,19 @@ enum amt_offload_counter {
 	AMT_OFFLOAD_CNT_TEARDOWN_PROVIDER,
 	/* a required-mode relay lost its provider and dropped carrier */
 	AMT_OFFLOAD_CNT_REQUIRED_UNBOUND,
+	/* a group could not be programmed and is served by software */
+	AMT_OFFLOAD_CNT_SW_REMAINDER,
+	/* an op overran op_timeout_ms: flush and replay from desired state
+	 * (a release op while amt gives everything back: flush only)
+	 */
+	AMT_OFFLOAD_CNT_RESET,
+	/* an op result arrived under an older epoch and was ignored; a
+	 * programming, gone or GC op that overran counts here too, since its
+	 * reset moved the epoch (a release op's flush does not move it)
+	 */
+	AMT_OFFLOAD_CNT_STALE,
+	/* desired state lost an update (allocation failure); software only */
+	AMT_OFFLOAD_CNT_DESYNC,
 	AMT_OFFLOAD_CNT_MAX,
 };
 
@@ -508,16 +527,24 @@ struct amt_dev {
 	struct socket		*stream_sock_v6;
 	atomic_t		upstream_setsockopt_slow_count;
 
-	/* Replication offload (relay mode). Everything here is written
-	 * under RTNL; offload is also read by the data path under RCU.
-	 * offload_node links the relay into amt_offload_devs so a provider
-	 * registering on its stream_dev can find it.
+	/* Replication offload (relay mode). offload_mode is set at newlink.
+	 * offload is written under RTNL and offload_st's mutex, and read by
+	 * the data path under RCU. offload_epoch is written under
+	 * offload_st's mutex: at bind and teardown with RTNL held too, and
+	 * by the reconciler, without RTNL, when it resets the provider.
+	 * offload_node, under RTNL, links the relay into amt_offload_devs so
+	 * a provider registering on its stream_dev can find it. offload_cnt
+	 * is atomic and bumped from any context.
 	 */
 	u32			offload_mode;
 	struct amt_offload_bound __rcu *offload;
 	struct list_head	offload_node;
 	u64			offload_epoch;
 	atomic_t		offload_cnt[AMT_OFFLOAD_CNT_MAX];
+	/* Desired state and reconciler; allocated at newlink in auto and
+	 * required mode, freed at ndo_uninit once every tunnel is gone.
+	 */
+	struct amt_offload_state *offload_st;
 };
 
 #define AMT_TOS			0xc0
diff --git a/include/net/amt_offload.h b/include/net/amt_offload.h
index 3be5d129c..b5c119851 100644
--- a/include/net/amt_offload.h
+++ b/include/net/amt_offload.h
@@ -179,10 +179,17 @@ struct amt_offload_stats {
  *	been deleted or disabled. Free @b->priv. RTNL held.
  * @endpoint_add: program one gateway endpoint. Idempotent: an identical
  *	key returns the existing handle. 0 means accepted and durable, not yet
- *	forwarding. Process context, never under amt's spinlocks.
- * @endpoint_del: remove an endpoint no group references any more.
+ *	forwarding.
+ * @endpoint_del: remove an endpoint no committed group references any
+ *	more. amt only deletes endpoints once every group naming one has been
+ *	recommitted without it or disabled.
  * @group_update: stage the member set of one group under generation @gen,
- *	allocating *@grp on first use. Not forwarding until @group_commit.
+ *	allocating *@grp on first use (also on failure, if it allocated). On
+ *	any failure amt serves the group in software and disables *@grp if it
+ *	is set, a live group included. @members is valid only during the
+ *	call. Not forwarding until @group_commit. amt holds at most one group
+ *	per key per binding: a first use (*@grp NULL) never names a key whose
+ *	earlier group on this binding has not been disabled or flushed.
  * @group_commit: start forwarding generation @gen of @grp. amt hands @gen
  *	to @xmit only after this returns 0, and may never do so: an overrun
  *	resets the provider, and on TX a member leaving meanwhile withholds
@@ -190,9 +197,11 @@ struct amt_offload_stats {
  *	@grp carries an earlier generation this provider committed, and a call
  *	already in flight may carry any of those or @gen itself; the provider
  *	serves such a generation or declines it. A provider must never emit
- *	one packet to one endpoint under two generations. On failure the group
- *	stays in software and previously added endpoints stay valid.
- * @group_disable: stop forwarding @grp and free it.
+ *	one packet to one endpoint under two generations. On failure amt
+ *	disables the group and serves it in software; previously added
+ *	endpoints stay valid, since they may serve other groups.
+ * @group_disable: stop forwarding @grp and free it. amt has already
+ *	stopped submitting packets for @grp and waited out @xmit callers.
  * @xmit: TX path. Replicate @skb for @grp under @gen or decline; see
  *	&enum amt_offload_result. Softirq context, under rcu_read_lock().
  * @flush: drop every endpoint and group (reset after a timeout). amt then
@@ -237,15 +246,64 @@ struct amt_offload_ops {
 		      struct amt_offload_stats *st);
 };
 
+/*
+ * Completion semantics. Every programming op (@endpoint_add,
+ * @endpoint_del, @group_update, @group_commit, @group_disable, @flush) is
+ * synchronous: amt calls it in process context, never under amt's
+ * spinlocks -- from one reconciler per relay, or with RTNL held when the
+ * binding is torn down -- so a provider may sleep in it but must not
+ * take RTNL. Return 0 means accepted and
+ * durable in the provider's tables. Nothing forwards before @group_commit
+ * returns 0. @xmit is only passed a generation for which @group_commit on
+ * that group returned 0, which can lag the one committed last (see
+ * @group_commit).
+ *
+ * An op that takes longer than &amt_offload_caps.op_timeout_ms (0: no
+ * limit) marks the provider wedged: amt stops submitting packets, calls
+ * @flush, forgets every handle, bumps &amt_offload_binding.epoch and
+ * replays every group from its own desired state. The exception is amt
+ * giving every object back (teardown, or desired state lost): there an
+ * overrunning @group_disable or @endpoint_del ends it with @flush, and the
+ * remaining handles are forgotten, with no new epoch and no replay. A
+ * result returned under an older epoch is ignored. After @flush the
+ * provider holds nothing for this binding; amt never passes it an older
+ * handle again.
+ *
+ * Cancellation is the teardown order on &struct amt_offload_ops. A
+ * reconciler pass running when a teardown starts finishes the op it is in
+ * and then makes no further @endpoint_add, @group_update, @group_commit or
+ * @endpoint_del, except that it may still call @flush (after an overrun),
+ * @group_disable (for a group it parks or found emptied) and, on a pass
+ * giving every object back once desired state is lost, the remaining
+ * @group_disable and @endpoint_del calls of that release.
+ *
+ * The reconciler starts no new group once a pass has spent the amt module
+ * parameter offload_op_budget (default 1000, an estimate) ops, and never
+ * splits a group's ops across passes, so a pass can overrun the budget by
+ * one group's ops. If the budget left no room for one, a pass still makes
+ * one @endpoint_del, so endpoint collection is never starved. The pass
+ * that gives every object back once desired state is lost is not
+ * budgeted. A group the provider refuses (-ENOSPC or any other error) is
+ * served by software and retried once the provider holds an eighth fewer
+ * objects than when it refused, after a reset, or on a new binding.
+ */
+
 /**
  * amt_offload_register - offer a provider for relays on @lower
  * @lower: the netdev the relays transmit on.
  * @ops: provider callbacks; must outlive the registration.
  *
  * Every relay already using @lower in auto or required mode tries to bind
- * now. Caller holds RTNL.
+ * now. Caller holds RTNL. Every op but @stats and @xmit is required.
+ * Whether a provider offers %AMT_OFFLOAD_PATH_TX shows only in the caps
+ * @bind fills, so @xmit is not checked here. Without it, once @bind
+ * succeeds and the caps cover the relay's outer family, amt treats TX as
+ * not offered: a relay in required mode whose caps offer
+ * %AMT_OFFLOAD_PATH_INGRESS binds on the ingress path, and any other
+ * relay stays unbound (counted as path_unsupported).
  *
- * Return: 0, -EEXIST if @lower already has a provider, or -ENOMEM.
+ * Return: 0, -EINVAL if a required op is missing, -EEXIST if @lower
+ * already has a provider, or -ENOMEM.
  */
 int amt_offload_register(struct net_device *lower,
 			 const struct amt_offload_ops *ops);
-- 
2.43.0

