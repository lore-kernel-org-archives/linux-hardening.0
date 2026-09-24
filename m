Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD013D6478
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217720; cv=none; b=aZtonv0cfhMzz/thPx7Pc9H9mXvXCtIki+bUHK02HN0CiE75fD5duey2lS1CgM7E+NxVgdfBV/H6N/zCMaSW5xoJK3lkhSmJy8FlQAIe1+RIlPtT1D4X4702wxPJ3Vj1tz86dCfWt+0G40jsvMNhJoiARRFGqQ+A6daGU7ZL18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217720; c=relaxed/simple;
	bh=xGsLNyQlQoDV+Ub/zZp7BYFxqifILtCYTg9z7VysFrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkXx5u7j4B9+klD3GAdYwBmwz+3PJSR1JuhVCijP861b+7suX4GBqoxCeCqU50zuzkmrmCog3A4ii37R1VTDLKDxehKL2OVTJl/WwFvHem0mRVfMpyHQgNSUfvt/Fr7/a02DM63ZAhB3K+7UX14fFf++zz+xZ0u+Zm78ooVROEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZR/5+r0a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y4EMzOCK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZR/5+r0a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y4EMzOCK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2KH48159543
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R2A5S7dXBn8f2uUVD7ehSB6YipngkdXNcYQ7ZXaa4CA=; b=ZR/5+r0aoSNOdZ+I
	7vy/9oswEnWZTd70OnS8d74cYf4NdDzgpWRaxBOl2uwycxHj6Bmx2NY7Jwx5uedR
	uFSuJEaZ7ygeisnMAYMA8FTsr3G95C5+SN517w12Jhz8NirMOgCbCBt/DJ14qjvY
	7l8U6A8z0q6CfeOO0Fj2OZJQ+Uj6LQmq5m2XrmjwsurggG0r54zgoI3sSjJL9/xG
	L+r1jFvRAQexrbNs5cSXvU6sPWFj4YHqX/R14KhJjw8/UB7W7WIjoJpKJRcu4/db
	rodtwJCxXItBP/RoBEst4/tj+pxAbbMgqEjAzSgC5NDPkV473tTJhP2vByeIa8XZ
	y5rmXg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwjw0n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:41:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-334f782d1abso476669eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 19:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790217717; x=1790822517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2A5S7dXBn8f2uUVD7ehSB6YipngkdXNcYQ7ZXaa4CA=;
        b=Y4EMzOCKvyy4QyxDFJcg2KBWICQcrMQKxME3hvCcA3mkpgu/m2wafpb2vL5jwzFTk7
         L6afB3fY0hA3mrL1J9QSPiDxsV/ZwO0NWqBno8lR0fY3Zg3Rud7o7JrIAoO9w6m8UIAe
         StxAov33eA7YuMVq8JakQx8KmTGpR9bAvyVKpASxhlt43bhpSy1QsQBBflDJVOMdmzLy
         to5TMo+Zx8AiEcuYQ6GN7IoVfygtQazcRSP3vBhITahQZjlw+qbo61Y3Ctfqo968JMVT
         4YzWnbiucctpQsJ+Rb/d8mDcWJu+uOYjUE1OT7NNOzHeom9u4HULxH5XqyoMqWGGFsV7
         /dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790217717; x=1790822517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R2A5S7dXBn8f2uUVD7ehSB6YipngkdXNcYQ7ZXaa4CA=;
        b=KcXVJAHA/VzOnQEqzJkIRhZCrCqIUO6sNg6p+oC7PxfvlUF9DpD3hQ9akC9ualGn7Y
         Z8qb5nYBM85OBthPk9uP72biX5tqkU/74g7p+kvq/73ZKCnAPxYlWSbk5CX5fQH/3Pht
         8C9mq8aQpLcST3tow9FlZgzZdkFYcY/x2q0qre+k7qb2rDPiUFE73lkf09fOxPS301FL
         4VXOr+8DEkgczT57UG3WeH6PISucmTR0OEf1RQnOwE0zgalNffqLakITJmuSN/QpZZLX
         yJbLp05Hg3N/4+QwNHKpFlebUuqsDjDO4sEtYy4kPVKnhtd7Wm6ubz64IW00OXi92c0c
         clag==
X-Forwarded-Encrypted: i=1; AKwUvBy+ZZBnHXUZTbzm6b2wTESMazDoH9TPKGZQFKBbImrWA+Z3g4sE1UVZA2PS47b79fp0qyDeA6mffwANU9bjr44=@vger.kernel.org
X-Gm-Message-State: AFuF++mseWwCpBFt+3VPTP71nKcNRF0L8GU9MOcSxwcdGcQaaiXklaPB
	2bFblFktRi5LSs5+NRpISjtU62U+Vx/QPC0b1BmiDyGa9DpKMgJ0W8AbPLBaYwTZXnhql1hmdpn
	gBR9zgn17674cWVH5f++zAYjC/PkwyvzPLHX0v0qq3X8VPccmMOp4bXqARahrKA4fxiEVapVwf7
	Eugw==
X-Gm-Gg: AYBFou2gT1mVTI+K3s/+Gq5lWLH2XlOlnlJ9BY36s1PVRF1SkIheRq6AQFA03taNoTa
	+1gaCVtQRRho19O+XQ/R/Z/jZvSy7/gzCFOoEapeNRq3wYC5zYLGVdL9gfhkqqI+mlTJU29PRwr
	FK3ygR5zSSGOItJbywwtJ/DFlKOyfxOJLIhIHt24b5irbNsIsk5fUFytyBYd/AbRSGDgouFscDi
	1LccoY2y7JljF+Qx2nTcO3pB+ssBy548rxHH6MY+ct2Y1btG7QX4eKlZY/6jnVo4Ap4EAL/VukM
	doBsIqd+N2dFG2b5NytFZ7P8IPn9MNC9yX4a1LgnPFB377DxpuzZIKUHHv9+NwYkn8ia+ffM4Qy
	06HdW0cnV1Q+81Rr6N5+ZOqaf7g0WmIkvGaF29NYjw3bEJWiFrZWCCJwtVEzWMJuJt/G6ExiHAi
	W23QXbpYm4mrSrDA5APM96Eg==
X-Received: by 2002:a05:7300:ec0a:b0:33c:14c9:c79d with SMTP id 5a478bee46e88-34004b8b5bamr1063037eec.9.1790217716883;
        Wed, 23 Sep 2026 19:41:56 -0700 (PDT)
X-Received: by 2002:a05:7300:ec0a:b0:33c:14c9:c79d with SMTP id 5a478bee46e88-34004b8b5bamr1063017eec.9.1790217716275;
        Wed, 23 Sep 2026 19:41:56 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm9692263eec.12.2026.09.23.19.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 19:41:55 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 08:10:45 +0530
Subject: [PATCH wireless-next v2 08/16] wifi: mac80211: Send BlockAck
 policy in AMPDU action
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-smd-v2-8-bb40094da1d4@oss.qualcomm.com>
References: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
In-Reply-To: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, pooventhiran.g@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX/ORMnIPpDptc
 zUKJpBUkmKMwZoLNG+TmR8pqTiDlKHHyMqSYdcFP8lliPhoqTl08thUjx/JodzHhgWcs5t1Ni1B
 e9dvTvYoChFpYsYYL19vzG6fXmdjfQ1Y5LYBdWor+2o2s+Sp3/xsC/YrkprtxQGcYo2FRA+0bLl
 JKi/IYdqNwFcAhRZ3uNBTIKmsuR988PWi2Zs9jrYxwvg3AsmH2g2XAenc5zsVn5lAxmEIqVJo3R
 KtVQj2yTeEg1dY/3kr/OevCIWq7HqQKAmVR/mDuzM9z7jPcpPhLvfg4H+x0bRsIp1Qu3Ezl24HB
 Yx32vDCMHMtP3QjeNJ1Zaclv7GPMkvkynCqnd65f12wcvMEGtlsv9cAyPp6vMyAsURBw5i8TDY7
 /fT2bUAe47tx7ffovtTYmCn0yCClKwZYs1VDZTZdkTI6evgNUniv9ax1bw+1zl3DsGF2JnaIEV6
 irpRZKJKcccdOJt/3Sw==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab48df5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=nliDdBWBufQ-nTcFh1oA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX/sBqB89F03Zi
 n0TQqO94csQ25ttwQqpxOCHTjSMDPntqmHhQu7HzHIH24JriZ5YMNGQTjlOCaR2SQhccVUYyt3z
 PCULa0kj5aTtzqkxybdepx/JCroOhxM=
X-Proofpoint-ORIG-GUID: LAv9LFB7Y--AH9g5k9-CxNy18aoVk3IT
X-Proofpoint-GUID: LAv9LFB7Y--AH9g5k9-CxNy18aoVk3IT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240012

While sending AMPDU action hints to drivers, mac80211 does not include
the BlockAck policy extracted from ADDBA frames. Drivers may require the
complete set of BlockAck negotiation parameters for certain use cases,
such as SMD BSS Transition, where the complete BlockAck context needs to
be transported as part of the transition.

Include the BlockAck policy as well in AMPDU action so that drivers have
the required information about the negotiation. Since the policy is
extracted from the received ADDBA Request, it is valid only for
IEEE80211_AMPDU_RX_START.

Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/net/mac80211.h | 15 +++++++++++++++
 net/mac80211/agg-rx.c  |  1 +
 net/mac80211/trace.h   |  8 +++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 03b75eead766..7bfa421535ca 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3963,6 +3963,19 @@ enum ieee80211_ampdu_mlme_action {
 #define IEEE80211_AMPDU_TX_START_IMMEDIATE 1
 #define IEEE80211_AMPDU_TX_START_DELAY_ADDBA 2
 
+/**
+ * enum ieee80211_ba_policy - BlockAck Policy
+ *
+ * @IEEE80211_BLOCKACK_DELAYED: Block ACK sent to the BAR sender in next TXOP
+ * @IEEE80211_BLOCKACK_IMMEDIATE: Block ACK sent to the BAR sender immediately
+ *
+ * This field is valid only for %IEEE80211_AMPDU_RX_START.
+ */
+enum ieee80211_ba_policy {
+	IEEE80211_BLOCKACK_DELAYED,
+	IEEE80211_BLOCKACK_IMMEDIATE,
+};
+
 /**
  * struct ieee80211_ampdu_params - AMPDU action parameters
  *
@@ -3975,6 +3988,7 @@ enum ieee80211_ampdu_mlme_action {
  * @buf_size: reorder buffer size  (number of subframes). Valid only when the
  *	action is set to %IEEE80211_AMPDU_RX_START or
  *	%IEEE80211_AMPDU_TX_OPERATIONAL
+ * @policy: BlockAck policy of type &enum ieee80211_ba_policy
  * @amsdu: indicates the peer's ability to receive A-MSDU within A-MPDU.
  *	valid when the action is set to %IEEE80211_AMPDU_TX_OPERATIONAL
  * @timeout: BA session timeout. Valid only when the action is set to
@@ -3986,6 +4000,7 @@ struct ieee80211_ampdu_params {
 	u16 tid;
 	u16 ssn;
 	u16 buf_size;
+	enum ieee80211_ba_policy policy;
 	bool amsdu;
 	u16 timeout;
 };
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 9629e00069a1..2d67fd883146 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -289,6 +289,7 @@ void __ieee80211_start_rx_ba_session(struct sta_info *sta,
 		.amsdu = false,
 		.timeout = timeout,
 		.ssn = start_seq_num,
+		.policy = ba_policy,
 	};
 	int i, ret = -EOPNOTSUPP;
 	u16 status = WLAN_STATUS_REQUEST_DECLINED;
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 294a8a44a125..63838a6d5d07 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -116,6 +116,7 @@
 				__field(u16, ssn)					\
 				__field(u16, buf_size)					\
 				__field(bool, amsdu)					\
+				__field(u8, policy)					\
 				__field(u16, timeout)					\
 				__field(u16, action)
 #define AMPDU_ACTION_ASSIGN	STA_NAMED_ASSIGN(params->sta);				\
@@ -123,12 +124,13 @@
 				__entry->ssn = params->ssn;				\
 				__entry->buf_size = params->buf_size;			\
 				__entry->amsdu = params->amsdu;				\
+				__entry->policy = params->policy;			\
 				__entry->timeout = params->timeout;			\
 				__entry->action = params->action;
-#define AMPDU_ACTION_PR_FMT	STA_PR_FMT " tid %d, ssn %d, buf_size %u, amsdu %d, timeout %d action %d"
+#define AMPDU_ACTION_PR_FMT	STA_PR_FMT " tid %d, ssn %d, buf_size %u, amsdu %d, policy=%u, timeout %d action %d"
 #define AMPDU_ACTION_PR_ARG	STA_PR_ARG, __entry->tid, __entry->ssn,			\
-				__entry->buf_size, __entry->amsdu, __entry->timeout,	\
-				__entry->action
+				__entry->buf_size, __entry->amsdu, __entry->policy,	\
+				__entry->timeout, __entry->action
 
 /*
  * Tracing for driver callbacks.

-- 
2.34.1

