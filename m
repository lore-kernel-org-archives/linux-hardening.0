Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965C372EF0
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776813145; cv=none; b=EHNwdyCJQ3L9yGxtpuYSg0p+cHquRZdj5AwVB/TAQkFPtRbylGksFq/7Q4C4rjOHE0w96p7ZGxj6dTj0JaO+arDh0vCersjeWMyHrRMeW6aD0FSXiYdmZn1QEAzXz519nwXKLtQRPlWJ6s0Pr2XF1YLCYyCJYP013bVJSASK9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776813145; c=relaxed/simple;
	bh=gpp9xmU85YlFb/u4oByGfsxZtY8GvWmQndeL55+bGKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i/JbYbWCJcnCrhgQ0HIe49g58KZmZBQUA7GIrJe8Q0HNCEnzTogrbEZ2Wv/Qw1YVyzVMSGyM5WsjRF2IrGHE80f93WWCXLmBMpSVQ2RA2mamBTiGqZaqdp42XZgwL+9xr9gZD6P2DpFsA4i9QzCptLVL4rogRqvXNnm8XvJ/n6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRI9YAwP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRI9YAwP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35f9ab079bdso3036853a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 16:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776813142; x=1777417942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTFjozRKzlcsUeI3wET9p6IVNlwFbfMKkKPMEGBJgq8=;
        b=RRI9YAwPtcS3VFPVwr3ZDxaOJhi/WTERvXxBsnW8ojtwEn9e259j/NK9w+pViSK6PY
         m29WAIO9jd4onNbLXUzQOz10KrshW32dvnnvgjWD69c7yRGp0NwBVzH9Q/HZkwKrBcjX
         gn23EvjBaBi4zC8TWZbqEMWAZMiXN+it9J0Ij8AnDZ2ZpjCvLMWByJVl43hU3qOhhE+R
         Wj+ho7ZTJkSXdOcWHMwhBQbEWwX+ospBamj9I476tCT78ySmwY6cKDPxaN7ohuuSREVk
         pkQrlvkddO1mmi/tJDLP2tLihhxHoLUB/oossZ0SQOBoOBORtRkP6hZqFF0e6I+iSCJu
         jywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776813142; x=1777417942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTFjozRKzlcsUeI3wET9p6IVNlwFbfMKkKPMEGBJgq8=;
        b=dIsiwjGkZ4tWlsPn0Ihkc54meJH8ctbp4/RLpp7G0mOXel+FWEze6OVdrG2o2Dpb31
         aUQJUUWV+Jq7K/Jcz4ulJN1ZFycqko8N5mwB+kYTTvmMvy7mFcnXxCy7xPbLhA7+qMEc
         oueSlgVUKn3odMewArxSc0qCkfxdo1fy6DvqGmxtCjSpA4wZQPlmjS89UjcmDqW4K6W1
         A81ILzfF7xquCp3cOAvmTQHnFk6vEAQlFRMjW6uoZRabpNeFb8/CWJ8fT/eaV6KS/2V2
         U+/VCWaWsw4PfTBub/+5M60eathfIULZAm5aIxO+j1YItppr8rskUCHJuNuECVsE0mUG
         LsFA==
X-Forwarded-Encrypted: i=1; AFNElJ8Eap9XkLqy52w06L+/cxOeIx3KeZ5uCaqQJANP3kFKrjoUv08YPE8uB6ImA/rI7kAHg4lp9at3gYVkxVWeSik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLnYgQ/BhjtjJ/JScV07g+my58xlDd9khgub3ZH2TYYOPJ/Ez
	DWd6aXEfYnpj3wZ5HXmS9JFnvkJypl9g2hVeevrAdexFRRu4zLY8ipPlDp98jA==
X-Gm-Gg: AeBDiesZYVtNkpAzLCTZa4bSZJA/X42gxw57M3oLmHMgHWjqNLQrVxCRnGajcy0XBtU
	ekMdbhhOQ4DhhwAGd2UAJRkwhyVZuOlW+2adW3QtO00EXsdW0r6K+O6DbyTpNFxPxmh3yBNGfLS
	xT041ZuZiv1FRUEZbvOxpJjN40fOfaHWzDQ+lKphgWpM2mV+T+9CGTdMhx6/dBw/JETStcYeTU7
	IZMDaX6W1VLKptU1jybXFqKaTnzQ7NVktFpCGJdOtDA0Zr19gPuFgP8KWTKQupnOBP+6FUba9xG
	KybLEFemWNaL5rsqArN25PUseFiABwJOHP0yRgCALGYFVdIjOPsIz2Dm+bw1Fuo6byA1lmQrTKv
	centIwX2GmDwpXlLsFiX81GmhBVQPBBpIj8pMM0xATkvDMBq9zImR2ftyFqJXXFAzlZ8VcaRZz5
	suJTsDfRVPOb2kmrpVWAqOMVMzhPUoZduw92L7Wf7sPwzD+Li2ZERYfZP27zd1Gf7/Hg==
X-Received: by 2002:a17:90b:3b89:b0:35f:b1f3:ac12 with SMTP id 98e67ed59e1d1-361403cb172mr19257134a91.4.1776813142527;
        Tue, 21 Apr 2026 16:12:22 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8be])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc575bsm14881131a91.4.2026.04.21.16.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:12:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ath11k@lists.infradead.org (open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 ath-next] wifi: ath11k: use kzalloc_flex
Date: Tue, 21 Apr 2026 16:12:05 -0700
Message-ID: <20260421231205.77361-1-rosenp@gmail.com>
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
---
 v2: reword counting variable comment.
 drivers/net/wireless/ath/ath11k/mac.c | 71 ++++++++++-----------------
 drivers/net/wireless/ath/ath11k/wmi.h |  2 +-
 2 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4a68bb9ca4fa..b5f3d7221b5f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4228,13 +4228,14 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;

-	arg = kzalloc_obj(*arg);
+	arg = kzalloc_flex(*arg, chan_list, req->n_channels);

 	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}

+	arg->num_chan = req->n_channels;
 	ath11k_wmi_start_scan_init(ar, arg);
 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH11K_SCAN_ID;
@@ -4262,38 +4263,27 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 		arg->scan_f_passive = 1;
 	}

-	if (req->n_channels) {
-		arg->num_chan = req->n_channels;
-		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
-					 GFP_KERNEL);
+	for (i = 0; i < arg->num_chan; i++) {
+		if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
+			     ar->ab->wmi_ab.svc_map)) {
+			arg->chan_list[i] =
+				u32_encode_bits(req->channels[i]->center_freq,
+						WMI_SCAN_CONFIG_PER_CHANNEL_MASK);

-		if (!arg->chan_list) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-
-		for (i = 0; i < arg->num_chan; i++) {
-			if (test_bit(WMI_TLV_SERVICE_SCAN_CONFIG_PER_CHANNEL,
-				     ar->ab->wmi_ab.svc_map)) {
-				arg->chan_list[i] =
-					u32_encode_bits(req->channels[i]->center_freq,
-							WMI_SCAN_CONFIG_PER_CHANNEL_MASK);
-
-				/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
-				 * flags, then scan all PSC channels in 6 GHz band and
-				 * those non-PSC channels where RNR IE is found during
-				 * the legacy 2.4/5 GHz scan.
-				 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
-				 * then all channels in 6 GHz will be scanned.
-				 */
-				if (req->channels[i]->band == NL80211_BAND_6GHZ &&
-				    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
-				    !cfg80211_channel_is_psc(req->channels[i]))
-					arg->chan_list[i] |=
-						WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
-			} else {
-				arg->chan_list[i] = req->channels[i]->center_freq;
-			}
+			/* If NL80211_SCAN_FLAG_COLOCATED_6GHZ is set in scan
+			 * flags, then scan all PSC channels in 6 GHz band and
+			 * those non-PSC channels where RNR IE is found during
+			 * the legacy 2.4/5 GHz scan.
+			 * If NL80211_SCAN_FLAG_COLOCATED_6GHZ is not set,
+			 * then all channels in 6 GHz will be scanned.
+			 */
+			if (req->channels[i]->band == NL80211_BAND_6GHZ &&
+			    req->flags & NL80211_SCAN_FLAG_COLOCATED_6GHZ &&
+			    !cfg80211_channel_is_psc(req->channels[i]))
+				arg->chan_list[i] |=
+					WMI_SCAN_CH_FLAG_SCAN_ONLY_IF_RNR_FOUND;
+		} else {
+			arg->chan_list[i] = req->channels[i]->center_freq;
 		}
 	}

@@ -9736,19 +9726,14 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,

 	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;

-	arg = kzalloc_obj(*arg);
+	arg = kzalloc_flex(*arg, chan_list, 1);
 	if (!arg) {
 		ret = -ENOMEM;
 		goto exit;
 	}
-	ath11k_wmi_start_scan_init(ar, arg);
+
 	arg->num_chan = 1;
-	arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
-				 GFP_KERNEL);
-	if (!arg->chan_list) {
-		ret = -ENOMEM;
-		goto free_arg;
-	}
+	ath11k_wmi_start_scan_init(ar, arg);

 	arg->vdev_id = arvif->vdev_id;
 	arg->scan_id = ATH11K_SCAN_ID;
@@ -9769,7 +9754,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		spin_lock_bh(&ar->data_lock);
 		ar->scan.state = ATH11K_SCAN_IDLE;
 		spin_unlock_bh(&ar->data_lock);
-		goto free_chan_list;
+		goto free_arg;
 	}

 	ret = wait_for_completion_timeout(&ar->scan.on_channel, 3 * HZ);
@@ -9779,7 +9764,7 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 		if (ret)
 			ath11k_warn(ar->ab, "failed to stop scan: %d\n", ret);
 		ret = -ETIMEDOUT;
-		goto free_chan_list;
+		goto free_arg;
 	}

 	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
@@ -9787,8 +9772,6 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,

 	ret = 0;

-free_chan_list:
-	kfree(arg->chan_list);
 free_arg:
 	kfree(arg);
 exit:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index baed501b640b..b2dade0516ac 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3423,7 +3423,6 @@ struct scan_req_params {
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 *chan_list;
 	u32 notify_scan_events;
 	struct wlan_ssid ssid[WLAN_SCAN_PARAMS_MAX_SSID];
 	struct wmi_mac_addr bssid_list[WLAN_SCAN_PARAMS_MAX_BSSID];
@@ -3436,6 +3435,7 @@ struct scan_req_params {
 	struct hint_bssid hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
 	struct wmi_mac_addr mac_addr;
 	struct wmi_mac_addr mac_mask;
+	u32 chan_list[] __counted_by(num_chan);
 };

 struct wmi_ssid_arg {
--
2.53.0

