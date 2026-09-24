Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115D733372A
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217703; cv=none; b=cMarSs1A00hQzUjaNFb40Oez+kiLTw8kGVHeN9aUmBd2mYD1iyhNGl4YjkUzwgk2TELPGcgUxxQdE/3TDkf/3zNCp4zUW/qV4rLGenN37/xLA0zDWavpbXwb2xa5SzbS00OHHuNKNusKf9Em/M6vW3Hea9Gwmi9y8hNZbM0wfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217703; c=relaxed/simple;
	bh=EyWLR8HT45CAln0XcNXl0Swx1iiDzFpgEV+ivaL8IlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ak35Ysk4w2TEUetm3fbRoaBx9fzwBuKTkD8JE972vCCzXKIsXlOcrQo++8qhvyYUqyda9UENqS+HtysK4+hdOA6oyf9NVwtgj75MABROaMVNLJhaPPIuPa7GiOVVxay+0GGDol2lQwNGW3AaYOGJcfwaedYOeAl3XyQUoRvBScg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WT0ALLL8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZJmYicwO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WT0ALLL8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZJmYicwO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2K31u853874
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	28JFi8aQFyfFe/wqTpKPLr2ytagGCO4P3M2TiHnNNmg=; b=WT0ALLL8GCdyvton
	Eok1FIZvqH2OxbrwYcXSxfwlkecLxdZOatKff2W1cNwGd1uJg+PnvszVHMzxtgkN
	9ezr+k3+5FI6a9NMsm+dtgFTXWoqmYHbbKzb9BGrseVWSMe862vuqFnxo8zLoJR0
	HHRE0cZYL5Mv2yowRMrRDra8Y15go1gvWGit38bZ02kuS5PtEvS/Z0k1f/8akXoz
	XLYTkvqSyVaMNFqbnrmFN/BmFdNS8N9yzZNn28rY6mqTUtUdIEjVj8G8SwpwOtrK
	vpU5pS2lpym2+giVe7ryFJUMMJ+PKcgLK1BBwtCNTV5CGXIXu/OMj2K0blYxsLKZ
	6gTO5Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvhsb28ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33baaba6371so834753eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 19:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790217695; x=1790822495; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=28JFi8aQFyfFe/wqTpKPLr2ytagGCO4P3M2TiHnNNmg=;
        b=ZJmYicwO7dJtq4G/RC5X0fD56wmdq+iRD7DWtjPt7vnHmrtm1MIfnRMRwxbQ56GqXJ
         ojncJIFdpyV7mzlKosWCu6/VsAuVkejE7XFadT1R3w79GMrv8+PR1RJUlrkSpnaFl5oX
         Z26LI4lDx4HbDDR5+hQzcEz3thMRZtkSSeXJR49VlyGbOl69DgzRco4MMUJ6655nIV5x
         RFOOHFqcl8Lp0CT/WAumTROND4jVypijK9DDFAZB4Go4ZIuxVZgDlf+6LfFwURxBzo/X
         N24q6L/YuGBDWubjyjENBgJtgGQ7AvOACe+HYMXIWk6C4gizBi2cJup5jCQrHVxqOn46
         XiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790217695; x=1790822495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=28JFi8aQFyfFe/wqTpKPLr2ytagGCO4P3M2TiHnNNmg=;
        b=wtWGlKFxkf+EemcS/1EOKZ1NqZHeit1C8vGDh9NLq+ZgVpjC7rXJcwxxC0p8u+kj1D
         k00Ocl9H/rEbgVlPy+ZMAutuCdBLaVdi9flkkIoM11l6xaw+OjwDLJqkgKVYA8Fx6ez7
         fa5NdtswrNmXK9rxEfm0pIN/Fersdb8GVcKiIbop0VrCvd8BG2bRcu74U4I6yjVgjiQO
         /MnglpwMCYUz1Om54PFERBptn7IvNU9Bd1k5F9RnPDQ1Q5sglP1W+X6u9iODSvvSacoc
         pSuqDMbmaHNNC+OETm7K8qCiJbdqC1BEzjDaRgvBRje/Zz/dRCPXqJQZ/ikfAgms1ANL
         rn+w==
X-Forwarded-Encrypted: i=1; AKwUvBw8Hq+b6naxFllcH2lEpZQNiDs2StNxV2nX6qWGt6tMv5H2pXlJv4uzMitbmwRfhRvQI4rULAlacyk0KV952NY=@vger.kernel.org
X-Gm-Message-State: AFuF++k5slEwmJlFqm4yuMhiUo7BNkAws/Gq+5dPeZOF2RtAeJOPYvRp
	Rrl28wqJImM3Av8UGiStYwmKBofIMaCar+IhXUajUy6gpoKBVLmYDDKGgC4cw5uwLHVb/lyJpSz
	5QoEXGYSUX8y8yu625mJbpGRJKf2DWHbP1RsdOMEKQthWAHtSckcPPROgWndhw5l2hO+d0w==
X-Gm-Gg: AYBFou1UnUG4OuVTgqHzCLkHtZvNp2Xt0xfrWUIAhPeLq0vj4TdWBDM1x8Dij9awMMQ
	hmVBbDGsIKXdAmghiP589Q/Mo8RLXaQ5XYO50JQn1aJiPRVqlCqQ3zDzzETPABcBjWYMAa5+LAe
	avCN1p+2FLTt8zXp9elHrJR+hR7Cr0pSb7gdQjoI4gDVB9mYvgrMBbUW8JxUWjrueNLwJtgKeUw
	FBoAJPa5Mfw3sQZHR2MEF2IrgCQj9E8mGoVvSDewaTStbwAWwrXrS/qiV+KflDjN/IAsQFWticd
	3FJqZ2d5BWeexV4KFvU0FWaj7CR76ij+M4FeMuR4OLOxsLM1e08d8SDLNjCGTT8jZ7p9XSy320i
	7KK3LpzVPwDSUSNMNcKJXUuCNSYmJV4fxWYqs8BvlcN+3DAGGDhMeHAfa5G64fDRwPRYYSJCV8e
	J0SN3u6iCdkUkRyctIrYZ+FQ==
X-Received: by 2002:a05:7300:8189:b0:33c:3515:daf4 with SMTP id 5a478bee46e88-340034c1e5amr1109995eec.27.1790217694823;
        Wed, 23 Sep 2026 19:41:34 -0700 (PDT)
X-Received: by 2002:a05:7300:8189:b0:33c:3515:daf4 with SMTP id 5a478bee46e88-340034c1e5amr1109965eec.27.1790217694179;
        Wed, 23 Sep 2026 19:41:34 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm9692263eec.12.2026.09.23.19.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 19:41:33 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 08:10:38 +0530
Subject: [PATCH wireless-next v2 01/16] wifi: nl80211: Define Seamless
 Mobility Domain (SMD) device capability
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-smd-v2-1-bb40094da1d4@oss.qualcomm.com>
References: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
In-Reply-To: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, pooventhiran.g@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: FRZAihLrjcHQU2dsxnlf89JpLScmeqVa
X-Proofpoint-ORIG-GUID: FRZAihLrjcHQU2dsxnlf89JpLScmeqVa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX4HyIbnJ5z4he
 Cz5yHiIdrpk+qVB7opsXOfa8qgcqzEHfg+EodHGGr6PpzjPZWqJh8Hteut0hG4dElVWDyYQGCyS
 TYUEvxjTcNECzoGVfVteYzBMf5BIo4ze463oguUIYYS7qUXU+afMj8CEuTYnO26CNR4UowfJx2A
 JEhgExgSbRIc0pCG51YMllvHTTxDRZseMAMkgNXlIjSAB306DTiM0+hD9vCI5/eVtB0hHrVLPVz
 4y09QLY8s+mQsfqLrWt4yjN1XdPkrn061nz0U33tzdpO/4FHYJtPDeZx0uj1WLL+nwRCItex0vK
 quZRB+3CNEMtKRs6KId5Mt2ajA6Uil6vFICeErg9ZQ7xEYfhuLkcdUhB5nrD/1cgY3m0xBXFIDk
 HbPJXuTQcjxa2mUrc0ztF+ncGNasOPSj7mPMpGs+BPPA5PWyhxlVkcCxNC6bMkApV6GWWdYt4NO
 N+nLXb4NmInfYmfkg5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX9uZPgZQm3PUP
 xUBzim+Dwlzc0cpEp61rElGyGUszDmno3bk+MKmF2FOighw5KkzFYTRzJBOS9y1K9RyzzLmOSif
 DElDhb7gUisdmwu7dIpSn8Z4NShW7VI=
X-Authority-Analysis: v=2.4 cv=f7vdl+yM c=1 sm=1 tr=0 ts=6ab48ddf cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-9rhnhb8Ej--qkh-m00A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240012

From: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>

Per IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16, an AP MLD can be
managed by a Seamless Mobility Domain Management Entity (SMD-ME) along
with partner AP MLDs to enable seamless transition of an associated
non-AP MLD from the current AP MLD to a target AP MLD. A non-AP MLD
advertising SMD supports association to an SMD-ME and SMD BSS
Transition between AP MLDs within an SMD.

Subclause 37.16.11 defines an optional capability for the current AP
MLD to forward buffered downlink (DL) data frames for the non-AP MLD to
the target AP MLD.

Userspace needs a way to be aware of the driver's SMD capabilities so that
it can enable SMD configuration and operation only on capable devices.

Define two extended feature flags
 - NL80211_EXT_FEATURE_SMD for SMD management and BSS Transition
   capability
 - NL80211_EXT_FEATURE_SMD_DL_PKT_FORWARDING for DL data forwarding
   capability

so that userspace can gate SMD setup and data forwarding configuration
on driver support.

Signed-off-by: Sidhanta Sahu <sidhanta.sahu@oss.qualcomm.com>
Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9a2ccb8d66b8..d05103889912 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7126,6 +7126,15 @@ enum nl80211_feature_flags {
  *	offload in station mode, including Fast Transition or Opportunistic
  *	Key Caching.
  *
+ * @NL80211_EXT_FEATURE_SMD: Driver supports Seamless Mobility Domain (SMD)
+ *	and is managed by an SMD-ME to support SMD BSS Transition in AP mode
+ *	and supports association to an SMD-ME and SMD BSS transition in
+ *	non-AP STA mode.
+ *
+ * @NL80211_EXT_FEATURE_SMD_DL_PKT_FORWARDING: Driver supports forwarding of
+ *	buffered downlink (DL) data packets in AP mode to the non-AP STA during
+ *	SMD BSS Transition.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -7209,6 +7218,8 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SET_KEY_LTF_SEED,
 	NL80211_EXT_FEATURE_PROBE_AP,
 	NL80211_EXT_FEATURE_FAST_ROAM_OFFLOAD,
+	NL80211_EXT_FEATURE_SMD,
+	NL80211_EXT_FEATURE_SMD_DL_PKT_FORWARDING,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,

-- 
2.34.1

