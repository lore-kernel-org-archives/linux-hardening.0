Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C99B3DB303
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217737; cv=none; b=MDYo0mPpEme3GODpWQwTNdLPMIvoopS8E49Iw6hyAjHcBsUgh6epXe/UOyk40BjHPK/7dmKvKmefVk0sFHwAJFw4dPglp1aFjScHEYGF41aGaX5XUphRQd0RCYNBwQL9T714ojkc8tALpAG1hRUnM+URSYX01X5ceAjP37OyUMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217737; c=relaxed/simple;
	bh=rsyg9OrxC2RSurVrwLyot/phk4aj8tlnPMYH8VeVBtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdElQOvV6ySUptgvTG2xjBWQaDU4NNNrR0NPtcPHbH913hx+DkNSIPXl4fcvsWKuk5Al7GMmXS4BrW9of5VAWSgZCtHFX8pr24B1MiEVua0yLjoxMNwS+Ybm9EtJTDfndECovv35me0e2JZliFzaPIxdzvmL813Cn4Pq/h3h8nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fCRtEAwt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MPo2gEeY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fCRtEAwt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MPo2gEeY"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2K4cs722206
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mBkciKky5zjvb0Hg8dGSMjmVQWKMKuOxs8eQ0lWL6P8=; b=fCRtEAwtnONDGJpG
	ap5sT9C5CZyg1eJL0claRn41YeD6/NQSaZaNzTiSqkvT7cfTFaDSAerE2MAXmSj/
	KYIkN95sEmGtUnt+G6Y9BXle6zo99Jl+VQvAtURxV/4vC9kl/VsTyyD/RsItka6y
	LDqIUPGg2Y8SbNeczilvkSom4sF+2oG5kyz/So7e5SYvoC+OPn1YsnZC+9Zu+2m0
	DENr7PYFBNMLSj0h5TdwP+N/Ak3bovYWvsL2bptI5WPiMexAkd7j1Ik9gTwE3c+Q
	3UDttF1j9CdhFMdEiLV0O9k0LJFMaai4vwIfsa3vdBtotJCzfQLtmbe8ZNP5qutR
	VTNy6g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvmrr9bxv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:42:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso2044798eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 19:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790217733; x=1790822533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBkciKky5zjvb0Hg8dGSMjmVQWKMKuOxs8eQ0lWL6P8=;
        b=MPo2gEeYb4ndlgJZJh1t6s7wSfyurbjltbnHXtTo89NC0FUIoOF0FvGCUZoD6CZHXl
         Tr6bqAM7Myvh/+pVtiBBvwV4SgzeFCOq36yHE0bLoQMEisQrHu3pb7mfVvPn40Sq5BhL
         fZjgkOSnBOxJYA2+6yywyqQ8cP/HpoWtmCLlIwKEyAgoWtllkrHJRQbKUtLWWr2Zbtts
         XOC/frWvFT9RDpOR2SRfNThF+eqV3Ut8WtMv2lky04pZI4IrfewKkHjptsI56IZM3wTI
         DQ3RWTpCh48b0Im1J5v5iixJCj/uHvOI/9PAF2rSvLauljNVEQxf1FQ2Rx63rAhaBS0N
         jHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790217733; x=1790822533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mBkciKky5zjvb0Hg8dGSMjmVQWKMKuOxs8eQ0lWL6P8=;
        b=PTtHewuh7U9OT3Aj/XT2HkAxDHPa6ciTa1R2BQlG60cV5FgTMyb/0zLScLHN8JBdSV
         CbtuJZhPKL8nJCtaZiaZRXpzss3clOgdNP8LJiUh9iQ9dzDqMhoZyjgUd2l3qelPZJfd
         egb+rhRzh8hM44mRy1m2Ylwjq0vEPAotDFXC0O4GaMFF9MmOtW83/c4B3wHYw8i3in/9
         FSltYj8O3HWOg7uanbzHDzgfd2q5mv6k4CMxJwSWnRN7HCbZe1cGf3NshJWyGyqHsWLZ
         RlGcSjp4cdfLOc2FdBa1duyOJMag13R3s8i1hFTFs16UgsC5y4UbFCcPffmXH5nfe7ar
         eqgg==
X-Forwarded-Encrypted: i=1; AKwUvBwd30KvXMMG29zrZjgEjH5NN0DJMR8VHzG1zeo4z/keVKeeXj5vdj+6rnTIn/aePwqy+BHvfebR++Pqxj/A5mo=@vger.kernel.org
X-Gm-Message-State: AFuF++kYT9XC3SaTPysIz82EAoPk8An8f/gQbfkgrwWZIycGi3SJv3N3
	ODfFQYWbE0Djybq0IfFSqQ38K4ZI0/XcPrvCnntd7JrTz1uWCgdKuWkN09FM7GCSa26nQMixrEZ
	0E/I+KAQnWS5A2YUB/QIIfXLRkZDqsvOGzfY97ZIUzcJU9BqLXOiYKOuitPqDsdQqoln96Q==
X-Gm-Gg: AYBFou1MZ7JEegKPSP3L4XpslCKvGBwqoNaM6N0ZYRDr4iJaoBg/QRdE4giER2tlYnU
	gIBfnmdZJCG6wIYuh8z5bA3sBaiSf1jbQqeN4WZ9os6d0Nw+Mn8jCkUI4E86zp6BovWi2q/OiP5
	WEsIg2T6RFRDYHRNICQL9qLsSx3lf2OwH61zC+aANRS+LNeZhsng0UDSyR0JrRkVgNH4S0VSadC
	9LXs7cyUcqkuMpuoJTztfwFAnUvnI8ZTkE1zm/WVGb8YrBiZHjY/VVjZDRV6k4OlaSsv+40/dIx
	WuaLIto16F5VMjSYMjORIUhknjB582VO4z88iXrjX758/jFcP32kKWK+BFcimrPmrRu78mPjYa9
	1RwEjjLNvbkX654oCs3wY8AThwVnVjb6o9y27vanFSWD1r422XMk1Apt98q1c4MwXjV0CV3k8EH
	LcrPz2KhHSr44sVaIx2HkSeQ==
X-Received: by 2002:a05:7301:77ca:b0:33c:e93:764d with SMTP id 5a478bee46e88-3400151e050mr795423eec.39.1790217732672;
        Wed, 23 Sep 2026 19:42:12 -0700 (PDT)
X-Received: by 2002:a05:7301:77ca:b0:33c:e93:764d with SMTP id 5a478bee46e88-3400151e050mr795395eec.39.1790217732013;
        Wed, 23 Sep 2026 19:42:12 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm9692263eec.12.2026.09.23.19.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 19:42:11 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 08:10:50 +0530
Subject: [PATCH wireless-next v2 13/16] wifi: nl80211/cfg80211: Add support
 for SMD context programming
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-smd-v2-13-bb40094da1d4@oss.qualcomm.com>
References: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
In-Reply-To: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, pooventhiran.g@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX0mEquA5+wWEg
 fa8BAoQMN2xKYfFcTNqwCjhBwkPb/7OGH7EmLH//+pjMreUn+p/Z8Zc/6r8j4jF37l0kSYV+0GN
 KWcjwC66N/NDwVicDWg5ZunvO58GMIzIhyKGjn7JW+qCFR6jvidDsnTPoVYXK1HuObtP7ZaPjn3
 9lXKgXr7aNSP4oTbIR0QaB3uL96GFA0iMK6AxWmNlKA5JODXSDVkDCK7X7S9M+74eFCnurD4RUb
 HIJUGTx77N+QQdcV2zgWpMrMLepQON3zmrcpnb4IQhzOzEslP1jPdD1f8dcnFlSvFGM2eqNshVz
 o+nYhTnf9Kz7u3Q8J3LJWZOu6cv08WHQzxbthfe59F0ety41UNVJI4w1/Ckbb4JItUWn9vvrVD2
 Qkx9i3cc7q0Zxi/EJ2bNEMv9fpz5s4ULTUJM3LHCHa+xjO/nrOEn8DtGz53s3LjDRO9+f65QJ5v
 kvXwZr8PA6bRcJNFgdA==
X-Authority-Analysis: v=2.4 cv=TYwDJhQh c=1 sm=1 tr=0 ts=6ab48e05 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=4KCYKawKnagZyZotmBEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX6CRHWkyPqINr
 47xl/RuAYzoFu64rXOF9EoWGNb3D7feji4rUyKuTCGeHpsVzEFW8A76AohZiUo1tBVVyHfgcLqB
 KYHzBAPwDcUtzdPPqZmfe4iWZUan8QM=
X-Proofpoint-GUID: MJ45ZuCQvlwflOI9wgIQ7IgeycOGyqHy
X-Proofpoint-ORIG-GUID: MJ45ZuCQvlwflOI9wgIQ7IgeycOGyqHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240012

On the target AP MLD to which the STA will be transitioning, the dynamic
context collected and sent by the current AP MLD needs to be programmed
on the TX and RX queues to enable seamless transition and reception.

Such data include Sequence Number (SN), Packet Number (PN), BlockAck
sessions, and any driver-specific data.

Add nl80211 support to handle NL80211_CMD_SET_SMD_CTX, parse the SMD
context attributes, and invoke the cfg80211 operation on the target AP
MLD.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/net/cfg80211.h  |   7 +
 net/wireless/nl80211.c  | 330 ++++++++++++++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h |  14 ++
 net/wireless/trace.h    |  47 +++++++
 4 files changed, 398 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 02fe733f0204..ab003692f00e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5331,6 +5331,10 @@ struct cfg80211_smd_transition_info {
  *
  * @start_pd: Start the PD interface.
  * @stop_pd: Stop the PD interface.
+ *
+ * @set_smd_ctx: Set UHR SMD context data for the non-AP MLD. @st_info->ctx is
+ *	freed immediately after this call returns; drivers must copy
+ *	@st_info->ctx if asynchronous processing is required.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -5709,6 +5713,9 @@ struct cfg80211_ops {
 			    bool val);
 	int	(*start_pd)(struct wiphy *wiphy, struct wireless_dev *wdev);
 	void	(*stop_pd)(struct wiphy *wiphy, struct wireless_dev *wdev);
+	int	(*set_smd_ctx)(struct wiphy *wiphy, struct wireless_dev *wdev,
+			       const u8 *addr,
+			       struct cfg80211_smd_transition_info *st_info);
 };
 
 /*
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5dc9d654d6f6..550f65634480 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19842,6 +19842,293 @@ static int nl80211_put_smd_ctx(struct sk_buff *msg,
 	return -EINVAL;
 }
 
+static int
+nl80211_parse_smd_ctx_ba_params(struct nlattr *tb,
+				struct ieee80211_smd_ctx_ba *ba_tids,
+				unsigned long *valid_ctx_bmap)
+{
+	struct nlattr *ba_tb[NL80211_SMD_CTX_BA_ATTR_MAX + 1];
+	struct ieee80211_smd_ctx_ba *ba;
+	struct nlattr *ba_attr;
+	int n_tids = 0;
+	int rem, tid;
+
+	if (!tb)
+		return 0;
+
+	nla_for_each_nested(ba_attr, tb, rem) {
+		tid = nla_type(ba_attr) - 1;
+		if (tid < 0 || tid >= IEEE80211_SMD_CTX_NUM_TIDS)
+			return -EINVAL;
+
+		if (nla_parse_nested(ba_tb, NL80211_SMD_CTX_BA_ATTR_MAX,
+				     ba_attr, nl80211_smd_ctx_ba_policy,
+				     NULL))
+			return -EINVAL;
+
+		ba = &ba_tids[tid];
+
+		if (ba_tb[NL80211_SMD_CTX_BA_ATTR_BUFF_SIZE])
+			ba->buffer_size =
+				nla_get_u16(ba_tb[NL80211_SMD_CTX_BA_ATTR_BUFF_SIZE]);
+
+		if (ba_tb[NL80211_SMD_CTX_BA_ATTR_POLICY])
+			ba->ba_policy =
+				nla_get_u8(ba_tb[NL80211_SMD_CTX_BA_ATTR_POLICY]);
+
+		ba->amsdu_supported =
+			!!ba_tb[NL80211_SMD_CTX_BA_ATTR_AMSDU_SUPPORT];
+
+		if (ba_tb[NL80211_SMD_CTX_BA_ATTR_TIMEOUT])
+			ba->timeout =
+				nla_get_u16(ba_tb[NL80211_SMD_CTX_BA_ATTR_TIMEOUT]);
+
+		ba->ext_no_frag = !!ba_tb[NL80211_SMD_CTX_BA_ATTR_EXT_NO_FRAG];
+
+		if (ba_tb[NL80211_SMD_CTX_BA_ATTR_EXT_FRAG_LEVEL])
+			ba->extfrag_level =
+				nla_get_u8(ba_tb[NL80211_SMD_CTX_BA_ATTR_EXT_FRAG_LEVEL]);
+
+		if (ba_tb[NL80211_SMD_CTX_BA_ATTR_EXT_BUFF_SIZE])
+			ba->ext_buffer_size =
+				nla_get_u16(ba_tb[NL80211_SMD_CTX_BA_ATTR_EXT_BUFF_SIZE]);
+
+		n_tids++;
+	}
+
+	if (!n_tids)
+		return -EINVAL;
+
+	set_bit(IEEE80211_SMD_CTX_VALID_BA_PARAMS, valid_ctx_bmap);
+
+	return 0;
+}
+
+static int nl80211_parse_smd_ctx(struct genl_info *info,
+				 struct cfg80211_smd_transition_info *st_info)
+{
+	struct nlattr *dl_tb[NL80211_SMD_CTX_DL_ATTR_MAX + 1];
+	struct nlattr *ul_tb[NL80211_SMD_CTX_UL_ATTR_MAX + 1];
+	struct nlattr *tb[NL80211_SMD_CTX_ATTR_MAX + 1];
+	struct ieee80211_smd_ctx *ctx;
+	struct nlattr *bmap_attr;
+	size_t drv_ctx_size = 0;
+
+	st_info->type = nla_get_u8(info->attrs[NL80211_ATTR_SMD_CTX_TYPE]);
+
+	if (nla_parse_nested(tb, NL80211_SMD_CTX_ATTR_MAX,
+			     info->attrs[NL80211_ATTR_SMD_CTX],
+			     nl80211_smd_ctx_policy, NULL)) {
+		GENL_SET_ERR_MSG(info, "failed to parse SMD context");
+		return -EINVAL;
+	}
+
+	if (tb[NL80211_SMD_CTX_ATTR_DRV_DATA])
+		drv_ctx_size = nla_len(tb[NL80211_SMD_CTX_ATTR_DRV_DATA]);
+
+	ctx = kzalloc(sizeof(*ctx) + drv_ctx_size, GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	st_info->ctx = ctx;
+
+	/* DL Context */
+	if (tb[NL80211_SMD_CTX_ATTR_DL]) {
+		struct nlattr *ba_attr;
+
+		if (nla_parse_nested(dl_tb, NL80211_SMD_CTX_DL_ATTR_MAX,
+				     tb[NL80211_SMD_CTX_ATTR_DL],
+				     nl80211_smd_ctx_dl_policy, NULL)) {
+			GENL_SET_ERR_MSG(info, "failed to parse DL context");
+			goto err_free_ctx;
+		}
+
+		bmap_attr = dl_tb[NL80211_SMD_CTX_DL_ATTR_VALID_TID_BITMAP];
+		if (bmap_attr)
+			bitmap_write(ctx->dl.valid_tid_bmap,
+				     nla_get_u8(bmap_attr),
+				     0, IEEE80211_SMD_CTX_NUM_TIDS);
+
+		if (dl_tb[NL80211_SMD_CTX_DL_ATTR_SN]) {
+			struct nlattr *sn_attr;
+			int n_tids = 0;
+			int rem, tid;
+
+			nla_for_each_nested(sn_attr,
+					    dl_tb[NL80211_SMD_CTX_DL_ATTR_SN],
+					    rem) {
+				tid = nla_type(sn_attr) - 1;
+				if (tid < 0 ||
+				    tid >= IEEE80211_SMD_CTX_NUM_TIDS) {
+					GENL_SET_ERR_MSG(info,
+							 "invalid DL SN tid");
+					goto err_free_ctx;
+				}
+
+				if (nla_len(sn_attr) != sizeof(u16)) {
+					GENL_SET_ERR_MSG(info,
+							 "invalid DL SN len");
+					goto err_free_ctx;
+				}
+
+				ctx->dl.sn[tid] = nla_get_u16(sn_attr);
+				n_tids++;
+			}
+
+			if (!n_tids) {
+				GENL_SET_ERR_MSG(info, "empty DL SN nesting");
+				goto err_free_ctx;
+			}
+
+			set_bit(IEEE80211_SMD_CTX_VALID_DL_SN,
+				ctx->valid_ctx_bmap);
+		}
+
+		if (dl_tb[NL80211_SMD_CTX_DL_ATTR_PN]) {
+			const u8 *pn_data =
+				nla_data(dl_tb[NL80211_SMD_CTX_DL_ATTR_PN]);
+
+			ctx->pn_len =
+				nla_len(dl_tb[NL80211_SMD_CTX_DL_ATTR_PN]);
+
+			memcpy(ctx->dl.pn, pn_data, ctx->pn_len);
+			set_bit(IEEE80211_SMD_CTX_VALID_PN,
+				ctx->valid_ctx_bmap);
+		}
+
+		ba_attr = dl_tb[NL80211_SMD_CTX_DL_ATTR_BA_PARAMS];
+		if (ba_attr &&
+		    nl80211_parse_smd_ctx_ba_params(ba_attr, ctx->dl.ba,
+						    ctx->valid_ctx_bmap)) {
+			GENL_SET_ERR_MSG(info,
+					 "failed to parse DL BlockAck params");
+			goto err_free_ctx;
+		}
+	}
+
+	/* UL Context */
+	if (tb[NL80211_SMD_CTX_ATTR_UL]) {
+		struct nlattr *ba_attr;
+
+		if (nla_parse_nested(ul_tb, NL80211_SMD_CTX_UL_ATTR_MAX,
+				     tb[NL80211_SMD_CTX_ATTR_UL],
+				     nl80211_smd_ctx_ul_policy, NULL)) {
+			GENL_SET_ERR_MSG(info, "failed to parse UL context");
+			goto err_free_ctx;
+		}
+
+		bmap_attr = ul_tb[NL80211_SMD_CTX_UL_ATTR_VALID_TID_BITMAP];
+		if (bmap_attr)
+			bitmap_write(ctx->ul.valid_tid_bmap,
+				     nla_get_u8(bmap_attr),
+				     0, IEEE80211_SMD_CTX_NUM_TIDS);
+
+		if (ul_tb[NL80211_SMD_CTX_UL_ATTR_SN]) {
+			struct nlattr *sn_attr;
+			int n_tids = 0;
+			int rem, tid;
+
+			nla_for_each_nested(sn_attr,
+					    ul_tb[NL80211_SMD_CTX_UL_ATTR_SN],
+					    rem) {
+				tid = nla_type(sn_attr) - 1;
+				if (tid < 0 ||
+				    tid >= IEEE80211_SMD_CTX_NUM_TIDS) {
+					GENL_SET_ERR_MSG(info,
+							 "invalid UL SN tid");
+					goto err_free_ctx;
+				}
+
+				if (nla_len(sn_attr) != sizeof(u16)) {
+					GENL_SET_ERR_MSG(info,
+							 "invalid UL SN len");
+					goto err_free_ctx;
+				}
+
+				ctx->ul.sn[tid] = nla_get_u16(sn_attr);
+				n_tids++;
+			}
+
+			if (!n_tids) {
+				GENL_SET_ERR_MSG(info, "empty UL SN nesting");
+				goto err_free_ctx;
+			}
+
+			set_bit(IEEE80211_SMD_CTX_VALID_UL_SN,
+				ctx->valid_ctx_bmap);
+		}
+
+		if (ul_tb[NL80211_SMD_CTX_UL_ATTR_PN]) {
+			struct nlattr *pn_attr;
+			int n_tids = 0;
+			int rem, tid;
+
+			nla_for_each_nested(pn_attr,
+					    ul_tb[NL80211_SMD_CTX_UL_ATTR_PN],
+					    rem) {
+				u8 pn_len;
+
+				tid = nla_type(pn_attr) - 1;
+				if (tid < 0 ||
+				    tid >= IEEE80211_SMD_CTX_NUM_TIDS) {
+					GENL_SET_ERR_MSG(info,
+							 "invalid UL PN tid");
+					goto err_free_ctx;
+				}
+
+				/*
+				 * PN length must be the same for all DL and
+				 * UL TIDs.
+				 */
+				pn_len = nla_len(pn_attr);
+				if (pn_len > IEEE80211_SMD_CTX_MAX_PN_LEN ||
+				    (ctx->pn_len && pn_len != ctx->pn_len)) {
+					GENL_SET_ERR_MSG(info,
+							 "invalid PN length");
+					goto err_free_ctx;
+				}
+				ctx->pn_len = pn_len;
+
+				memcpy(ctx->ul.pn[tid], nla_data(pn_attr),
+				       ctx->pn_len);
+				n_tids++;
+			}
+
+			if (!n_tids) {
+				GENL_SET_ERR_MSG(info, "empty UL PN nesting");
+				goto err_free_ctx;
+			}
+
+			set_bit(IEEE80211_SMD_CTX_VALID_PN,
+				ctx->valid_ctx_bmap);
+		}
+
+		ba_attr = ul_tb[NL80211_SMD_CTX_UL_ATTR_BA_PARAMS];
+		if (ba_attr &&
+		    nl80211_parse_smd_ctx_ba_params(ba_attr, ctx->ul.ba,
+						    ctx->valid_ctx_bmap)) {
+			GENL_SET_ERR_MSG(info,
+					 "failed to parse UL BlockAck params");
+			goto err_free_ctx;
+		}
+	}
+
+	/* Driver data */
+	if (tb[NL80211_SMD_CTX_ATTR_DRV_DATA]) {
+		ctx->drv_ctx_size = drv_ctx_size;
+		memcpy(ctx->drv_ctx,
+		       nla_data(tb[NL80211_SMD_CTX_ATTR_DRV_DATA]),
+		       drv_ctx_size);
+	}
+
+	return 0;
+
+err_free_ctx:
+	kfree(ctx);
+	st_info->ctx = NULL;
+	return -EINVAL;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -20183,6 +20470,42 @@ static int nl80211_set_sar_specs(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+static int nl80211_set_smd_ctx(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct cfg80211_smd_transition_info st_info = {};
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	const u8 *addr;
+	int err;
+
+	if (!rdev->ops->set_smd_ctx)
+		return -EOPNOTSUPP;
+
+	if (wdev->iftype != NL80211_IFTYPE_AP &&
+	    wdev->iftype != NL80211_IFTYPE_AP_VLAN)
+		return -EINVAL;
+
+	if (!info->attrs[NL80211_ATTR_MLD_ADDR] ||
+	    !info->attrs[NL80211_ATTR_SMD_CTX] ||
+	    !info->attrs[NL80211_ATTR_SMD_CTX_TYPE]) {
+		GENL_SET_ERR_MSG(info, "required attributes are missing");
+		return -EINVAL;
+	}
+
+	addr = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
+
+	err = nl80211_parse_smd_ctx(info, &st_info);
+	if (err)
+		return err;
+
+	/* drivers must copy @ctx for any deferred processing */
+	err = rdev_set_smd_ctx(rdev, wdev, addr, &st_info);
+
+	kfree(st_info.ctx);
+	return err;
+}
+
 #define SELECTOR(__sel, name, value) \
 	((__sel) == (value)) ? NL80211_IFL_SEL_##name :
 int __missing_selector(void);
@@ -21084,6 +21407,13 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_SET_SMD_CTX,
+		.doit = nl80211_set_smd_ctx,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_CLEAR_SKB),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 46849fe8d0b3..d33a969606d7 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1636,4 +1636,18 @@ rdev_set_epcs(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int rdev_set_smd_ctx(struct cfg80211_registered_device *rdev,
+				   struct wireless_dev *wdev, const u8 *addr,
+				   struct cfg80211_smd_transition_info *st_info)
+{
+	int ret = -EOPNOTSUPP;
+
+	trace_rdev_set_smd_ctx(&rdev->wiphy, wdev, addr, st_info);
+	if (rdev->ops->set_smd_ctx)
+		ret = rdev->ops->set_smd_ctx(&rdev->wiphy, wdev, addr, st_info);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 8c2a91b85c39..6234ceb9ebb1 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4405,6 +4405,53 @@ TRACE_EVENT(cfg80211_nan_channel_evac,
 	TP_printk(WDEV_PR_FMT ", " WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
 		  WDEV_PR_ARG, WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
 );
+
+TRACE_EVENT(rdev_set_smd_ctx,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, const u8 *addr,
+		 struct cfg80211_smd_transition_info *st_info),
+
+	TP_ARGS(wiphy, wdev, addr, st_info),
+
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		MAC_ENTRY(sta_addr)
+		__field(u8, st_type)
+		__field(unsigned int, num_tids)
+		__dynamic_array(unsigned long, tx_tid_bitmap,
+				BITS_TO_LONGS(IEEE80211_SMD_CTX_NUM_TIDS))
+		__dynamic_array(unsigned long, rx_tid_bitmap,
+				BITS_TO_LONGS(IEEE80211_SMD_CTX_NUM_TIDS))
+	),
+
+	TP_fast_assign(
+		struct ieee80211_smd_ctx *ctx = st_info->ctx;
+		unsigned long sz;
+
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		MAC_ASSIGN(sta_addr, addr);
+		__entry->st_type = st_info->type;
+
+		__entry->num_tids = IEEE80211_SMD_CTX_NUM_TIDS;
+		sz = BITS_TO_LONGS(__entry->num_tids) * sizeof(unsigned long);
+
+		memcpy(__get_dynamic_array(tx_tid_bitmap),
+		       ctx->dl.valid_tid_bmap, sz);
+		memcpy(__get_dynamic_array(rx_tid_bitmap),
+		       ctx->ul.valid_tid_bmap, sz);
+	),
+
+	TP_printk(WIPHY_PR_FMT  ", " WDEV_PR_FMT
+		  ", sta=%pM, ST type=%u DL TIDs: %*pb, UL TIDs: %*pb",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->sta_addr,
+		  __entry->st_type,
+		  __entry->num_tids,
+		  (unsigned long *)__get_dynamic_array(tx_tid_bitmap),
+		  __entry->num_tids,
+		  (unsigned long *)__get_dynamic_array(rx_tid_bitmap))
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH

-- 
2.34.1

