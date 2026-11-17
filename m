Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921499;
	b=0INhhtl2riCTalzSNEMAkO1JMzCJ9auqe7COKWn/inLBEyx11qLrw4rNL0/MCoETSkHN
	 FRfAErIzSKOxWI1Urtrt5wnpKs0vJ8COGL0H87kRxUAytOUiifLDoEweIOIG01+mRH9UR
	 GqJtavhZnDnToF5BlMb9R9UO0w/bF1sjofkJRqyz/PHtSi5+1em4VWwsH5zWoybeO0E2c
	 EBKZOFrmxzq9E2GmYRPb8P4vO9tav6h7Uu8cU2HBrShdB8dBdr3YV2znFeXPtwMN5YyYQ
	 +BEn4da9bugT9pWoZoritctwEstnQTssu8AVU+aIu4bifnqx93lyFTalokBz2Ap2HKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921499;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=kNz3rNFML8NBYplBdXbd3vvnlayZ3aptRF8GOn0AxCc=;
	b=PxDqCNSXdjlniITqRI4acYHxfc2BCR0oiVGeEh0Zr1fTGsOzNWRWA21HtTCHTWIOmkYl
	 pGaRt5OFeq2YXl2X5vlIkSMG3LJbXII/n1s7oVeR7HoSrRpgGeKDt3UtTtrelkDebBnYj
	 9OOIMq3TopIc8c/huQj685LwkCvZ5c8wfQGAVw9R9lb8+ZuY762s2odtj1MkSFkRV6mnN
	 ld0RgzY6mEE6UYxbxcfXzRxtTiIRBVI70IRXApcEpjVQW8OtC6MZnaBG42Mc1wfLymTEq
	 mBw18BaUt8Dbb1gmL8GvcigjpoBDPBOI0yCNdG6EGr3CA+LxfKKu55sK58UtjEszS2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=w+fhNKvN;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B2606A33D;
	Tue, 17 Nov 2026 13:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD5B2606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=w+fhNKvN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794921498; x=1826457498;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ejnE5AMknxxOB/r9NJq4is/0b+SED+tZ8yjTK/6CWz0=;
  b=w+fhNKvNY2aHJaPu2k4RrbHDvhuw8d3HH0UFPUPCbZFOBaNTE9hoHRiO
   E5zyZXKYhBaOMJoMAddlursWfGnSR30gilvQ7+oJJXAItHUDxDmRIrJf0
   m/SmU7h+qOGfQrXrEuLTJLzCKCqfPc5teopCrrezcEP/a24fo1oA5Cdej
   7wpVIR++bYaDngKDA9nKzKTfOET7jr3GyHe2lt7TFYZjzwF3AwuQRdu3l
   jCYe3ORxfveZmx5IAjm9sZQ/fbQsHbYf0lsz3LtPOzNh3i2Y00zeaYGY8
   jlzfCo3bjZqb7xfbQ6yqAncEVIzTz6JPss1JvSuCZTvDdCvlH6CohflDh
   Q==;
X-CSE-ConnectionGUID: iIy6ArWnSZiFXBZXHSVhww==
X-CSE-MsgGUID: 0W4LanHoTBy1oGdnVHh3ag==
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="65663147"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:18:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 17 Nov 2026 06:18:18 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 17 Nov 2026 06:18:14 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 17 Nov 2026 14:17:38 +0100
Subject: [PATCH net-next v3 2/3] net: sparx5: add L3 router legs
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
Message-ID: <20261117-sparx5_l3_routing-v3-2-e680ed79c7dc@microchip.com>
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

The chips can only route in VLAN aware mode, and routing happens between
router legs (RLEG). To each direct VLAN upper of a VLAN aware bridge, we
associate a router leg. The indices to the router leg table are called
VMIDs in the datasheet. Leg hardware state is indexed by VLAN id, so leg
vids must be unique.

A leg is created when the first address is added to such an upper, and
destroyed when the last one is removed or the upper is unregistered. A
bridge's legs are also torn down when its last switch port leaves, since
the switch then has no datapath on it.

There is a global router leg base MAC used for MAC rewrites by the chip.
Here we use the bridge MAC, programmed when a leg is created.

A router leg is offloaded only for a device that is:

1) A direct VLAN upper of the single bridge that has switch ports
   lowers.

2) On an 802.1Q bridge, using the bridge's VLAN protocol.

3) On a non-zero vid. Every non-bridged port classifies into vid 0, so
   such a leg would offer routing to frames from ports outside the
   bridge.

4) Carrying and inheriting the bridge MAC. ANA_L3 matches one global
   base MAC as the router leg MAC for every VMID.

5) Without a master. A bridge, LAG, OVS or HSR master owns the devices
   rx path, and an l3mdev master owns its routing table.

The conditions are evaluated when an address is added to a VLAN upper.
Configurations that are not offloaded are handled in software as usual.
A qualifying upper whose leg cannot be created, because the VMIDs are
used up, an allocation fails or another upper already has a leg for the
vid, keeps its address and is routed in software. The failure is
reported as an extack warning, or in the kernel log.

Routing is enabled in the chip, but no LPM rule is programmed. A routed
frame misses the LPM lookup and is redirected to the CPU on
CPU_UC_FAIL_QU, so the kernel routes every frame in software.

L3 offload is optional. If the router cannot initialise, probe carries on
without offload rather than failing the whole switch.

Without CONFIG_VLAN_8021Q there is no VLAN upper to attach a leg to, so
sparx5_rr_router_init() returns early: no notifiers are registered and
routing is not enabled in the chip.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 drivers/net/ethernet/microchip/sparx5/Makefile     |   2 +-
 .../ethernet/microchip/sparx5/lan969x/lan969x.c    |   1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |  13 +-
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  33 +
 .../net/ethernet/microchip/sparx5/sparx5_router.c  | 783 +++++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_switchdev.c   |   5 +-
 .../net/ethernet/microchip/sparx5/sparx5_vlan.c    |   2 +
 7 files changed, 835 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/Makefile b/drivers/net/ethernet/microchip/sparx5/Makefile
index 06cf583effdb..d7a1e6ad087e 100644
--- a/drivers/net/ethernet/microchip/sparx5/Makefile
+++ b/drivers/net/ethernet/microchip/sparx5/Makefile
@@ -11,7 +11,7 @@ sparx5-switch-y  := sparx5_main.o sparx5_packet.o \
  sparx5_ptp.o sparx5_pgid.o sparx5_tc.o sparx5_qos.o \
  sparx5_vcap_impl.o sparx5_vcap_ag_api.o sparx5_tc_flower.o \
  sparx5_tc_matchall.o sparx5_pool.o sparx5_sdlb.o sparx5_police.o \
- sparx5_psfp.o sparx5_mirror.o sparx5_regs.o sparx5_tas.o
+ sparx5_psfp.o sparx5_mirror.o sparx5_regs.o sparx5_tas.o sparx5_router.o
 
 sparx5-switch-$(CONFIG_SPARX5_DCB) += sparx5_dcb.o
 sparx5-switch-$(CONFIG_DEBUG_FS) += sparx5_vcap_debugfs.o
diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
index c02499d1b297..eca03b4154ee 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
@@ -324,6 +324,7 @@ static const struct sparx5_consts lan969x_consts = {
 	.qres_max_prio_idx   = 315,
 	.qres_max_colour_idx = 323,
 	.tod_pin             = 4,
+	.vmid_cnt            = 127,
 	.vcaps               = lan969x_vcaps,
 	.vcap_stats          = &lan969x_vcap_stats,
 	.vcaps_cfg           = lan969x_vcap_inst_cfg,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index 9b67a0520907..c82e2d65140e 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -995,15 +995,22 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 		goto cleanup_ptp;
 	}
 
+	/* L3 offload is optional, probe carries on without it. */
+	err = sparx5_rr_router_init(sparx5);
+	if (err)
+		dev_warn(sparx5->dev, "L3 routing offload unavailable: %pe\n",
+			 ERR_PTR(err));
+
 	err = sparx5_register_notifier_blocks(sparx5);
 	if (err) {
 		dev_err(sparx5->dev, "Failed to register notifier blocks\n");
-		goto cleanup_netdevs;
+		goto cleanup_router;
 	}
 
 	goto cleanup_config;
 
-cleanup_netdevs:
+cleanup_router:
+	sparx5_rr_router_deinit(sparx5);
 	sparx5_unregister_netdevs(sparx5);
 cleanup_ptp:
 	sparx5_ptp_deinit(sparx5);
@@ -1030,6 +1037,7 @@ static void mchp_sparx5_remove(struct platform_device *pdev)
 
 	debugfs_remove_recursive(sparx5->debugfs_root);
 	sparx5_unregister_notifier_blocks(sparx5);
+	sparx5_rr_router_deinit(sparx5);
 	sparx5_unregister_netdevs(sparx5);
 	sparx5_ptp_deinit(sparx5);
 	sparx5_frame_io_deinit(sparx5);
@@ -1070,6 +1078,7 @@ static const struct sparx5_consts sparx5_consts = {
 	.qres_max_prio_idx   = 630,
 	.qres_max_colour_idx = 638,
 	.tod_pin             = 4,
+	.vmid_cnt            = 511,
 	.vcaps               = sparx5_vcaps,
 	.vcaps_cfg           = sparx5_vcap_inst_cfg,
 	.vcap_stats          = &sparx5_vcap_stats,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index ad29db91ce91..7ce7ad607c34 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -138,6 +138,11 @@ enum sparx5_feature {
 
 #define SPARX5_MAX_PTP_ID	512
 
+/* Must be the maximum across all L3 enabled platforms, which
+ * sparx5_rr_router_init() checks against the per-platform consts.
+ */
+#define SPARX5_ROUTER_LEG_N_VMID 511
+
 struct sparx5;
 
 struct sparx5_calendar_data {
@@ -356,6 +361,7 @@ struct sparx5_consts {
 	u32 qres_max_prio_idx;   /* Maximum QRES prio index */
 	u32 qres_max_colour_idx; /* Maximum QRES colour index */
 	u32 tod_pin;             /* PTP TOD pin */
+	u32 vmid_cnt;            /* Number of router leg VMID's */
 	const struct sparx5_vcap_inst *vcaps_cfg;
 	const struct vcap_info *vcaps;
 	const struct vcap_statistics *vcap_stats;
@@ -473,6 +479,8 @@ struct sparx5 {
 	/* Common root for debugfs */
 	struct dentry *debugfs_root;
 	const struct sparx5_match_data *data;
+	/* L3 Forwarding */
+	struct sparx5_router *router;
 };
 
 /* sparx5_main.c */
@@ -542,6 +550,31 @@ int sparx5_vlan_vid_add(struct sparx5_port *port, u16 vid, bool pvid,
 int sparx5_vlan_vid_del(struct sparx5_port *port, u16 vid);
 void sparx5_vlan_port_apply(struct sparx5 *sparx5, struct sparx5_port *port);
 
+/* sparx5_router.c */
+void sparx5_rr_port_fwd_update(struct sparx5 *sparx5);
+int sparx5_rr_router_init(struct sparx5 *sparx5);
+void sparx5_rr_router_deinit(struct sparx5 *sparx5);
+void sparx5_rr_bridge_legs_flush(struct sparx5 *sparx5,
+				 const struct net_device *bridge);
+
+struct sparx5_router {
+	struct sparx5 *sparx5;
+	struct notifier_block inetaddr_nb;
+	struct notifier_block inetaddr_valid_nb;
+	struct notifier_block netdevice_nb;
+	struct notifier_block inet6addr_nb;
+	struct notifier_block inet6addr_valid_nb;
+
+	struct mutex lock; /* Global router lock for all shared data. */
+
+	struct workqueue_struct *sparx5_router_owq;
+	struct work_struct legs_work;
+
+	struct list_head leg_list;
+	/* Track allocated router leg indices in hw */
+	DECLARE_BITMAP(vmid_mask, SPARX5_ROUTER_LEG_N_VMID);
+};
+
 /* sparx5_calendar.c */
 int sparx5_calendar_init(struct sparx5 *sparx5);
 int sparx5_dsm_calendar_calc(struct sparx5 *sparx5, u32 taxi,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_router.c b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
new file mode 100644
index 000000000000..26aeee17733c
--- /dev/null
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_router.c
@@ -0,0 +1,783 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip Sparx5 Switch driver
+ *
+ * Copyright (c) 2026 Microchip Technology Inc. and its subsidiaries.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/if_bridge.h>
+#include <linux/if_ether.h>
+#include <linux/inet.h>
+#include <linux/inetdevice.h>
+#include <linux/list.h>
+#include <net/addrconf.h>
+#include <net/ipv6.h>
+
+#include "sparx5_main.h"
+#include "sparx5_port.h"
+
+/* The main routing objects are
+ *
+ * 1) Router legs, which correspond to IP interfaces. They can have multiple IPs
+ *    attached and are associated with a VLAN, and are identified in hardware
+ *    by their VMID.
+ */
+
+#define SPARX5_RLEG_USE_GLOBAL_BASE_MAC	2
+
+struct sparx5_rr_router_leg {
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+	struct sparx5 *sparx5;
+	struct list_head leg_list_node; /* Router member */
+	u16 vmid; /* Internal id */
+	u16 vid; /* VLAN id */
+};
+
+static void sparx5_rr_schedule_work(struct sparx5 *sparx5,
+				    struct work_struct *work)
+{
+	queue_work(sparx5->router->sparx5_router_owq, work);
+}
+
+static void sparx5_rr_legs_reconcile_schedule(struct sparx5 *sparx5)
+{
+	sparx5_rr_schedule_work(sparx5, &sparx5->router->legs_work);
+}
+
+static void sparx5_rr_split_mac(const unsigned char *mac, u32 split,
+				u32 *msb, u32 *lsb)
+{
+	u32 mask = GENMASK(split - 1, 0);
+	u64 m = ether_addr_to_u64(mac);
+
+	*lsb = m & mask;
+	*msb = m >> split;
+}
+
+static int sparx5_vmid_alloc(struct sparx5 *sparx5)
+{
+	int vmid;
+
+	vmid = find_first_zero_bit(sparx5->router->vmid_mask,
+				   sparx5->data->consts->vmid_cnt);
+	if (vmid >= sparx5->data->consts->vmid_cnt)
+		return -ENOSPC;
+
+	set_bit(vmid, sparx5->router->vmid_mask);
+
+	return vmid;
+}
+
+static void sparx5_vmid_free(struct sparx5 *sparx5, u16 vmid)
+{
+	clear_bit(vmid, sparx5->router->vmid_mask);
+}
+
+static struct sparx5_rr_router_leg *
+sparx5_rr_leg_find_by_dev(struct sparx5 *sparx5, struct net_device *dev)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	list_for_each_entry(leg, &sparx5->router->leg_list, leg_list_node) {
+		if (leg->dev == dev)
+			return leg;
+	}
+
+	return NULL;
+}
+
+static struct sparx5_rr_router_leg *
+sparx5_rr_leg_find_by_vid(struct sparx5 *sparx5, u16 vid)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	list_for_each_entry(leg, &sparx5->router->leg_list, leg_list_node) {
+		if (leg->vid == vid)
+			return leg;
+	}
+
+	return NULL;
+}
+
+static void sparx5_rr_leg_base_mac_set(struct sparx5 *sparx5,
+				       const unsigned char *mac)
+{
+	/* Only router teardown passes a zero MAC. The base MAC is otherwise
+	 * left programmed after the last leg goes, which is harmless.
+	 */
+	u8 rleg_type_sel = is_zero_ether_addr(mac) ?
+			   0 : SPARX5_RLEG_USE_GLOBAL_BASE_MAC;
+	u32 mac_msb, mac_lsb;
+
+	sparx5_rr_split_mac(mac, 24, &mac_msb, &mac_lsb);
+
+	dev_dbg(sparx5->dev, "Router leg base MAC=%pM\n", mac);
+
+	/* ANA_L3, REW and EACL must hold the same leg MAC. */
+	spx5_wr(ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB_SET(mac_lsb), sparx5,
+		ANA_L3_RLEG_CFG_0);
+
+	spx5_rmw(ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB_SET(mac_msb) |
+		 ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(rleg_type_sel),
+		 ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB |
+		 ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL,
+		 sparx5, ANA_L3_RLEG_CFG_1);
+
+	spx5_wr(REW_RLEG_CFG_0_RLEG_MAC_LSB_SET(mac_lsb), sparx5,
+		REW_RLEG_CFG_0);
+
+	spx5_rmw(REW_RLEG_CFG_1_RLEG_MAC_MSB_SET(mac_msb) |
+		 REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(rleg_type_sel),
+		 REW_RLEG_CFG_1_RLEG_MAC_MSB | REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL,
+		 sparx5, REW_RLEG_CFG_1);
+
+	spx5_wr(EACL_RLEG_CFG_0_RLEG_MAC_LSB_SET(mac_lsb), sparx5,
+		EACL_RLEG_CFG_0);
+
+	spx5_rmw(EACL_RLEG_CFG_1_RLEG_MAC_MSB_SET(mac_msb) |
+		 EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(rleg_type_sel),
+		 EACL_RLEG_CFG_1_RLEG_MAC_MSB |
+		 EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL,
+		 sparx5, EACL_RLEG_CFG_1);
+}
+
+/* Enable or disable routing of frames received on the leg. */
+static void sparx5_rr_leg_hw_uc_set(struct sparx5 *sparx5,
+				    struct sparx5_rr_router_leg *leg,
+				    bool enable)
+{
+	spx5_rmw(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(enable) |
+		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_SET(enable),
+		 ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA |
+		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, sparx5,
+		 ANA_L3_RLEG_CTRL(leg->vmid));
+}
+
+static void sparx5_rr_leg_hw_init(struct sparx5 *sparx5,
+				  struct sparx5_rr_router_leg *leg)
+{
+	/* Associate Router leg VMID to VLAN */
+	spx5_rmw(ANA_L3_VMID_CFG_VMID_SET(leg->vmid), ANA_L3_VMID_CFG_VMID,
+		 sparx5, ANA_L3_VMID_CFG(leg->vid));
+
+	/* Enable Router leg for VLAN */
+	spx5_rmw(ANA_L3_VLAN_CFG_VLAN_RLEG_ENA_SET(1),
+		 ANA_L3_VLAN_CFG_VLAN_RLEG_ENA, sparx5,
+		 ANA_L3_VLAN_CFG(leg->vid));
+
+	/* Configure router leg */
+
+	spx5_rmw(ANA_L3_RLEG_CTRL_RLEG_EVID_SET(leg->vid),
+		 ANA_L3_RLEG_CTRL_RLEG_EVID, sparx5,
+		 ANA_L3_RLEG_CTRL(leg->vmid));
+
+	sparx5_rr_leg_hw_uc_set(sparx5, leg, true);
+
+	/* Configure egress VLAN in rewriter */
+	spx5_rmw(REW_RLEG_CTRL_RLEG_EVID_SET(leg->vid), REW_RLEG_CTRL_RLEG_EVID,
+		 sparx5, REW_RLEG_CTRL(leg->vmid));
+}
+
+static void sparx5_rr_leg_hw_deinit(struct sparx5 *sparx5,
+				    struct sparx5_rr_router_leg *leg)
+{
+	/* Disable Router leg for VLAN */
+	spx5_rmw(ANA_L3_VLAN_CFG_VLAN_RLEG_ENA_SET(0),
+		 ANA_L3_VLAN_CFG_VLAN_RLEG_ENA, sparx5,
+		 ANA_L3_VLAN_CFG(leg->vid));
+
+	/* Disable IP UC routing on leg */
+	spx5_rmw(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(0) |
+		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_SET(0) |
+		 ANA_L3_RLEG_CTRL_RLEG_EVID_SET(0),
+		 ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA |
+		 ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA |
+		 ANA_L3_RLEG_CTRL_RLEG_EVID, sparx5,
+		 ANA_L3_RLEG_CTRL(leg->vmid));
+
+	/* VMID 0 is harmless, VLAN_RLEG_ENA is already cleared. */
+	spx5_rmw(ANA_L3_VMID_CFG_VMID_SET(0), ANA_L3_VMID_CFG_VMID, sparx5,
+		 ANA_L3_VMID_CFG(leg->vid));
+
+	/* Clear egress VLAN in rewriter */
+	spx5_rmw(REW_RLEG_CTRL_RLEG_EVID_SET(0), REW_RLEG_CTRL_RLEG_EVID,
+		 sparx5, REW_RLEG_CTRL(leg->vmid));
+}
+
+static struct sparx5_rr_router_leg *
+__sparx5_rr_leg_alloc(struct sparx5 *sparx5, struct net_device *dev, u16 vmid,
+		      u16 vid)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	leg = kzalloc_obj(*leg);
+	if (!leg)
+		return NULL;
+
+	leg->dev = dev;
+	leg->vmid = vmid;
+	leg->vid = vid;
+	leg->sparx5 = sparx5;
+
+	return leg;
+}
+
+static struct sparx5_rr_router_leg *
+sparx5_rr_leg_alloc(struct sparx5 *sparx5, struct net_device *dev, u16 vid)
+{
+	struct sparx5_rr_router_leg *leg;
+	int next_vmid;
+
+	next_vmid = sparx5_vmid_alloc(sparx5);
+	if (next_vmid < 0)
+		return ERR_PTR(next_vmid);
+
+	leg = __sparx5_rr_leg_alloc(sparx5, dev, next_vmid, vid);
+	if (!leg)
+		goto err_kzalloc;
+
+	return leg;
+
+err_kzalloc:
+	sparx5_vmid_free(sparx5, next_vmid);
+
+	return ERR_PTR(-ENOMEM);
+}
+
+static void sparx5_rr_router_leg_destroy(struct sparx5_rr_router_leg *leg)
+{
+	struct sparx5 *sparx5 = leg->sparx5;
+
+	dev_dbg(sparx5->dev, "Leg destroy vid=%u vmid=%u dev=%s\n", leg->vid,
+		leg->vmid, netdev_name(leg->dev));
+
+	sparx5_rr_leg_hw_deinit(sparx5, leg);
+	sparx5_vmid_free(leg->sparx5, leg->vmid);
+	list_del(&leg->leg_list_node);
+
+	netdev_put(leg->dev, &leg->dev_tracker);
+	kfree(leg);
+}
+
+static struct sparx5_rr_router_leg *
+sparx5_rr_router_leg_create(struct sparx5 *sparx5, struct net_device *dev,
+			    u16 vid, struct netlink_ext_ack *extack)
+{
+	struct sparx5_rr_router_leg *leg;
+
+	if (sparx5_rr_leg_find_by_vid(sparx5, vid)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "A router leg already exists for this VLAN id");
+		return ERR_PTR(-EBUSY);
+	}
+
+	leg = sparx5_rr_leg_alloc(sparx5, dev, vid);
+	if (IS_ERR(leg)) {
+		if (PTR_ERR(leg) == -ENOSPC)
+			NL_SET_ERR_MSG_MOD(extack,
+					   "No more router legs available in hardware");
+		return leg;
+	}
+
+	netdev_hold(dev, &leg->dev_tracker, GFP_KERNEL);
+
+	/* Global router leg base MAC tracks the bridge MAC. */
+	sparx5_rr_leg_base_mac_set(sparx5, vlan_dev_real_dev(dev)->dev_addr);
+
+	list_add(&leg->leg_list_node, &sparx5->router->leg_list);
+	sparx5_rr_leg_hw_init(sparx5, leg);
+
+	dev_dbg(sparx5->dev, "Leg create dev=%s vid=%u vmid=%u\n", dev->name,
+		leg->vid, leg->vmid);
+
+	return leg;
+}
+
+/* The immediate lower device, unlike vlan_dev_real_dev() which walks
+ * past any intermediate vlan device.
+ */
+static struct net_device *sparx5_rr_vlan_lower_dev(struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
+	return vlan_dev_priv(dev)->real_dev;
+#else
+	return NULL;
+#endif
+}
+
+static bool sparx5_rr_dev_real_is_vlan_aware(struct sparx5 *sparx5,
+					     struct net_device *dev)
+{
+	struct net_device *vlan_rdev;
+	u16 br_proto;
+
+	if (!is_vlan_dev(dev))
+		return false;
+
+	if (!net_eq(dev_net(dev), &init_net))
+		return false;
+
+	/* A master owns the receive path, or for an l3mdev the table. */
+	if (netdev_master_upper_dev_get(dev))
+		return false;
+
+	/* Standalone ports classify into vid 0. */
+	if (vlan_dev_vlan_id(dev) == NULL_VID)
+		return false;
+
+	vlan_rdev = sparx5_rr_vlan_lower_dev(dev);
+	if (sparx5_netdevice_check(vlan_rdev))
+		return false;
+
+	if (!net_eq(dev_net(vlan_rdev), &init_net))
+		return false;
+
+	/* ANA_L3 has one global leg MAC, which tracks the bridge. A
+	 * NET_ADDR_SET upper matches the bytes but stops following.
+	 */
+	if (dev->addr_assign_type != NET_ADDR_STOLEN ||
+	    !ether_addr_equal(dev->dev_addr, vlan_rdev->dev_addr))
+		return false;
+
+	/* Legs program per-VLAN state, only on the offloaded bridge. */
+	if (bitmap_empty(sparx5->bridge_mask, SPX5_PORTS) ||
+	    vlan_rdev != sparx5->hw_bridge_dev ||
+	    !br_vlan_enabled(vlan_rdev))
+		return false;
+
+	/* The chip takes both 0x8100 and 0x88A8 into the leg vid, so
+	 * only an 802.1Q bridge with a matching upper agrees with it.
+	 */
+	if (br_vlan_get_proto(vlan_rdev, &br_proto))
+		return false;
+
+	if (br_proto != ETH_P_8021Q)
+		return false;
+
+	return vlan_dev_vlan_proto(dev) == htons(br_proto);
+}
+
+static bool sparx5_rr_dev_addr_list_empty_rcu(struct net_device *dev)
+{
+	struct inet6_dev *inet6_dev;
+	struct in_device *in_dev;
+
+	in_dev = __in_dev_get_rcu(dev);
+	if (in_dev && rcu_access_pointer(in_dev->ifa_list))
+		return false;
+
+	inet6_dev = __in6_dev_get(dev);
+	if (inet6_dev && !list_empty(&inet6_dev->addr_list))
+		return false;
+
+	return true;
+}
+
+static bool sparx5_rr_dev_addr_list_empty(struct net_device *dev)
+{
+	bool addr_list_empty;
+
+	rcu_read_lock();
+	addr_list_empty = sparx5_rr_dev_addr_list_empty_rcu(dev);
+	rcu_read_unlock();
+
+	return addr_list_empty;
+}
+
+static int __sparx5_rr_inetaddr_event(struct sparx5 *sparx5,
+				      struct net_device *dev,
+				      unsigned long event,
+				      struct netlink_ext_ack *extack)
+{
+	struct sparx5_rr_router_leg *leg;
+	u16 vid;
+
+	switch (event) {
+	case NETDEV_UP:
+		if (!sparx5_rr_dev_real_is_vlan_aware(sparx5, dev))
+			return 0;
+
+		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
+		if (leg)
+			return 0;
+
+		vid = vlan_dev_vlan_id(dev);
+
+		leg = sparx5_rr_router_leg_create(sparx5, dev, vid, extack);
+		if (IS_ERR(leg))
+			return PTR_ERR(leg);
+		break;
+	case NETDEV_DOWN:
+		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
+		if (!leg || !sparx5_rr_dev_addr_list_empty(leg->dev))
+			return 0;
+
+		sparx5_rr_router_leg_destroy(leg);
+		break;
+	}
+
+	return 0;
+}
+
+static int sparx5_rr_inetaddr_event_handle(struct sparx5 *sparx5,
+					   struct net_device *dev,
+					   unsigned long event,
+					   struct netlink_ext_ack *extack)
+{
+	struct sparx5_rr_router_leg *leg;
+	int err;
+
+	if (!net_eq(dev_net(dev), &init_net))
+		return NOTIFY_DONE;
+
+	mutex_lock(&sparx5->router->lock);
+	leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
+	err = __sparx5_rr_inetaddr_event(sparx5, dev, event, extack);
+	if (!leg && sparx5_rr_leg_find_by_dev(sparx5, dev))
+		sparx5_rr_legs_reconcile_schedule(sparx5);
+	mutex_unlock(&sparx5->router->lock);
+
+	if (err) {
+		NL_SET_ERR_MSG_WEAK_MOD(extack,
+					"Failed to offload the L3 router leg");
+		if (!extack && net_ratelimit())
+			netdev_warn(dev, "Failed to offload L3 router leg: %pe\n",
+				    ERR_PTR(err));
+	}
+
+	return NOTIFY_DONE;
+}
+
+/* Called with RTNL. */
+static int sparx5_rr_inet6addr_valid_event(struct notifier_block *nb,
+					   unsigned long event, void *ptr)
+{
+	struct in6_validator_info *i6vi = (struct in6_validator_info *)ptr;
+	struct net_device *dev = i6vi->i6vi_dev->dev;
+	struct sparx5_router *router;
+
+	ASSERT_RTNL();
+
+	if (event != NETDEV_UP)
+		return NOTIFY_DONE;
+
+	router = container_of(nb, struct sparx5_router, inet6addr_valid_nb);
+
+	return sparx5_rr_inetaddr_event_handle(router->sparx5, dev, event,
+					       i6vi->extack);
+}
+
+/* Called in atomic context. */
+static int sparx5_rr_inet6addr_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	struct inet6_ifaddr *if6 = (struct inet6_ifaddr *)ptr;
+	struct net_device *dev = if6->idev->dev;
+	struct sparx5_router *router;
+
+	if (event != NETDEV_DOWN)
+		return NOTIFY_DONE;
+
+	if (!net_eq(dev_net(dev), &init_net))
+		return NOTIFY_DONE;
+
+	if (!is_vlan_dev(dev))
+		return NOTIFY_DONE;
+
+	router = container_of(nb, struct sparx5_router, inet6addr_nb);
+	sparx5_rr_legs_reconcile_schedule(router->sparx5);
+
+	return NOTIFY_DONE;
+}
+
+/* Handle address changes, which manage router legs. Called with RTNL. */
+static int sparx5_rr_inetaddr_event(struct notifier_block *nb,
+				    unsigned long event, void *ptr)
+{
+	struct in_ifaddr *ifa = (struct in_ifaddr *)ptr;
+	struct net_device *dev = ifa->ifa_dev->dev;
+	struct sparx5_router *router;
+
+	ASSERT_RTNL();
+
+	if (event != NETDEV_DOWN)
+		return NOTIFY_DONE;
+
+	router = container_of(nb, struct sparx5_router, inetaddr_nb);
+
+	return sparx5_rr_inetaddr_event_handle(router->sparx5, dev, event,
+					       NULL);
+}
+
+/* Called with RTNL. */
+static int sparx5_rr_inetaddr_valid_event(struct notifier_block *nb,
+					  unsigned long event, void *ptr)
+{
+	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
+	struct net_device *dev = ivi->ivi_dev->dev;
+	struct sparx5_router *router;
+
+	ASSERT_RTNL();
+
+	if (event != NETDEV_UP)
+		return NOTIFY_DONE;
+
+	router = container_of(nb, struct sparx5_router, inetaddr_valid_nb);
+
+	return sparx5_rr_inetaddr_event_handle(router->sparx5, dev, event,
+					       ivi->extack);
+}
+
+/* Called with RTNL. */
+static int sparx5_rr_netdevice_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct sparx5_rr_router_leg *leg;
+	struct sparx5_router *router;
+	struct sparx5 *sparx5;
+
+	ASSERT_RTNL();
+
+	if (!net_eq(dev_net(dev), &init_net))
+		return NOTIFY_OK;
+
+	router = container_of(nb, struct sparx5_router, netdevice_nb);
+	sparx5 = router->sparx5;
+
+	switch (event) {
+	case NETDEV_UNREGISTER:
+		mutex_lock(&router->lock);
+		leg = sparx5_rr_leg_find_by_dev(sparx5, dev);
+		if (leg)
+			sparx5_rr_router_leg_destroy(leg);
+		mutex_unlock(&router->lock);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static void sparx5_rr_router_legs_flush(struct sparx5 *sparx5)
+{
+	struct sparx5_rr_router_leg *leg, *tmp;
+
+	list_for_each_entry_safe(leg, tmp, &sparx5->router->leg_list,
+				 leg_list_node)
+		sparx5_rr_router_leg_destroy(leg);
+}
+
+static void sparx5_rr_legs_reconcile(struct sparx5 *sparx5)
+{
+	struct sparx5_rr_router_leg *leg, *tmp;
+	struct sparx5_router *router;
+
+	ASSERT_RTNL();
+
+	router = sparx5->router;
+
+	mutex_lock(&router->lock);
+	list_for_each_entry_safe(leg, tmp, &router->leg_list, leg_list_node) {
+		if (sparx5_rr_dev_addr_list_empty(leg->dev))
+			sparx5_rr_router_leg_destroy(leg);
+	}
+	mutex_unlock(&router->lock);
+}
+
+static void sparx5_rr_legs_work(struct work_struct *work)
+{
+	struct sparx5_router *router =
+		container_of(work, struct sparx5_router, legs_work);
+
+	rtnl_lock();
+	sparx5_rr_legs_reconcile(router->sparx5);
+	rtnl_unlock();
+}
+
+/* Tear down the router legs of a bridge that is no longer offloaded. */
+void sparx5_rr_bridge_legs_flush(struct sparx5 *sparx5,
+				 const struct net_device *bridge)
+{
+	struct sparx5_rr_router_leg *leg, *tmp;
+
+	if (!sparx5->router)
+		return;
+
+	mutex_lock(&sparx5->router->lock);
+	list_for_each_entry_safe(leg, tmp, &sparx5->router->leg_list,
+				 leg_list_node) {
+		if (vlan_dev_real_dev(leg->dev) == bridge)
+			sparx5_rr_router_leg_destroy(leg);
+	}
+	mutex_unlock(&sparx5->router->lock);
+}
+
+void sparx5_rr_port_fwd_update(struct sparx5 *sparx5)
+{
+	u32 mask[3];
+
+	if (!sparx5->router)
+		return;
+
+	bitmap_to_arr32(mask, sparx5->bridge_fwd_mask, SPX5_PORTS);
+	spx5_wr(mask[0], sparx5, ANA_L3_L3_UC_ENA);
+	if (is_sparx5(sparx5)) {
+		spx5_wr(mask[1], sparx5, ANA_L3_L3_UC_ENA1);
+		spx5_wr(mask[2], sparx5, ANA_L3_L3_UC_ENA2);
+	}
+}
+
+/* Restore the reset values programmed by sparx5_rr_router_init(). */
+static void sparx5_rr_router_hw_deinit(struct sparx5 *sparx5)
+{
+	static const unsigned char zero_mac[ETH_ALEN] __aligned(2);
+
+	sparx5_rr_leg_base_mac_set(sparx5, zero_mac);
+
+	spx5_wr(0, sparx5, ANA_L3_L3_UC_ENA);
+	if (is_sparx5(sparx5)) {
+		spx5_wr(0, sparx5, ANA_L3_L3_UC_ENA1);
+		spx5_wr(0, sparx5, ANA_L3_L3_UC_ENA2);
+	}
+
+	spx5_rmw(ANA_L3_ROUTING_CFG_L3_ENA_MODE_SET(0) |
+		 ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA_SET(0) |
+		 ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA_SET(0) |
+		 ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA_SET(0) |
+		 ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA_SET(0),
+		 ANA_L3_ROUTING_CFG_L3_ENA_MODE |
+		 ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA,
+		 sparx5, ANA_L3_ROUTING_CFG);
+	/* IP4_TTL_REDIR_ENA and IP6_HC_REDIR_ENA reset to 1, as init sets them. */
+
+	spx5_rmw(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL_SET(2),
+		 ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, sparx5,
+		 ANA_ACL_VCAP_S2_MISC_CTRL);
+}
+
+int sparx5_rr_router_init(struct sparx5 *sparx5)
+{
+	struct sparx5_router *r;
+	int err;
+
+	/* No leg can exist without CONFIG_VLAN_8021Q. */
+	if (!IS_ENABLED(CONFIG_VLAN_8021Q))
+		return 0;
+
+	if (WARN_ON(!sparx5->data->consts->vmid_cnt ||
+		    sparx5->data->consts->vmid_cnt > SPARX5_ROUTER_LEG_N_VMID))
+		return -EINVAL;
+
+	r = kzalloc_obj(*r);
+	if (!r)
+		return -ENOMEM;
+
+	mutex_init(&r->lock);
+	r->sparx5 = sparx5;
+
+	INIT_LIST_HEAD(&r->leg_list);
+
+	sparx5->router = r;
+
+	r->sparx5_router_owq = alloc_ordered_workqueue("sparx5_router_owq", 0);
+	if (!r->sparx5_router_owq) {
+		err = -ENOMEM;
+		goto err_free_router;
+	}
+	INIT_WORK(&r->legs_work, sparx5_rr_legs_work);
+
+	sparx5_rr_port_fwd_update(sparx5);
+
+	/* Enable routing and global router options */
+	spx5_rmw(ANA_L3_ROUTING_CFG_L3_ENA_MODE_SET(1) |
+		 ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA_SET(1) |
+		 ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA_SET(1),
+		 ANA_L3_ROUTING_CFG_L3_ENA_MODE |
+		 ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA |
+		 ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA,
+		 sparx5, ANA_L3_ROUTING_CFG);
+
+	/* Do the routing frame edits in ANA_ACL rather than REW, so routing
+	 * combines with PTP.
+	 */
+	spx5_rmw(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL_SET(1),
+		 ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, sparx5,
+		 ANA_ACL_VCAP_S2_MISC_CTRL);
+
+	r->inetaddr_nb.notifier_call = sparx5_rr_inetaddr_event;
+	err = register_inetaddr_notifier(&r->inetaddr_nb);
+	if (err)
+		goto err_router_hw_deinit;
+
+	r->inetaddr_valid_nb.notifier_call = sparx5_rr_inetaddr_valid_event;
+	err = register_inetaddr_validator_notifier(&r->inetaddr_valid_nb);
+	if (err)
+		goto err_unreg_inet_notifier;
+
+	r->netdevice_nb.notifier_call = sparx5_rr_netdevice_event;
+	err = register_netdevice_notifier(&r->netdevice_nb);
+	if (err)
+		goto err_unreg_inet_addr_val_notifier;
+
+	r->inet6addr_valid_nb.notifier_call = sparx5_rr_inet6addr_valid_event;
+	err = register_inet6addr_validator_notifier(&r->inet6addr_valid_nb);
+	if (err)
+		goto err_unreg_netdev_notifier;
+
+	r->inet6addr_nb.notifier_call = sparx5_rr_inet6addr_event;
+	err = register_inet6addr_notifier(&r->inet6addr_nb);
+	if (err)
+		goto err_unreg_inet6_addr_val_notifier;
+
+	return 0;
+
+err_unreg_inet6_addr_val_notifier:
+	unregister_inet6addr_validator_notifier(&r->inet6addr_valid_nb);
+err_unreg_netdev_notifier:
+	unregister_netdevice_notifier(&r->netdevice_nb);
+err_unreg_inet_addr_val_notifier:
+	unregister_inetaddr_validator_notifier(&r->inetaddr_valid_nb);
+err_unreg_inet_notifier:
+	unregister_inetaddr_notifier(&r->inetaddr_nb);
+err_router_hw_deinit:
+	sparx5_rr_router_hw_deinit(sparx5);
+	destroy_workqueue(r->sparx5_router_owq);
+err_free_router:
+	sparx5->router = NULL;
+	mutex_destroy(&r->lock);
+	kfree(r);
+
+	return err;
+}
+
+void sparx5_rr_router_deinit(struct sparx5 *sparx5)
+{
+	struct sparx5_router *router = sparx5->router;
+
+	if (!router)
+		return;
+
+	unregister_inet6addr_notifier(&router->inet6addr_nb);
+	unregister_inet6addr_validator_notifier(&router->inet6addr_valid_nb);
+	unregister_netdevice_notifier(&router->netdevice_nb);
+	unregister_inetaddr_validator_notifier(&router->inetaddr_valid_nb);
+	unregister_inetaddr_notifier(&router->inetaddr_nb);
+	destroy_workqueue(router->sparx5_router_owq);
+	sparx5_rr_router_legs_flush(sparx5);
+	sparx5_rr_router_hw_deinit(sparx5);
+	sparx5->router = NULL;
+	mutex_destroy(&router->lock);
+	kfree(router);
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
index dac4dd833127..46b3351f717f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_switchdev.c
@@ -227,8 +227,11 @@ static void sparx5_port_bridge_leave(struct sparx5_port *port,
 	switchdev_bridge_port_unoffload(port->ndev, NULL, NULL, NULL);
 
 	clear_bit(port->portno, sparx5->bridge_mask);
-	if (bitmap_empty(sparx5->bridge_mask, SPX5_PORTS))
+	if (bitmap_empty(sparx5->bridge_mask, SPX5_PORTS)) {
+		/* L3 offload has no datapath left on this bridge. */
+		sparx5_rr_bridge_legs_flush(sparx5, bridge);
 		sparx5->hw_bridge_dev = NULL;
+	}
 
 	/* Clear bridge vlan settings before updating the port settings */
 	port->vlan_aware = 0;
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
index 494782871903..96edb05af5b7 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vlan.c
@@ -199,6 +199,8 @@ void sparx5_update_fwd(struct sparx5 *sparx5)
 		spx5_wr(mask[1], sparx5, ANA_L2_AUTO_LRN_CFG1);
 		spx5_wr(mask[2], sparx5, ANA_L2_AUTO_LRN_CFG2);
 	}
+
+	sparx5_rr_port_fwd_update(sparx5);
 }
 
 void sparx5_vlan_port_apply(struct sparx5 *sparx5,

-- 
2.52.0

