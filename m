Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B2C3AD531;
	Mon, 10 Aug 2026 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361025; cv=none; b=jgKwXe/bakoOrbF2rX37lNZSmWo7ggaeAFWim35K+qZ/4F3RCpLPvNZJFQu6iof5sIsg2W74oKvapvJ563IIOGK21wK8RilyGW5QzRxU2pIWOn/88slBtJOlKdtRVztztgeHD29QJxi4OTAnBa5Cx+hqMyzLbemSe/PeuewXMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361025; c=relaxed/simple;
	bh=Nb4mdXaHJMZNrjDyYT5myhGF7dKDRlGfcen4+EL+mB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=O1HTXZ7TqwCXIdM55BTyT77aCfGrb3rVrARhiTKRP7TzJlO6+x+4r9hLjybqmjOTJ9+kx7MaSd8q/hjMP4dVMgY7GiyuIrSITIiBKJMs1OwKuYUFfBXI8nf/ZkB/ZdkIiVIrLdU8kSvR4Ims9IiT+nde+MqmOUiD3lbOtYy7x5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nc5/9rNQ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nc5/9rNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786361024; x=1817897024;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Nb4mdXaHJMZNrjDyYT5myhGF7dKDRlGfcen4+EL+mB4=;
  b=nc5/9rNQQM+7HOm9jJbPERfLY6lX+O7xDhb7WH+3jWnvKWJWKPPQ9eSS
   pbg/+xJNHzs/SFkAvRljHqltIBIUpMRHeN3vLqZeXTbgukioEbcy9EriW
   pmUDtJGi+uTKJnHnwO4yZdDUtSpxwZE/KKj9JAQEZAxOpm+R1DRt0vMwd
   xuVabYoM/G+WiyjFIAGvXxPsg/Kc/lb/eOSQnkpXty2jHHkoVg9yjD7ih
   od43qhRB3OjofMrindW1ASYlzqDrzX3gTabnc4n6e1hFDrefyJDaapd9j
   pFL1IK/D+DoE4kwRLlfRpJFSwrkn9E7XqU6T7LG+BqxFlI97J7cI53lT1
   A==;
X-CSE-ConnectionGUID: HVuSDFkuS2muVFor/OqiNA==
X-CSE-MsgGUID: B8VIR86PSpiLbdFE4RTcYQ==
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="61894154"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 04:23:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 10 Aug 2026 04:23:40 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 10 Aug 2026 04:23:37 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Mon, 10 Aug 2026 13:20:49 +0200
Subject: [PATCH net-next v2 4/9] net: microchip: vcap: expose helpers in
 vcap api and update debugfs
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260810-sparx5_l3_routing-v2-4-59e68cc8c8ca@microchip.com>
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

Add new helpers to the vcap client api, in preparation for L3 routing
functionality:

 - vcap_val_add_rule(): wraps vcap_val_rule() + vcap_add_rule().
 - vcap_rule_mod_action_bit(): modify a bit-typed action on an existing
   rule.

Rename VCAP_CID_PREROUTING to VCAP_CID_PREROUTING_L0 and add
VCAP_USER_L3, both needed by the upcoming LPM VCAP user.

Extend the debugfs display to handle the new IP4_XIP and IP6_XIP key
fields.

Fix a latent undefined-behaviour bug in the debugfs action-field
printer. The old mask expression (1 << width) - 1 is UB when width is
32. The bug is unreachable before this series, since no existing field
in any client hits this, but the LPM VCAP introduces VCAP_AF_MAC_LSB
which is 32 bit wide.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
Changes in v2:
- Zero-initialise the client actionfield data in
  vcap_rule_mod_action_bit() to avoid copying uninitialised stack bytes.
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c     | 25 ++++++++++++++++++++++
 drivers/net/ethernet/microchip/vcap/vcap_api.h     |  4 +++-
 .../net/ethernet/microchip/vcap/vcap_api_client.h  |  6 ++++++
 .../net/ethernet/microchip/vcap/vcap_api_debugfs.c | 13 ++++++++---
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 6e1ee15b82b7..1ad2c44da8bd 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -2389,6 +2389,19 @@ int vcap_add_rule(struct vcap_rule *rule)
 }
 EXPORT_SYMBOL_GPL(vcap_add_rule);
 
+/* Validate and add rule to a VCAP instance */
+int vcap_val_add_rule(struct vcap_rule *rule, u16 l3_proto)
+{
+	int err;
+
+	err = vcap_val_rule(rule, l3_proto);
+	if (err)
+		return err;
+
+	return vcap_add_rule(rule);
+}
+EXPORT_SYMBOL_GPL(vcap_val_add_rule);
+
 /* Allocate a new rule with the provided arguments */
 struct vcap_rule *vcap_alloc_rule(struct vcap_control *vctrl,
 				  struct net_device *ndev, int vcap_chain_id,
@@ -3560,6 +3573,18 @@ int vcap_rule_mod_action_u32(struct vcap_rule *rule,
 }
 EXPORT_SYMBOL_GPL(vcap_rule_mod_action_u32);
 
+/* Modify a bit action with value in the rule */
+int vcap_rule_mod_action_bit(struct vcap_rule *rule,
+			     enum vcap_action_field action,
+			     enum vcap_bit val)
+{
+	struct vcap_client_actionfield_data data = {};
+
+	vcap_rule_set_action_bitsize(&data.u1, val);
+	return vcap_rule_mod_action(rule, action, VCAP_FIELD_BIT, &data);
+}
+EXPORT_SYMBOL_GPL(vcap_rule_mod_action_bit);
+
 /* Drop keys in a keylist and any keys that are not supported by the keyset */
 int vcap_filter_rule_keys(struct vcap_rule *rule,
 			  enum vcap_key_field keylist[], int length,
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.h b/drivers/net/ethernet/microchip/vcap/vcap_api.h
index 05b4b02e59ef..011d1cb7b594 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.h
@@ -22,7 +22,7 @@
 #define VCAP_CID_INGRESS_L5          1500000 /* Ingress Stage 1 Lookup 5 */
 
 #define VCAP_CID_PREROUTING_IPV6     3000000 /* Prerouting Stage */
-#define VCAP_CID_PREROUTING          6000000 /* Prerouting Stage */
+#define VCAP_CID_PREROUTING_L0       6000000 /* Prerouting Stage Lookup 0 */
 
 #define VCAP_CID_INGRESS_STAGE2_L0   8000000 /* Ingress Stage 2 Lookup 0 */
 #define VCAP_CID_INGRESS_STAGE2_L1   8100000 /* Ingress Stage 2 Lookup 1 */
@@ -41,7 +41,9 @@ enum vcap_user {
 	VCAP_USER_MRP,
 	VCAP_USER_CFM,
 	VCAP_USER_VLAN,
+	VCAP_USER_L3,
 	VCAP_USER_QOS,
+	/* permanent enabled users above here */
 	VCAP_USER_VCAP_UTIL,
 	VCAP_USER_TC,
 	VCAP_USER_TC_EXTRA,
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
index cdf79e17ca54..3f17e1e76b7d 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
@@ -167,6 +167,8 @@ void vcap_free_rule(struct vcap_rule *rule);
 int vcap_val_rule(struct vcap_rule *rule, u16 l3_proto);
 /* Add rule to a VCAP instance */
 int vcap_add_rule(struct vcap_rule *rule);
+/* Validate and add rule to a VCAP instance */
+int vcap_val_add_rule(struct vcap_rule *rule, u16 l3_proto);
 /* Delete rule in a VCAP instance */
 int vcap_del_rule(struct vcap_control *vctrl, struct net_device *ndev, u32 id);
 /* Make a full copy of an existing rule with a new rule id */
@@ -266,6 +268,10 @@ int vcap_rule_mod_key_u32(struct vcap_rule *rule, enum vcap_key_field key,
 int vcap_rule_mod_action_u32(struct vcap_rule *rule,
 			     enum vcap_action_field action,
 			     u32 value);
+/* Modify a bit action with value in the rule */
+int vcap_rule_mod_action_bit(struct vcap_rule *rule,
+			     enum vcap_action_field action,
+			     enum vcap_bit val);
 
 /* Get a 32 bit key field value and mask from the rule */
 int vcap_rule_get_key_u32(struct vcap_rule *rule, enum vcap_key_field key,
diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
index e0c65c7ab23e..36150822ce15 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
@@ -40,7 +40,8 @@ static void vcap_debugfs_show_rule_keyfield(struct vcap_control *vctrl,
 		value = (u8 *)(&data->u32.value);
 		mask = (u8 *)(&data->u32.mask);
 
-		if (key == VCAP_KF_L3_IP4_SIP || key == VCAP_KF_L3_IP4_DIP) {
+		if (key == VCAP_KF_L3_IP4_SIP || key == VCAP_KF_L3_IP4_DIP ||
+		    key == VCAP_KF_IP4_XIP) {
 			out->prf(out->dst, "%pI4h/%pI4h", &data->u32.value,
 				 &data->u32.mask);
 		} else if (key == VCAP_KF_ETYPE ||
@@ -88,7 +89,8 @@ static void vcap_debugfs_show_rule_keyfield(struct vcap_control *vctrl,
 	case VCAP_FIELD_U128:
 		value = data->u128.value;
 		mask = data->u128.mask;
-		if (key == VCAP_KF_L3_IP6_SIP || key == VCAP_KF_L3_IP6_DIP) {
+		if (key == VCAP_KF_L3_IP6_SIP || key == VCAP_KF_L3_IP6_DIP ||
+		    key == VCAP_KF_IP6_XIP) {
 			u8 nvalue[16], nmask[16];
 
 			vcap_netbytes_copy(nvalue, data->u128.value,
@@ -133,7 +135,12 @@ vcap_debugfs_show_rule_actionfield(struct vcap_control *vctrl,
 		out->prf(out->dst, "%d", value[0]);
 		break;
 	case VCAP_FIELD_U32:
-		fmsk = (1 << actionfield[action].width) - 1;
+		if (action == VCAP_AF_MAC_LSB || action == VCAP_AF_MAC_MSB) {
+			hex = true;
+			break;
+		}
+		fmsk = actionfield[action].width ?
+		       GENMASK(actionfield[action].width - 1, 0) : 0;
 		val = *(u32 *)value;
 		out->prf(out->dst, "%u", val & fmsk);
 		break;

-- 
2.52.0

