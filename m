Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49313DA5C5
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194250; cv=none; b=TgWVKl9TPtnCjXytudHICb7MrL7zK3O21VFc2mrW2S0jqvME9dwKJiq8huVdYa+yI4xam2q9N04fF0n/26XL3Bnw1wcs5cMclMqjcGmskMBpiE0mOYdRA7fQVZq4RSNDWRxh/2AIomNcOo1OSQNaW1MX03xjpBorBTR8g0ZzLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194250; c=relaxed/simple;
	bh=LHNi+12cboraoNbCzpt/W6iWtyjIVws+K21hs0+sClI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kd8FmcCeGj82nPrB/VrTK3OaOrrhcNMh3X/K3q1n3h0yNvIcDp/Sq6AnDwgDq5V8No4l4pZNxGYJPbGzvaoT8Eko3UrnUiH1C1D6Fr+Jclz9jgQdn7CJkfYw0X21E3UunaLgptzbabHwe1AydZqpBU6U1eKwi0nFGDwMZloNYiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HQngIrc/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nsma7KOR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQngIrc/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nsma7KOR"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647LsJMp1173965
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	edJue4htj1/6yA330XjSk4emEsskraGJVNTPDwrcKdE=; b=HQngIrc/io4BeD8i
	ZNTtsFiiaegrguhhJrfqFW/WFVa49f/NvGeqsrpbsYTbpmCKxYkdCluIH7x+mArs
	XW79CSSU67He9YmA3ncj9z9wLpwlNOjeInW4kNjhoUuhrKWXDJmu/croAIaloVf1
	7eRsys2lgrPJKnl5nshK5U7BFY2HJOD8TiuNLoCVDEgoEu4YuypDVH8vob5SFcck
	4+81JYTjha9UUxpamE6UA09JBYIEowvo+r2K1g155KTFaWYhREFB99OB+MpxU/nL
	uTyJXkn7yZmKr/BS2reSCjV//FfEc6fCYUXCCiY4yPXMAW3nOMfHx5Qoq8th6E0r
	isGHNw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e132h84c8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:47 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-956804755faso1978155241.0
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194247; x=1778799047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edJue4htj1/6yA330XjSk4emEsskraGJVNTPDwrcKdE=;
        b=Nsma7KOR+vLrGr+q/CtwlrYtpfX/353EdJlJzhQc6hqFGnu5JSTWQ5stT052Yw0Ovm
         tBWZhEJN6miwbWhLCgUxRMekM8vYU6Ojn8NLQXh8b7BN7c204chtCEaDnjYF5oEZmrQK
         4vtkzDD3EFdQheIOxBIiCawhTdewq6BXg5hyKzmQ5lPkoVZmDwJ3MvEQSvxUXKFfhO3d
         DqSLBKvgbT0lOQo/s2KUGSpwbL4KJI73Ls/a1OFuovFRQZifjCHWcdL+QAexfILsGxSe
         u76imxgcNsNrbGOLVP2TG1LgVMz5lKdsN7OytdU++jqJjip3YH8SnpwVIbxEJrqvEmqH
         ldOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194247; x=1778799047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=edJue4htj1/6yA330XjSk4emEsskraGJVNTPDwrcKdE=;
        b=kwUmLe9JKr1EeqKZ/7ttCShKrBxZmGCFkoobr6ZsFKTkBkHB51c39q8OXduhjpGKgf
         COOC8POPza5JfLWcWOU6sAw4WwFVXgHppVEhJKj2WSmt8Hq5MSZRYCbspWm+6fAp03zR
         TKjH7wZrRZlDYZH3HRBkPraoBmQjN84LxtIoHDeNqYWnxMb8KZUyE8UJERXAt8SNlH1o
         y7zajSCbJbSlE5pDoX4hmGShF7UOSH/fcRsqBdPaasr9FKWFKJ/4DFRlMxbFVfn2+0sk
         vZkwhKQg4cuHpbgjt51W3xalTbWbj76FjbGT7DDeb4OCgQQcWf+60ECi8HkH9Baia5WP
         aVCg==
X-Forwarded-Encrypted: i=1; AFNElJ+RPEneefHb4s9KKVv9nVp/SNFBZs4cXZ883lUuZ3+TegpoeHLnE9cUKA4Fx5YxXk0cC0glGFZ8/RerorNRf8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YygHS8vWK5QjCpWuUTJQsfILdrmM7eSgvs3/A7aLLpbm2IRffAG
	Wm9atEIY7Z4r8vNhUnwFC9VBH0XrmUVyGrQef7i7RS0JIlBzNFglknTXhJwnfE82h3RRDms3zMD
	f0ZsUVnJVl8+gQlaWewJWG6rDNjkF7ogKknvpJC0DgzboB5C6zcz6pmESCBOH7+xM1KZae+c=
X-Gm-Gg: AeBDieuAjkxZnhwPeQ/PQGzvAhOQsOJMbJQAk6dnITkLtyiHOd+A+zU7APm24WaP218
	gdEJqzNx3+ucIgc1/VqqN+HVP7Vr+foqcJ3yrTzVXJzQ7ZujmOzScB+KjVsOhZyXxlun4ndA5Xw
	eO5bF7ghed7NSNh83fACZkNMdyZhxdQSKT5LnXPYAcRRrtV5QL6kXm0pAZyrlVQ9KaoO8sDVERu
	IpkPHR8hi8MSvzvdSjydsGu4swpMkyrQLZt2ILY0aY33a/vW10upyK3gzXLS6D/zulmEM3ENrq5
	AE0efia45tR7QLSJIZe1v29PEtxJ9u2uucGaawZFH4fQVSahyNAYtAgTeWzfPfJIxopP23SJdKB
	uY4leKpEjXmyR0W1h08/jwAEYqfcJZ/0rkBTBrJI7gQ5bhMNs9M9A+pD6lJ8f5BqOdAA+mPLLRm
	k7VheGId6bwjpcMZRO
X-Received: by 2002:a05:6102:54a7:b0:607:f4e7:d2e8 with SMTP id ada2fe7eead31-63115d82c8emr2076956137.4.1778194247146;
        Thu, 07 May 2026 15:50:47 -0700 (PDT)
X-Received: by 2002:a05:6102:54a7:b0:607:f4e7:d2e8 with SMTP id ada2fe7eead31-63115d82c8emr2076938137.4.1778194246707;
        Thu, 07 May 2026 15:50:46 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:45 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:49:29 +0200
Subject: [PATCH v3 14/15] arm64: dts: qcom: agatti: Assigned clock rate for
 CAMSS AXI
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-camss-isp-ope-v3-14-bb1055274603@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMiBTYWx0ZWRfXwP6+JomluPE2
 FvZmwVCxKibd2Z95+6Qg+12DGFMeybtFS+z5obt8kpIgN2zrvX2Z78yi91JHrwNc6np8MudcYjc
 lhRm+Lke6t/+L8DgTRl92iFYoU9r4UacTB2MIKUbIANyRjF0npVR2SM1wQJRF4xNbMGpe0PX6jR
 hQXwNS7+ZL58FPBddB9MVI1/neUlaQY9S7kvAOldBvkqxFzXb/HrJOYHyCW4fz3y+5LC0V7R+Rq
 7pQu7qrwHtfkkYJi7AnaXzfO3rPL5Juz4lQFNSjJxDAGsMVv6X79zFVTqJ+9z4rBGxYwz3GRvj3
 TstIyfZRA+1Efaqgp8GlA8t2zXVRSloxwKF9TpeFV4fL0dxrzkHI445ZJoQ+GU1MvJGwaqT7Epy
 kYa7X8gbWToV3E/mt3W4CFyFVedilvM5OkYp+fl8GjfzrpCGbyOhKB7GpcggWnEAEizwBszdUHw
 3RlgB7uN8Yc/JydQndA==
X-Proofpoint-ORIG-GUID: AyuHWQ7B41mondPeJeDvjM8XLUdBgVgq
X-Proofpoint-GUID: AyuHWQ7B41mondPeJeDvjM8XLUdBgVgq
X-Authority-Analysis: v=2.4 cv=McxcfZ/f c=1 sm=1 tr=0 ts=69fd1747 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=gjCkitBQ8UzLeNF7HDgA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070232

On Agatti, the CAMSS AXI clock is not managed by the interconnect
and defaults to its lowest rate (19.2 MHz), which is insufficient
and leads to throttling of CAMSS-related traffic.

Set the CAMSS AXI clock to a suitable operating point by assigning
it to its nominal frequency (300 MHz) as defined by the specification.
This ensures correct and stable operation while leaving room for
future dynamic scaling support in the driver.

Avoid relying on boot default by explicitly specifying the expected
initial clock rate in the device tree.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/agatti.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/agatti.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
index f9b46cf1c6462a89784429565e1636ce2ba68d73..6a6ab3f15c49eb1e8150f57198ffe2515fa9ae52 100644
--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -1884,6 +1884,8 @@ camss: camss@5c11000 {
 				      "vfe0_cphy_rx",
 				      "vfe1",
 				      "vfe1_cphy_rx";
+			assigned-clocks = <&gcc GCC_CAMSS_AXI_CLK>;
+			assigned-clock-rates = <300000000>;
 
 			interrupts = <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,

-- 
2.34.1

