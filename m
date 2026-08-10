Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AA3C108B;
	Mon, 10 Aug 2026 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361031; cv=none; b=MY85qpXI1ZuY6rq/Fu/bgvh7Tg5xufvizL00tWA0bLpXTr0r90m0C+YyIssxCaxbRE+DNwaWHfmVuclHmBC10VZjSOlMQyvWRff7IOQ9ZT3ilRUtTapuJ+QEaF83+pCjbz+zhY2uHFXECwhyYdG/3g3eM4Uej742YfH7ci5oSvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361031; c=relaxed/simple;
	bh=4gs7XsUMaxxDsPQlZcnvjhq+TtMsQtG3hxgfHmatxJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tf52uaeybw9MvMSpP2O+rEHZLIYIKbyAa+dIlEl55c6vcN1o58Xl3w70phctzh5ouHpBPyQNM0NqNMBRVANRE4r4tiTiinksOD2X0u6xPnBKMjJzlswMi4QMUIGVhh/XYIkmdUOsZ6bvTJYWso9Wa7uuTVVW8a70YPmFNLP5YTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RuXtiSLY; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RuXtiSLY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786361033; x=1817897033;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4gs7XsUMaxxDsPQlZcnvjhq+TtMsQtG3hxgfHmatxJI=;
  b=RuXtiSLY51zlmh6Xp6s347Zn10/lGRDcKDh6sg//2X6VLHUf++QU9ixz
   sQMp1A3LCx1/jmDZ/2sx6dx882vbzJiSd5lTLkzUOdLPJtMTYtduGL5m9
   dwAWwm7UlGCVahNrhnTwLCUfWqRSwUWDkuI66BcwpskeqK5ELD1Th4xMF
   lHlrFrBf3EPxPRvYadCtKBuwoWhzy+0oWjlkwI06wzx92cHjfzTbbFTbs
   qQy9F0+GcGlI8t3Kn2QcnrWqKnVdNVn4F6WsPeu268ifrJIC1RFSissFf
   p+iQhgJuZHFoRtE4i8ABQL2zq+/OM+S/jedTjXz//IteTZzvIa8/CnTWv
   A==;
X-CSE-ConnectionGUID: 17a5XkrDTG22KXV8IoxI5A==
X-CSE-MsgGUID: /RVOJBfbTv6790khpOqJkQ==
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="229030162"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2026 04:23:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 10 Aug 2026 04:23:48 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 10 Aug 2026 04:23:45 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 10 Aug 2026 13:20:51 +0200
Subject: [PATCH net-next v2 6/9] net: sparx5: vcap: add lpm vcap
 implementation
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260810-sparx5_l3_routing-v2-6-59e68cc8c8ca@microchip.com>
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

Add the implementation for the LPM VCAP for lan969x and sparx5. The LPM
VCAP has a static keyset configuration, and a single lookup dedicated to
LPM, so this is straight forward, and many functions can use existing
functionality.

The LPM VCAP is allocated from the Super VCAP Blocks, which is shared
amongst different VCAPs. All blocks are used, so we steal a block from
IS0, which had 2 assigned. Since we statically assign blocks, this means
IS0 has half the available address space for vcap rules, compared to
before.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_vcap_impl.c   |  12 ++
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.c   | 159 ++++++++++++++++++++-
 .../ethernet/microchip/sparx5/sparx5_vcap_impl.h   |   5 +
 3 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
index 543a1f2bf6bd..6e6a1f833dea 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_vcap_impl.c
@@ -82,4 +82,16 @@ const struct sparx5_vcap_inst lan969x_vcap_inst_cfg[] = {
 		.count = 1024,
 		.ingress = false,
 	},
+	{
+		.vtype = VCAP_TYPE_LPM,
+		.vinst = 0,
+		.map_id = 6,
+		.lookups = SPARX5_LPM_LOOKUPS,
+		.lookups_per_instance = SPARX5_LPM_LOOKUPS,
+		.first_cid = SPARX5_VCAP_CID_LPM_L0,
+		.last_cid = SPARX5_VCAP_CID_LPM_MAX,
+		.blockno = 5,
+		.blocks = 1,
+		.ingress = true,
+	},
 };
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
index cf332de6bf73..20450462e2d8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.c
@@ -54,8 +54,8 @@ const struct sparx5_vcap_inst sparx5_vcap_inst_cfg[] = {
 		.lookups_per_instance = SPARX5_IS0_LOOKUPS / 3,
 		.first_cid = SPARX5_VCAP_CID_IS0_L0,
 		.last_cid = SPARX5_VCAP_CID_IS0_L2 - 1,
-		.blockno = 8, /* Maps block 8-9 */
-		.blocks = 2,
+		.blockno = 8, /* Maps block 8 */
+		.blocks = 1,
 		.ingress = true,
 	},
 	{
@@ -124,6 +124,18 @@ const struct sparx5_vcap_inst sparx5_vcap_inst_cfg[] = {
 		.count = 12288, /* Addresses according to datasheet */
 		.ingress = false,
 	},
+	{
+		.vtype = VCAP_TYPE_LPM,
+		.vinst = 0,
+		.map_id = 6,
+		.lookups = SPARX5_LPM_LOOKUPS,
+		.lookups_per_instance = SPARX5_LPM_LOOKUPS,
+		.first_cid = SPARX5_VCAP_CID_LPM_L0,
+		.last_cid = SPARX5_VCAP_CID_LPM_MAX,
+		.blockno = 9,
+		.blocks = 1,
+		.ingress = true,
+	},
 };
 
 /* These protocols have dedicated keysets in IS0 and a TC dissector */
@@ -149,6 +161,12 @@ static u16 sparx5_vcap_es2_known_etypes[] = {
 	ETH_P_IPV6,
 };
 
+static u16 sparx5_vcap_lpm_known_etypes[] = {
+	ETH_P_ALL,
+	ETH_P_IP,
+	ETH_P_IPV6,
+};
+
 static void sparx5_vcap_type_err(struct sparx5 *sparx5,
 				 struct vcap_admin *admin,
 				 const char *fname)
@@ -195,6 +213,7 @@ static void _sparx5_vcap_range_init(struct sparx5 *sparx5,
 	u32 size = count - 1;
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
 	case VCAP_TYPE_IS0:
 	case VCAP_TYPE_IS2:
 		spx5_wr(VCAP_SUPER_CFG_MV_NUM_POS_SET(0) |
@@ -386,6 +405,11 @@ static int sparx5_vcap_es2_cid_to_lookup(int cid)
 	return lookup;
 }
 
+static int sparx5_vcap_lpm_cid_to_lookup(int cid)
+{
+	return 0;
+}
+
 /* Add ethernet type IS0 keyset to a list */
 static void
 sparx5_vcap_is0_get_port_etype_keysets(struct vcap_keyset_list *keysetlist,
@@ -401,6 +425,28 @@ sparx5_vcap_is0_get_port_etype_keysets(struct vcap_keyset_list *keysetlist,
 	}
 }
 
+static int sparx5_vcap_lpm_get_port_keysets(struct net_device *ndev,
+					    int lookup,
+					    struct vcap_keyset_list *keysetlist,
+					    u16 l3_proto)
+{
+	/* LPM keysets are static. */
+	if (l3_proto == ETH_P_ALL) {
+		vcap_keyset_list_add(keysetlist, VCAP_KFS_DBL_IP4);
+		vcap_keyset_list_add(keysetlist, VCAP_KFS_SGL_IP4);
+		vcap_keyset_list_add(keysetlist, VCAP_KFS_DBL_IP6);
+		vcap_keyset_list_add(keysetlist, VCAP_KFS_SGL_IP6);
+	} else if (l3_proto == ETH_P_IP) {
+		vcap_keyset_list_add(keysetlist, VCAP_KFS_DBL_IP4);
+		vcap_keyset_list_add(keysetlist, VCAP_KFS_SGL_IP4);
+	} else if (l3_proto == ETH_P_IPV6) {
+		vcap_keyset_list_add(keysetlist, VCAP_KFS_DBL_IP6);
+		vcap_keyset_list_add(keysetlist, VCAP_KFS_SGL_IP6);
+	}
+
+	return 0;
+}
+
 /* Return the list of keysets for the vcap port configuration */
 static int sparx5_vcap_is0_get_port_keysets(struct net_device *ndev,
 					    int lookup,
@@ -683,6 +729,11 @@ int sparx5_vcap_get_port_keyset(struct net_device *ndev,
 	struct sparx5_port *port;
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
+		lookup = sparx5_vcap_lpm_cid_to_lookup(cid);
+		err = sparx5_vcap_lpm_get_port_keysets(ndev, lookup, kslist,
+						       l3_proto);
+		break;
 	case VCAP_TYPE_IS0:
 		lookup = sparx5_vcap_is0_cid_to_lookup(cid);
 		err = sparx5_vcap_is0_get_port_keysets(ndev, lookup, kslist,
@@ -716,6 +767,10 @@ bool sparx5_vcap_is_known_etype(struct vcap_admin *admin, u16 etype)
 	int size, idx;
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
+		known_etypes = sparx5_vcap_lpm_known_etypes;
+		size = ARRAY_SIZE(sparx5_vcap_lpm_known_etypes);
+		break;
 	case VCAP_TYPE_IS0:
 		known_etypes = sparx5_vcap_is0_known_etypes;
 		size = ARRAY_SIZE(sparx5_vcap_is0_known_etypes);
@@ -760,6 +815,11 @@ sparx5_vcap_validate_keyset(struct net_device *ndev,
 
 	/* Get a list of currently configured keysets in the lookups */
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
+		lookup = sparx5_vcap_lpm_cid_to_lookup(rule->vcap_chain_id);
+		sparx5_vcap_lpm_get_port_keysets(ndev, lookup, &keysetlist,
+						 l3_proto);
+		break;
 	case VCAP_TYPE_IS0:
 		lookup = sparx5_vcap_is0_cid_to_lookup(rule->vcap_chain_id);
 		sparx5_vcap_is0_get_port_keysets(ndev, lookup, &keysetlist,
@@ -873,6 +933,9 @@ static void sparx5_vcap_add_default_fields(struct net_device *ndev,
 
 	/* add the lookup bit */
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
+		/* LPM VCAP has no default fields */
+		break;
 	case VCAP_TYPE_IS0:
 	case VCAP_TYPE_IS2:
 		sparx5_vcap_ingress_add_default_fields(ndev, admin, rule);
@@ -1083,6 +1146,46 @@ static void sparx5_vcap_es2_cache_write(struct sparx5 *sparx5,
 	}
 }
 
+static void sparx5_vcap_lpm_cache_write(struct sparx5 *sparx5,
+					struct vcap_admin *admin,
+					enum vcap_selection sel,
+					u32 start,
+					u32 count)
+{
+	u32 *keystr, *mskstr, *actstr;
+	int idx;
+
+	keystr = &admin->cache.keystream[start];
+	mskstr = &admin->cache.maskstream[start];
+	actstr = &admin->cache.actionstream[start];
+
+	switch (sel) {
+	case VCAP_SEL_ENTRY:
+		for (idx = 0; idx < count; ++idx) {
+			/* Avoid 'match-off' by setting value & mask */
+			spx5_wr(keystr[idx] & mskstr[idx], sparx5,
+				VCAP_SUPER_VCAP_ENTRY_DAT(idx));
+			spx5_wr(~mskstr[idx], sparx5,
+				VCAP_SUPER_VCAP_MASK_DAT(idx));
+		}
+		break;
+	case VCAP_SEL_ACTION:
+		for (idx = 0; idx < count; ++idx)
+			spx5_wr(actstr[idx], sparx5,
+				VCAP_SUPER_VCAP_ACTION_DAT(idx));
+		break;
+	case VCAP_SEL_ALL:
+		pr_err("%s:%d: cannot write all streams at once\n", __func__,
+		       __LINE__);
+		break;
+	default:
+		break;
+	}
+	if (sel & VCAP_SEL_COUNTER)
+		spx5_wr(admin->cache.counter, sparx5,
+			VCAP_SUPER_VCAP_CNT_DAT(0));
+}
+
 /* API callback used for writing to the VCAP cache */
 static void sparx5_vcap_cache_write(struct net_device *ndev,
 				    struct vcap_admin *admin,
@@ -1094,6 +1197,9 @@ static void sparx5_vcap_cache_write(struct net_device *ndev,
 	struct sparx5 *sparx5 = port->sparx5;
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
+		sparx5_vcap_lpm_cache_write(sparx5, admin, sel, start, count);
+		break;
 	case VCAP_TYPE_IS0:
 		sparx5_vcap_is0_cache_write(sparx5, admin, sel, start, count);
 		break;
@@ -1273,6 +1379,41 @@ static void sparx5_vcap_es2_cache_read(struct sparx5 *sparx5,
 	}
 }
 
+static void sparx5_vcap_lpm_cache_read(struct sparx5 *sparx5,
+				       struct vcap_admin *admin,
+				       enum vcap_selection sel,
+				       u32 start,
+				       u32 count)
+{
+	u32 *keystr, *mskstr, *actstr;
+	int idx;
+
+	keystr = &admin->cache.keystream[start];
+	mskstr = &admin->cache.maskstream[start];
+	actstr = &admin->cache.actionstream[start];
+
+	if (sel & VCAP_SEL_ENTRY) {
+		for (idx = 0; idx < count; ++idx) {
+			keystr[idx] = spx5_rd(sparx5,
+					      VCAP_SUPER_VCAP_ENTRY_DAT(idx));
+			mskstr[idx] = ~spx5_rd(sparx5,
+					       VCAP_SUPER_VCAP_MASK_DAT(idx));
+		}
+	}
+
+	if (sel & VCAP_SEL_ACTION)
+		for (idx = 0; idx < count; ++idx)
+			actstr[idx] = spx5_rd(sparx5,
+					      VCAP_SUPER_VCAP_ACTION_DAT(idx));
+
+	if (sel & VCAP_SEL_COUNTER) {
+		u32 val = spx5_rd(sparx5, VCAP_SUPER_VCAP_CNT_DAT(0));
+
+		admin->cache.counter = val;
+		admin->cache.sticky = !!val;
+	}
+}
+
 /* API callback used for reading from the VCAP into the VCAP cache */
 static void sparx5_vcap_cache_read(struct net_device *ndev,
 				   struct vcap_admin *admin,
@@ -1284,6 +1425,9 @@ static void sparx5_vcap_cache_read(struct net_device *ndev,
 	struct sparx5 *sparx5 = port->sparx5;
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
+		sparx5_vcap_lpm_cache_read(sparx5, admin, sel, start, count);
+		break;
 	case VCAP_TYPE_IS0:
 		sparx5_vcap_is0_cache_read(sparx5, admin, sel, start, count);
 		break;
@@ -1379,6 +1523,7 @@ static void sparx5_vcap_update(struct net_device *ndev,
 	struct sparx5 *sparx5 = port->sparx5;
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
 	case VCAP_TYPE_IS0:
 	case VCAP_TYPE_IS2:
 		sparx5_vcap_super_update(sparx5, cmd, sel, addr);
@@ -1475,6 +1620,7 @@ static void sparx5_vcap_move(struct net_device *ndev, struct vcap_admin *admin,
 	}
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
 	case VCAP_TYPE_IS0:
 	case VCAP_TYPE_IS2:
 		sparx5_vcap_super_move(sparx5, addr, cmd, mv_num_pos, mv_size);
@@ -1743,6 +1889,8 @@ void sparx5_vcap_set_port_keyset(struct net_device *ndev,
 	int lookup;
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
+		break;
 	case VCAP_TYPE_IS0:
 		lookup = sparx5_vcap_is0_cid_to_lookup(cid);
 		if (orig)
@@ -1879,6 +2027,9 @@ static void sparx5_vcap_port_key_selection(struct sparx5 *sparx5,
 	case VCAP_TYPE_ES2:
 		sparx5_vcap_es2_port_key_selection(sparx5, admin);
 		break;
+	case VCAP_TYPE_LPM:
+		/* VCAP LPM key selection is static */
+		break;
 	default:
 		sparx5_vcap_type_err(sparx5, admin, __func__);
 		break;
@@ -1920,6 +2071,9 @@ static void sparx5_vcap_port_key_deselection(struct sparx5 *sparx5,
 					 sparx5,
 					 EACL_VCAP_ES2_KEY_SEL(portno, lookup));
 		break;
+	case VCAP_TYPE_LPM:
+		/* LPM key selection is static */
+		break;
 	default:
 		sparx5_vcap_type_err(sparx5, admin, __func__);
 		break;
@@ -1979,6 +2133,7 @@ static void sparx5_vcap_block_alloc(struct sparx5 *sparx5,
 	int idx, cores;
 
 	switch (admin->vtype) {
+	case VCAP_TYPE_LPM:
 	case VCAP_TYPE_IS0:
 	case VCAP_TYPE_IS2:
 		/* Super VCAP block mapping and address configuration. Block 0
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.h b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.h
index d0a42406bf26..94c77a60e4f8 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_vcap_impl.h
@@ -20,6 +20,7 @@
 #define SPARX5_IS0_LOOKUPS 6
 #define SPARX5_ES0_LOOKUPS 1
 #define SPARX5_ES2_LOOKUPS 2
+#define SPARX5_LPM_LOOKUPS 1
 
 #define SPARX5_VCAP_CID_IS0_L0 VCAP_CID_INGRESS_L0 /* IS0/CLM lookup 0 */
 #define SPARX5_VCAP_CID_IS0_L1 VCAP_CID_INGRESS_L1 /* IS0/CLM lookup 1 */
@@ -30,6 +31,10 @@
 #define SPARX5_VCAP_CID_IS0_MAX \
 	(VCAP_CID_INGRESS_L5 + VCAP_CID_LOOKUP_SIZE - 1) /* IS0/CLM Max */
 
+#define SPARX5_VCAP_CID_LPM_L0 VCAP_CID_PREROUTING_L0 /* LPM lookup 0 */
+#define SPARX5_VCAP_CID_LPM_MAX \
+	(VCAP_CID_PREROUTING_L0 + VCAP_CID_LOOKUP_SIZE - 1) /* LPM Max */
+
 #define SPARX5_VCAP_CID_IS2_L0 VCAP_CID_INGRESS_STAGE2_L0 /* IS2 lookup 0 */
 #define SPARX5_VCAP_CID_IS2_L1 VCAP_CID_INGRESS_STAGE2_L1 /* IS2 lookup 1 */
 #define SPARX5_VCAP_CID_IS2_L2 VCAP_CID_INGRESS_STAGE2_L2 /* IS2 lookup 2 */

-- 
2.52.0

