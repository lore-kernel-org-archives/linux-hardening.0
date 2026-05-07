Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8313D1CD4
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194216; cv=none; b=NIPuyWdlG9ucShA0MY7+mYrKpXs6akPPwjA3VqwwLfD5z1fMWKxAe5WSrVTeGLktJ+FSwHQSSbk5n0NfviovpBslp8m1BOliU4ytOizT8NfScVrSb5d5IvexPwC2kyfxj7GqspN1QkJdRsWBwjUmMoqOzjxGKSBH5Hy5RHLeo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194216; c=relaxed/simple;
	bh=d6sTldzr20rxqyeexiCHog1RigxMQcbtDegyP5w3YpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9OWlUhXdNYttNtCZA+QZBde3nw8OnVnU1oMbHUkRW1sjnbMVPhQ17A8PrdFv9UFYiUxKe8+ZNurcz9yW6UbazDlTTscknwBAizxtr37bnE/ihhf3Rva5qWGxW5faRc7ic1tryPEfi3D2TUj5Ncwfzazdbr58mv9banAWVFzNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mi5j+ZlJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ArQpPrT2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mi5j+ZlJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ArQpPrT2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647KUQOZ1424459
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dQvxefKofl/MWew8drQPijHpKnkbQHmoKvevMGmHYPQ=; b=mi5j+ZlJdbfKBhd1
	Y6dLOtI2uozcHYMzVfe/0bwdeUBpGEvTuBh1uFUtEEdXlr0kkxbSjrZ0MbxG/Wc/
	2WiCDHULMGVuZe9n6J+HPk+eD1WZ4ycoo3v5d/bGEpJAmQbITKQb4hfRUYsrvfWA
	WYSkjH+OMJNTAfz/V5sjF1flMIS66yv1a06AWW5tTeimaa7FbUZxhubAmwWBbisq
	BEC8Xhipbp2t50SYtGzCtcJ/JgzuG8mF5ZFoPcW+2KPBYcJqaRl9zAhKnz5hUk3P
	Bq64Mit6uPyOUgzklRt6mkfNf6O7U+jDAzXrzMIStmfqAH+79bnQKQsd5g+D6Zz2
	UPJlZQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfub87-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:14 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95d434f3356so1327687241.0
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194214; x=1778799014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQvxefKofl/MWew8drQPijHpKnkbQHmoKvevMGmHYPQ=;
        b=ArQpPrT2oMGZeCYJKXVyrIkUPhB6yI7Qm/Sze8dFw7bFuc/7albtp+Sj2JtJgjVhSJ
         FKTdh/ouj9RcIL/x95DsDVTNgRW6H+NO11ZVGfHwNC5NEheAqxxico7ws9SsL7/OzJAW
         xglhmxEgxuq2xu3WwhSOJk5BEEM9OV96yxQQ3nAKRBUNWpNgccWTjnVPsAwhQ02HKgjV
         P/koEXgJ28DdCVQYBUkUHl/sQuBGbnTfB1I8NDXOXjqNqDbz0RqlHqkKG4L6PsVoYoWP
         V1Ef8bxPL+3T+4jgxGAu6pZG+N+MzBJG3HM6wuP8CvXtGlLgaY3Tv+A/+ugJqsUQxHBE
         VfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194214; x=1778799014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dQvxefKofl/MWew8drQPijHpKnkbQHmoKvevMGmHYPQ=;
        b=gvdfmiXE0oLxEDOEjYxdrm9j9AcU6OsB5IswG23VLk8cyX1cc6omdOU9ExgnOWMsdq
         z4E3AZcjlk0qEYqETbtP+IWQEv082ZQoXYU6kKXVUlPTOMy81Q1vUFDM1P4vUy8+QAus
         VQYqht5h24/739r9qxO7Vucbjm5ctyH2wExExka1HRODxf2KKucKe/jn5guI4bBPpTrT
         xAHvRx6RWQ1kRpkl4v3do3lZ3y+CwJL7iC1fnGwnumpAln64kjtsYk1647L/RAyuoql1
         tW8Lv4hzU0tizJtwy22pD4IlZPY6cnE9lN73kTIJRzQ9lF71qLPE+urrAJSl31CldHhX
         RRbA==
X-Forwarded-Encrypted: i=1; AFNElJ/QaRJdHXvSRtCNaOegnKyLFupirLehSfL3CRxaTGkVWq3LGcEpwCKSrgjUbOQowc8vT/wRpXNCyU39Khvj9vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75LxeS/u7ozYU7/NKVCoatQvNjYLO00+I8LqUpTM3UNn/k5TQ
	WABfWC9w/Z6SsRXpyrkyNp5OG4RpE5/4T2C7ONpSTZCxDReX1y/2+F/2sNoet638yHCusKwguKn
	QIBvT0KW4hC8YeAODLjNSM6g5ch/ylI9Zzeq51AMR7M5CELD6iXFxtILp5RseRWFPYuXh73A=
X-Gm-Gg: AeBDievW1Y7RgyrW6nwi8GCq8C8gCIPS0fXYAK/uU+D5841K6nQZKP6Ms5Q68Ws0V3H
	+Y6st5+tKU2eJKFFVfn5YTBkHytiVrAK6mbTZBwGDwJ3e5iu6Xljtm4YJ0tF1Tk0I/Tt3RocPce
	or/yVmf8S66HbnYrQPSgEUIujcJjrYrcSuSsaEsk3hOKceMulQQSxPFlELViFPt1P32q/w8ZRSR
	wvW3CSd+d+z/3NTMCijfq3yKXUOrC2A2E5MVRvoH2N/1iMf20b1ZbxJL1Q1txVOiOBMktL3w9io
	ushTMaSBmr0yloIQDoy8Z/MeJOH9lha/57Xv76by4UnheyyZiIMQT2KuH+Mva1FRNl7ma42askF
	Fbwr9h3Ps/gqkvy8SEDDOv7drIaWRltKxY3+yzaD5rMzjmYss7YWr2syoVC8zlzpx2WrC6NZCRc
	fCmuAF8E5JTqg8e2iI
X-Received: by 2002:a05:6102:b01:b0:631:3b92:9dcc with SMTP id ada2fe7eead31-6313b92aa4emr424430137.27.1778194213807;
        Thu, 07 May 2026 15:50:13 -0700 (PDT)
X-Received: by 2002:a05:6102:b01:b0:631:3b92:9dcc with SMTP id ada2fe7eead31-6313b92aa4emr424408137.27.1778194213371;
        Thu, 07 May 2026 15:50:13 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:49:18 +0200
Subject: [PATCH v3 03/15] media: qcom: camss: Drop top_ahb/axi from QCM2290
 subdevice clocks
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-camss-isp-ope-v3-3-bb1055274603@oss.qualcomm.com>
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
In-Reply-To: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
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
        kieran.bingham@ideasonboard.com, johannes.goede@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fd1726 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=yFrQIQtVvbDJ7NVWecMA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMSBTYWx0ZWRfX7+8IdtEtOBM9
 IAzIxUi+QDs/ulH992Ck94mYqQ2Vx2vBr3QQydwkPxSpgrBwf5f/02V3eFPwzHQyCTnlYdQNucw
 igOdQUlnErcbfZeM6tpWCvskXByuvSz5+FPUlxPayiaJtMicRB3GEDE7OZ85DO/GNtCX16xNYVt
 hDsXCqDj5UQ/W298dRJ0xYIM5/k9+YOgbAhcB9xcCFyD7aNj9ja5rCSyWrKAS4M6kPDTgVuJtgv
 8Aid3BJWZDsq8kknLJ79Ji5oICOcgY1nvjDKYy7xG2QA6IBW2XIspoc49eH5fN48lHII7rUI3FJ
 8CzuqzwD8kEvVOeHS+OXQUNCddXRTgzXUnZ+X/4w0DGSF3UJz1qorWW57m2is1UwS2bJLmXxJx0
 E6GklVbM6cEFPkr4uZ/RKSqpc8g+X4xMyBdd1U8py0NpnvRS9hzB4TjxCSgcoeB51YXoBiHK/X1
 C+T/C2S1CbTuCpRquoA==
X-Proofpoint-GUID: MfxgveytHmNtTfiN6u0C3anoiG0HHevN
X-Proofpoint-ORIG-GUID: MfxgveytHmNtTfiN6u0C3anoiG0HHevN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070231

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
index 3bde26c4750ea932ea69fdbf5c5da9f959e5e5e2..0ceab12d573ee7521d44b77d23ee563930d6aac3 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -663,9 +663,8 @@ static const struct camss_subdev_resources csiphy_res_2290[] = {
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
@@ -680,9 +679,8 @@ static const struct camss_subdev_resources csiphy_res_2290[] = {
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
@@ -699,9 +697,8 @@ static const struct camss_subdev_resources csid_res_2290[] = {
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
@@ -717,9 +714,8 @@ static const struct camss_subdev_resources csid_res_2290[] = {
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
@@ -737,10 +733,8 @@ static const struct camss_subdev_resources vfe_res_2290[] = {
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
@@ -757,10 +751,8 @@ static const struct camss_subdev_resources vfe_res_2290[] = {
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

