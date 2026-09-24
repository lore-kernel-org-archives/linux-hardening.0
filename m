Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C73D34AC
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217706; cv=none; b=UfCrvLQgLAHKZppKy2xAEptRzsGq83gA2suN8Zb19qdUKZkREo8g4gTGlOzV0SVrgi/VaJ0sFGWbRJoUi9exUeEvE8BivvxCNi3ZvuwcsTehBiGp388U9umkTdectvgsbV5NtrKxNnXhBz3WjngWtItcjBMOWLZ8cnQoNUzSFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217706; c=relaxed/simple;
	bh=eSricYYNrtrlErctZulR5p1WU1rEO75n7pS1CPhbnEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBS8kUwEVT5X9zC/nC8eDRGtpk3xhn1ZNN727ai2Y0czLGt3A9SZIS26oKxkki3lQgkEglWbQgJ7Mpamiy8LvcdIXc+ondbhag5mQ18BlgwMhIpjT0OBSa9HvlIwGnxAgOwt0ysJXTRKd9crxOsH6dBfknWLqZhnB+8/8dribBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1eXD18b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R907v6J7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1eXD18b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R907v6J7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2KZ20854446
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9l9FUpOYaeyDvNvaTKqpoEQKgTajA/wJWZ0uNQmQU8I=; b=D1eXD18bMdcb/tLp
	KqVrBi9N+M4hPuv81rRhn02HDDhl6T9x1ZVH1bUE9DPm5fIBryR2Ztrd2sigNvJf
	00pCynZFOO+cDCJ4ZrCGGConotBHdyaxQLFT7HX9ChtqwNcQea1mL9Qm/LT/HdVT
	lYXjCr6n2DOiMPVxQEPyyn+3bxTbZQ0gUfVaurcNgCj9jT1zGcP3APYqDqNj7fSG
	t0IJSq48lMx/rrB0OzEb0I9R9hn0XcffoDrkoaPH/j3VaaqqVFfIbsXJN7PI3ZJr
	laZgmK4TB/AXKaPIjOJ8LbUYLCHJY339r5WKBf5gGvjYSILC5Qf/Xr6JadXfS2gS
	TpPfqQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb28x8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3282d5302ffso470211eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 19:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790217701; x=1790822501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9l9FUpOYaeyDvNvaTKqpoEQKgTajA/wJWZ0uNQmQU8I=;
        b=R907v6J7HoaTzdPuDqUfqrU6cKFcgFELX1jVS652ouL4P+CaD5SQnbNENMby1opiKa
         qRtfi5Gj9sMCc5GHu5ui6+kCthoSTMWFVH72pU6VhFrN3GrodTOghinHyMEJnw7HPk/I
         jDIoJ+nOXuTC/YAYB+ZtrTtST3wG78tFlq/jp1QLvbp2ADxU6nDHLyAB5pvYxKertThr
         hAUUQUmh1u9d31IuGWZfaKMCeNQK5GnI+E2r0f8kvpT1iUByc83becEjMoZA6OxUBrwH
         uLhV9mpsb+iUMVuGY9YZ0aYh356Bwxee7j2DvousSjvbFbOAdHk+NI9hOSOJ0c/tWNJ3
         NJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790217701; x=1790822501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9l9FUpOYaeyDvNvaTKqpoEQKgTajA/wJWZ0uNQmQU8I=;
        b=tv0lZs65e77YQ+P6Sq6YHCoTG93GJ5ik1tdiCtdu0XFueKMzRlZA45e+VbNeJDd8/Z
         yqujmeLeDieb8JsVndfw68hwrPWfG1x3ac1gNyr9H7DfboIeR3eJezEGHy/Ki7sWGg/Z
         bbWWOz2mwM8A5dOZTlrJt7uvWVAFOvRQmEnsRWdUYgYCLzUZTY6LmRtP09YkudJMl63m
         N/BJurZuDy4l7740EPVwEMftD6dGIYnlUaRYQ0aRPnlSn2Di9cA86OcltI1ZxLwmdOHV
         ++aXJEuH6NwOLGuosrfQchq7cBvUDjfAREjoODj7cgygoKU5feBHQV2phg22iyZ15zrl
         Xmbw==
X-Forwarded-Encrypted: i=1; AKwUvByjK7DwaC53dkWS2eLm6LYiFcPZUyJ3SVdz67CfVoyWW0BsgPZ7iGOzToKttGJRtaQBXuT5R5lHmq74Y0Ejzeo=@vger.kernel.org
X-Gm-Message-State: AFuF++m7AMa7t1lof7R5dJ0O88pT4jqLthHl2AlJfEYAUYS/XqFwujeN
	AtufGbIh9wdsP8nMinxvEf+xGCNgEIp6ICvVUZ7EYRk4BnBq6HXMDHr9jOYnfXZ6B6xNAprZ1Cd
	Q61PfMZqqIUlES2vClByKU0+6F0o6p4N1uDzM9CdPAvyN6qyFIl6gNSF7kq+hjHIdgHe8+UOpzT
	Zm0A==
X-Gm-Gg: AYBFou3iIhpqGK1FSMdOKynZccCbfj2aj0MbykbgEjneNErlWIl2hBr54oFul0zM3GF
	86PyGfdzAfWFyF1R5j8xUQEjIMoNwt9Qr8Uw/pXiRz66vj73PCLJptvPY30DutqKsHsqHxZHENi
	7sdHKmJAURVedHGt0IkVeC6pyX3lnUbLR4AEr8nOwuNny0OApc5ZOQvIOLG1V9KMp+IjDlPo6JE
	4z7P4NiPqfIhLgp+/VemY7VhcL4XkkpwcaJ9iaMGk1lGZVmQ6gcs5YgWqoTj/8l1AGXgRFoPc8F
	dCJzoXFP3qUOr+46SMfKN1Q8Ik4ZTTsDHN8c0Dy1+b5kxIwm5T00ryQxgU+BofJzWE3AQlzDwvx
	7mqfmzmW7OxJH6T6urwW62UnXrS4muu3PaCJM0/zlt9pFi6HeOUz3Ros7e7vOC/wxHX67hj3/Qp
	2CWeS+DPH3zUBMnC/7AMxbMg==
X-Received: by 2002:a05:7301:705:b0:332:946c:477a with SMTP id 5a478bee46e88-340059679dfmr678101eec.16.1790217701102;
        Wed, 23 Sep 2026 19:41:41 -0700 (PDT)
X-Received: by 2002:a05:7301:705:b0:332:946c:477a with SMTP id 5a478bee46e88-340059679dfmr678086eec.16.1790217700474;
        Wed, 23 Sep 2026 19:41:40 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm9692263eec.12.2026.09.23.19.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 19:41:40 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 08:10:40 +0530
Subject: [PATCH wireless-next v2 03/16] wifi: cfg80211/mac80211: Configure
 AP with SMD capabilities
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-smd-v2-3-bb40094da1d4@oss.qualcomm.com>
References: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
In-Reply-To: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, pooventhiran.g@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: HDTbihwBt9p7FZGeJCFrAjLLBy7EbS-L
X-Proofpoint-ORIG-GUID: HDTbihwBt9p7FZGeJCFrAjLLBy7EbS-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX4ylQpO+QOHNI
 77HEhQV8/c67ajK+Zyr3xtUJlVocubUpxcD6plw4heU4OapQ4INvt90+LahJFLpWvi7Gyzd1v19
 1SgNlCBtqcbe2lrw9qkW/meoc4Lf2/YFKLFyYELhYVHDrZhXDKrSXXsf4YkSgkP2SNsNNcdAFUh
 /hTkTx/j8arE0aWy7M2qBxQ6SaDyH3iehYcscMCGCXXt6XrU/9xP6MdsAFIdvGvnv2neFITT9iH
 +B8R8hR16z4P0Lg3ySmHxq7SEvgyhRb80SQV59y2Cp+Xj02zeSxSuNUu5tF12aBDvnYCaSPi5pK
 Akx8hJbEeD011xZcD9Q2KiCSaRNB+HVYNpQD2WnZyKOE1JWPWtwls8H4bES+orMmUP+VWx8Zi1P
 o0zOR0+/8lRRZFrc64VIA5rbHvVLG5lGdOUSX28n9wOlDsRG3B7oeLMvIyBBYWXKjFg1LnMWMGN
 OD51j0sG8SwJsnjWBSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX2QHEBJFOL1/e
 sHldbYVTEPsvVivGMJYm8zJqpriT+UglllQtdvtxdqH52WaN4rU/yTryuuJ4Mf1v686cLFk213o
 B4iK7qK5DU0ufsKjdZ40jeCBFdjsPEY=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab48de6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=56q9xwJp3_aMvtWITrUA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240012

From: Rohan Dutta <drohan@qti.qualcomm.com>

When an AP is getting started, configure the AP as SMD-enabled if
userspace provides configuration for the Seamless Mobility Domain (SMD).

The SMD parameters are:
 - SMD Identifier: unique identifier of the SMD
 - SMD Preparation Timeout: Valid duration for a prepared target AP MLD
 - Downlink Data Forwarding: Forwarding support for buffered DL packets
 - Max Number of Peer AP MLDs: Number of target AP MLDs that a non-AP
                               MLD can prepare with
 - SMD Type: Type of SMD
 - SMD PTK Mode: PTK mode used in the SMD
 - Neighbor Probing: UHR Neighboring AP Probing

Without these parameters configured, drivers and lower layers cannot
support SMD BSS Transition.

Signed-off-by: Rohan Dutta <drohan@qti.qualcomm.com>
Co-developed-by: Aditya Sathish <asathish@qti.qualcomm.com>
Signed-off-by: Aditya Sathish <asathish@qti.qualcomm.com>
Co-developed-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Signed-off-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/net/cfg80211.h | 25 ++++++++++++++++
 include/net/mac80211.h |  2 ++
 net/mac80211/cfg.c     |  5 ++++
 net/wireless/nl80211.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9aa7d2d4a184..df85dc804c50 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1587,6 +1587,29 @@ struct cfg80211_s1g_short_beacon {
 	size_t short_tail_len;
 };
 
+/**
+ * struct cfg80211_smd_params - Seamless Mobility Domain parameters
+ *
+ * @smd_enabled: SMD is enabled on this device
+ * @smd_identifier: SMD ID (ETH_ALEN bytes)
+ * @smd_timeout: timeout in 64 TUs for ST Preparation
+ * @dl_data_fwd: MSDU forwarding supported
+ * @max_num_of_peer_apmlds: max prepared AP MLDs supported (0-7)
+ * @smd_type: SMD type
+ * @ptk_mode: PTK mode
+ * @neighbor_probing: UHR Neighboring AP Probing supported
+ */
+struct cfg80211_smd_params {
+	bool smd_enabled;
+	u8 smd_identifier[ETH_ALEN];
+	u16 smd_timeout;
+	bool dl_data_fwd;
+	u8 max_num_of_peer_apmlds;
+	enum nl80211_smd_type smd_type;
+	enum nl80211_smd_ptk_mode ptk_mode;
+	bool neighbor_probing;
+};
+
 /**
  * struct cfg80211_ap_settings - AP configuration
  *
@@ -1623,6 +1646,7 @@ struct cfg80211_s1g_short_beacon {
  * @mbssid_config: AP settings for multiple bssid
  * @s1g_long_beacon_period: S1G long beacon period
  * @s1g_short_beacon: S1G short beacon data
+ * @smd_params: Seamless Mobility Domain (SMD) parameters
  */
 struct cfg80211_ap_settings {
 	struct cfg80211_chan_def chandef;
@@ -1655,6 +1679,7 @@ struct cfg80211_ap_settings {
 	struct cfg80211_mbssid_config mbssid_config;
 	u8 s1g_long_beacon_period;
 	struct cfg80211_s1g_short_beacon s1g_short_beacon;
+	struct cfg80211_smd_params smd_params;
 };
 
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 1172d7b83ed1..3a5011945eed 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -797,6 +797,7 @@ struct ieee80211_bss_npca_params {
  * @s1g_long_beacon_period: number of beacon intervals between each long
  *	beacon transmission.
  * @npca: NPCA parameters
+ * @smd_params: SMD parameters
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -904,6 +905,7 @@ struct ieee80211_bss_conf {
 	u8 s1g_long_beacon_period;
 
 	struct ieee80211_bss_npca_params npca;
+	struct cfg80211_smd_params smd_params;
 };
 
 #define IEEE80211_NAN_MAX_CHANNELS 3
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 23f4f9ec86d0..b4b42790c5d7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1796,6 +1796,11 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 		}
 	}
 
+	if (params->smd_params.smd_enabled)
+		link_conf->smd_params = params->smd_params;
+	else
+		link_conf->smd_params.smd_enabled = false;
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index de93b34444b4..b4ff784d131b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7225,6 +7225,78 @@ static int nl80211_check_npca(struct cfg80211_registered_device *rdev,
 	return -EINVAL;
 }
 
+static int nl80211_parse_smd_params(struct genl_info *info,
+				    struct cfg80211_smd_params *smd_params)
+{
+	struct nlattr *smd_params_attr = info->attrs[NL80211_ATTR_SMD_PARAMS];
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct nlattr *tb[NL80211_SMD_PARAMS_ATTR_MAX + 1];
+	int err;
+
+	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_SMD)) {
+		GENL_SET_ERR_MSG(info, "SMD is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (!wdev->valid_links) {
+		GENL_SET_ERR_MSG(info, "SMD is not allowed without MLO");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(tb, NL80211_SMD_PARAMS_ATTR_MAX,
+			       smd_params_attr, nl80211_smd_params_policy,
+			       NULL);
+	if (err) {
+		GENL_SET_ERR_MSG(info, "failed to parse SMD parameters");
+		return err;
+	}
+
+	if (!tb[NL80211_SMD_PARAMS_ATTR_IDENTIFIER] ||
+	    !tb[NL80211_SMD_PARAMS_ATTR_TIMEOUT] ||
+	    !tb[NL80211_SMD_PARAMS_ATTR_MAX_PEER_APMLDS] ||
+	    !tb[NL80211_SMD_PARAMS_ATTR_TYPE] ||
+	    !tb[NL80211_SMD_PARAMS_ATTR_PTK_MODE]) {
+		GENL_SET_ERR_MSG(info, "required SMD parameters are missing");
+		return -EINVAL;
+	}
+
+	memcpy(smd_params->smd_identifier,
+	       nla_data(tb[NL80211_SMD_PARAMS_ATTR_IDENTIFIER]),
+	       ETH_ALEN);
+
+	smd_params->smd_timeout =
+		nla_get_u16(tb[NL80211_SMD_PARAMS_ATTR_TIMEOUT]);
+
+	smd_params->dl_data_fwd =
+		!!tb[NL80211_SMD_PARAMS_ATTR_DL_DATA_FORWARDING];
+	if (smd_params->dl_data_fwd &&
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_SMD_DL_PKT_FORWARDING)) {
+		GENL_SET_ERR_MSG(info,
+				 "SMD DL packet forwarding is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	smd_params->max_num_of_peer_apmlds =
+		nla_get_u8(tb[NL80211_SMD_PARAMS_ATTR_MAX_PEER_APMLDS]);
+
+	smd_params->smd_type =
+		nla_get_u8(tb[NL80211_SMD_PARAMS_ATTR_TYPE]);
+
+	smd_params->ptk_mode =
+		nla_get_u8(tb[NL80211_SMD_PARAMS_ATTR_PTK_MODE]);
+
+	smd_params->neighbor_probing =
+		!!tb[NL80211_SMD_PARAMS_ATTR_NEIGHBOR_PROBING];
+
+	smd_params->smd_enabled = true;
+
+	return 0;
+}
+
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -7506,6 +7578,12 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 	/* FIXME: validate MLO/link-id against driver capabilities */
 
+	if (info->attrs[NL80211_ATTR_SMD_PARAMS]) {
+		err = nl80211_parse_smd_params(info, &params->smd_params);
+		if (err)
+			goto out;
+	}
+
 	err = rdev_start_ap(rdev, dev, params);
 	if (!err) {
 		wdev->links[link_id].ap.beacon_interval = params->beacon_interval;

-- 
2.34.1

