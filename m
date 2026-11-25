Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613737;
	b=tozxrZCB6cnrvhyFZxZLtFLp+0jbWX/uqna3IE/quZWha9bri7NxIMhTsZNcAHc/EpvI
	 xOU7sQkJ9JvXu86El81fFh2aRLdHOzfz6I94M42yam/vf61uT8A61S4dLnGjcao7PzE8K
	 UNnBQVzBKKdYeAMwz7s6fQDj2dp7hJR81qDvNwsPLKWLNq3ejs8n2anwgtrpAH13jSfPH
	 4G1ocPWGkwxz57sxlMlpbKA5b4sTqZkBrlaSQh1Qs94UbP+rSMo2dNdYqMfwTYapmD6B7
	 PTphexicIVE1BNtcSAL5mUQzPYlRu9SrJdsoc4ZXvYQPqaHPKJ4o1SlvyEltLfQegwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613737;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=SAseRpkYHOHxtCyLwxWo6ng1OQmqjK4taSlfohgP3TU=;
	b=5MCt9jRZ69DZ06a7jiECOv2hxiSjfe9oXtjttDIJHCGhRRNmxiyzoFAJJ7VdNm9+/Chz
	 HOVhO4EIzuNvv+ljUKVF0+mDMPZY5+xO14jw9ya0O7JsMOGnl9N7tJrsL00WXuXEe+/xO
	 FlZtBq84ZSEbLD7Hegb9nauuf9Q4m14DoUkJOPWypOvo7OIArakp+aIJTPB1HgSU05fdE
	 aHNmMrDTSuGYdxOVS5VkftAKH4HCNnbYNbc9zpsDnLo3APRN4dc5iImAWruhVYVfZnlbB
	 VFO4/iHMtW0FfYultpaxq7XjR0sRY4p9hB+gICl2Cp6A4NDQZWk0q3JZrDW6jzmlAiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=GNBTqgdk;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD59606A68E;
	Wed, 25 Nov 2026 13:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD59606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=GNBTqgdk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1795613737; x=1827149737;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Vbi3tz3CkB6j3ucTPBJQgVOcJX3uxTsbM2Fs24u5Z0U=;
  b=GNBTqgdk/i8NZA5nHfGaxY1KptU9yiFvfEyQC4cRm5Af4I81SeSEp0tl
   BdMvH3WrnfCLzOpjaRlsKernTrhalovleYJh3p2VS5WKQpeaMZht9TLbp
   1QD0tQkDmNa+gWMOkioE5SgvTO7LGo/uhynFhIRbw8gVgjnhKfeFXqSHM
   HhsoR1YwXwx2fwJbumtQ2zdCCiWCMUBs4gLfSUkNmyX4XAhS8rdM7+EI2
   uw6rw2dLi06kN1DamScoh1lex32WMzsi4Uco7ZWfuINzoguG1+G3AF2Pj
   jv16ynuHsXR1YvXDh2MMt5fqD6W7OxoaytgecLIlz6nCTOLw9JSZI+zzj
   w==;
X-CSE-ConnectionGUID: QJF8mUDsRhey5vuKd671Rg==
X-CSE-MsgGUID: uyprGAqWTt6C4ep59O3PVQ==
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="298447218"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:35:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.57; Wed, 25 Nov 2026 06:35:35 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 25 Nov 2026 06:35:32 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Wed, 25 Nov 2026 14:35:08 +0100
Subject: [PATCH net-next v4 3/3] net: sparx5: keep router legs in sync with
 the bridge
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20261125-sparx5_l3_routing-v4-3-86a9bac28fcf@microchip.com>
References: <20261125-sparx5_l3_routing-v4-0-86a9bac28fcf@microchip.com>
In-Reply-To: <20261125-sparx5_l3_routing-v4-0-86a9bac28fcf@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Daniel Machon <daniel.machon@microchip.com>,
	"Steen Hegelund" <Steen.Hegelund@microchip.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Robert Marko
	<robert.marko@sartura.hr>, Eric Dumazet <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>,
	=?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
X-Mailer: b4 0.15-dev

The conditions for offloading a leg are evaluated when an address is
added, but the bridge and the upper can change afterwards.

A change that would leave the chip routing differently from the kernel
destroys the leg before it takes effect: disabling VLAN filtering,
changing the bridge to a VLAN protocol other than 802.1Q, linking the
upper to a master, and changing the upper's MAC.

The global leg base MAC follows later bridge MAC changes. When the first
switch port joins a bridge again, the reconcile is queued and creates
the legs for its uppers that kept their addresses while the bridge was
not offloaded.

While the upper is administratively down the leg is disabled as an
ingress router leg. The same holds while the bridge itself does not
carry the leg's vid, or carries it untagged, since the kernel then does
not deliver that vid to the upper. A bridge vlan delete, or an add that
makes the vid untagged, disables the leg at once.

A leg with an IPv4 address is kept while the upper is down, so it is
available again when the interface comes back up. Unless
keep_addr_on_down is set, link down removes IPv6 addresses, so an IPv6
only leg goes with its last address.

A down upper does not follow bridge MAC changes, so it can lose its leg
while down. Bringing a vlan upper of the bridge up queues the reconcile,
which creates the leg again.

IPv6 addresses that the kernel adds without calling the validator, such
as SLAAC and temporary addresses, get their leg from the reconcile, which
the address notifier queues for them.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   3 +
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 140 ++++++++++++++++++++-
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |  25 +++-
 3 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index b940f8199942..36df730e9bdb 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -563,6 +563,9 @@ int sparx5_rr_router_init(struct sparx5 *sparx5);
 void sparx5_rr_router_deinit(struct sparx5 *sparx5);
 void sparx5_rr_bridge_legs_flush(struct sparx5 *sparx5,
 				 const struct net_device *bridge);
+void sparx5_rr_legs_reconcile_schedule(struct sparx5 *sparx5);
+void sparx5_rr_bridge_vlan_clear(struct sparx5 *sparx5,
+				 const struct net_device *bridge, u16 vid);
 
 struct sparx5_router {
 	struct sparx5 *sparx5;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
index c04be943e1af..068bf8c71b78 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
@@ -32,6 +32,8 @@ struct sparx5_rr_router_leg {
 	struct list_head leg_list_node; /* Router member */
 	u16 vmid; /* Internal id */
 	u16 vid; /* VLAN id */
+	/* The bridge carries vid as a vlan of its own. */
+	bool vlan_present;
 };
 
 static void sparx5_rr_schedule_work(struct sparx5 *sparx5,
@@ -40,9 +42,10 @@ static void sparx5_rr_schedule_work(struct sparx5 *sparx5,
 	queue_work(sparx5->router->sparx5_router_owq, work);
 }
 
-static void sparx5_rr_legs_reconcile_schedule(struct sparx5 *sparx5)
+void sparx5_rr_legs_reconcile_schedule(struct sparx5 *sparx5)
 {
-	sparx5_rr_schedule_work(sparx5, &sparx5->router->legs_work);
+	if (sparx5->router)
+		sparx5_rr_schedule_work(sparx5, &sparx5->router->legs_work);
 }
 
 static void sparx5_rr_split_mac(const unsigned char *mac, u32 split,
@@ -100,6 +103,19 @@ sparx5_rr_leg_find_by_vid(struct sparx5 *sparx5, u16 vid)
 	return NULL;
 }
 
+static bool sparx5_rr_bridge_has_legs(struct sparx5 *sparx5,
+				      const struct net_device *bridge)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	list_for_each_entry(leg, &sparx5->router->leg_list, leg_list_node) {
+		if (vlan_dev_real_dev(leg->dev) == bridge)
+			return true;
+	}
+
+	return false;
+}
+
 static void sparx5_rr_leg_base_mac_set(struct sparx5 *sparx5,
 				       const unsigned char *mac)
 {
@@ -154,6 +170,16 @@ static void sparx5_rr_leg_hw_uc_set(struct sparx5 *sparx5,
 		 ANA_L3_RLEG_CTRL(leg->vmid));
 }
 
+/* Route ingress on the leg only while the kernel would receive on it: the
+ * upper is up and the bridge carries its vid.
+ */
+static void sparx5_rr_leg_hw_uc_update(struct sparx5 *sparx5,
+				       struct sparx5_rr_router_leg *leg)
+{
+	sparx5_rr_leg_hw_uc_set(sparx5, leg,
+				netif_running(leg->dev) && leg->vlan_present);
+}
+
 static void sparx5_rr_leg_hw_init(struct sparx5 *sparx5,
 				  struct sparx5_rr_router_leg *leg)
 {
@@ -172,7 +198,7 @@ static void sparx5_rr_leg_hw_init(struct sparx5 *sparx5,
 		 ANA_L3_RLEG_CTRL_RLEG_EVID, sparx5,
 		 ANA_L3_RLEG_CTRL(leg->vmid));
 
-	sparx5_rr_leg_hw_uc_set(sparx5, leg, true);
+	sparx5_rr_leg_hw_uc_update(sparx5, leg);
 
 	/* Configure egress VLAN in rewriter */
 	spx5_rmw(REW_RLEG_CTRL_RLEG_EVID_SET(leg->vid), REW_RLEG_CTRL_RLEG_EVID,
@@ -260,6 +286,15 @@ static void sparx5_rr_router_leg_destroy(struct sparx5_rr_router_leg *leg)
 	kfree(leg);
 }
 
+static bool sparx5_rr_bridge_vlan_present(struct net_device *bridge, u16 vid)
+{
+	struct bridge_vlan_info info;
+
+	return !br_vlan_get_info(bridge, vid, &info) &&
+	       info.flags & BRIDGE_VLAN_INFO_BRENTRY &&
+	       !(info.flags & BRIDGE_VLAN_INFO_UNTAGGED);
+}
+
 static struct sparx5_rr_router_leg *
 sparx5_rr_router_leg_create(struct sparx5 *sparx5, struct net_device *dev,
 			    u16 vid, struct netlink_ext_ack *extack)
@@ -285,6 +320,9 @@ sparx5_rr_router_leg_create(struct sparx5 *sparx5, struct net_device *dev,
 	/* Global router leg base MAC tracks the bridge MAC. */
 	sparx5_rr_leg_base_mac_set(sparx5, vlan_dev_real_dev(dev)->dev_addr);
 
+	leg->vlan_present =
+		sparx5_rr_bridge_vlan_present(vlan_dev_real_dev(dev), vid);
+
 	list_add(&leg->leg_list_node, &sparx5->router->leg_list);
 	sparx5_rr_leg_hw_init(sparx5, leg);
 
@@ -476,7 +514,7 @@ static int sparx5_rr_inet6addr_event(struct notifier_block *nb,
 	struct net_device *dev = if6->idev->dev;
 	struct sparx5_router *router;
 
-	if (event != NETDEV_DOWN)
+	if (event != NETDEV_UP && event != NETDEV_DOWN)
 		return NOTIFY_DONE;
 
 	if (!net_eq(dev_net(dev), &init_net))
@@ -529,6 +567,20 @@ static int sparx5_rr_inetaddr_valid_event(struct notifier_block *nb,
 					       ivi->extack);
 }
 
+static void sparx5_rr_leg_withdraw(struct sparx5 *sparx5,
+				   struct net_device *dev)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	mutex_lock(&sparx5->router->lock);
+	leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
+	if (leg) {
+		sparx5_rr_router_leg_destroy(leg);
+		sparx5_rr_legs_reconcile_schedule(sparx5);
+	}
+	mutex_unlock(&sparx5->router->lock);
+}
+
 /* Called with RTNL. */
 static int sparx5_rr_netdevice_event(struct notifier_block *nb,
 				     unsigned long event, void *ptr)
@@ -547,6 +599,39 @@ static int sparx5_rr_netdevice_event(struct notifier_block *nb,
 	sparx5 = router->sparx5;
 
 	switch (event) {
+	case NETDEV_PRECHANGEUPPER: {
+		struct netdev_notifier_changeupper_info *upper_info = ptr;
+
+		if (upper_info->linking && upper_info->master)
+			sparx5_rr_leg_withdraw(sparx5, dev);
+		break;
+	}
+	case NETDEV_CHANGEUPPER:
+		if (is_vlan_dev(dev))
+			sparx5_rr_legs_reconcile_schedule(sparx5);
+		break;
+	case NETDEV_UP:
+	case NETDEV_DOWN:
+		mutex_lock(&router->lock);
+		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
+		if (leg)
+			sparx5_rr_leg_hw_uc_update(sparx5, leg);
+		mutex_unlock(&router->lock);
+		if (event == NETDEV_UP && is_vlan_dev(dev) &&
+		    vlan_dev_real_dev(dev) == sparx5->hw_bridge_dev)
+			sparx5_rr_legs_reconcile_schedule(sparx5);
+		break;
+	case NETDEV_PRE_CHANGEADDR:
+		sparx5_rr_leg_withdraw(sparx5, dev);
+		break;
+	case NETDEV_CHANGEADDR:
+		mutex_lock(&router->lock);
+		if (sparx5_rr_bridge_has_legs(sparx5, dev))
+			sparx5_rr_leg_base_mac_set(sparx5, dev->dev_addr);
+		mutex_unlock(&router->lock);
+		if (is_vlan_dev(dev))
+			sparx5_rr_legs_reconcile_schedule(sparx5);
+		break;
 	case NETDEV_UNREGISTER:
 		mutex_lock(&router->lock);
 		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
@@ -568,10 +653,34 @@ static void sparx5_rr_router_legs_flush(struct sparx5 *sparx5)
 		sparx5_rr_router_leg_destroy(leg);
 }
 
+/* Follow a vlan of the bridge itself, the kernel only receives on a vlan
+ * upper while the bridge carries its vid.
+ */
+void sparx5_rr_bridge_vlan_clear(struct sparx5 *sparx5,
+				 const struct net_device *bridge, u16 vid)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	if (!sparx5->router)
+		return;
+
+	mutex_lock(&sparx5->router->lock);
+	list_for_each_entry(leg, &sparx5->router->leg_list, leg_list_node) {
+		if (leg->vid != vid || vlan_dev_real_dev(leg->dev) != bridge)
+			continue;
+		leg->vlan_present = false;
+		sparx5_rr_leg_hw_uc_update(sparx5, leg);
+	}
+	sparx5_rr_legs_reconcile_schedule(sparx5);
+	mutex_unlock(&sparx5->router->lock);
+}
+
 static void sparx5_rr_legs_reconcile(struct sparx5 *sparx5)
 {
 	struct sparx5_rr_router_leg *leg, *tmp;
+	struct net_device *bridge, *dev;
 	struct sparx5_router *router;
+	struct list_head *iter;
 
 	ASSERT_RTNL();
 
@@ -579,8 +688,29 @@ static void sparx5_rr_legs_reconcile(struct sparx5 *sparx5)
 
 	mutex_lock(&router->lock);
 	list_for_each_entry_safe(leg, tmp, &router->leg_list, leg_list_node) {
-		if (sparx5_rr_dev_addr_list_empty(leg->dev))
+		if (sparx5_rr_dev_addr_list_empty(leg->dev) ||
+		    !sparx5_rr_dev_real_is_vlan_aware(sparx5, leg->dev)) {
 			sparx5_rr_router_leg_destroy(leg);
+			continue;
+		}
+
+		bridge = vlan_dev_real_dev(leg->dev);
+		leg->vlan_present = sparx5_rr_bridge_vlan_present(bridge,
+								  leg->vid);
+		sparx5_rr_leg_hw_uc_update(sparx5, leg);
+	}
+
+	bridge = sparx5->hw_bridge_dev;
+	if (!bitmap_empty(sparx5->bridge_mask, SPX5_PORTS) && bridge) {
+		netdev_for_each_upper_dev_rcu(bridge, dev, iter) {
+			if (!is_vlan_dev(dev) ||
+			    sparx5_rr_dev_addr_list_empty(dev))
+				continue;
+			if (__sparx5_rr_inetaddr_event(sparx5, dev, NETDEV_UP,
+						       NULL) && net_ratelimit())
+				netdev_warn(dev,
+					    "Failed to offload L3 router leg\n");
+		}
 	}
 	mutex_unlock(&router->lock);
 }
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index 46b3351f717f..322806fbfe2b 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -152,6 +152,11 @@ static int sparx5_port_attr_set(struct net_device *dev, const void *ctx,
 		sparx5_port_attr_ageing_set(port, attr->u.ageing_time);
 		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		/* L3 offload requires a VLAN aware bridge. */
+		if (!attr->u.vlan_filtering)
+			sparx5_rr_bridge_legs_flush(port->sparx5,
+						    attr->orig_dev);
+		sparx5_rr_legs_reconcile_schedule(port->sparx5);
 		/* Used PVID 1 when default_pvid is 0, to avoid
 		 * collision with non-bridged ports.
 		 */
@@ -160,6 +165,13 @@ static int sparx5_port_attr_set(struct net_device *dev, const void *ctx,
 		port->vlan_aware = attr->u.vlan_filtering;
 		sparx5_vlan_port_apply(port->sparx5, port);
 		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL:
+		/* A leg is classified by vid alone, whatever the protocol. */
+		if (attr->u.vlan_protocol != ETH_P_8021Q)
+			sparx5_rr_bridge_legs_flush(port->sparx5,
+						    attr->orig_dev);
+		sparx5_rr_legs_reconcile_schedule(port->sparx5);
+		return -EOPNOTSUPP;
 	case SWITCHDEV_ATTR_ID_PORT_MROUTER:
 		sparx5_port_attr_mrouter_set(port,
 					     attr->orig_dev,
@@ -179,9 +191,11 @@ static int sparx5_port_bridge_join(struct sparx5_port *port,
 	struct switchdev_brport_flags flags = {0};
 	struct sparx5 *sparx5 = port->sparx5;
 	struct net_device *ndev = port->ndev;
+	bool first;
 	int err;
 
-	if (bitmap_empty(sparx5->bridge_mask, SPX5_PORTS))
+	first = bitmap_empty(sparx5->bridge_mask, SPX5_PORTS);
+	if (first)
 		/* First bridged port */
 		sparx5->hw_bridge_dev = bridge;
 	else
@@ -211,6 +225,10 @@ static int sparx5_port_bridge_join(struct sparx5_port *port,
 	flags.val = flags.mask;
 	sparx5_port_attr_bridge_flags(port, flags);
 
+	/* The bridge's legs were flushed when its last port left. */
+	if (first)
+		sparx5_rr_legs_reconcile_schedule(sparx5);
+
 	return 0;
 
 err_switchdev_offload:
@@ -448,6 +466,10 @@ static int sparx5_handle_port_vlan_add(struct net_device *dev,
 		/* Flood broadcast to CPU */
 		sparx5_mact_learn(sparx5, sparx5_get_pgid(sparx5, PGID_BCAST),
 				  dev->broadcast, v->vid);
+		if (v->flags & BRIDGE_VLAN_INFO_UNTAGGED)
+			sparx5_rr_bridge_vlan_clear(sparx5, dev, v->vid);
+		else
+			sparx5_rr_legs_reconcile_schedule(sparx5);
 		return 0;
 	}
 
@@ -683,6 +705,7 @@ static int sparx5_handle_port_vlan_del(struct net_device *dev,
 				     switchdev_blocking_nb);
 
 		sparx5_mact_forget(sparx5, dev->broadcast, vid);
+		sparx5_rr_bridge_vlan_clear(sparx5, dev, vid);
 		return 0;
 	}
 

-- 
2.52.0

