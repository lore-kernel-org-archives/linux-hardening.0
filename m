Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794077092;
	b=gA6H7+9uhO4HaCNO4hMM0WliXGV+8tihlHeqO3yaeOgXPB+cnV07RwMF0tFkDnaTQx9R
	 YZDVu17Q7RN0Mbw96REjLw21fGOtp9mwDbXR/uD7ujmET5PVWyeyXRiIn/0QvBabiuuDG
	 VHVcnHcb+qYn/qdYHgN1WEaOZNKGQs7wQx+CX3fxJQVbu1wNqdug8WeLA/FtRee+eJEsM
	 0A/Yi+LWctHxlZ2ftWBe3gwN04pCqwjkq2xbJV3MeK8WXj+qU6fUgRZuwLQACg8oaFALx
	 qBREkVf3m3WSr+6pqf2ECUFXqBA/kmcf61RE0VC34rq1af2CEWyG92pjgwCoPXBJ4Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=034iry7WHQ0bPsFgpNeABa63Awxx8ExkIQs+SzxKml4=;
	b=I8235Nm4rjVLIXR2+sLFYsHpT4s2H1AhqNCA8TKWIy30FvOCyoyXdvN7nt5BWfTFf6B8
	 nDXKw9ccMoIGo+BcS6wLO//Uo2HBGLcz/osP9xhd1atD1o2HCDOTpKSAsiUHz9MNKukAK
	 zR18blo7rSDgKdjLLfYUteNeTVxCdEcAULD/GNeWUqZavhM1uP9gIV69NXspq4n0qfGNv
	 nJLG/5o5eF+zBrE8a2YSEISXyvGLK6xJvrUq1qCP55JxTOcasSSELXque/jjpomiODGQw
	 5ELFM4CteT0YxJeUUMOjdSXSoALrICdDnyRnbunpSGk9AjK+UFHqCOEx35k0DEr2+JA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=OLKKdnPP;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDEB606D814
	for <linux-hardening@vger.kernel.org>; Sat,  7 Nov 2026 18:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CDEB606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=OLKKdnPP
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-19305bcb72cso1621233c88.1
        for <linux-hardening@vger.kernel.org>; Sat, 07 Nov 2026 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794077091; x=1794681891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=034iry7WHQ0bPsFgpNeABa63Awxx8ExkIQs+SzxKml4=;
        b=OLKKdnPPeCkqRJohePg2wlWvHtfEJvAy6t9YTLjpy2nxczCcKuEQNt940aFRvo0L7l
         npmPS+Rk+990B5IGIO/jn9YCp88tzli4tnH+oKx26MUf5tUnrq79/nu8FO1H5wHfnh4S
         gnrmEK3JdJsICq2roHCAuB3icGOSh9uPzYlH2fHEYGZ3ufYsFhoa8fgP33jt1stFs7r4
         dpVkxG3xA/Vev+tqUG0n0SmdvcYKq7wlJgZrkWqXPRXh0RYEsv6yCwIeA2o6Y1XeTlSS
         TW2Tt9Z3Nhes/ONBd0rIaodHuJn9KOlEShhwwb7GU5XbrULjp1H4mXlfIglamdcMrYO4
         H/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077091; x=1794681891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=034iry7WHQ0bPsFgpNeABa63Awxx8ExkIQs+SzxKml4=;
        b=Tftah9HQ0lQF4BtOAHpPkOVrckpb+CFH9fDw5Qvf3upT6CJuTW0kzigH9d/SmytmkN
         ukbrFzjJbq0BczCLh/H6N5QerXMnE6DDQ8SijQF5Agd7h82k6cWAJy9S23zrCS5a9UV2
         ThU2oEpgNxw47D5RY+QQNxC9EjoQvfczPReXdGEBiea34DyQ2pqxWpcRpC3wrJ6NxTB2
         qcTulFgHHHIFWfWw5gAvEK0BftMerDf4fVZrkBmk/g7V2xxCIBuBX7vRsDNNdIWIUZVc
         OVVQvGBei4x0bgKdS8b8My/wSSbmmMORQ4VwFlFJSd7rYzVr1FqBAO75t/eC5oqhglMg
         QA+w==
X-Forwarded-Encrypted: i=1; AKwUvBwRElECW1iPjIkM3QxZv/if7AbpntLFrI7rZb9qm4jO5ogqKpS9awOgdseMWn3Mw71pYimJXKiLqgRoGNlYWBk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8aJdGScFrVhn9SjNVxt+XQqZSYi8BAmP0TJM2K+9041+bu1nMg
	jqvPGcjH2pVJOrw6v77noSMD4sedxw+W4WidgkhWiZsd73CD6QmOSlDOTUnd/M11kQY=
X-Gm-Gg: AYBFou0hRAd0pUw1XTKglCkjgaM++PKE3lgc4V/VDKMTD/0K42V9AOPKAU+8Ozo1BPP
	gRcF5O1i93YxebsyeQEXdXITypsRcHp66gyibaHxK0Ahth4hbacrJ1RiMMr8jD8XOIEe+6reOHU
	ql/0fkRmR0OZ/pTnjJAh74vXZDgAAFHZ1+WdstLnlmCooDFFmVfphWzFtlGFcAUxHHL2xgQkU5e
	p7oB+6zChQqRrpcwFS/3t9txLt3p6uoBJqMWretMS43Q76tMU2PSO1slodMxAyKMo70NCNwz/SV
	A9FuEz6/piaUgFwlzKaafopdmnjA9TsFCnBth9ggRYXMAS9DHHjWBNKU1GgnimPEnSxOCOyNTUz
	zS20MjepxvzBexpClav3LOwWn/fupTOfQcjJRAxhnP1UNIgUtB62HF1jb8ryaqb8RHe/nC8KnX0
	yB5qbTigsxLoMSuKIcuqkSgr53sJUNtXUEyJNi+7eSFFCjAUqZpsWx4inXzj6008Q0ku/i6qXsv
	hxC1y5Q/3ITogb8iljQnOwmYoDIjO0h8HVPsTWByl5ZO4yR2gXfkMIaZRP6GWBqdkekDXxYRM9O
	LsyEMtNqVjcIhVRARxfXoIaLgLh5qCkPcIBNukCp7qWHYfYNK58saQKFEwqB/nqAJ2qjyZ0=
X-Received: by 2002:a05:7022:b04b:10b0:196:bf5f:8bb with SMTP id a92af1059eb24-1b25d34a675mr8380119c88.45.1794077090265;
        Sat, 07 Nov 2026 10:44:50 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 10:44:49 -0800 (PST)
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
Subject: [RFC PATCH net-next 4/9] amt: offload TX handoff, ingress punt rule and counters
Date: Sat,  7 Nov 2026 18:44:32 +0000
Message-ID: <20261107184437.2783174-5-omar@blockcast.net>
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

On a TX binding, amt_dev_xmit hands each relay data packet of a group
the reconciler has published (hw_active, set with hw_gen after a
successful group_commit) to the provider before its software fan-out,
while the binding admits packets and desired state is in sync; every
other packet goes to software. Exactly one actor handles each packet
handed over: CONSUMED means the provider handled every copy (sent it, or
dropped it and counted it, apart from the copy and route failures
amt_offload_encap_xmit() counts itself) and owns the skb; FALLBACK
leaves the skb untouched for the software loop; BUSY runs one
synchronous software pass and counts it, never NETDEV_TX_BUSY since the
relay is IFF_NO_QUEUE. hw_gen is read once per packet. The reconciler
writes it after a successful group_commit, also when it then withholds
hw_active because a member left meanwhile, so a packet already past the
hw_active test can carry the new generation and one that read hw_gen
earlier any older committed one; the provider serves or declines it.

On the ingress path the provider replicates every packet of a group from
group_commit until group_disable or flush, and must never also punt one.
While the group's commit is published (hw_active, with the binding
admitting and desired state in sync), a punted copy that reaches the
relay is dropped and counted; at any other time (before the first
publication, after a park, during a reset or a teardown, after desync)
it goes to the software fan-out. The provider sees none of these
transitions as amt makes them, so the drop is only a safety net.
Removing a member on an ingress binding does not withdraw the group as
it does on TX: hardware replicates to the committed set until the
recommit regardless, and lifting the drop would send the remaining
members every punted packet a second time. For the same reason the
reconciler publishes a commit on an ingress binding even when a member
left while it was programmed. A relay binds on ingress only in required
mode: a packet the provider consumes on ingress never reaches the host,
so nothing on the host's forwarding path, mroute counters included, sees
it, and auto does not choose that. A provider offering no path the relay
may use leaves it unbound, counted. TX needs ops->xmit.

New offload/ counters: path_unsupported, busy_fallback, punt_dropped
(plus sw_remainder, resets, stale_completions and desync from the
reconciler). With no provider bound the data path does one more RCU
pointer read and test.

A simulated replication provider -- netdevsim is the reference one --
decides from its own tables which gateways get a copy of a relay data
packet, but has no business re-implementing AMT encapsulation: if its
copies differed on the wire from amt's own, a test could not tell a
provider bug from an encapsulation difference.

amt_offload_encap_xmit(binding, endpoint key, skb), exported, emits one
gateway's copy byte for byte as the software fan-out does: the copy, AMT
Multicast Data header and amt_udp_xmit() of amt_send_multicast_data(),
from the relay port to the gateway's port with AMT_TOS on an IPv4 outer
and the route's hop limit. Each failed copy or route lookup counts once
in tx_dropped; the software fan-out on this base counts neither. It
takes the endpoint key, not the provider's handle, which is opaque to
amt, and is for use from ops->xmit only.

With no provider registered nothing calls it.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c         | 206 +++++++++++++++++++++++++++++++++++---
 include/net/amt.h         |  13 ++-
 include/net/amt_offload.h |  38 ++++++-
 3 files changed, 237 insertions(+), 20 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 17337989a..377660e55 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -319,6 +319,8 @@ static void amt_ofl_member_del(struct amt_dev *amt,
 static void amt_ofl_tunnel_gone(struct amt_dev *amt,
 				struct amt_tunnel_list *tunnel);
 static void amt_ofl_state_free(struct amt_dev *amt);
+static bool amt_offload_tx(struct amt_dev *amt, struct sk_buff *skb,
+			   const union amt_addr *group, bool v6);
 
 static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 {
@@ -1510,6 +1512,11 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (!data)
 			goto free;
+		/* A bound offload provider replicates it, or declines; see
+		 * amt_offload_tx() for the cutover rules.
+		 */
+		if (amt_offload_tx(amt, skb, &group, v6))
+			return NETDEV_TX_OK;
 		key.group_addr = group;
 		key.v6 = v6;
 		list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
@@ -4087,6 +4094,7 @@ struct amt_offload_bound {
 	struct amt_offload_binding	pub;
 	const struct amt_offload_ops	*ops;
 	struct amt_offload_caps		caps;
+	enum amt_offload_path		path;
 	/* Cleared first on teardown; ops->xmit is only called while set. */
 	bool				admitting;
 };
@@ -4209,6 +4217,10 @@ struct amt_offload_state {
 	struct list_head		parked;
 	struct list_head		ep_gc;
 	bool				desync;
+	/* The binding is on the ingress path: a member change must not
+	 * clear hw_active, which there gates the punt-drop. Set at bind.
+	 */
+	bool				ingress;
 	/* Reconciler. bind and teardown also take the mutex. */
 	struct mutex			mutex;
 	struct work_struct		work;
@@ -4286,9 +4298,9 @@ static u32 amt_offload_outer_family(const struct amt_dev *amt)
 }
 
 /* The data path's way in: a binding is usable only while admitting. The
- * caller holds rcu_read_lock(). The later TX handoff is its first caller.
+ * caller holds rcu_read_lock().
  */
-static __maybe_unused struct amt_offload_bound *
+static struct amt_offload_bound *
 amt_offload_tx_admit(struct amt_dev *amt)
 {
 	struct amt_offload_bound *b = rcu_dereference(amt->offload);
@@ -4402,13 +4414,15 @@ static void amt_ofl_kick(struct amt_offload_state *st)
 }
 
 /* Desired state could not record a change. Hardware would forward to a
- * stale member set, so the relay leaves offload for good: the data path
- * stops consulting the provider, and the next reconciler pass gives every
- * provider object back (group_disable, endpoint_del; the binding stays,
- * with no unbind). Desync does not schedule that pass: a pass already
- * queued or a later removal of a recorded member (by a leave, a timer or
- * a tunnel removal) does, and a teardown gives everything back itself
- * and unbinds. Caller holds st->lock.
+ * stale member set, so the relay leaves offload for good. On TX that
+ * takes effect at once: the data path stops handing packets to the
+ * provider. The next reconciler pass gives every provider object back
+ * (group_disable, endpoint_del; the binding stays, with no unbind).
+ * Desync does not schedule that pass: a pass already queued or a later
+ * removal of a recorded member (by a leave, a timer or a tunnel removal)
+ * does, and a teardown gives everything back itself and unbinds. On an
+ * ingress binding the provider replicates to its committed sets until
+ * then. Caller holds st->lock.
  */
 static void amt_ofl_desync(struct amt_offload_state *st)
 {
@@ -4562,12 +4576,16 @@ static void amt_ofl_member_unlink(struct amt_offload_state *st,
 	g->nr_members--;
 	g->gen++;
 	g->left++;
-	/* The committed member set still names this endpoint: stop handing
-	 * the group to hardware now, not when the reconciler recommits, so
-	 * no packet admitted after this is replicated to it. Software serves
-	 * the group meanwhile.
+	/* TX: the committed member set still names this endpoint. Stop
+	 * handing the group to hardware now, not when the reconciler
+	 * recommits, so no packet admitted after this is replicated to it;
+	 * software serves the group meanwhile. Ingress: hardware replicates
+	 * on its own until the recommit whatever the host does, and
+	 * hw_active there only drops the punted copies, so clearing it
+	 * would send the remaining members every packet twice.
 	 */
-	WRITE_ONCE(g->hw_active, false);
+	if (!READ_ONCE(st->ingress))
+		WRITE_ONCE(g->hw_active, false);
 	amt_ofl_grp_dirty(st, g);
 	ep->refs--;
 	amt_ofl_ep_unused(st, ep);
@@ -4966,7 +4984,10 @@ static unsigned int amt_ofl_grp_program(struct amt_offload_state *st,
 	 * committed, and amt_ofl_member_unlink() already withdrew the group.
 	 * A join meanwhile does not hold the publication back: the committed
 	 * set is a subset that names no departed endpoint. Either change
-	 * re-queued @g; the next pass commits it.
+	 * re-queued @g; the next pass commits it. On ingress, hardware is
+	 * already replicating to the committed set whatever the host does,
+	 * and hw_active only drops the punted copies, so withholding it there
+	 * protects no one and sends the remaining members every packet twice.
 	 */
 	spin_lock_bh(&st->lock);
 	for (i = 0; i < n; i++)
@@ -4978,7 +4999,7 @@ static unsigned int amt_ofl_grp_program(struct amt_offload_state *st,
 	swap(g->ceps, eps);	/* out: frees the old set */
 	g->nr_ceps = n;
 	WRITE_ONCE(g->hw_gen, gen);
-	if (g->left == left)
+	if (READ_ONCE(st->ingress) || g->left == left)
 		smp_store_release(&g->hw_active, true);
 	spin_unlock_bh(&st->lock);
 	goto out;
@@ -5238,6 +5259,135 @@ static void amt_ofl_state_free(struct amt_dev *amt)
 	amt->offload_st = NULL;
 }
 
+/* Cutover, per packet; exactly one actor handles each one.
+ *
+ *   relay data packet (inner IP; Ethernet pulled)
+ *    |
+ *    +-- bound, admitting, desired state in sync, and (family, group)
+ *    |   hw_active?  no --> software fan-out
+ *    |
+ *    +-- TX path: ops->xmit(grp, hw_gen)
+ *    |     CONSUMED --> the provider handled every copy and owns the skb
+ *    |     FALLBACK --> skb untouched --> software fan-out
+ *    |     BUSY     --> skb untouched --> software fan-out, counted
+ *    |                  (never NETDEV_TX_BUSY: the relay is IFF_NO_QUEUE)
+ *    |
+ *    +-- ingress path: a punted copy of an hw_active group reaching here
+ *          is dropped and counted; one that took the "no" branch is
+ *          forwarded in software. A provider cannot tell which (amt
+ *          publishes after group_commit returns, and withdraws before
+ *          the callback on a reset, park or teardown and with no
+ *          callback on desync), so it must never punt a packet it
+ *          replicates.
+ *
+ * hw_gen is read once per packet. The reconciler writes it after
+ * group_commit returns 0, before it publishes hw_active, and also when a
+ * member left meanwhile and it withholds hw_active. So a packet already
+ * past the hw_active test may carry that new generation, and one that
+ * read hw_gen earlier any older committed one; the provider serves or
+ * declines it.
+ *
+ * Returns true when the skb is gone (consumed, or a punted copy dropped);
+ * false sends it to the software fan-out untouched.
+ */
+static bool amt_offload_tx(struct amt_dev *amt, struct sk_buff *skb,
+			   const union amt_addr *group, bool v6)
+{
+	struct amt_offload_group_key key;
+	enum amt_offload_result res;
+	struct amt_offload_bound *b;
+	struct amt_ofl_grp *g;
+	bool gone = false;
+
+	rcu_read_lock();
+	b = amt_offload_tx_admit(amt);
+	if (!b || READ_ONCE(amt->offload_st->desync))
+		goto out;
+	amt_ofl_grp_key(&key, group, v6);
+	g = amt_ofl_grp_find(amt->offload_st, &key);
+	/* Pairs with the release in amt_ofl_grp_program(). */
+	if (!g || !smp_load_acquire(&g->hw_active))
+		goto out;
+
+	if (b->path == AMT_OFFLOAD_PATH_INGRESS) {
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_PUNT_DROPPED);
+		consume_skb(skb);
+		gone = true;
+		goto out;
+	}
+
+	res = b->ops->xmit(&b->pub, g->hw, skb, READ_ONCE(g->hw_gen));
+	switch (res) {
+	case AMT_OFFLOAD_CONSUMED:
+		gone = true;
+		break;
+	case AMT_OFFLOAD_BUSY:
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_BUSY_FALLBACK);
+		break;
+	case AMT_OFFLOAD_FALLBACK:
+		break;
+	default:
+		WARN_ONCE(1, "amt: offload xmit returned %d\n", res);
+		break;
+	}
+out:
+	rcu_read_unlock();
+	return gone;
+}
+
+/* One gateway's copy for a simulated provider, built and sent exactly
+ * as amt_send_multicast_data() builds and sends a software copy: the
+ * same copy, AMT Multicast Data header, UDP ports, TOS and hop limit,
+ * through amt_udp_xmit(). Called from ops->xmit, in softirq context
+ * under rcu_read_lock().
+ */
+int amt_offload_encap_xmit(struct amt_offload_binding *b,
+			   const struct amt_offload_endpoint_key *key,
+			   struct sk_buff *oskb)
+{
+	struct amt_dev *amt = netdev_priv(b->dev);
+	struct amt_header_mcast_data *amtmd;
+	bool v6 = ip_hdr(oskb)->version == 6;
+	union amt_addr daddr = {0,};
+	struct socket *sock;
+	struct sk_buff *skb;
+
+	sock = rcu_dereference_bh(amt->sock);
+	if (!sock)
+		return -ENETDOWN;
+	if (key->family != (amt_v6(amt) ? AF_INET6 : AF_INET))
+		return -EAFNOSUPPORT;
+
+	skb = skb_copy_expand(oskb, sizeof(*amtmd) + amt_ip_hlen(amt) +
+			      sizeof(struct udphdr), 0, GFP_ATOMIC);
+	if (!skb)
+		goto drop;
+
+	skb_reset_inner_headers(skb);
+	amtmd = skb_push(skb, sizeof(*amtmd));
+	amtmd->version = 0;
+	amtmd->reserved = 0;
+	amtmd->type = AMT_MSG_MULTICAST_DATA;
+	skb_set_inner_protocol(skb, htons(v6 ? ETH_P_IPV6 : ETH_P_IP));
+
+#if IS_ENABLED(CONFIG_IPV6)
+	if (key->family == AF_INET6)
+		daddr.ip6 = key->addr.ip6;
+	else
+#endif
+		daddr.ip4 = key->addr.ip4;
+	if (amt_udp_xmit(amt, sock->sk, skb, &daddr, amt->relay_port,
+			 key->port, 0))
+		goto free;
+	return 0;
+free:
+	kfree_skb(skb);
+drop:
+	DEV_STATS_INC(amt->dev, tx_dropped);
+	return -ENETUNREACH;
+}
+EXPORT_SYMBOL_GPL(amt_offload_encap_xmit);
+
 static void amt_offload_set_carrier(struct amt_dev *amt, bool on)
 {
 	if (amt->offload_mode != AMT_OFFLOAD_MODE_REQUIRED)
@@ -5285,9 +5435,27 @@ static int amt_offload_bind(struct amt_dev *amt,
 		kfree(b);
 		return -EOPNOTSUPP;
 	}
+	/* TX when offered. Ingress only for a required relay: a packet
+	 * consumed on ingress never reaches the host, so nothing on its
+	 * forwarding path sees it, and auto never chooses that.
+	 */
+	if ((b->caps.paths & BIT(AMT_OFFLOAD_PATH_TX)) && b->ops->xmit) {
+		b->path = AMT_OFFLOAD_PATH_TX;
+	} else if ((b->caps.paths & BIT(AMT_OFFLOAD_PATH_INGRESS)) &&
+		   amt->offload_mode == AMT_OFFLOAD_MODE_REQUIRED) {
+		b->path = AMT_OFFLOAD_PATH_INGRESS;
+	} else {
+		b->ops->unbind(&b->pub);
+		amt_offload_count(amt, AMT_OFFLOAD_CNT_PATH_UNSUPPORTED);
+		kfree(b);
+		return -EOPNOTSUPP;
+	}
 
 	b->admitting = true;
 	mutex_lock(&amt->offload_st->mutex);
+	/* Before any group can hold hw under this binding. */
+	WRITE_ONCE(amt->offload_st->ingress,
+		   b->path == AMT_OFFLOAD_PATH_INGRESS);
 	rcu_assign_pointer(amt->offload, b);
 	/* Replay desired state: every group is programmed afresh. */
 	amt_ofl_requeue_all(amt->offload_st);
@@ -5506,6 +5674,9 @@ AMT_OFFLOAD_CNT_ATTR(sw_remainder, AMT_OFFLOAD_CNT_SW_REMAINDER);
 AMT_OFFLOAD_CNT_ATTR(resets, AMT_OFFLOAD_CNT_RESET);
 AMT_OFFLOAD_CNT_ATTR(stale_completions, AMT_OFFLOAD_CNT_STALE);
 AMT_OFFLOAD_CNT_ATTR(desync, AMT_OFFLOAD_CNT_DESYNC);
+AMT_OFFLOAD_CNT_ATTR(path_unsupported, AMT_OFFLOAD_CNT_PATH_UNSUPPORTED);
+AMT_OFFLOAD_CNT_ATTR(busy_fallback, AMT_OFFLOAD_CNT_BUSY_FALLBACK);
+AMT_OFFLOAD_CNT_ATTR(punt_dropped, AMT_OFFLOAD_CNT_PUNT_DROPPED);
 
 static struct attribute *amt_offload_attrs[] = {
 	&dev_attr_offload_mode.attr,
@@ -5521,6 +5692,9 @@ static struct attribute *amt_offload_attrs[] = {
 	&dev_attr_offload_resets.attr,
 	&dev_attr_offload_stale_completions.attr,
 	&dev_attr_offload_desync.attr,
+	&dev_attr_offload_path_unsupported.attr,
+	&dev_attr_offload_busy_fallback.attr,
+	&dev_attr_offload_punt_dropped.attr,
 	NULL,
 };
 
diff --git a/include/net/amt.h b/include/net/amt.h
index 0c746e4be..0b57c8604 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -389,7 +389,9 @@ struct amt_offload_state;
 
 /* Per-relay offload counters, exported under offload/ in sysfs. */
 enum amt_offload_counter {
-	/* bind() succeeded and the caps covered the outer family */
+	/* bind() succeeded, and the caps covered the outer family and offered
+	 * a data path this relay may use
+	 */
 	AMT_OFFLOAD_CNT_BIND,
 	/* ... of which: bound when a provider registered on the stream_dev
 	 * this relay already uses
@@ -418,6 +420,15 @@ enum amt_offload_counter {
 	AMT_OFFLOAD_CNT_STALE,
 	/* desired state lost an update (allocation failure); software only */
 	AMT_OFFLOAD_CNT_DESYNC,
+	/* no data path this relay may use: the caps offered none, or TX
+	 * without ops->xmit (ingress counts only in required mode); it stayed
+	 * unbound
+	 */
+	AMT_OFFLOAD_CNT_PATH_UNSUPPORTED,
+	/* xmit returned BUSY: one synchronous software pass ran instead */
+	AMT_OFFLOAD_CNT_BUSY_FALLBACK,
+	/* ingress: a punted copy of a group the provider replicates, dropped */
+	AMT_OFFLOAD_CNT_PUNT_DROPPED,
 	AMT_OFFLOAD_CNT_MAX,
 };
 
diff --git a/include/net/amt_offload.h b/include/net/amt_offload.h
index b5c119851..99f78699f 100644
--- a/include/net/amt_offload.h
+++ b/include/net/amt_offload.h
@@ -42,8 +42,16 @@ struct sk_buff;
  *	group without a callback when a member leaves, until it publishes the
  *	recommit. Every other packet goes straight to software.
  * @AMT_OFFLOAD_PATH_INGRESS: the provider replicates on ingress and the
- *	host only sees punted packets. Semantics only until a real provider
- *	exists; no simulated provider implements it.
+ *	host only sees punted packets. From &amt_offload_ops.group_commit
+ *	until &amt_offload_ops.group_disable or &amt_offload_ops.flush the
+ *	provider replicates every packet of the group, and it must never also
+ *	punt one. amt drops, and counts, a punted copy of a group only while
+ *	the group's commit is published: from some time after group_commit
+ *	returns until amt withdraws it, which it does before any group_disable
+ *	or flush and, with no callback, once its desired state is lost. A
+ *	punted copy outside that window is forwarded in software as well.
+ *	Semantics only until a real provider exists; no simulated provider
+ *	implements it, and only a relay in required mode binds on it.
  */
 enum amt_offload_path {
 	AMT_OFFLOAD_PATH_TX,
@@ -203,7 +211,12 @@ struct amt_offload_stats {
  * @group_disable: stop forwarding @grp and free it. amt has already
  *	stopped submitting packets for @grp and waited out @xmit callers.
  * @xmit: TX path. Replicate @skb for @grp under @gen or decline; see
- *	&enum amt_offload_result. Softirq context, under rcu_read_lock().
+ *	&enum amt_offload_result. @skb is the relay data packet with its
+ *	data at the inner IP header. On %AMT_OFFLOAD_CONSUMED the provider
+ *	owns @skb and must have handled every copy under @gen alone: each one
+ *	handed to the stack, or dropped and counted (see
+ *	%AMT_OFFLOAD_CONSUMED). Otherwise it must not have sent any copy, nor
+ *	modified or freed @skb. Softirq context, under rcu_read_lock().
  * @flush: drop every endpoint and group (reset after a timeout). amt then
  *	replays from its own desired state under a new epoch, except when
  *	the op that overran was a @group_disable or @endpoint_del of amt
@@ -318,4 +331,23 @@ int amt_offload_register(struct net_device *lower,
  */
 void amt_offload_unregister(struct net_device *lower);
 
+/**
+ * amt_offload_encap_xmit - emit one gateway's copy of a relay data packet
+ * @b: the binding @skb was handed to the provider under.
+ * @key: the gateway endpoint, as amt passed it to endpoint_add.
+ * @skb: the packet given to &amt_offload_ops.xmit; not consumed.
+ *
+ * For simulated providers: encapsulates a copy of @skb as AMT Multicast
+ * Data to @key and transmits it on the relay's stream device, byte for
+ * byte as amt's own software fan-out would. Which endpoints get a copy
+ * is the provider's decision, made from its own tables. Call only from
+ * &amt_offload_ops.xmit.
+ *
+ * Return: 0 if the copy was handed to the stack, else a negative errno
+ * (counted in the relay's tx_dropped when the copy or route failed).
+ */
+int amt_offload_encap_xmit(struct amt_offload_binding *b,
+			   const struct amt_offload_endpoint_key *key,
+			   struct sk_buff *skb);
+
 #endif /* _NET_AMT_OFFLOAD_H_ */
-- 
2.43.0

