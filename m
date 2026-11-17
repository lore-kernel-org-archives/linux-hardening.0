Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921496;
	b=M3lleyDJqRF4ZYgt0Ozfl8LmzyXdvb+x/NMCk3x19atvfrC4S8g7BVitHL1pEuHdGlvn
	 5vhEJba6RiueJjSliGTZen+3qdEOacCzJENQXyIVDu7HaNoESf/Y8NQC+5XLSuEZrr/bc
	 NLL4NBtszFlB5UBetsVjDr4G2IQfaABS+MnvJpXEAacqESXdhnbuJ5DX+HSSjM+cpWOKC
	 VxNkhIdFBbk6l7IeTx8gnbot9x7DrfcP7Ck/2GFgAHbr51UvzNcsnjyEDLyG39vSKLGLn
	 qZePLIsA0UJ8tv4sp0DMsSLeQbpEW1BWmgImck2sCmaTKuo5B48RrcfkGhk27rAOTaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921496;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=lo+eud9QBy9Mhh7jiBe4DkOyfA3rlFDhT8A9XsI5gxA=;
	b=X9l0qxmua9aIMNp/BpxGxVrMKn6izgLX7pH7pZm0EBBrqgB39utnEdgRmudjS8rYlRPG
	 5EVeUaF3JGuNQBOevC0idq6OoE1bVXyiSbpV5emEYjAmwUuXI76Ng2lhhbjl+26lgTvEH
	 HAbEOaz8J6hwPY/C+NdLx/4lebyl8Wow86xy2phj+ozRILmbiy+tuJfEl2QTqufa5qGpt
	 795MORXsjT/D/qdGKIqu/3Q/dMrONF5Bn236rqcQU6Lz5yAjj1WjOfd7j9MZAdOI64Hcr
	 doJC2NjNABNNpxc74hWDoD/vm5lGSODpENlz/jXlG3kZO4OKavUbKBnYqr0WTRXI3+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Lsh+I95H;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A04606A32A;
	Tue, 17 Nov 2026 13:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A04606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Lsh+I95H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794921494; x=1826457494;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xpYJMY8VAf/P18xwxp6He3jRGlz70QtC45nH671hk6g=;
  b=Lsh+I95HoVQxuj9hWu+7XaLEv8p8YcPxbph/WbbF69ohvIhsUmZUrkXu
   BVg+XKqM5/jcCaVIlSgYPe+L59zh9+ECEz0i88ZOJ+o55rOdOnUTKwBXy
   6/poLuAeqLYkWxd0NUpetUK7Af79WI440AZ7Rg/Bo45m4svNWGPl6HsmB
   9l7sK8T9EqNS0qJagZf2Gckz8RQGJQcnj2v/v7Fj3lpusNO/WbkPoCAj7
   cd5hQiV5chooZd+VCuMCJwr6s6tHzBayWVeI7EEr2TVNWI7kAbCTxJnrU
   KX7DXs81Nq2Ki5dQNSgBxw+ZbWJ4lDuEZuIiwJIrVwvi6ge3ywv61+fla
   Q==;
X-CSE-ConnectionGUID: WXSXeOKXRYm+44tfoIX+FQ==
X-CSE-MsgGUID: KiDRO1ixQTOr7EcvrChjiQ==
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="65663142"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:18:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 17 Nov 2026 06:18:14 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 17 Nov 2026 06:18:10 -0700
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
Date: Tue, 17 Nov 2026 14:17:37 +0100
Subject: [PATCH net-next v3 1/3] net: sparx5: add l3 routing registers
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
Message-ID: <20261117-sparx5_l3_routing-v3-1-e680ed79c7dc@microchip.com>
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

Add the registers used to configure L3 routing, on both sparx5 and
lan969x: the common routing and router leg configuration of ANA_L3, its
per VLAN and per VMID router leg configuration and its ARP table, the
router leg MAC and per VMID router leg control of REW, the router leg
MAC of EACL, and the VCAP_S2_MISC_CTRL register of ANA_ACL.

Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
---
 .../microchip/sparx5/lan969x/lan969x_regs.c        |  11 +
 .../ethernet/microchip/sparx5/sparx5_main_regs.h   | 528 +++++++++++++++++++++
 .../net/ethernet/microchip/sparx5/sparx5_regs.c    |  11 +
 .../net/ethernet/microchip/sparx5/sparx5_regs.h    |  11 +
 4 files changed, 561 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
index 5650550d4294..6858772c964f 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
@@ -82,12 +82,15 @@ const unsigned int lan969x_gaddr[GADDR_LAST] = {
 	[GA_ANA_CL_COMMON] = 87040,
 	[GA_ANA_L2_COMMON] = 561928,
 	[GA_ANA_L3_COMMON] = 370752,
+	[GA_ANA_L3_VMID] = 360448,
+	[GA_ANA_L3_ARP] = 294912,
 	[GA_ANA_L3_VLAN_ARP_L3MC_STICKY] = 368580,
 	[GA_ASM_CFG] = 18304,
 	[GA_ASM_PFC_TIMER_CFG] = 15568,
 	[GA_ASM_LBK_WM_CFG] = 15596,
 	[GA_ASM_LBK_MISC_CFG] = 15608,
 	[GA_ASM_RAM_CTRL] = 15684,
+	[GA_EACL_COMMON] = 37408,
 	[GA_EACL_ES2_KEY_SELECT_PROFILE] = 36864,
 	[GA_EACL_CNT_TBL] = 30720,
 	[GA_EACL_POL_CFG] = 38400,
@@ -111,6 +114,7 @@ const unsigned int lan969x_gaddr[GADDR_LAST] = {
 	[GA_QSYS_RAM_CTRL] = 2204,
 	[GA_REW_COMMON] = 98304,
 	[GA_REW_PORT] = 49152,
+	[GA_REW_VMID] = 96768,
 	[GA_REW_VOE_PORT_LM_CNT] = 90112,
 	[GA_REW_RAM_CTRL] = 93992,
 	[GA_VOP_RAM_CTRL] = 16368,
@@ -133,6 +137,8 @@ const unsigned int lan969x_gcnt[GCNT_LAST] = {
 	[GC_ANA_L2_ISDX_LIMIT] = 256,
 	[GC_ANA_L2_ISDX] = 1024,
 	[GC_ANA_L3_VLAN] = 4608,
+	[GC_ANA_L3_VMID] = 127,
+	[GC_ANA_L3_ARP] = 1024,
 	[GC_ASM_DEV_STATISTICS] = 30,
 	[GC_EACL_ES2_KEY_SELECT_PROFILE] = 68,
 	[GC_EACL_CNT_TBL] = 512,
@@ -143,6 +149,7 @@ const unsigned int lan969x_gcnt[GCNT_LAST] = {
 	[GC_PTP_PTP_PINS] = 8,
 	[GC_PTP_PHASE_DETECTOR_CTRL] = 8,
 	[GC_REW_PORT] = 35,
+	[GC_REW_VMID] = 127,
 	[GC_REW_VOE_PORT_LM_CNT] = 240,
 };
 
@@ -202,7 +209,10 @@ const unsigned int lan969x_fsize[FSIZE_LAST] = {
 	[FW_ANA_L2_AUTO_LRN_CFG_AUTO_LRN_ENA] = 30,
 	[FW_ANA_L2_DLB_CFG_DLB_IDX] = 9,
 	[FW_ANA_L2_TSN_CFG_TSN_SFID] = 8,
+	[FW_ANA_L3_L3_UC_ENA_L3_UC_ENA] = 30,
+	[FW_ANA_L3_VMID_CFG_VMID] = 7,
 	[FW_ANA_L3_VLAN_MASK_CFG_VLAN_PORT_MASK] = 30,
+	[FW_ANA_L3_ARP_CFG_0_ARP_VMID] = 7,
 	[FW_FDMA_CH_CFG_CH_DCB_DB_CNT] = 2,
 	[FW_GCB_HW_SGPIO_TO_SD_MAP_CFG_SGPIO_TO_SD_SEL] = 7,
 	[FW_HSCH_SE_CFG_SE_DWRR_CNT] = 5,
@@ -234,6 +244,7 @@ const unsigned int lan969x_fsize[FSIZE_LAST] = {
 	[FW_QSYS_ATOP_ATOP] = 11,
 	[FW_QSYS_ATOP_TOT_CFG_ATOP_TOT] = 11,
 	[FW_REW_RTAG_ETAG_CTRL_IPE_TBL] = 6,
+	[FW_REW_RLEG_CTRL_DECAP_IRLEG] = 7,
 	[FW_XQS_STAT_CFG_STAT_VIEW] = 10,
 	[FW_XQS_QLIMIT_SHR_TOP_CFG_QLIMIT_SHR_TOP] = 14,
 	[FW_XQS_QLIMIT_SHR_ATOP_CFG_QLIMIT_SHR_ATOP] = 14,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 1bf7dabf622e..db49e1c74cdc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -722,6 +722,101 @@ extern const struct sparx5_regs *regs;
 #define ANA_ACL_SWAP_IP_CTRL_IP_SWAP_IP4_TTL_ENA_GET(x)\
 	FIELD_GET(ANA_ACL_SWAP_IP_CTRL_IP_SWAP_IP4_TTL_ENA, x)
 
+/* ANA_ACL:COMMON:VCAP_S2_MISC_CTRL */
+#define ANA_ACL_VCAP_S2_MISC_CTRL                                              \
+	__REG(TARGET_ANA_ACL, 0, 1, regs->gaddr[GA_ANA_ACL_COMMON], 0, 1, 592, \
+	      416, 0, 1, 4)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA GENMASK(27, 24)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_MAPPED_PORT_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA GENMASK(23, 20)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_AFFIX_OVERLOAD_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA GENMASK(19, 16)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ISDX_OVERLOAD_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA GENMASK(15, 12)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_PAG_FORCE_VID_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA BIT(11)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_VLAN_PIPELINE_ACT_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE BIT(10)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_IGR_RLEG_STAT_MODE, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE BIT(9)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_EGR_RLEG_STAT_MODE, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA BIT(8)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_FORCE_ES0_VID_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA BIT(7)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_UPDATE_CL_VID_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL     GENMASK(6, 5)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_ACL_RT_SEL, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA BIT(4)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_LBK_IGR_MASK_SEL3_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA BIT(3)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_MASQ_IGR_MASK_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA BIT(2)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_FP_VS2_IGR_MASK_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA BIT(1)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_VD_IGR_MASK_ENA, x)
+
+#define ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA BIT(0)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA_SET(x)\
+	FIELD_PREP(ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA, x)
+#define ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA_GET(x)\
+	FIELD_GET(ANA_ACL_VCAP_S2_MISC_CTRL_CPU_IGR_MASK_ENA, x)
+
 /* ANA_ACL:COMMON:VCAP_S2_RLEG_STAT */
 #define ANA_ACL_VCAP_S2_RLEG_STAT(r)                                           \
 	__REG(TARGET_ANA_ACL, 0, 1, regs->gaddr[GA_ANA_ACL_COMMON], 0, 1, 592, \
@@ -1917,6 +2012,194 @@ extern const struct sparx5_regs *regs;
 #define ANA_L3_VLAN_CTRL_VLAN_ENA_GET(x)\
 	FIELD_GET(ANA_L3_VLAN_CTRL_VLAN_ENA, x)
 
+/* ANA_L3:COMMON:L3_UC_ENA */
+#define ANA_L3_L3_UC_ENA                                                       \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184, 8,\
+	      0, 1, 4)
+
+/* SPARX5 ONLY */
+/* ANA_L3:COMMON:L3_UC_ENA1 */
+#define ANA_L3_L3_UC_ENA1                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      12, 0, 1, 4)
+
+/* SPARX5 ONLY */
+/* ANA_L3:COMMON:L3_UC_ENA2 */
+#define ANA_L3_L3_UC_ENA2                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      16, 0, 1, 4)
+
+#define ANA_L3_L3_UC_ENA2_L3_UC_ENA2             BIT(0)
+#define ANA_L3_L3_UC_ENA2_L3_UC_ENA2_SET(x)\
+	FIELD_PREP(ANA_L3_L3_UC_ENA2_L3_UC_ENA2, x)
+#define ANA_L3_L3_UC_ENA2_L3_UC_ENA2_GET(x)\
+	FIELD_GET(ANA_L3_L3_UC_ENA2_L3_UC_ENA2, x)
+
+/* ANA_L3:COMMON:ROUTING_CFG */
+#define ANA_L3_ROUTING_CFG                                                     \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      104, 0, 1, 4)
+
+#define ANA_L3_ROUTING_CFG_L3_ENA_MODE           BIT(30)
+#define ANA_L3_ROUTING_CFG_L3_ENA_MODE_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_L3_ENA_MODE, x)
+#define ANA_L3_ROUTING_CFG_L3_ENA_MODE_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_L3_ENA_MODE, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA    BIT(29)
+#define ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_MC_DIP_FWD_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA    BIT(28)
+#define ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_MC_DIP_FWD_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA    BIT(27)
+#define ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA, x)
+#define ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_RT_SMAC_UPDATE_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE GENMASK(26, 25)
+#define ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE, x)
+#define ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_RLEG_NONIP_UC_REDIR_MODE, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_LEN_REDIR         BIT(22)
+#define ANA_L3_ROUTING_CFG_IP6_LEN_REDIR_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_LEN_REDIR, x)
+#define ANA_L3_ROUTING_CFG_IP6_LEN_REDIR_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_LEN_REDIR, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_LEN_REDIR         BIT(21)
+#define ANA_L3_ROUTING_CFG_IP4_LEN_REDIR_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_LEN_REDIR, x)
+#define ANA_L3_ROUTING_CFG_IP4_LEN_REDIR_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_LEN_REDIR, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA    BIT(20)
+#define ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_L2_BC_COPY_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA    BIT(19)
+#define ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_L2_BC_COPY_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA BIT(18)
+#define ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_RLEG_IP6_SIP_RPF_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA BIT(17)
+#define ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_RLEG_IP4_SIP_RPF_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA GENMASK(16, 15)
+#define ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_DIP_ADDR_VIOLATION_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA GENMASK(13, 11)
+#define ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_DIP_ADDR_VIOLATION_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA GENMASK(10, 8)
+#define ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_SIP_ADDR_VIOLATION_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA GENMASK(7, 5)
+#define ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_SIP_ADDR_VIOLATION_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA BIT(4)
+#define ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_CPU_RLEG_IP_HDR_FAIL_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA BIT(3)
+#define ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_CPU_IP6_HOPBYHOP_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA BIT(2)
+#define ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_CPU_IP4_OPTIONS_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA      BIT(1)
+#define ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP6_HC_REDIR_ENA, x)
+
+#define ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA     BIT(0)
+#define ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA, x)
+#define ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ROUTING_CFG_IP4_TTL_REDIR_ENA, x)
+
+/* ANA_L3:COMMON:RLEG_CFG_0 */
+#define ANA_L3_RLEG_CFG_0                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      112, 0, 1, 4)
+
+#define ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB           GENMASK(31, 8)
+#define ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB, x)
+#define ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CFG_0_RLEG_MAC_LSB, x)
+
+/* ANA_L3:COMMON:RLEG_CFG_1 */
+#define ANA_L3_RLEG_CFG_1                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_COMMON], 0, 1, 184,   \
+	      116, 0, 1, 4)
+
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL      GENMASK(25, 24)
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB           GENMASK(23, 0)
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB, x)
+#define ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CFG_1_RLEG_MAC_MSB, x)
+
+/* ANA_L3:VLAN:VMID_CFG */
+#define ANA_L3_VMID_CFG(g)                                                     \
+	__REG(TARGET_ANA_L3, 0, 1, 0, g, regs->gcnt[GC_ANA_L3_VLAN], 64, 0, 0, \
+	      1, 4)
+
+#define ANA_L3_VMID_CFG_VMID\
+	GENMASK(regs->fsize[FW_ANA_L3_VMID_CFG_VMID] + 0 - 1, 0)
+#define ANA_L3_VMID_CFG_VMID_SET(x)\
+	spx5_field_prep(ANA_L3_VMID_CFG_VMID, x)
+#define ANA_L3_VMID_CFG_VMID_GET(x)\
+	spx5_field_get(ANA_L3_VMID_CFG_VMID, x)
+
 /* ANA_L3:VLAN:VLAN_CFG */
 #define ANA_L3_VLAN_CFG(g)                                                     \
 	__REG(TARGET_ANA_L3, 0, 1, 0, g, regs->gcnt[GC_ANA_L3_VLAN], 64, 8, 0, \
@@ -1999,6 +2282,171 @@ extern const struct sparx5_regs *regs;
 #define ANA_L3_VLAN_MASK_CFG2_VLAN_PORT_MASK2_GET(x)\
 	FIELD_GET(ANA_L3_VLAN_MASK_CFG2_VLAN_PORT_MASK2, x)
 
+/* ANA_L3:VMID:RLEG_CTRL */
+#define ANA_L3_RLEG_CTRL(g)                                                    \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_VMID], g,             \
+	      regs->gcnt[GC_ANA_L3_VMID], 64, 0, 0, 1, 4)
+
+#define ANA_L3_RLEG_CTRL_RLEG_EVID               GENMASK(31, 19)
+#define ANA_L3_RLEG_CTRL_RLEG_EVID_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_EVID, x)
+#define ANA_L3_RLEG_CTRL_RLEG_EVID_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_EVID, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA BIT(18)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_STAT_IP_ONLY_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA BIT(17)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_STAT_IP_ONLY_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE   GENMASK(15, 14)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_SIP_RPF_MODE, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE   GENMASK(13, 12)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_SIP_RPF_MODE, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS   BIT(9)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_TTL_DECR_DIS, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS   BIT(8)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_TTL_DECR_DIS, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA         BIT(7)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_UC_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA         BIT(6)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_UC_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA         BIT(5)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_MC_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA         BIT(4)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_MC_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA BIT(3)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_ICMP_REDIR_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA BIT(2)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_ICMP_REDIR_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA       BIT(1)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP6_VRID_ENA, x)
+
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA       BIT(0)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA, x)
+#define ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA_GET(x)\
+	FIELD_GET(ANA_L3_RLEG_CTRL_RLEG_IP4_VRID_ENA, x)
+
+/* ANA_L3:VMID:MAX_LEN */
+#define ANA_L3_MAX_LEN(g)                                                      \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_VMID], g,             \
+	      regs->gcnt[GC_ANA_L3_VMID], 64, 28, 0, 1, 4)
+
+#define ANA_L3_MAX_LEN_IP6_MAX_LEN               GENMASK(31, 16)
+#define ANA_L3_MAX_LEN_IP6_MAX_LEN_SET(x)\
+	FIELD_PREP(ANA_L3_MAX_LEN_IP6_MAX_LEN, x)
+#define ANA_L3_MAX_LEN_IP6_MAX_LEN_GET(x)\
+	FIELD_GET(ANA_L3_MAX_LEN_IP6_MAX_LEN, x)
+
+#define ANA_L3_MAX_LEN_IP4_MAX_LEN               GENMASK(15, 0)
+#define ANA_L3_MAX_LEN_IP4_MAX_LEN_SET(x)\
+	FIELD_PREP(ANA_L3_MAX_LEN_IP4_MAX_LEN, x)
+#define ANA_L3_MAX_LEN_IP4_MAX_LEN_GET(x)\
+	FIELD_GET(ANA_L3_MAX_LEN_IP4_MAX_LEN, x)
+
+/* ANA_L3:ARP:ARP_CFG_0 */
+#define ANA_L3_ARP_CFG_0(g)                                                    \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_ARP], g,              \
+	      regs->gcnt[GC_ANA_L3_ARP], 32, 0, 0, 1, 4)
+
+#define ANA_L3_ARP_CFG_0_MAC_MSB                 GENMASK(31, 16)
+#define ANA_L3_ARP_CFG_0_MAC_MSB_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_MAC_MSB, x)
+#define ANA_L3_ARP_CFG_0_MAC_MSB_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_MAC_MSB, x)
+
+#define ANA_L3_ARP_CFG_0_ARP_VMID\
+	GENMASK(regs->fsize[FW_ANA_L3_ARP_CFG_0_ARP_VMID] + 7 - 1, 7)
+#define ANA_L3_ARP_CFG_0_ARP_VMID_SET(x)\
+	spx5_field_prep(ANA_L3_ARP_CFG_0_ARP_VMID, x)
+#define ANA_L3_ARP_CFG_0_ARP_VMID_GET(x)\
+	spx5_field_get(ANA_L3_ARP_CFG_0_ARP_VMID, x)
+
+#define ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU        GENMASK(6, 4)
+#define ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU, x)
+#define ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_ZERO_DMAC_CPU_QU, x)
+
+#define ANA_L3_ARP_CFG_0_SIP_RPF_ENA             BIT(3)
+#define ANA_L3_ARP_CFG_0_SIP_RPF_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_SIP_RPF_ENA, x)
+#define ANA_L3_ARP_CFG_0_SIP_RPF_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_SIP_RPF_ENA, x)
+
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA    BIT(2)
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA, x)
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_SECUR_MATCH_VMID_ENA, x)
+
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA     BIT(1)
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA, x)
+#define ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_SECUR_MATCH_MAC_ENA, x)
+
+#define ANA_L3_ARP_CFG_0_ARP_ENA                 BIT(0)
+#define ANA_L3_ARP_CFG_0_ARP_ENA_SET(x)\
+	FIELD_PREP(ANA_L3_ARP_CFG_0_ARP_ENA, x)
+#define ANA_L3_ARP_CFG_0_ARP_ENA_GET(x)\
+	FIELD_GET(ANA_L3_ARP_CFG_0_ARP_ENA, x)
+
+/* ANA_L3:ARP:ARP_CFG_1 */
+#define ANA_L3_ARP_CFG_1(g)                                                    \
+	__REG(TARGET_ANA_L3, 0, 1, regs->gaddr[GA_ANA_L3_ARP], g,              \
+	      regs->gcnt[GC_ANA_L3_ARP], 32, 4, 0, 1, 4)
+
 /* ASM:DEV_STATISTICS:RX_IN_BYTES_CNT */
 #define ASM_RX_IN_BYTES_CNT(g)                                                 \
 	__REG(TARGET_ASM, 0, 1, 0, g, regs->gcnt[GC_ASM_DEV_STATISTICS], 512,  \
@@ -4620,6 +5068,34 @@ extern const struct sparx5_regs *regs;
 #define DSM_TAXI_CAL_CFG_CAL_PGM_SEL_GET(x)\
 	FIELD_GET(DSM_TAXI_CAL_CFG_CAL_PGM_SEL, x)
 
+/* EACL:COMMON:RLEG_CFG_0 */
+#define EACL_RLEG_CFG_0                                                        \
+	__REG(TARGET_EACL, 0, 1, regs->gaddr[GA_EACL_COMMON], 0, 1, 216, 64, 0,\
+	      1, 4)
+
+#define EACL_RLEG_CFG_0_RLEG_MAC_LSB             GENMASK(23, 0)
+#define EACL_RLEG_CFG_0_RLEG_MAC_LSB_SET(x)\
+	FIELD_PREP(EACL_RLEG_CFG_0_RLEG_MAC_LSB, x)
+#define EACL_RLEG_CFG_0_RLEG_MAC_LSB_GET(x)\
+	FIELD_GET(EACL_RLEG_CFG_0_RLEG_MAC_LSB, x)
+
+/* EACL:COMMON:RLEG_CFG_1 */
+#define EACL_RLEG_CFG_1                                                        \
+	__REG(TARGET_EACL, 0, 1, regs->gaddr[GA_EACL_COMMON], 0, 1, 216, 68, 0,\
+	      1, 4)
+
+#define EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL        GENMASK(25, 24)
+#define EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(x)\
+	FIELD_PREP(EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+#define EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_GET(x)\
+	FIELD_GET(EACL_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+
+#define EACL_RLEG_CFG_1_RLEG_MAC_MSB             GENMASK(23, 0)
+#define EACL_RLEG_CFG_1_RLEG_MAC_MSB_SET(x)\
+	FIELD_PREP(EACL_RLEG_CFG_1_RLEG_MAC_MSB, x)
+#define EACL_RLEG_CFG_1_RLEG_MAC_MSB_GET(x)\
+	FIELD_GET(EACL_RLEG_CFG_1_RLEG_MAC_MSB, x)
+
 /* EACL:ES2_KEY_SELECT_PROFILE:VCAP_ES2_KEY_SEL */
 #define EACL_VCAP_ES2_KEY_SEL(g, r)                                            \
 	__REG(TARGET_EACL, 0, 1, regs->gaddr[GA_EACL_ES2_KEY_SELECT_PROFILE],  \
@@ -7662,6 +8138,34 @@ extern const struct sparx5_regs *regs;
 #define REW_ES0_CTRL_ES0_LU_ENA_GET(x)\
 	FIELD_GET(REW_ES0_CTRL_ES0_LU_ENA, x)
 
+/* REW:COMMON:RLEG_CFG_0 */
+#define REW_RLEG_CFG_0                                                         \
+	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_COMMON], 0, 1, 1232, 1156,  \
+	      0, 1, 4)
+
+#define REW_RLEG_CFG_0_RLEG_MAC_LSB              GENMASK(23, 0)
+#define REW_RLEG_CFG_0_RLEG_MAC_LSB_SET(x)\
+	FIELD_PREP(REW_RLEG_CFG_0_RLEG_MAC_LSB, x)
+#define REW_RLEG_CFG_0_RLEG_MAC_LSB_GET(x)\
+	FIELD_GET(REW_RLEG_CFG_0_RLEG_MAC_LSB, x)
+
+/* REW:COMMON:RLEG_CFG_1 */
+#define REW_RLEG_CFG_1                                                         \
+	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_COMMON], 0, 1, 1232, 1160,  \
+	      0, 1, 4)
+
+#define REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL         GENMASK(25, 24)
+#define REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_SET(x)\
+	FIELD_PREP(REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+#define REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL_GET(x)\
+	FIELD_GET(REW_RLEG_CFG_1_RLEG_MAC_TYPE_SEL, x)
+
+#define REW_RLEG_CFG_1_RLEG_MAC_MSB              GENMASK(23, 0)
+#define REW_RLEG_CFG_1_RLEG_MAC_MSB_SET(x)\
+	FIELD_PREP(REW_RLEG_CFG_1_RLEG_MAC_MSB, x)
+#define REW_RLEG_CFG_1_RLEG_MAC_MSB_GET(x)\
+	FIELD_GET(REW_RLEG_CFG_1_RLEG_MAC_MSB, x)
+
 /* REW:PORT:PORT_VLAN_CFG */
 #define REW_PORT_VLAN_CFG(g)                                                   \
 	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_PORT], g,                   \
@@ -7888,6 +8392,30 @@ extern const struct sparx5_regs *regs;
 #define REW_PTP_GEN_STAMP_FMT_RT_FMT_GET(x)\
 	FIELD_GET(REW_PTP_GEN_STAMP_FMT_RT_FMT, x)
 
+/* REW:VMID:RLEG_CTRL */
+#define REW_RLEG_CTRL(g)                                                       \
+	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_VMID], g,                   \
+	      regs->gcnt[GC_REW_VMID], 4, 0, 0, 1, 4)
+
+#define REW_RLEG_CTRL_DECAP_IRLEG\
+	GENMASK(regs->fsize[FW_REW_RLEG_CTRL_DECAP_IRLEG] + 13 - 1, 13)
+#define REW_RLEG_CTRL_DECAP_IRLEG_SET(x)\
+	spx5_field_prep(REW_RLEG_CTRL_DECAP_IRLEG, x)
+#define REW_RLEG_CTRL_DECAP_IRLEG_GET(x)\
+	spx5_field_get(REW_RLEG_CTRL_DECAP_IRLEG, x)
+
+#define REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED     BIT(12)
+#define REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED_SET(x)\
+	FIELD_PREP(REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED, x)
+#define REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED_GET(x)\
+	FIELD_GET(REW_RLEG_CTRL_RLEG_VSTAX2_WAS_TAGGED, x)
+
+#define REW_RLEG_CTRL_RLEG_EVID                  GENMASK(11, 0)
+#define REW_RLEG_CTRL_RLEG_EVID_SET(x)\
+	FIELD_PREP(REW_RLEG_CTRL_RLEG_EVID, x)
+#define REW_RLEG_CTRL_RLEG_EVID_GET(x)\
+	FIELD_GET(REW_RLEG_CTRL_RLEG_EVID, x)
+
 /* REW:RAM_CTRL:RAM_INIT */
 #define REW_RAM_INIT                                                           \
 	__REG(TARGET_REW, 0, 1, regs->gaddr[GA_REW_RAM_CTRL], 0, 1, 4, 0, 0, 1,\
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
index ce5f0bbf0e65..3a382603cb01 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
@@ -82,12 +82,15 @@ const unsigned int sparx5_gaddr[GADDR_LAST] = {
 	[GA_ANA_CL_COMMON] = 166912,
 	[GA_ANA_L2_COMMON] = 566024,
 	[GA_ANA_L3_COMMON] = 493632,
+	[GA_ANA_L3_VMID] = 458752,
+	[GA_ANA_L3_ARP] = 327680,
 	[GA_ANA_L3_VLAN_ARP_L3MC_STICKY] = 491460,
 	[GA_ASM_CFG] = 33280,
 	[GA_ASM_PFC_TIMER_CFG] = 34716,
 	[GA_ASM_LBK_WM_CFG] = 34744,
 	[GA_ASM_LBK_MISC_CFG] = 34756,
 	[GA_ASM_RAM_CTRL] = 34832,
+	[GA_EACL_COMMON] = 118480,
 	[GA_EACL_ES2_KEY_SELECT_PROFILE] = 149504,
 	[GA_EACL_CNT_TBL] = 122880,
 	[GA_EACL_POL_CFG] = 150608,
@@ -111,6 +114,7 @@ const unsigned int sparx5_gaddr[GADDR_LAST] = {
 	[GA_QSYS_RAM_CTRL] = 2344,
 	[GA_REW_COMMON] = 387264,
 	[GA_REW_PORT] = 360448,
+	[GA_REW_VMID] = 389120,
 	[GA_REW_VOE_PORT_LM_CNT] = 393216,
 	[GA_REW_RAM_CTRL] = 378696,
 	[GA_VOP_RAM_CTRL] = 279176,
@@ -133,6 +137,8 @@ const unsigned int sparx5_gcnt[GCNT_LAST] = {
 	[GC_ANA_L2_ISDX_LIMIT] = 1536,
 	[GC_ANA_L2_ISDX] = 4096,
 	[GC_ANA_L3_VLAN] = 5120,
+	[GC_ANA_L3_VMID] = 511,
+	[GC_ANA_L3_ARP] = 2048,
 	[GC_ASM_DEV_STATISTICS] = 65,
 	[GC_EACL_ES2_KEY_SELECT_PROFILE] = 138,
 	[GC_EACL_CNT_TBL] = 2048,
@@ -143,6 +149,7 @@ const unsigned int sparx5_gcnt[GCNT_LAST] = {
 	[GC_PTP_PTP_PINS] = 5,
 	[GC_PTP_PHASE_DETECTOR_CTRL] = 5,
 	[GC_REW_PORT] = 70,
+	[GC_REW_VMID] = 511,
 	[GC_REW_VOE_PORT_LM_CNT] = 520,
 };
 
@@ -202,7 +209,10 @@ const unsigned int sparx5_fsize[FSIZE_LAST] = {
 	[FW_ANA_L2_AUTO_LRN_CFG_AUTO_LRN_ENA] = 32,
 	[FW_ANA_L2_DLB_CFG_DLB_IDX] = 13,
 	[FW_ANA_L2_TSN_CFG_TSN_SFID] = 10,
+	[FW_ANA_L3_L3_UC_ENA_L3_UC_ENA] = 32,
+	[FW_ANA_L3_VMID_CFG_VMID] = 9,
 	[FW_ANA_L3_VLAN_MASK_CFG_VLAN_PORT_MASK] = 32,
+	[FW_ANA_L3_ARP_CFG_0_ARP_VMID] = 9,
 	[FW_FDMA_CH_CFG_CH_DCB_DB_CNT] = 4,
 	[FW_GCB_HW_SGPIO_TO_SD_MAP_CFG_SGPIO_TO_SD_SEL] = 9,
 	[FW_HSCH_SE_CFG_SE_DWRR_CNT] = 7,
@@ -234,6 +244,7 @@ const unsigned int sparx5_fsize[FSIZE_LAST] = {
 	[FW_QSYS_ATOP_ATOP] = 12,
 	[FW_QSYS_ATOP_TOT_CFG_ATOP_TOT] = 12,
 	[FW_REW_RTAG_ETAG_CTRL_IPE_TBL] = 7,
+	[FW_REW_RLEG_CTRL_DECAP_IRLEG] = 9,
 	[FW_XQS_STAT_CFG_STAT_VIEW] = 13,
 	[FW_XQS_QLIMIT_SHR_TOP_CFG_QLIMIT_SHR_TOP] = 15,
 	[FW_XQS_QLIMIT_SHR_ATOP_CFG_QLIMIT_SHR_ATOP] = 15,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
index 17abaa5798cb..a9741a3e35de 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
@@ -91,12 +91,15 @@ enum sparx5_gaddr_enum {
 	GA_ANA_CL_COMMON,
 	GA_ANA_L2_COMMON,
 	GA_ANA_L3_COMMON,
+	GA_ANA_L3_VMID,
+	GA_ANA_L3_ARP,
 	GA_ANA_L3_VLAN_ARP_L3MC_STICKY,
 	GA_ASM_CFG,
 	GA_ASM_PFC_TIMER_CFG,
 	GA_ASM_LBK_WM_CFG,
 	GA_ASM_LBK_MISC_CFG,
 	GA_ASM_RAM_CTRL,
+	GA_EACL_COMMON,
 	GA_EACL_ES2_KEY_SELECT_PROFILE,
 	GA_EACL_CNT_TBL,
 	GA_EACL_POL_CFG,
@@ -120,6 +123,7 @@ enum sparx5_gaddr_enum {
 	GA_QSYS_RAM_CTRL,
 	GA_REW_COMMON,
 	GA_REW_PORT,
+	GA_REW_VMID,
 	GA_REW_VOE_PORT_LM_CNT,
 	GA_REW_RAM_CTRL,
 	GA_VOP_RAM_CTRL,
@@ -143,6 +147,8 @@ enum sparx5_gcnt_enum {
 	GC_ANA_L2_ISDX_LIMIT,
 	GC_ANA_L2_ISDX,
 	GC_ANA_L3_VLAN,
+	GC_ANA_L3_VMID,
+	GC_ANA_L3_ARP,
 	GC_ASM_DEV_STATISTICS,
 	GC_EACL_ES2_KEY_SELECT_PROFILE,
 	GC_EACL_CNT_TBL,
@@ -153,6 +159,7 @@ enum sparx5_gcnt_enum {
 	GC_PTP_PTP_PINS,
 	GC_PTP_PHASE_DETECTOR_CTRL,
 	GC_REW_PORT,
+	GC_REW_VMID,
 	GC_REW_VOE_PORT_LM_CNT,
 	GCNT_LAST,
 };
@@ -215,7 +222,10 @@ enum sparx5_fsize_enum {
 	FW_ANA_L2_AUTO_LRN_CFG_AUTO_LRN_ENA,
 	FW_ANA_L2_DLB_CFG_DLB_IDX,
 	FW_ANA_L2_TSN_CFG_TSN_SFID,
+	FW_ANA_L3_L3_UC_ENA_L3_UC_ENA,
+	FW_ANA_L3_VMID_CFG_VMID,
 	FW_ANA_L3_VLAN_MASK_CFG_VLAN_PORT_MASK,
+	FW_ANA_L3_ARP_CFG_0_ARP_VMID,
 	FW_FDMA_CH_CFG_CH_DCB_DB_CNT,
 	FW_GCB_HW_SGPIO_TO_SD_MAP_CFG_SGPIO_TO_SD_SEL,
 	FW_HSCH_SE_CFG_SE_DWRR_CNT,
@@ -247,6 +257,7 @@ enum sparx5_fsize_enum {
 	FW_QSYS_ATOP_ATOP,
 	FW_QSYS_ATOP_TOT_CFG_ATOP_TOT,
 	FW_REW_RTAG_ETAG_CTRL_IPE_TBL,
+	FW_REW_RLEG_CTRL_DECAP_IRLEG,
 	FW_XQS_STAT_CFG_STAT_VIEW,
 	FW_XQS_QLIMIT_SHR_TOP_CFG_QLIMIT_SHR_TOP,
 	FW_XQS_QLIMIT_SHR_ATOP_CFG_QLIMIT_SHR_ATOP,

-- 
2.52.0

