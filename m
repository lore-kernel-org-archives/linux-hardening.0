Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F93B95F6
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294006; cv=none; b=rsPl8LfNEsS1T7YuFL+5ZSlreNvYcfGFx+4mCcRoLOvFEBUHVHh5Z8dDvJyTgSsllKHC/xzgX7GpAgpplLr75pAOfy59xHnYaEx9Vlj1qX6Odqp4K4uv8t5CMfIhnhd2HAt91pYfn6wmqBFgwA8Qb7iU/df4P2JYLZRmR9qT0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294006; c=relaxed/simple;
	bh=20WLnkiYWDQEOKwJiDNPOzP1Og78Nshg+iIm1A20VvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2GVDnKOqTYxTtjeboC67XFj4JuXeHoRLZQSJr0qLzcJJk0dpyCbPJ8rCGp0ECdj+SEpStDqSSi0k3JFObbpt1gs5mlgtwQayUznCAYH0E03cQ13CNMcdJ3kg+L8aaLO80/P1aRWDQLV2ko0vmtLQ+3B7NJ7GZd+qqi2RJAJ1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G6+nG4/S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vv1g8Tf6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G6+nG4/S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vv1g8Tf6"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RA3pGU3123642
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0rj2JamDaDnv/s7jI1Vm/rkzZOBtp55LTzg2o5dZC7s=; b=G6+nG4/SWFx3ErrK
	UsnkIxKAviaOcZrqkJhfVlmOmbHoQzjgInzE76+F9jqEJRA18gFD2uktvRJSUQ6C
	4N9Ql9YDNEKkztC1cCidMFzTvuSuhClbSb/nvjjimlVbmXhCpCkr0RKK5VLQGsfF
	j29a1QNebdiFh6bk8yZwvQZZ8axh3iM3XNoya32/60lLGvc4VMG+JhcEQRHWJL26
	Hlwlxb6cbPuvT2SHiR/odV23rSda1dvRxaY3x+2Xlf7mp59M8Gj0GuXPdDv64rva
	qd3+3TTDarwBXBKyGKV5CBtRSapgTvbeBUEDkTBIpMASK2Banbu5An6qfCIqY6Wb
	C0vtGQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qgghqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:43 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fcdd579e1so76122311cf.1
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777294003; x=1777898803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rj2JamDaDnv/s7jI1Vm/rkzZOBtp55LTzg2o5dZC7s=;
        b=Vv1g8Tf614rePhjf5rlkqimSv9sOhCtmKzRxPyctx9LuU46ck/2XmGQwGZhIsIs8Ds
         5MquywZMwhSHVml8L0rNJUYF7BW+ZNdrp9Su8Z17RZjqwGFSJGfRH6wABO6jFM8T/xve
         W9WVPHw6IvuAZQwCnJsT9IEKihbH0H3OrWNCWZ4M9ySOhBzS9te8q8Xded6AIiEQVVJb
         Yi4xnoWI0IUBWLrkCnbxn2eJcK4USgh3XCTDyclgK5yvEucf+uLwGNcVTu6Ub+RcW9fH
         fnCVijCTwr/1F8HezX/GgTPzRTuWLBFchP7Pjg20ZsiFscb+VmI0zpPjSinbLt6mndis
         P/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294003; x=1777898803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0rj2JamDaDnv/s7jI1Vm/rkzZOBtp55LTzg2o5dZC7s=;
        b=o52ktjSgium5YEH//ZE4YK6jki2DXWAskAdue3UGgtlnsVcdQXahN7OyeoYiMdIxiL
         /K9c6gZR/nMPAGuEouRzVb5BF3SNqiF5SFLRtdqo2sD55LMqlFn/DWLB5xbLe4DmqUM0
         VtpcIFvhG+w616vXmuZMFdQCz7vFK7lH4JJdKPxn7eWQxVbeXM/ouskOsFQf84+GM8cI
         LRlDuzS8lug08UGCHyANfrrp8hyMUc909KeuGmir/Qk2F10K96CWiq/a8Fyes8lgh7of
         KTPeAZN37QLjnaMqkSbWtAZFlBiKgMuCCEJm0derRRv0L1YaDYpXxl6HM8Actl540Kcw
         ovog==
X-Forwarded-Encrypted: i=1; AFNElJ9DmenDpIxwT+HG/8RGT0dS3QUASAYJYmsiujhoJmwNHn2ndK8MtzPKbzE1vEgaRjBrQUPA5fBya6dbL5sxw0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV3o2gq913dJFBrt8DdlhYpLQf3JoX/P0atryW0QkBJwpxsLCr
	I8Tk+Ko1dQhccde/tuiarwf2ByngyYcoS1dj+75M7rC0Ugxv+2i4JHdsiKp2A/DPnd8gzUgYS5/
	e59Sg7RH0btntRDNBRZoqoTTWJQ6NPYnQ3HXPXK+wkh6lXvHS3ntRP3Twb+B7EwKf4B6bEOE=
X-Gm-Gg: AeBDieuKmCvMf5MaGV+HbUIw098NQyblqpo7zMWDG8ZxdnP6+JbaQCYXbiyXbW2nqpJ
	iXOvvwdlVIH2NPPeTJN620tU555aJ+CRTuTizXNzJXCsoxcoWJDyLWw5cZNxkIO/aBE/cIUAXIW
	FIy0flivbn2SH7qR4kEs5aIDsGL3VixUFGxJtFF2/iTmPJ/6avPGyq2xSJaawwgwBS1NOCoOEZv
	Z4g2gZJu7aaVQ46Q0bAXlTnRjDp9456rTMnnP0SiYdz5oSaginWepxlVFSj952UsaFfZotI5eS1
	b7jEtGIWC18baFWdS1FeLbyvPYo/qX2bT650fE3VB4OP83DOGdQ/nqeHniIKvkZ9+C4JYVyljoQ
	0jFy6RpQz4wOMBMYKgZ+zYMozLB4CdAvG+IKoNXu7ymMhvkxPy7uRHkZzk87ozb7pX9jeW3RIXd
	ma3qYAXKtBggudLp6NVXXpQoQcjYE=
X-Received: by 2002:a05:622a:2615:b0:50d:8792:b6d1 with SMTP id d75a77b69052e-50e36c122efmr629758891cf.38.1777294002722;
        Mon, 27 Apr 2026 05:46:42 -0700 (PDT)
X-Received: by 2002:a05:622a:2615:b0:50d:8792:b6d1 with SMTP id d75a77b69052e-50e36c122efmr629758091cf.38.1777294002214;
        Mon, 27 Apr 2026 05:46:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:43:31 +0200
Subject: [PATCH v2 04/14] media: qcom: camss: Drop top_ahb/axi from QCM2290
 subdevice clocks
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-camss-isp-ope-v2-4-f430e7485009@oss.qualcomm.com>
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNSBTYWx0ZWRfXxJGyOXLwu/L+
 qGn2HOMDTHX7tmJIp7qacRPk5ZMLQxQIvJ7b5owxiBznxwoSPmIyeIATm3FeoRCk9eLIRm0aYW3
 OVUJenTZRE386pqGfn1ybm+aXIIVKB+RpRZ3c8nIiaEzAGexJuqq8u+t1f34qhmdBnmVz0vnpNk
 +o8EcSIWEPv+qiEmmI6jotwvejBspb/Ng8NMhB6uNzAdxqbFL7xRM2J1sO6CdckSp8oFH/BsY/g
 566IykCeDB3tM8tt/3zklompPiX5HU3C1OKHMGtmRRSQ4OUU+urBjMsAMkLXUj4+BC9peZNhzT6
 TzA2GWiqkuncKPjXdSMiV/bzu3VjuD8iYsSwB8x5/s4/QlNW1JKDxtZe4KBvTSlZpZY7yrO/ZJr
 g7p1NlYQBfrUoW+cALsufRn1UPtKAZhRu9B0CtW0KHyAiFqaLMAlqWM83dMoqqw1xwQyPc3HWzR
 gNLndC6zrvzCGDIxzVA==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69ef5ab3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=yFrQIQtVvbDJ7NVWecMA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: WkPsY0jJNG3FLnJu25pagnvAbuVWZG3A
X-Proofpoint-ORIG-GUID: WkPsY0jJNG3FLnJu25pagnvAbuVWZG3A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270135

Remove the top_ahb/axi clocks from QCM2290 subdevice clock lists.
These clocks are now handled centrally as a global CAMSS PM clock
and are automatically enabled when any CAMSS child is active.

This avoids redundant clock references in individual subdevices and
ensures consistent clock management across the CAMSS pipeline.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index b2b0afc3fb5f597622f9b4ebfee2ec6703bf0890..1fa42565c28a8cd461771821518875a8f468834c 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -664,9 +664,8 @@ static const struct camss_subdev_resources csiphy_res_2290[] = {
 	/* CSIPHY0 */
 	{
 		.regulators = { "vdd-csiphy-1p2", "vdd-csiphy-1p8" },
-		.clock = { "top_ahb", "ahb", "csiphy0", "csiphy0_timer" },
+		.clock = { "ahb", "csiphy0", "csiphy0_timer" },
 		.clock_rate = { { 0 },
-				{ 0 },
 				{ 240000000, 341330000, 384000000 },
 				{ 100000000, 200000000, 268800000 }  },
 		.reg = { "csiphy0" },
@@ -681,9 +680,8 @@ static const struct camss_subdev_resources csiphy_res_2290[] = {
 	/* CSIPHY1 */
 	{
 		.regulators = { "vdd-csiphy-1p2", "vdd-csiphy-1p8" },
-		.clock = { "top_ahb", "ahb", "csiphy1", "csiphy1_timer" },
+		.clock = { "ahb", "csiphy1", "csiphy1_timer" },
 		.clock_rate = { { 0 },
-				{ 0 },
 				{ 240000000, 341330000, 384000000 },
 				{ 100000000, 200000000, 268800000 }  },
 		.reg = { "csiphy1" },
@@ -700,9 +698,8 @@ static const struct camss_subdev_resources csid_res_2290[] = {
 	/* CSID0 */
 	{
 		.regulators = {},
-		.clock = { "top_ahb", "ahb", "csi0", "vfe0_cphy_rx", "vfe0" },
+		.clock = { "ahb", "csi0", "vfe0_cphy_rx", "vfe0" },
 		.clock_rate = { { 0 },
-				{ 0 },
 				{ 192000000, 240000000, 384000000, 426400000 },
 				{ 0 },
 				{ 0 } },
@@ -718,9 +715,8 @@ static const struct camss_subdev_resources csid_res_2290[] = {
 	/* CSID1 */
 	{
 		.regulators = {},
-		.clock = { "top_ahb", "ahb", "csi1", "vfe1_cphy_rx", "vfe1" },
-		.clock_rate = { { 0 },
-				{ 0 },
+		.clock = { "ahb", "csi1", "vfe1_cphy_rx", "vfe1" },
+		.clock_rate = {	{ 0 },
 				{ 192000000, 240000000, 384000000, 426400000 },
 				{ 0 },
 				{ 0 } },
@@ -738,10 +734,8 @@ static const struct camss_subdev_resources vfe_res_2290[] = {
 	/* VFE0 */
 	{
 		.regulators = {},
-		.clock = { "top_ahb", "ahb", "axi", "vfe0", "camnoc_rt_axi", "camnoc_nrt_axi" },
+		.clock = { "ahb", "vfe0", "camnoc_rt_axi", "camnoc_nrt_axi" },
 		.clock_rate = { { 0 },
-				{ 0 },
-				{ 0 },
 				{ 19200000, 153600000, 192000000, 256000000, 384000000, 460800000 },
 				{ 0 },
 				{ 0 }, },
@@ -758,10 +752,8 @@ static const struct camss_subdev_resources vfe_res_2290[] = {
 	/* VFE1 */
 	{
 		.regulators = {},
-		.clock = { "top_ahb", "ahb", "axi", "vfe1", "camnoc_rt_axi", "camnoc_nrt_axi" },
+		.clock = { "ahb", "vfe1", "camnoc_rt_axi", "camnoc_nrt_axi" },
 		.clock_rate = { { 0 },
-				{ 0 },
-				{ 0 },
 				{ 19200000, 153600000, 192000000, 256000000, 384000000, 460800000 },
 				{ 0 },
 				{ 0 }, },

-- 
2.34.1

