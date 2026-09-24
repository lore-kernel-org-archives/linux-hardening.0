Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B763CF976
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217709; cv=none; b=cTTsrTyhlLMDTdgy8o8fTrqDpF78hv6hwDJLBe8Z4iZyJ1stOLNLAh3OAY9FOaTL0UapPup+/x3CE14+JttptiXJoftJ+dqXIoPurt4B3CUmkABQvBDMgBElAUeBliGXT8kBh9WghCAlSciz/ZyOLM34EmKX15jVJFnrXZwxPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217709; c=relaxed/simple;
	bh=G/rmWbY+P9DmNnDDZSpiVUK0rqtD5UWT3SjfEoiJI3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=El+0Tginm18W3FOrMJIwJ3ciiUNnHjJhvLiWG3RD5/qALOaIbQ6ZXOvzrNUTLMTuJaTGNnQJ60I8zxF47d5uV62h0wOFmhzodpffRcJWwQWxJwxDoZ0RUGUHpovC8TNJPokpd9aG/vVe6ordPtABy4EJm1bfSLcjKRyvXt4kkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J6suPMHD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YMwxbU7l; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6suPMHD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YMwxbU7l"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2KIuu3723375
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qmVZoiMv7M0RtjS1Lv0wIeHx7PFyXkJQmL7AOMJ+2DQ=; b=J6suPMHDMoTCMm8y
	qI6woFcIELpbsV0kfSv1WYhQkiFxnAQL8ZXCCEh9yNUJ1pe9kpjNJuNCE+fT5XSh
	N+qM3zEl9KDP2IizMWo7pAsDZ4odgXW2RDJZp92auL/K+2EHN9X9txlN7QsbJUAY
	z29wpJtiZeSNlkSfTU574EYovq1EYAIKNEn0mRr25sk2t848pIGit6xFL1jG3og0
	clAbhDp5m1Qcy1ZnYbuwPXqAexhHWiu7wVyWejvGdjbdEapRrhImjh+Cla7MIKuw
	pm/0rgK7GAP5Y12imGnyvP2SipJ/nvGnMsu2ZJQFiWyU5c7iMgiMnKaj5yFl0CCq
	qaDtxg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfjv2wq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso2623885eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 19:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790217704; x=1790822504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmVZoiMv7M0RtjS1Lv0wIeHx7PFyXkJQmL7AOMJ+2DQ=;
        b=YMwxbU7lDHjVcfMp8+xu22w04jeR4rzZmIvCs0N2AQF5GIG9F1ji+2/6j2eiu1F9v7
         a+DDJABhxhTl4Xq0I7XUOLHvHsKXPHQu0S2bEwuQC8GiLy3xRmhQELsiYih6oixDNt21
         EhREzdrddtDZHLTg/FvL70LZm35efwiG3RgdsdENUXPBCbiGfwmiXLTQXmBf3R21ryJD
         YMohHkZq1KU3v/SwXfhvJcIdPNRcxY/X1j3YKQNIweQjNmVII/uo1NCUJ4ccvF+HTfhd
         9eYwW6vPYcc0VQBJUcOhqCpdvwWFw1jo6XWQNlctEm9uogJANSpc/k12+kpGfsiHIlD1
         WSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790217704; x=1790822504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qmVZoiMv7M0RtjS1Lv0wIeHx7PFyXkJQmL7AOMJ+2DQ=;
        b=juLMMs3R6mPChw57gegK46I/pUdvcO4sEMtvj2tFIuEI2UniithmR+hDeX2vLPSZx/
         pJUIQv58TA/nBL/geMvxUYtX1nvVEJD8vbMv4QIFOHze3eb61R6AlD+Jwh5iXww/ihU6
         HqAkkH7uXvkNVciC38RNN0f6586laDa4fPQh+aEc08Ath1cOEWuQ073+4YYkrnepPmJK
         ciIpH3kzVuGWjpzaZrW22lsWLO8SCfzB0U0P57m1pkrqcBiFRP8kcWsZ38Lw/Udqo7zs
         ypL3sZFlVmy+wUBLAGYnNUC+I4RBKSd2QTxt+oYW6+eFmZ2ZGUjygy0ujpzDZX0vlKIK
         3ifQ==
X-Forwarded-Encrypted: i=1; AKwUvBxBzAsrrpyUesp469bMpu2YGKL0VKBSZb5DzgAhY2PLI8hjS2VXNawacqz/goTivwtAVgLB1oGAiX9eL75iUcc=@vger.kernel.org
X-Gm-Message-State: AFuF++nZEKrDVbRCiz5FGV0udpgHcqRdTwVp3K9AW4zia9B+17Za4vl+
	uWuYGzICyfBZFrIXy0TwBiyyu7n59OngTgusdbDthnJJpWIqtJcuQis+8//CK87js6hrhM40a7s
	VzIfXREXXEpZnguL3vpZQB96sVxFFTblytOgOor2Tel7t5Ywn3QQ/lYQ0ATF6GwZ2QL/Ocg==
X-Gm-Gg: AYBFou1eMNDE2LIWQ8s/cjseGT6tLGHDaImblwDbeYvyKH3QnsuyB/aztXS9UDe+O6N
	B6+eOror3c5efJUV7M9+cBygKjz4XODaY3HPZBGOOqvLhShvUbeIs9hf21mt/rldgbZeDqhTgbj
	bKEHC43mGHlXUaNYz+RfvzbWc1pWtkalvO8v+HWYufoXHxSL45zFGmHPjaXvUf3gIVYzwBlAFfN
	A96O/Z/qo9pjN+/5AxRtyNuGcwLADJNmskgCjZ8mPTEzvbdmllNhmj5FSUB+XNoD0+bLjzY7JcT
	nIk9ObZcKyFmB1puQMBadnEqylmWF7a5G9yekKGoAAWAl0n9zUC4kqgDuFXCh0fCSU7Lj1aJUjT
	3dD5OhgGATHGqpu2jnz4ZjolAinj0QdlH/ceOfCbvl/+nXmtJdRxyM5rgMxaB0VuXbxPCWRpeRV
	gHQSFX++CS9085qrxMDuKuxA==
X-Received: by 2002:a05:7300:1695:b0:33c:16f1:2e3f with SMTP id 5a478bee46e88-33ffe44d72bmr658551eec.6.1790217704286;
        Wed, 23 Sep 2026 19:41:44 -0700 (PDT)
X-Received: by 2002:a05:7300:1695:b0:33c:16f1:2e3f with SMTP id 5a478bee46e88-33ffe44d72bmr658530eec.6.1790217703616;
        Wed, 23 Sep 2026 19:41:43 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm9692263eec.12.2026.09.23.19.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 19:41:43 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 08:10:41 +0530
Subject: [PATCH wireless-next v2 04/16] wifi: cfg80211/mac80211: Parse SMD
 parameters in STA addition/modification
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-smd-v2-4-bb40094da1d4@oss.qualcomm.com>
References: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
In-Reply-To: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, pooventhiran.g@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX7rTNkLKgfVeM
 UCN89NYDm4f5GU7F0oIf17PxIrbipCgGQc/BZ7+JjDoaDXOSaw6bxH4MZi+452bdrMI3vTx/Vb2
 hAz/G+MgBj1omcbfJjieFOTC5cfOFkkWgfaCsSKU/BEbUCmugJdU0F0fmm7wom+JHxXdi3XTRIG
 CuNnXI73jBcLg9Vt84OYY5xCdQMtdyOCMYZ4/fTikF84kgNmKgfLIxSYTg63snUq2E40XisfTG/
 VfWD/+uIuf401TyTRiWKfiQ+Z/ekreptPG8cwBrEf1F4BuUx7cT7+tVPTP5fEuk0rOnrKj182BR
 eUiRppplBFDYMLYhlItlb3vMK6+3WlGb3yKKxfLNN9X1AeFE+Pe90LIhUANhSzCbtI7Yqv9MHQX
 6GOc3l4lgi7QZ4lMp4EdFZY6mN3S93Fxmcg7oh9mAPnBpTrM30mvR8mgxg1D5w2JwSCk8UHJruk
 jc4ifXsAzTJqVMrMA5A==
X-Authority-Analysis: v=2.4 cv=aIxlOr9m c=1 sm=1 tr=0 ts=6ab48de9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=tJjRGxMx1SIfQ35-_K4A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: iKWsJilMhKBWPEBFFbidiOAugCyA7t81
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfXxTPUpwNR4Ydg
 SV57k8XIdH11HirQIHA7UfgUqT9XzlBuRFe3hURe2Im2ChdcoHucnCkOUCjiKnrbcfUOMfEXdJa
 DHC513+0+PXBxfZnzKU5a0TwWdyRupY=
X-Proofpoint-ORIG-GUID: iKWsJilMhKBWPEBFFbidiOAugCyA7t81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240012

From: Aditya Sathish <asathish@qti.qualcomm.com>

When a non-AP MLD is getting added or having its capabilities updated,
handle the SMD parameters passed from userspace. Otherwise, drivers will
not be able to identify that the non-AP MLD has negotiated SMD with this
AP MLD during association nor can they support SMD BSS Transition if it
has been requested later by the non-AP MLD.

Signed-off-by: Aditya Sathish <asathish@qti.qualcomm.com>
Co-developed-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Signed-off-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Co-developed-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 15 +++++++++++++
 include/net/mac80211.h       |  3 +++
 include/uapi/linux/nl80211.h | 17 ++++++++++++++
 net/mac80211/cfg.c           | 10 +++++++++
 net/mac80211/debugfs_sta.c   |  1 +
 net/mac80211/sta_info.h      |  2 ++
 net/wireless/nl80211.c       | 53 ++++++++++++++++++++++++++++++++++++++------
 7 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index df85dc804c50..51fb64a837fd 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1897,6 +1897,19 @@ struct cfg80211_ttlm_params {
 	u16 ulink[8];
 };
 
+/**
+ * struct cfg80211_sta_smd_params - SMD parameters for an added station
+ *
+ * @smd_sta: SMD-negotiated STA
+ * @smd_identifier: SMD Identifier
+ * @dl_data_fwd: MSDU forwarding supported
+ */
+struct cfg80211_sta_smd_params {
+	bool smd_sta;
+	u8 smd_identifier[ETH_ALEN];
+	bool dl_data_fwd;
+};
+
 /**
  * struct station_parameters - station parameters
  *
@@ -1937,6 +1950,7 @@ struct cfg80211_ttlm_params {
  * @link_sta_params: link related params.
  * @epp_peer: EPP peer indication
  * @nmi_mac: MAC address of the NMI station of the NAN peer
+ * @smd_params: SMD params for this station
  */
 struct station_parameters {
 	struct net_device *vlan;
@@ -1965,6 +1979,7 @@ struct station_parameters {
 	struct link_station_parameters link_sta_params;
 	bool epp_peer;
 	const u8 *nmi_mac;
+	struct cfg80211_sta_smd_params smd_params;
 };
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 3a5011945eed..39d67c054ae6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2726,6 +2726,7 @@ struct ieee80211_link_sta {
  * @nan_sched: NAN peer schedule for this station. Valid only for NMI stations.
  * @ext_mld_capa_ops: the MLD's extended MLD capabilities and operations
  *	NOTE: currently only tracked for AP STAs
+ * @smd_params: SMD parameters of the STA
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN] __aligned(2);
@@ -2760,6 +2761,8 @@ struct ieee80211_sta {
 	/* should only be accessed with the wiphy mutex held */
 	struct ieee80211_nan_peer_sched *nan_sched;
 
+	struct cfg80211_sta_smd_params smd_params;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1177a511c8cb..265c5883e6cf 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3196,6 +3196,17 @@ enum nl80211_commands {
  *	%NL80211_EXT_FEATURE_SMD.
  *	Used with %NL80211_CMD_START_AP. See &enum nl80211_smd_params_attrs.
  *
+ * @NL80211_ATTR_PEER_SMD_ENABLED: Flag indicating a peer STA has SMD enabled.
+ *	Used with %NL80211_CMD_NEW_STATION and %NL80211_CMD_SET_STATION.
+ *
+ * @NL80211_ATTR_PEER_SMD_MAC_ADDR: Binary attribute with the 6-byte MAC
+ *	address of the SMD-capable peer STA.
+ *	Used with %NL80211_CMD_NEW_STATION and %NL80211_CMD_SET_STATION.
+ *
+ * @NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING: Flag indicating the peer STA
+ *	supports DL data forwarding within the SMD domain.
+ *	Used with %NL80211_CMD_NEW_STATION and %NL80211_CMD_SET_STATION.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3800,6 +3811,10 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SMD_PARAMS,
 
+	NL80211_ATTR_PEER_SMD_ENABLED,
+	NL80211_ATTR_PEER_SMD_MAC_ADDR,
+	NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3950,6 +3965,7 @@ enum nl80211_iftype {
  *	that support %NL80211_FEATURE_FULL_AP_CLIENT_STATE to transition a
  *	previously added station into associated state
  * @NL80211_STA_FLAG_SPP_AMSDU: station supports SPP A-MSDUs
+ * @NL80211_STA_FLAG_SMD: station has negotiated SMD.
  * @NL80211_STA_FLAG_MAX: highest station flag number currently defined
  * @__NL80211_STA_FLAG_AFTER_LAST: internal use
  */
@@ -3963,6 +3979,7 @@ enum nl80211_sta_flags {
 	NL80211_STA_FLAG_TDLS_PEER,
 	NL80211_STA_FLAG_ASSOCIATED,
 	NL80211_STA_FLAG_SPP_AMSDU,
+	NL80211_STA_FLAG_SMD,
 
 	/* keep last */
 	__NL80211_STA_FLAG_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b4b42790c5d7..138b67f4bda4 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2528,6 +2528,16 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
 		sta->sta.spp_amsdu = set & BIT(NL80211_STA_FLAG_SPP_AMSDU);
 
+	if (mask & BIT(NL80211_STA_FLAG_SMD)) {
+		if (set & BIT(NL80211_STA_FLAG_SMD))
+			set_sta_flag(sta, WLAN_STA_SMD);
+		else if (test_sta_flag(sta, WLAN_STA_SMD))
+			clear_sta_flag(sta, WLAN_STA_SMD);
+	}
+
+	if (params->smd_params.smd_sta)
+		sta->sta.smd_params = params->smd_params;
+
 	/* mark TDLS channel switch support, if the AP allows it */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) &&
 	    !sdata->deflink.u.mgd.tdls_chan_switch_prohibited &&
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index ef75255d47d5..d7e7c9c578e4 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -78,6 +78,7 @@ static const char * const sta_flag_names[] = {
 	FLAG(PS_DELIVER),
 	FLAG(USES_ENCRYPTION),
 	FLAG(DECAP_OFFLOAD),
+	FLAG(SMD),
 #undef FLAG
 };
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index ee0d32877c5b..506aeb241a6d 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -72,6 +72,7 @@
  * @WLAN_STA_USES_ENCRYPTION: This station was configured for encryption,
  *	so drop all packets without a key later.
  * @WLAN_STA_DECAP_OFFLOAD: This station uses rx decap offload
+ * @WLAN_STA_SMD: this station is associated to an SMD-ME.
  *
  * @NUM_WLAN_STA_FLAGS: number of defined flags
  */
@@ -104,6 +105,7 @@ enum ieee80211_sta_info_flags {
 	WLAN_STA_PS_DELIVER,
 	WLAN_STA_USES_ENCRYPTION,
 	WLAN_STA_DECAP_OFFLOAD,
+	WLAN_STA_SMD,
 
 	NUM_WLAN_STA_FLAGS,
 };
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b4ff784d131b..76fb83f61b89 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1115,6 +1115,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_FRAME_NO_STA] = { .type = NLA_FLAG },
 	[NL80211_ATTR_SMD_PARAMS] =
 		NLA_POLICY_NESTED(nl80211_smd_params_policy),
+	[NL80211_ATTR_PEER_SMD_ENABLED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_PEER_SMD_MAC_ADDR] = NLA_POLICY_ETH_ADDR,
+	[NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -7703,6 +7706,7 @@ static const struct nla_policy sta_flags_policy[NL80211_STA_FLAG_MAX + 1] = {
 	[NL80211_STA_FLAG_MFP] = { .type = NLA_FLAG },
 	[NL80211_STA_FLAG_AUTHENTICATED] = { .type = NLA_FLAG },
 	[NL80211_STA_FLAG_TDLS_PEER] = { .type = NLA_FLAG },
+	[NL80211_STA_FLAG_SMD] = { .type = NLA_FLAG },
 };
 
 static int parse_station_flags(struct genl_info *info,
@@ -7769,11 +7773,13 @@ static int parse_station_flags(struct genl_info *info,
 	switch (iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
+		params->sta_flags_mask = BIT(NL80211_STA_FLAG_SMD);
+		fallthrough;
 	case NL80211_IFTYPE_P2P_GO:
-		params->sta_flags_mask = BIT(NL80211_STA_FLAG_AUTHORIZED) |
-					 BIT(NL80211_STA_FLAG_SHORT_PREAMBLE) |
-					 BIT(NL80211_STA_FLAG_WME) |
-					 BIT(NL80211_STA_FLAG_MFP);
+		params->sta_flags_mask |= BIT(NL80211_STA_FLAG_AUTHORIZED) |
+					  BIT(NL80211_STA_FLAG_SHORT_PREAMBLE) |
+					  BIT(NL80211_STA_FLAG_WME) |
+					  BIT(NL80211_STA_FLAG_MFP);
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_STATION:
@@ -8914,7 +8920,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
-	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 8);
+	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 9);
 
 	switch (statype) {
 	case CFG80211_STA_MESH_PEER_KERNEL:
@@ -9008,7 +9014,8 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
 				  BIT(NL80211_STA_FLAG_SHORT_PREAMBLE) |
 				  BIT(NL80211_STA_FLAG_WME) |
 				  BIT(NL80211_STA_FLAG_MFP) |
-				  BIT(NL80211_STA_FLAG_SPP_AMSDU)))
+				  BIT(NL80211_STA_FLAG_SPP_AMSDU) |
+				  BIT(NL80211_STA_FLAG_SMD)))
 			return -EINVAL;
 
 		/* but authenticated/associated only if driver handles it */
@@ -9262,6 +9269,30 @@ static int nl80211_parse_sta_txpower_setting(struct genl_info *info,
 	return 0;
 }
 
+static int nl80211_set_station_smd(struct genl_info *info,
+				   struct station_parameters *params)
+{
+	struct nlattr *smd_mac;
+
+	params->smd_params.smd_sta =
+		!!info->attrs[NL80211_ATTR_PEER_SMD_ENABLED];
+
+	if (!params->smd_params.smd_sta)
+		return 0;
+
+	smd_mac = info->attrs[NL80211_ATTR_PEER_SMD_MAC_ADDR];
+
+	if (!info->attrs[NL80211_ATTR_MLD_ADDR] || !smd_mac)
+		return -EINVAL;
+
+	nla_memcpy(params->smd_params.smd_identifier, smd_mac, ETH_ALEN);
+
+	params->smd_params.dl_data_fwd =
+		!!info->attrs[NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING];
+
+	return 0;
+}
+
 static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -9400,6 +9431,10 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	err = nl80211_set_station_smd(info, &params);
+	if (err)
+		return err;
+
 	/* Include parameters for TDLS peer (will check later) */
 	err = nl80211_set_station_tdls(info, &params);
 	if (err)
@@ -9628,6 +9663,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	if (parse_station_flags(info, wdev->iftype, &params))
 		return -EINVAL;
 
+	err = nl80211_set_station_smd(info, &params);
+	if (err)
+		return err;
+
 	/* HT/VHT requires QoS, but if we don't have that just ignore HT/VHT
 	 * as userspace might just pass through the capabilities from the IEs
 	 * directly, rather than enforcing this restriction and returning an
@@ -9661,7 +9700,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	/* When you run into this, adjust the code below for the new flag */
-	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 8);
+	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 9);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:

-- 
2.34.1

