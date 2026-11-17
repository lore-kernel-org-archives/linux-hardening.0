Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921503;
	b=f6Shl3cxCDC3FKH4LKhfN6SWdQerWKfcuTJWWUZzaaRMd3lRTQG0uhbgxj2+SEG8BZon
	 NncWGI4lhNyw90j2SO1E5itHo8mBuZoDtI/qla8bu3/Q7IcZpstVY/Yepm/OB04xXdgXf
	 t28H7AuLlyD6aI3dO78Ezwpit87E2HFwCP9Jef3jlQu5a4NBYpyHiYtx+M1iCRTOtNs2c
	 d/JW0MLEA7Eht9KH3zF9Oyc+TBajqzAhYnIXsdpZNe6qtH6DUqQbMWyra7UBB3S/m8emO
	 Slvu3ImflMmaGuAKACqfrwk4PgBtQ3R/ZCNxPfNhq3XDX8a7kIDhooF6VBr+qcjUzNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921503;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=yXEs6uhNdaVSRLXO0hXE3cDhSy37uLC1l2oLGVvD32k=;
	b=F00YXJMrkg8/lV36jm+u/Mzj2l/FQK3yas8Plk0IDU0A3tNGatOIBWhS7G+4H5Maul5U
	 LbO7dFyrnfJfuMoWcbvcl4vXy4PjVatkP1KfO5G+Dpd6abCxreipXliSKSe3d2SUXMtoQ
	 YAvLxtbme9DM0GCDCZb2CigTN/gut6IDY1MD7urWa36wLmkyXHL4Q3liSGV3t2rBoyQSJ
	 Wzrn9CAjzXvpYIGVXCt87PwNl/rQ27nEtU+bgAKWxu4fcm0KGNArk0utA8kZsfOyoTQxc
	 WZYxrrr/p08+km+nXhvWNhAFp/GpSpkXN1NC1aog6Sd7Lo9/fq18O2GHVlpqcQv682w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=KsI4aZip;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC451606A323;
	Tue, 17 Nov 2026 13:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC451606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=KsI4aZip
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794921510; x=1826457510;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ItZZv5Eu/tDavInoWJrmXA5oVZ7DaT+1B9o5NUFZc1o=;
  b=KsI4aZip/OPxt2d3I0fJnLWFw/C6ZJsTO1cyiS0p/WsQjdhJOLWwDJRB
   yBGUXqUQNau/yAg9T7nFhOpR2mtdLRpNCq6PjUP+UkMt5VSsi+97YP58r
   y/6az6M5zUdH7UkvCu5yZTvW3lE5Wey/xPkebLBhpQ0tMzRP7KvQ3os6/
   L1Yn7OJU0SRfPGaY5c30hjqUobeEw0LEfhDIxDm9WOvTXjB3u4fhIZl77
   CoAE7UggrQGoo8h9Lov5JcJxP/U0Y2UtxmzmLkf9WUUJKqsgj/dXeUFvu
   yl/CVAn945J8PZtyulDnXGC2BENMOH5rTiexGUa+MB5VMyK0dIlVSqnfk
   Q==;
X-CSE-ConnectionGUID: p9PgQP3gRniFzphfdamHlQ==
X-CSE-MsgGUID: IiNDpHCkRqKZKLn1x6PG3g==
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="233689768"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:18:29 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 17 Nov 2026 06:18:21 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 17 Nov 2026 06:18:18 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 17 Nov 2026 14:17:39 +0100
Subject: [PATCH net-next v3 3/3] net: sparx5: keep router legs in sync with
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
Message-ID: <20261117-sparx5_l3_routing-v3-3-e680ed79c7dc@microchip.com>
References: <20261117-sparx5_l3_routing-v3-0-e680ed79c7dc@microchip.com>
In-Reply-To: <20261117-sparx5_l3_routing-v3-0-e680ed79c7dc@microchip.com>
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
switch port joins a bridge again, the reconcile runs at once and creates
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

IPv6 addresses that the kernel adds without calling the validator, such
as SLAAC and temporary addresses, get their leg from the reconcile, which
the address notifier queues for them.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |   4 +
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 142 ++++++++++++++++++++-
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |  25 +++-
 3 files changed, 164 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index 7ce7ad607c34..96e6a2857721 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -556,6 +556,10 @@ int sparx5_rr_router_init(struct sparx5 *sparx5);
 void sparx5_rr_router_deinit(struct sparx5 *sparx5);
 void sparx5_rr_bridge_legs_flush(struct sparx5 *sparx5,
 				 const struct net_device *bridge);
+void sparx5_rr_legs_reconcile(struct sparx5 *sparx5);
+void sparx5_rr_legs_reconcile_schedule(struct sparx5 *sparx5);
+void sparx5_rr_bridge_vlan_clear(struct sparx5 *sparx5,
+				 const struct net_device *bridge, u16 vid);
 
 struct sparx5_router {
 	struct sparx5 *sparx5;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
index 26aeee17733c..7412db7a6e7b 100644
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
 
+	leg->vlan_present = sparx5_rr_bridge_vlan_present(vlan_dev_real_dev(dev),
+							  vid);
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
@@ -547,6 +599,36 @@ static int sparx5_rr_netdevice_event(struct notifier_block *nb,
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
@@ -568,19 +650,66 @@ static void sparx5_rr_router_legs_flush(struct sparx5 *sparx5)
 		sparx5_rr_router_leg_destroy(leg);
 }
 
-static void sparx5_rr_legs_reconcile(struct sparx5 *sparx5)
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
+void sparx5_rr_legs_reconcile(struct sparx5 *sparx5)
 {
 	struct sparx5_rr_router_leg *leg, *tmp;
+	struct net_device *bridge, *dev;
 	struct sparx5_router *router;
+	struct list_head *iter;
 
 	ASSERT_RTNL();
 
 	router = sparx5->router;
+	if (!router)
+		return;
 
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
@@ -681,6 +810,7 @@ int sparx5_rr_router_init(struct sparx5 *sparx5)
 
 	INIT_LIST_HEAD(&r->leg_list);
 
+	/* The exported helpers use leg_list once sparx5->router is set. */
 	sparx5->router = r;
 
 	r->sparx5_router_owq = alloc_ordered_workqueue("sparx5_router_owq", 0);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index 46b3351f717f..baa46d21e7ba 100644
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
+		sparx5_rr_legs_reconcile(sparx5);
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

