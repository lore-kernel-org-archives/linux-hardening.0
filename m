Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77653D954A
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790217727; cv=none; b=GmOp1c5TGu1xKSBEFDd/G41XJhAAQxVpy+wqV+Cwel/Qu5vg/XER/O9Qe4IVKlrIg6+lROiHCPtd5KTQ3BByu/QJGIe+xIG1zY3SUuZdw/tksDH/+DvNOlyZw+kY8XAG3xDkPggpK6E6xomvyWE+927lq4Swlai4kGFdiVSw030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790217727; c=relaxed/simple;
	bh=nLEiBqAYmNRnj3SiQa4tyaqBOk21t8wwuGJUP41TRSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHq+gFrtcekn42hokYkaBlrIXIp4uUHoifxYzKFWkW59zr9fYH4FJQRomEa4hg2tNYvvjinf/QpiaHf+yherkfAElIK+1FkxTqjyRydKzIA1WC2WGnRIfbZMzTKubvjGEPAXNg2rWYLYKZQWfceN916RecmJHXuMPlua0/5jXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jwsn0qm9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ih4g/8y8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwsn0qm9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ih4g/8y8"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2K3fI1000777
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pFSQ9jGZZpBjq/XoLPLbW42juICNQvaI4z1dRYyfMfI=; b=jwsn0qm9gO00XM3F
	kMYRTW5+aB7OiKlkMaYFEtEXIwK6RkPzBNVRYud1GN9mXhgfQtZ1q5uRUoWrJ/bJ
	SlRuTILgOsjt6UGd/J1jzF2+mcHU2siRDdd2RtEF3EC6+VGX3rikF+IT9KYjwrk4
	Z9A/CgfOo4xDxpHa5EapJeytOADvejPPN/O1HLHdh5TpA3jEevnFH78xhjxaEDMG
	0L9TKLiQL7XeYAxltARHX5H543OURNgTv6q0IwX6Lah2aP9jcwgYIcD3+8tEonUS
	kre5DuVKUCjhi0fqJcEorSb2JrGXvJ+Q8DavxYkwGpb6yGjLYumELZqj5JNhYpfn
	3v9VNw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwmbwnu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 02:42:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-334f782d1abso476935eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 19:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790217723; x=1790822523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pFSQ9jGZZpBjq/XoLPLbW42juICNQvaI4z1dRYyfMfI=;
        b=Ih4g/8y8ipUX2uP/mGaothDADi27tIVelW/Hol4FVPjT6udKsGjN2K0cKXmOYMObcW
         vRh7mV9tLqY9oSgecYN30MLR8rnOL/1Oz8ALW2OK/nm9ZWQ4s9U6M4Pgvrm0kgEOQ5U4
         LNBk4Rx7GGo8eBK5Ya98yRIjP3JOzxpYZzQkP/xWToprKOJwNkiFCKXuC2OuBFTxtT9j
         lU6Y4ryj4f638brIMdw9Qv59WRjCh5YaZsGchPQ+fT7aOXuT1E74KsXn0tHt9ptC9lv0
         A/vaNqjDACUsD1WSq4qeP1rTXnTtsQ++Kjay6avs+SwNRiRqGmHdgf8Dhy5wheVp9ZTV
         I1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790217723; x=1790822523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pFSQ9jGZZpBjq/XoLPLbW42juICNQvaI4z1dRYyfMfI=;
        b=GIoeQnihBp+tgymDArTk7t9B93UAO8n3bZ3csukrl9UuvM1vkBqEWf3yRZGlOaoYwI
         pBKVGj1wLNErSdPzOOUvDjYkZgv3gfGEQJcODgaU8odxt9tGa7AwGm8/kZ7rs6pVS99Z
         1PxclMCDaqnYi723GnXlaTQztfrYzugq7lgQMOnG1oBBoEzOrM1yxNuQIwRNEGTA+Eoi
         PzLzZwyY3YnnQK9PgjaZP5w6FMmkNUjjX+oHMe1NDrYMhex/tyN0FzZctlW1QfubV0kB
         7uPfme+CP05iuT1JRF0eN3Map7cyVrPaJw13vsx0GZQ0S5ymu4uSuWaVxh2zUGo6QeeN
         CX3Q==
X-Forwarded-Encrypted: i=1; AKwUvBz6Ov6Rx8Mj6uKxCxTesxEu1bg8mmYTfBTEhm47b+ZiCMnY2IFRHJoiBLxDKJGxqWt+cB3KZEom7Tnw8fyegdk=@vger.kernel.org
X-Gm-Message-State: AFuF++l0NbYtQptlyjdwoeEijfIZEXxBczp+AnCWBTEwiLbTX5y0vwi7
	C6gLcerZcQG3l9MgCrlqFN+P2FFuRus1OjJiijE+wQeWBjofma75L0h3hVIJH52mvuXkrP09oqZ
	c+DODPA5ik4/D7wsKu7yv3KkoNYPJ1BbZvl2ft9dqGVVBcMBdYh9qH58Qbg6EIRBJta2j7w==
X-Gm-Gg: AYBFou2vAiFAgeTHsid7U5y9DMzRvSdeT6TMNAjcrElibxB8DDl/90pIwVYjItgxtan
	5p5kwvzN4zO2fNKLgsRFJVNlB8c6LpmFGz2H3V/lBZt5++SIq4yl36Qz0KGReMdPehSCn7dGw9m
	bfgtNuUjPL+mKY5lViaIp7f79tMBSq3v50n0a9R1mteJS4ViiC5TG3DnW2LfAoD2Z1U04taptri
	QGFLoq/WC+0gkmY5Rqc15Ayb+C4jm7LnHAlRB2Uj35FByttKVxLHZHXPt96SAq1IuJFynm+uhNW
	6gh+SQzoPAmX9GrG3k2aUOLKElgBdxxQkkQaHeDbpIT/VIX8NpDbq9mwEMaW1aq4wZJM3QkrJXT
	/J5CBrgQbrlMnfFcPBGKqfO1bQkESAT+LG5IfILRRszTqs0SLt5+3Xe5Iyf0bLeUx0pDaWKBIjU
	5k0HhnwyDUvzHbuva1C7ilew==
X-Received: by 2002:a05:693c:41db:10b0:33c:1fc9:3c17 with SMTP id 5a478bee46e88-34006e8e408mr764482eec.36.1790217723216;
        Wed, 23 Sep 2026 19:42:03 -0700 (PDT)
X-Received: by 2002:a05:693c:41db:10b0:33c:1fc9:3c17 with SMTP id 5a478bee46e88-34006e8e408mr764464eec.36.1790217722601;
        Wed, 23 Sep 2026 19:42:02 -0700 (PDT)
Received: from hu-pooventh-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96258351sm9692263eec.12.2026.09.23.19.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 19:42:02 -0700 (PDT)
From: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 08:10:47 +0530
Subject: [PATCH wireless-next v2 10/16] wifi: nl80211: Define attributes to
 pack SMD BSS Transition context
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-smd-v2-10-bb40094da1d4@oss.qualcomm.com>
References: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
In-Reply-To: <20260924-smd-v2-0-bb40094da1d4@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, pooventhiran.g@oss.qualcomm.com
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfX2ENA7hW0gxGS
 Px9Nwjjj9NP4a9W0Owd5yM4rFSjTqYL5U6KekPUwKeCRRRY974GUZWgqUPprrRRwHlESTRtOA+G
 GQUUIkC5s6i8Tw8uZx/p/NwUYEpeFW4=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab48dfc cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dL9KhdaHfVATLDi8aJoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: AuY0ZyjrYFSwNiJrbo74pahxWhVUQf1H
X-Proofpoint-ORIG-GUID: AuY0ZyjrYFSwNiJrbo74pahxWhVUQf1H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAxMiBTYWx0ZWRfXydGr+OSsd9WS
 kJmPcxIIe5mbTSvw8d2Qynrz2ep11q2B9ugAPHKVhmRoerBjT2iikwxzyk7d+yRD5SPtMGYQQy9
 QHSbV4oT2n+HeRRFwqM4URmxZ/cY9EfsysPbNaUKyQL9qzKrzPxewnLKWGejGHmA/qhezqA9q5w
 IrXuSnv/KpUwcrU8lsFLtnpY90LOxHT/gJ4vE6CAC3QstHcVNExJpvAkW5QnKMufp2T0UYP5D0t
 2OIV3AbhaBig57g1lOnnAu+6tHdPb7/6QhiF0bCCESKHF0vpYB0eY9x7ZWe+bunf9WbR4+N1lKP
 qdq1ZuvVTygSG1Lba8Wnbvf/z/ZePBx7y+amcV/V+vae3BXvjCKxjAeudRAoaAaR2vOInk6GiNc
 2ZrHzS/VfCdtNy06LUGNvZKqTd7wHfpgq4cjj4qYEQ0pmKte+qM5MbPMASRE1U4f6u63p7L59CX
 cQ1XMI0LaEn05uMthyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240012

Define nl80211 attributes and policies required to pack SMD BSS Transition
context along with NL80211_CMD_FRAME to be sent to userspace, and to set
and get the context during roaming via current AP MLD and roaming via
target AP MLD. Without these, userspace will not be able to transport the
context to the target AP MLD, program the context on the target AP MLD TX
and RX queues, nor fetch the context on behalf of the target AP MLD if
the ST Execution frame is sent directly to the target.

Suggested-by: Jouni Malinen <jouni.malinen@oss.qualcomm.com>
Signed-off-by: Pooventhiran G <pooventhiran.g@oss.qualcomm.com>
---
 include/uapi/linux/nl80211.h | 163 +++++++++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       |  44 ++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index cd9a320143d7..8dd07751a336 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1427,6 +1427,18 @@
  * @NL80211_CMD_STOP_PD: Stop the PD operation, identified by
  *	its %NL80211_ATTR_WDEV interface.
  *
+ * @NL80211_CMD_SET_SMD_CTX: Set the SMD BSS Transition dynamic context for a
+ *	non-AP MLD sent from the current AP MLD on the target AP MLD managed by
+ *	an SMD-ME. This command carries %NL80211_ATTR_MLD_ADDR,
+ *	%NL80211_ATTR_SMD_CTX_TYPE and %NL80211_ATTR_SMD_CTX.
+ * @NL80211_CMD_GET_SMD_CTX: Get the SMD BSS Transition dynamic context for a
+ *	non-AP MLD associated to an AP MLD managed by an SMD-ME. This command
+ *	carries %NL80211_ATTR_MLD_ADDR and %NL80211_ATTR_SMD_CTX_TYPE.
+ * @NL80211_CMD_SMD_CTX_EVENT: Event reporting the collected SMD context
+ *	(requested via %NL80211_CMD_GET_SMD_CTX) to userspace. It carries
+ *	%NL80211_ATTR_MLD_ADDR, %NL80211_ATTR_SMD_CTX_TYPE, and
+ *	%NL80211_ATTR_SMD_CTX.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1705,6 +1717,10 @@ enum nl80211_commands {
 	NL80211_CMD_START_PD,
 	NL80211_CMD_STOP_PD,
 
+	NL80211_CMD_SET_SMD_CTX,
+	NL80211_CMD_GET_SMD_CTX,
+	NL80211_CMD_SMD_CTX_EVENT,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -3212,6 +3228,13 @@ enum nl80211_commands {
  *	IEEE P802.11bn/D2.0, Aug 2026, subclause 37.16.6).
  *	This flag is carried in %NL80211_CMD_NEW_STATION.
  *
+ * @NL80211_ATTR_SMD_CTX: Nested attribute associated with UHR SMD BSS
+ *	Transition data. Used with %NL80211_CMD_SET_SMD_CTX and
+ *	%NL80211_CMD_SMD_CTX_EVENT. See &enum nl80211_smd_ctx.
+ * @NL80211_ATTR_SMD_CTX_TYPE: u8 attribute specifying the type of SMD context.
+ *	Used along with %NL80211_CMD_SET_SMD_CTX, %NL80211_CMD_GET_SMD_CTX,
+ *	and %NL80211_CMD_SMD_CTX_EVENT.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3822,6 +3845,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SMD_ROAM_STA,
 
+	NL80211_ATTR_SMD_CTX,
+	NL80211_ATTR_SMD_CTX_TYPE,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -9259,4 +9285,141 @@ enum nl80211_smd_params_attrs {
 	NL80211_SMD_PARAMS_ATTR_MAX = __NL80211_SMD_PARAMS_ATTR_LAST - 1
 };
 
+/**
+ * enum nl80211_smd_ctx_type - SMD Request Type values
+ *
+ * Used with %NL80211_ATTR_SMD_CTX_TYPE.
+ *
+ * @NL80211_SMD_CTX_TYPE_PREP: SMD BSS Transition (ST) Preparation.
+ * @NL80211_SMD_CTX_TYPE_EXEC: ST Execution.
+ * @NUM_SMD_CTX_TYPES: internal.
+ * @NL80211_SMD_CTX_TYPE_MAX: Max type of ST context.
+ */
+enum nl80211_smd_ctx_type {
+	NL80211_SMD_CTX_TYPE_PREP,
+	NL80211_SMD_CTX_TYPE_EXEC,
+
+	NUM_SMD_CTX_TYPES,
+	NL80211_SMD_CTX_TYPE_MAX = NUM_SMD_CTX_TYPES - 1,
+};
+
+/**
+ * enum nl80211_smd_ctx_ba_param - SMD Block Ack Context attributes
+ *
+ * @__NL80211_SMD_CTX_BA_ATTR_INVALID: Invalid attribute.
+ * @NL80211_SMD_CTX_BA_ATTR_BUFF_SIZE: Required (u16) BA buffer size.
+ * @NL80211_SMD_CTX_BA_ATTR_POLICY: Required (u8) BA policy.
+ * @NL80211_SMD_CTX_BA_ATTR_AMSDU_SUPPORT: Flag attribute to indicate
+ *	AMSDU support.
+ * @NL80211_SMD_CTX_BA_ATTR_TIMEOUT: Required (u16) Block Ack timeout.
+ * @NL80211_SMD_CTX_BA_ATTR_EXT_NO_FRAG: Flag attribute to indicate
+ *	fragmentation support.
+ * @NL80211_SMD_CTX_BA_ATTR_EXT_FRAG_LEVEL: Required (u8) HE fragmentation
+ *	level.
+ * @NL80211_SMD_CTX_BA_ATTR_EXT_BUFF_SIZE: Required (u16) extended buffer size.
+ * @__NL80211_SMD_CTX_BA_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_CTX_BA_ATTR_MAX: Max attribute.
+ *
+ * Used with %NL80211_SMD_CTX_DL_ATTR_BA_PARAMS and
+ * %NL80211_SMD_CTX_UL_ATTR_BA_PARAMS.
+ */
+enum nl80211_smd_ctx_ba_param {
+	__NL80211_SMD_CTX_BA_ATTR_INVALID,
+	NL80211_SMD_CTX_BA_ATTR_BUFF_SIZE,
+	NL80211_SMD_CTX_BA_ATTR_POLICY,
+	NL80211_SMD_CTX_BA_ATTR_AMSDU_SUPPORT,
+	NL80211_SMD_CTX_BA_ATTR_TIMEOUT,
+	NL80211_SMD_CTX_BA_ATTR_EXT_NO_FRAG,
+	NL80211_SMD_CTX_BA_ATTR_EXT_FRAG_LEVEL,
+	NL80211_SMD_CTX_BA_ATTR_EXT_BUFF_SIZE,
+
+	__NL80211_SMD_CTX_BA_ATTR_LAST,
+	NL80211_SMD_CTX_BA_ATTR_MAX = __NL80211_SMD_CTX_BA_ATTR_LAST - 1
+};
+
+/**
+ * enum nl80211_smd_ctx_dl - SMD Dynamic Context - DL direction
+ *
+ * @__NL80211_SMD_CTX_DL_ATTR_INVALID: Invalid attribute.
+ * @NL80211_SMD_CTX_DL_ATTR_VALID_TID_BITMAP: Optional (u8) TIDs included.
+ * @NL80211_SMD_CTX_DL_ATTR_SN: Optional (nested) next SN (u16) per TID to
+ *	be assigned to DL individually addressed frames.
+ * @NL80211_SMD_CTX_DL_ATTR_PN: Optional (binary) starting PN (max 16 bytes) for
+ *	DL individually addressed frames.
+ * @NL80211_SMD_CTX_DL_ATTR_BA_PARAMS: Optional (nested) Block Ack parameters,
+ *	nested array of TIDs (uses &enum nl80211_smd_ctx_ba_param).
+ * @__NL80211_SMD_CTX_DL_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_CTX_DL_ATTR_MAX: Max attribute.
+ *
+ * Used with %NL80211_SMD_CTX_ATTR_DL.
+ */
+enum nl80211_smd_ctx_dl {
+	__NL80211_SMD_CTX_DL_ATTR_INVALID,
+	NL80211_SMD_CTX_DL_ATTR_VALID_TID_BITMAP,
+	NL80211_SMD_CTX_DL_ATTR_SN,
+	NL80211_SMD_CTX_DL_ATTR_PN,
+	NL80211_SMD_CTX_DL_ATTR_BA_PARAMS,
+
+	__NL80211_SMD_CTX_DL_ATTR_LAST,
+	NL80211_SMD_CTX_DL_ATTR_MAX = __NL80211_SMD_CTX_DL_ATTR_LAST - 1
+};
+
+/**
+ * enum nl80211_smd_ctx_ul - SMD Dynamic Context - UL direction
+ *
+ * @__NL80211_SMD_CTX_UL_ATTR_INVALID: Invalid attribute.
+ * @NL80211_SMD_CTX_UL_ATTR_VALID_TID_BITMAP: Optional (u8) TIDs included.
+ * @NL80211_SMD_CTX_UL_ATTR_SN: Optional (nested) last SN received per TID
+ *	for UL individually addressed frames.
+ * @NL80211_SMD_CTX_UL_ATTR_PN: Optional (nested) last PN received per TID
+ *	for UL individually addressed frames.
+ * @NL80211_SMD_CTX_UL_ATTR_BA_PARAMS: Optional (nested) Block Ack parameters
+ *	(uses &enum nl80211_smd_ctx_ba_param).
+ * @__NL80211_SMD_CTX_UL_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_CTX_UL_ATTR_MAX: Max attribute.
+ *
+ * Used with %NL80211_SMD_CTX_ATTR_UL.
+ */
+enum nl80211_smd_ctx_ul {
+	__NL80211_SMD_CTX_UL_ATTR_INVALID,
+	NL80211_SMD_CTX_UL_ATTR_VALID_TID_BITMAP,
+	NL80211_SMD_CTX_UL_ATTR_SN,
+	NL80211_SMD_CTX_UL_ATTR_PN,
+	NL80211_SMD_CTX_UL_ATTR_BA_PARAMS,
+
+	__NL80211_SMD_CTX_UL_ATTR_LAST,
+	NL80211_SMD_CTX_UL_ATTR_MAX = __NL80211_SMD_CTX_UL_ATTR_LAST - 1
+};
+
+/**
+ * enum nl80211_smd_ctx - SMD Context information
+ *
+ * Top-level container for SMD BSS Transition dynamic context.  Carried in
+ * %NL80211_ATTR_SMD_CTX with %NL80211_CMD_SET_SMD_CTX (target AP MLD) or
+ * with %NL80211_CMD_FRAME (current AP MLD reporting context to userspace)
+ * and %NL80211_CMD_SMD_CTX_EVENT (current AP MLD reporting the requested
+ * context on behalf of the target AP MLD).
+ *
+ * @__NL80211_SMD_CTX_ATTR_INVALID: Invalid attribute.
+ * @NL80211_SMD_CTX_ATTR_DL: Optional (nested) DL parameters.
+ *	See &enum nl80211_smd_ctx_dl.
+ * @NL80211_SMD_CTX_ATTR_UL: Optional (nested) UL parameters.
+ *	See &enum nl80211_smd_ctx_ul.
+ * @NL80211_SMD_CTX_ATTR_DRV_DATA: Optional (binary) driver-specific blob.
+ *	Passed through nl80211 as a blob; parsed only at the driver layer of
+ *	the current AP MLD and target AP MLD. First 3 bytes shall be driver OUI
+ *	for the driver to parse as required.
+ * @__NL80211_SMD_CTX_ATTR_LAST: Last attribute, used internally.
+ * @NL80211_SMD_CTX_ATTR_MAX: Max attribute.
+ */
+enum nl80211_smd_ctx {
+	__NL80211_SMD_CTX_ATTR_INVALID,
+	NL80211_SMD_CTX_ATTR_DL,
+	NL80211_SMD_CTX_ATTR_UL,
+	NL80211_SMD_CTX_ATTR_DRV_DATA,
+
+	__NL80211_SMD_CTX_ATTR_LAST,
+	NL80211_SMD_CTX_ATTR_MAX = __NL80211_SMD_CTX_ATTR_LAST - 1
+};
+
 #endif /* __LINUX_NL80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 26277b3352ae..3940e349f270 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -704,6 +704,47 @@ nl80211_smd_params_policy[NL80211_SMD_PARAMS_ATTR_MAX + 1] = {
 	[NL80211_SMD_PARAMS_ATTR_NEIGHBOR_PROBING] = { .type = NLA_FLAG },
 };
 
+static const struct nla_policy
+nl80211_smd_ctx_ba_policy[NL80211_SMD_CTX_BA_ATTR_MAX + 1] = {
+	[NL80211_SMD_CTX_BA_ATTR_BUFF_SIZE] = { .type = NLA_U16 },
+	[NL80211_SMD_CTX_BA_ATTR_POLICY] = { .type = NLA_U8 },
+	[NL80211_SMD_CTX_BA_ATTR_AMSDU_SUPPORT] = { .type = NLA_FLAG },
+	[NL80211_SMD_CTX_BA_ATTR_TIMEOUT] = { .type = NLA_U16 },
+	[NL80211_SMD_CTX_BA_ATTR_EXT_NO_FRAG] = { .type = NLA_FLAG },
+	[NL80211_SMD_CTX_BA_ATTR_EXT_FRAG_LEVEL] = { .type = NLA_U8 },
+	[NL80211_SMD_CTX_BA_ATTR_EXT_BUFF_SIZE] = { .type = NLA_U16 },
+};
+
+static const struct nla_policy
+nl80211_smd_ctx_dl_policy[NL80211_SMD_CTX_DL_ATTR_MAX + 1] = {
+	[NL80211_SMD_CTX_DL_ATTR_VALID_TID_BITMAP] = { .type = NLA_U8 },
+	[NL80211_SMD_CTX_DL_ATTR_SN] = { .type = NLA_NESTED },
+	[NL80211_SMD_CTX_DL_ATTR_PN] = { .type = NLA_BINARY,
+					 .len = IEEE80211_SMD_CTX_MAX_PN_LEN },
+	[NL80211_SMD_CTX_DL_ATTR_BA_PARAMS] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_smd_ctx_ba_policy),
+};
+
+static const struct nla_policy
+nl80211_smd_ctx_ul_policy[NL80211_SMD_CTX_UL_ATTR_MAX + 1] = {
+	[NL80211_SMD_CTX_UL_ATTR_VALID_TID_BITMAP] = { .type = NLA_U8 },
+	[NL80211_SMD_CTX_UL_ATTR_SN] = { .type = NLA_NESTED },
+	[NL80211_SMD_CTX_UL_ATTR_PN] = { .type = NLA_NESTED },
+	[NL80211_SMD_CTX_UL_ATTR_BA_PARAMS] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_smd_ctx_ba_policy),
+};
+
+static const struct nla_policy
+nl80211_smd_ctx_policy[NL80211_SMD_CTX_ATTR_MAX + 1] = {
+	[NL80211_SMD_CTX_ATTR_DL] =
+		NLA_POLICY_NESTED(nl80211_smd_ctx_dl_policy),
+	[NL80211_SMD_CTX_ATTR_UL] =
+		NLA_POLICY_NESTED(nl80211_smd_ctx_ul_policy),
+	[NL80211_SMD_CTX_ATTR_DRV_DATA] =
+		NLA_POLICY_RANGE(NLA_BINARY,
+				 3, IEEE80211_MAX_DATA_LEN),
+};
+
 static const struct netlink_range_validation nl80211_punct_bitmap_range = {
 	.min = 0,
 	.max = 0xffff,
@@ -1119,6 +1160,9 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_PEER_SMD_MAC_ADDR] = NLA_POLICY_ETH_ADDR,
 	[NL80211_ATTR_PEER_SMD_DL_DATA_FORWARDING] = { .type = NLA_FLAG },
 	[NL80211_ATTR_SMD_ROAM_STA] = { .type = NLA_FLAG },
+	[NL80211_ATTR_SMD_CTX] = NLA_POLICY_NESTED(nl80211_smd_ctx_policy),
+	[NL80211_ATTR_SMD_CTX_TYPE] =
+		NLA_POLICY_MAX(NLA_U8, NL80211_SMD_CTX_TYPE_MAX),
 };
 
 /* policy for the key attributes */

-- 
2.34.1

