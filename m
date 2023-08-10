Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF31C001DE
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Aug 2023 10:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjHJKir (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjHJKiq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 10 Aug 2023 06:38:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1210DE;
        Thu, 10 Aug 2023 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691663925; x=1723199925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wkWq6UQrSoqn7LKSKk0ei4dEQfQd6OfK7Y33L/lijD0=;
  b=fMO2zN9ndoJNoNISfoFnXe91acWFl+WvxwfV6l59hjprCUN6OCgHb9gt
   art30gfEsbbRDh/93C6mPdqSdlONsAdS2uAIXd8LKYugQZfh4fmSICOG6
   R+lomwSn1bf4QQlt03mhqXq9zrMDRmyzBo8bCVEuCX97p+6jfUgVOdxod
   i0SXjrwVfwgEqPYRgaiTKIHaU07TaMqa5tUxVPaq/N5iYDWn5Bkthd1C5
   UdYIsEgEj1xWp35ju1KVW9MUF0x6QJXKpGypiRadt0afZgENd6HdjG/W1
   +FLce1m+UzGY80wmvy+oqI4pkHa3BIy+Hdt9hSzAuXTU8pA0f8OuguBLP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370260819"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="370260819"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:38:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767237175"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="767237175"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 03:38:43 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 08EB4333E2;
        Thu, 10 Aug 2023 11:38:41 +0100 (IST)
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
To:     Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        intel-wired-lan@lists.osuosl.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-hardening@vger.kernel.org, Steven Zou <steven.zou@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v1 4/7] ice: make use of DEFINE_FLEX() in ice_ddp.c
Date:   Thu, 10 Aug 2023 06:35:06 -0400
Message-Id: <20230810103509.163225-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Use DEFINE_FLEX() macro for constant-num-of-elems (4)
flex array members of ice_ddp.c

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 4/0 grow/shrink: 0/1 up/down: 1195/-887 (308)
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 39 +++++++-----------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index d71ed210f9c4..3bb760d2cf87 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1558,21 +1558,14 @@ static enum ice_ddp_state ice_init_pkg_info(struct ice_hw *hw,
  */
 static enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 {
-	enum ice_ddp_state state = ICE_DDP_PKG_SUCCESS;
-	struct ice_aqc_get_pkg_info_resp *pkg_info;
-	u16 size;
+	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg_info, pkg_info,
+		    ICE_PKG_CNT);
+	u16 size = const_flex_size(pkg_info);
 	u32 i;
 
-	size = struct_size(pkg_info, pkg_info, ICE_PKG_CNT);
-	pkg_info = kzalloc(size, GFP_KERNEL);
-	if (!pkg_info)
+	if (ice_aq_get_pkg_info_list(hw, pkg_info, size, NULL))
 		return ICE_DDP_PKG_ERR;
 
-	if (ice_aq_get_pkg_info_list(hw, pkg_info, size, NULL)) {
-		state = ICE_DDP_PKG_ERR;
-		goto init_pkg_free_alloc;
-	}
-
 	for (i = 0; i < le32_to_cpu(pkg_info->count); i++) {
 #define ICE_PKG_FLAG_COUNT 4
 		char flags[ICE_PKG_FLAG_COUNT + 1] = { 0 };
@@ -1602,10 +1595,7 @@ static enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 			  pkg_info->pkg_info[i].name, flags);
 	}
 
-init_pkg_free_alloc:
-	kfree(pkg_info);
-
-	return state;
+	return ICE_DDP_PKG_SUCCESS;
 }
 
 /**
@@ -1620,9 +1610,10 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 					     struct ice_pkg_hdr *ospkg,
 					     struct ice_seg **seg)
 {
-	struct ice_aqc_get_pkg_info_resp *pkg;
+	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg, pkg_info,
+		    ICE_PKG_CNT);
+	u16 size = const_flex_size(pkg);
 	enum ice_ddp_state state;
-	u16 size;
 	u32 i;
 
 	/* Check package version compatibility */
@@ -1641,15 +1632,8 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 	}
 
 	/* Check if FW is compatible with the OS package */
-	size = struct_size(pkg, pkg_info, ICE_PKG_CNT);
-	pkg = kzalloc(size, GFP_KERNEL);
-	if (!pkg)
-		return ICE_DDP_PKG_ERR;
-
-	if (ice_aq_get_pkg_info_list(hw, pkg, size, NULL)) {
-		state = ICE_DDP_PKG_LOAD_ERROR;
-		goto fw_ddp_compat_free_alloc;
-	}
+	if (ice_aq_get_pkg_info_list(hw, pkg, size, NULL))
+		return ICE_DDP_PKG_LOAD_ERROR;
 
 	for (i = 0; i < le32_to_cpu(pkg->count); i++) {
 		/* loop till we find the NVM package */
@@ -1666,8 +1650,7 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 		/* done processing NVM package so break */
 		break;
 	}
-fw_ddp_compat_free_alloc:
-	kfree(pkg);
+
 	return state;
 }
 
-- 
2.40.1

