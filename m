Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE53C140F;
	Mon, 10 Aug 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361043; cv=none; b=Nq/mrKHryqOY7FuZqLnT1614qWkAriHJV0QvVwuQydldxUxOKYW2cJ1E8c0Dx848ccDFsSkO+3vLFotep1mxwic9ok6/R6mlt+138wPtEjhU/3YLuPstteZCN39IByWOs4h1HQqzZzt43hMJwesdjHfIdsuhJwVL5YQ3WlR7/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361043; c=relaxed/simple;
	bh=rycCXlUKCDi8Gea4CfPFop5WlCBJGIojPTXqWUnWStw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eNKEc5MRnlBiHE9oNoPN8u2zEUsi7iVxzGAInGa4Zh3i9WL0qNslHBPywgmVjKxPOEoy68QUwXxWCA+mMHYPmP6BMiDs+lZ4xMZ+xE5hgeQHXa8IFz35Bchq+ixdSR74LrsCJBIIhuI/uW2sagDVX6RLAjsJq4dwpIgq87Tqgnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xMlRL72z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xMlRL72z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786361044; x=1817897044;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rycCXlUKCDi8Gea4CfPFop5WlCBJGIojPTXqWUnWStw=;
  b=xMlRL72z2DQN1gifIVBc1LMiFVHkDYCZEm3MBTLv5Vtxy6rwOPtBnzqM
   GIvCrceOCmsK0cwZM+V2uk/YPOXTHSCU1lrqfzEx45vIuhVgMghOBnqKO
   nbLY3Yedr6JywDuUYISOjn94jUA+mAU7OxEF4/3PQvFN54zLj6C+9LRK+
   cqmyWM6YNvN4b1267WYI7r2uqxFwW0YwIDfw5yPRwEtiu8jS1lqg9cICY
   nXxl76mPuAvagjgQX8m4HS50nAkQyR4ml8fAzwrYpdMzPf3K6N+aDSRK+
   aBP0emENNK1sF0C6FvBilhNGo7TWeUr10qTOCktipMvmDOumff9eXTamo
   w==;
X-CSE-ConnectionGUID: 7KhVYZE2RhyhPpw6FST1Gw==
X-CSE-MsgGUID: s7qVtqSCQ7WjOq1LPt7efw==
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="61006992"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 04:24:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 10 Aug 2026 04:23:59 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 10 Aug 2026 04:23:56 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 10 Aug 2026 13:20:54 +0200
Subject: [PATCH net-next v2 9/9] net: sparx5: add neighbour event handling
 for L3 routing
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260810-sparx5_l3_routing-v2-9-59e68cc8c8ca@microchip.com>
References: <20260810-sparx5_l3_routing-v2-0-59e68cc8c8ca@microchip.com>
In-Reply-To: <20260810-sparx5_l3_routing-v2-0-59e68cc8c8ca@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

Register a netevent notifier to handle NETEVENT_NEIGH_UPDATE events,
completing the L3 unicast forwarding data path:

- When ARP/NDP resolves a neighbour, update the hardware ARP table entry
  with the resolved MAC address and notify all linked nexthops to
  refresh their ECMP forwarding state.

- When a neighbour becomes unreachable, tear down the hardware ARP entry
  and mark linked nexthops as unresolved so traffic traps to the CPU.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v2:
- Add a netns (net_eq) guard to the netevent handler.
---
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 122 ++++++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
index 6d40d651180e..5f6add84b0d6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
@@ -1647,6 +1647,17 @@ static void sparx5_rr_nexthop_neigh_update(struct sparx5 *sparx5,
 	sparx5_rr_arp_tbl_hw_addr_apply(sparx5, mac, vmid, grp_idx + nh_offset);
 }
 
+static void
+sparx5_rr_nexthops_update_notify(struct sparx5 *sparx5,
+				 struct sparx5_rr_neigh_entry *neigh_entry,
+				 bool entry_connected)
+{
+	struct sparx5_rr_nexthop *nh;
+
+	list_for_each_entry(nh, &neigh_entry->nexthop_list, neigh_list_node)
+		sparx5_rr_nexthop_neigh_update(sparx5, nh, entry_connected);
+}
+
 static int sparx5_rr_neigh_entry_hw_apply(struct sparx5 *sparx5,
 					  struct sparx5_rr_neigh_entry *entry)
 {
@@ -2419,6 +2430,107 @@ static int sparx5_rr_fib_event(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_BAD;
 }
 
+static void sparx5_rr_neigh_event_work(struct work_struct *work)
+{
+	struct sparx5_rr_netevent_work *net_work =
+		container_of(work, struct sparx5_rr_netevent_work, work);
+	unsigned char hwaddr[ETH_ALEN] __aligned(2);
+	struct sparx5 *sparx5 = net_work->sparx5;
+	struct neighbour *n = net_work->neigh;
+	struct sparx5_rr_neigh_key key = { };
+	struct sparx5_rr_neigh_entry *entry;
+	bool entry_connected;
+	u8 nud_state, dead;
+
+	sparx5_rr_nb2neigh_key(n, &key);
+
+	/* Frames with link-local dip are trapped, so ignore the neighbour. */
+	if (key.iaddr.version == SPARX5_IPV6 &&
+	    ipv6_addr_type(&key.iaddr.ipv6) & IPV6_ADDR_LINKLOCAL)
+		goto out;
+
+	/* If n changes after this read section, we will get another neigh
+	 * event, which is processed after the current one.
+	 */
+	read_lock_bh(&n->lock);
+	ether_addr_copy(hwaddr, n->ha);
+	nud_state = n->nud_state;
+	dead = n->dead;
+	read_unlock_bh(&n->lock);
+
+	mutex_lock(&sparx5->router->lock);
+
+	entry_connected = nud_state & NUD_VALID && !dead;
+	entry = sparx5_rr_neigh_entry_lookup(sparx5, &key);
+	if (!entry_connected && !entry)
+		goto out_mutex;
+
+	if (!entry) {
+		entry = sparx5_rr_neigh_entry_create(sparx5, &key);
+		if (IS_ERR(entry))
+			goto out_mutex;
+	}
+
+	if (entry->connected && entry_connected &&
+	    ether_addr_equal(entry->hwaddr, hwaddr))
+		goto out_mutex;
+
+	ether_addr_copy(entry->hwaddr, hwaddr);
+	sparx5_rr_neigh_entry_update(sparx5, entry, entry_connected);
+	sparx5_rr_nexthops_update_notify(sparx5, entry, entry_connected);
+	if (!entry_connected)
+		sparx5_rr_neigh_entry_put(sparx5, entry);
+
+out_mutex:
+	mutex_unlock(&sparx5->router->lock);
+out:
+	neigh_release(n);
+	kfree(net_work);
+}
+
+/* Handle neighbour update events. Used to manage neigh_entries. Called in
+ * atomic context, with rcu_read_lock().
+ */
+static int sparx5_rr_netevent_event(struct notifier_block *nb,
+				    unsigned long event, void *ptr)
+{
+	struct sparx5_rr_netevent_work *net_work;
+	struct sparx5_router *router;
+	struct sparx5_port *port;
+	struct neighbour *n;
+
+	router = container_of(nb, struct sparx5_router, netevent_nb);
+
+	switch (event) {
+	case NETEVENT_NEIGH_UPDATE:
+		n = ptr;
+
+		if (!net_eq(dev_net(n->dev), &init_net))
+			return NOTIFY_DONE;
+
+		if (n->tbl->family != AF_INET && n->tbl->family != AF_INET6)
+			return NOTIFY_DONE;
+
+		port = sparx5_port_dev_lower_find(n->dev);
+		if (!port)
+			return NOTIFY_DONE;
+
+		net_work = kzalloc_obj(*net_work, GFP_ATOMIC);
+		if (!net_work)
+			return NOTIFY_BAD;
+
+		INIT_WORK(&net_work->work, sparx5_rr_neigh_event_work);
+		net_work->sparx5 = router->sparx5;
+		net_work->neigh = neigh_clone(n);
+		net_work->event = event;
+		sparx5_rr_schedule_work(router->sparx5, &net_work->work);
+
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_DONE;
+};
+
 static void sparx5_rr_leg_base_mac_set(struct sparx5 *sparx5,
 				       unsigned char mac[ETH_ALEN])
 {
@@ -2813,10 +2925,15 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 		 ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, sparx5,
 		 ANA_ACL_VCAP_S2_MISC_CTRL);
 
+	r->netevent_nb.notifier_call = sparx5_rr_netevent_event;
+	err = register_netevent_notifier(&r->netevent_nb);
+	if (err)
+		goto err_workqueue_destroy;
+
 	r->fib_nb.notifier_call = sparx5_rr_fib_event;
 	err = register_fib_notifier(&init_net, &r->fib_nb, NULL, NULL);
 	if (err)
-		goto err_workqueue_destroy;
+		goto err_unreg_netevent_notifier;
 
 	r->inetaddr_nb.notifier_call = sparx5_rr_inetaddr_event;
 	err = register_inetaddr_notifier(&r->inetaddr_nb);
@@ -2855,6 +2972,8 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 	unregister_inetaddr_notifier(&r->inetaddr_nb);
 err_unreg_fib_notifier:
 	unregister_fib_notifier(&init_net, &r->fib_nb);
+err_unreg_netevent_notifier:
+	unregister_netevent_notifier(&r->netevent_nb);
 err_workqueue_destroy:
 	destroy_workqueue(r->sparx5_router_owq);
 	sparx5_rr_fib_flush(sparx5);
@@ -2890,6 +3009,7 @@ void sparx5_rr_router_deinit(struct sparx5 *sparx5)
 	unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
 	unregister_inetaddr_notifier(&router->inetaddr_nb);
 	unregister_fib_notifier(&init_net, &router->fib_nb);
+	unregister_netevent_notifier(&router->netevent_nb);
 	destroy_workqueue(router->sparx5_router_owq);
 	sparx5_rr_fib_flush(sparx5);
 	sparx5_rr_router_legs_flush(sparx5);

-- 
2.52.0

