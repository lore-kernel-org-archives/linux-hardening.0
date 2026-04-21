Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89419CD1B
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807363; cv=none; b=pzdRLZ/0eNDZqTVX3mkmqI1oI1GLv8fqOqRDp4q0z2/6m+H+9UuxFbatkMV4rxPwCMEipQ3dNZJTWaEqlcIMyufPv8Yx4/VyhsLrAjz/5HbZPnr1bz2mLT4qljcGSN2dv3OTMlKgxEQ96VrNpbvfXCOCvmmfJvrsStsYM+I7pTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807363; c=relaxed/simple;
	bh=9I5kveaAdNuut0UZl02P16NYapFegdWhGD5fkgRUZTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oPYaxDSnXdmlH/aM3oNfF2j3LMx9fW0Si7C4AjH8vdsKppKXe0UO9x55yNUYIxN6K0+e3vLV26BdX0U0ZiXt6eD4zt43osEod/Vs5qi2OY4Af9SHNKeNq7swXL/Trs9ckDKNk/DUCjKf7P/+pFtGnNN4qfvXsR3CvB3QabqQcE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXO9/kcq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXO9/kcq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35e576110adso3183314a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776807362; x=1777412162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXmPZkb/Svwu6Il6bmZz1uAoo07kk+9/HvI68DRq0LI=;
        b=NXO9/kcqjqml/jhDCJ9NWVoHNi1oWnaz98qerEqtJYIb+HHK7e/4H+WQ61hlte1nWB
         1CwWTkfSomjXmnsIIvwFz2dKV33WHKSncO96NxLfpwmk6j5IPUPOpOIDlbl6G/35pdDh
         AClvcdV9Ac7Ps5kKojBsiigdaE4zS9IVoJaxk4jFeHoRGx2wwSUdHzUPxakhoSUKgv+e
         Gp7JorTH7+0nMn/4WzMwwoX/fUs5w2lRC1nU7iRXMnka4c7lhwmT+EacA6DxIyAysd9P
         BdxgvwMQaEm5rZZirbtDIdJnXyJOssHgPTYws8kbkV8ZlPleTnXqofRUIrXimURI5TF5
         CtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807362; x=1777412162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXmPZkb/Svwu6Il6bmZz1uAoo07kk+9/HvI68DRq0LI=;
        b=lcH7gmWPRtzghbvWKNz6zWlvnEOZtwt98tvi86OvxKIHw11UMrwrFPMq8vPvCfVapw
         /Q2sOzeKvP3NUltqnur3hSzmEJF65NesEXavCLhNFXxN10RX+9vbGaDa8jzwSbdrpFsw
         fOL3RZDI0hNeKdtGGQgsmBAVxVApf5I5VvCpTO44C0E8hldLFVRpiQwHYfe7eaZZxFw1
         LetuQCQAV9yCeWbYiOFoKdLCGfKTGGe/MkNpathACJGTxb6z8/N7mIS9nL3uryjBlj5U
         Kh1ixJ5EfnxoRv8ZpvO4kEzi2DvImUsonaLj1xHnV/7ALEso9/gAVdeBIeqtdJI9fCev
         LzUA==
X-Forwarded-Encrypted: i=1; AFNElJ/ljuM9zVCOtDs34prDJ3VU1Kncd4pQm0AOtouGv2gH0r2lSgS/8g12lBLPkPSP/Mr+E7kowv5lc3qRAYbt3Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYf8DkJOyecjTjRVwuqngeTzn05eGuyZbKIpv89AOFU3rpXDCn
	Ku1etZ7IhbPCG8BOsL9WsRPNP+BU1B6WQlXIKiOr0RImUoCMYX/dnRjh
X-Gm-Gg: AeBDievZdbjK08Y4P1L6O3Y8e+Jj9+0qgqA1bO5U/gr/XGZVAioKr5/8LhOQvc0pmtU
	Q0no60qJcpgCuITe3R4oJyTBK82S9taR8npF84uPVUF5sKQDFRw1S3PzECI6caUM23KUP6ZPwPL
	TIA9I4osyQBs6FZ1uJQ37g3JlMoG5Zr37NNe4ZDYyJ+NHWJHL0D4HmyyHCTY/xAiiqWFnvGj4uu
	BECxVBeEFYdL+UloaDGMgydWBllIb2Pqyu2fpYSMwLWuq+235ye+CJgdEE2CG1o+xneYnZrmjnT
	z3u+X2DHNtsWLlycK161b6NnhmCW3MaHZJncqwQKSM581C1qvkapxTzTLu+L+xqfE8s0uanbm91
	+SL5R3Vr/etFp0Ml08p5f/kldgRK/COJeXEJFV3wWV3ARAts/R2xvMBI7Up8SsXA7ajQuuWxnKG
	FU9eyK/1YjauAUjxcwV4HFH2+SSwDaLVPK/Bxz08a64aEAmByClYUNpCtJJrQXD9/kQjzThBTNA
	9X8
X-Received: by 2002:a17:90b:2e4e:b0:35e:579a:7e9a with SMTP id 98e67ed59e1d1-36140204c56mr15021196a91.7.1776807361797;
        Tue, 21 Apr 2026 14:36:01 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8be])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm14352270a91.10.2026.04.21.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 14:36:01 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ath12k@lists.infradead.org (open list:QUALCOMM ATH12K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 ath-next] wifi: ath12k: use kzalloc_flex
Date: Tue, 21 Apr 2026 14:35:44 -0700
Message-ID: <20260421213544.6238-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment immediately after allocation before any potential accesses.
kzalloc_flex does this anyway for GCC >= 15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 v2: reword last comment.
 drivers/net/wireless/ath/ath12k/mac.c | 29 +++++++--------------------
 drivers/net/wireless/ath/ath12k/wmi.h |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fbdfe6424fd7..32d590504a80 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5611,12 +5611,14 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;

-	arg = kzalloc_obj(*arg);
+	arg = kzalloc_flex(*arg, chan_list, n_channels);
 	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}

+	arg->num_chan = n_channels;
+
 	ath12k_wmi_start_scan_init(ar, arg);
 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH12K_SCAN_ID;
@@ -5638,18 +5640,8 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
 		arg->scan_f_passive = 1;
 	}

-	if (n_channels) {
-		arg->num_chan = n_channels;
-		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
-					 GFP_KERNEL);
-		if (!arg->chan_list) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-
-		for (i = 0; i < arg->num_chan; i++)
-			arg->chan_list[i] = chan_list[i]->center_freq;
-	}
+	for (i = 0; i < arg->num_chan; i++)
+		arg->chan_list[i] = chan_list[i]->center_freq;

 	ret = ath12k_start_scan(ar, arg);
 	if (ret) {
@@ -5674,7 +5666,6 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,

 exit:
 	if (arg) {
-		kfree(arg->chan_list);
 		kfree(arg->extraie.ptr);
 		kfree(arg);
 	}
@@ -13735,19 +13726,13 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;

 	struct ath12k_wmi_scan_req_arg *arg __free(kfree) =
-					kzalloc_obj(*arg);
+					kzalloc_flex(*arg, chan_list, 1);
 	if (!arg)
 		return -ENOMEM;

-	ath12k_wmi_start_scan_init(ar, arg);
 	arg->num_chan = 1;
+	ath12k_wmi_start_scan_init(ar, arg);

-	u32 *chan_list __free(kfree) = kcalloc(arg->num_chan, sizeof(*chan_list),
-					       GFP_KERNEL);
-	if (!chan_list)
-		return -ENOMEM;
-
-	arg->chan_list = chan_list;
 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH12K_SCAN_ID;
 	arg->chan_list[0] = chan->center_freq;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 5ba9b7d3a888..5f150f21c146 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -3586,7 +3586,6 @@ struct ath12k_wmi_scan_req_arg {
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 *chan_list;
 	u32 notify_scan_events;
 	struct cfg80211_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
 	struct ath12k_wmi_mac_addr_params bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
@@ -3595,6 +3594,7 @@ struct ath12k_wmi_scan_req_arg {
 	u32 num_hint_bssid;
 	struct ath12k_wmi_hint_short_ssid_arg hint_s_ssid[WLAN_SCAN_MAX_HINT_S_SSID];
 	struct ath12k_wmi_hint_bssid_arg hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
+	u32 chan_list[] __counted_by(num_chan);
 };

 struct wmi_ssid_arg {
--
2.53.0

