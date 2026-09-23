Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEE838E5FF
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179251; cv=none; b=Ds9cJVWj4EEqlIx9xzv1BqrM1L7Ns37v2+sODz5NJ4IlPvqVBrOYypEPNWUbJE44UbCIeh92vVBDyF+u4hcGJKrvjCf+OP764fyWW+cESNF8w7wsiZXAgQnsOsSwkIPUnp//DLxIah2RjaZsDg41tEk09pKY0M9/O3UjthwFHVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179251; c=relaxed/simple;
	bh=HmeR1l9JD8JvYgGsyzO5QvZGodxO5bhsmjCW69cOhmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRHYhXu1X1hU6iTHUOSCZFCuCy/w26sI5PL6wOkgo/9Twi9GOc8MrELlxV416tfJNEfcEqQVOVrqZ7QlPsWgA5/aH/zXArdLJV5NwkfLWAFCw8+ivnmwDzWiKG5om4ThZKEKJZ9eDyZyppX+H6/R6mWowCsG7294GQbYWLxAO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UuHl/btS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FWY0RTVP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UuHl/btS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FWY0RTVP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbUMJ2637894
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=; b=UuHl/btSwfLQIat4
	GxaElALrjsyayQ4rLRlSnJdnQ47rmQyvTcZhrK446sMpnREICbQvwOneUAR6appf
	vzq7qDQfKCs9BBiK4R/ajdlwq+I7e8SaPZGpJvTcdV+MtO/V7s4k90D3K/gatzWb
	O5TXDqEXImYanFikX6MTWbY7+KsiZV84t/CM4gMJvd2QBuum/vhvs4UOcy7kKf8c
	jIoOcNPSQMrLOJZkeMZQ8j0l+mW3xH4ZQ6WLbXWb51dsZ7NTA2B4Mbf+v6lORjXN
	QCNt74+bFfBCNf0kKwWGDZ/BVCCf9eBCKXyitVZK3kZ93QSU1jM1kmE2CBeDK1KO
	0gc1nw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv9bqjggc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:44 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7915a83539fso988779137.1
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 09:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790179243; x=1790784043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=;
        b=FWY0RTVPfq1E79DbVc4gJQdZITG+XhyPgLbmkOzDeFYpQjxM5qR9EIoEyH16MMzBbp
         Taqc19Ntke1VdU2qr9icI9K18wPKzsQNACKZTwv2hEreqS4c3C6xhRjav3KSEaZjxVeu
         c/HgDS0egXtK+VzAP7iu9gdIECUqc3iL5NTTfWnaBE0cZpwLVrlj36iw2zp68PejHy3X
         lCXdhrGa4VHCvuozPOhZjjv6SX8FLRldl+4kmSwfQRljOB99tBX8iKl5jw5H8leE1J00
         qMxon7VUJ/5ZYH0uutVzH74P3tuiAR91aa6u4ymNdJkwFJvF+LLoHCPtaIdKfq6gCaHR
         BrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179243; x=1790784043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=;
        b=OG3iu2vFsaUkwoRxm6wmnactmzlwxMyWqzNCjQtVsJW32y2TNIkuf7cgK16YVvYboz
         xmOhCkbzeiC+xqUtp0//A4y/Ltwmaq9y2owlKWYBFcJd9sYgB0+Xg1kZuQEXDlLVdXnI
         jGGVo5z43Bcll2Uu/0zZkJKZKFlOyJViAJ9R6XTamMza0OZS09/LZRKkBeSZi022WC7P
         7OY5iSLUgfB+7YbjAl4R3lDIOH0Sm7fcnCYoYfaDXt4KBkzKUwzxAOrfFCuWFkkaM7I9
         xYqVrI46FFSLjNW7D6ME9jYGiSs9FADD39aGCeyPqXDXsXrHcLk3ZJFitJreVKMdYGgo
         l8jA==
X-Forwarded-Encrypted: i=1; AKwUvByovHMzzsZu+XGAEvv62YNmIqRLzFbk9DFBaav5rSKWnCQhoO0J7iGL/WQNLZO4QCeAPj1AYS9FLqMGr2XrqAA=@vger.kernel.org
X-Gm-Message-State: AFuF++msiT6bKqRHjA0yjW4XMpYSg63EV/8mnrfZGhXnKrea9FhwcBT7
	tEwg8pQstF+Mjrg+F96g9PhSdDiIk4Qt/ERLrrQIgluBEuDyzIWNdCqUCS6q6cEM3alDRsjZA/L
	tzv16oycWqsxm+SNkOuqaOqDLBaJYpnQp+K8LCb6Y7bZ0IvETFZNct3Btd4w3mFV3ULIuOGU=
X-Gm-Gg: AYBFou1fKLNHiWvCVdJu9o7FeNOhgutnxyuMj11xbRfpGDzg5YOZlyvYy0b6sf36V2T
	UTMjTK98XfNEj5rQ+fvrU3pSQV90/6N89ZcmpX55mOltOfNUL/yT9cj1PZkPPpHb4O1aMRYQ3Sy
	VwCLlj+CuxN43+Jq1Vuoud+e6XAeE6mnI1E4HtW4SIiFNEkrGmbNo8H31+O/+nWqUJ7ND3l86Sz
	LaN8WNW6HGTR3NGFV39UKIytW3PksFMfQt97+HzrUUhOk80FS2sgtN51I4XqHpkCIFLMuDEAIVz
	L+Pibxbp32jxRDyDBbhruBo7F9kAJMFKFOtE3uL0Fds7x/RkqF14huXAlbh/4TtRsFkNkLAT50E
	/ZsSVzS8T/HE5Dk6jnle5OrD6NDqtDL6YIc5G/OLTDt863q6ZnJvUbvZwJw6Xbj+YSFf09noPjn
	yJZpyB11kLunDqRq0Wq1EsXjETvIodF/GLqERPaomhgG2B35hBsWWlJsOTP6D8Yg==
X-Received: by 2002:a05:6102:2928:b0:7a3:4e75:d1f0 with SMTP id ada2fe7eead31-7ac1c7902b0mr2848911137.23.1790179243005;
        Wed, 23 Sep 2026 09:00:43 -0700 (PDT)
X-Received: by 2002:a05:6102:2928:b0:7a3:4e75:d1f0 with SMTP id ada2fe7eead31-7ac1c7902b0mr2848869137.23.1790179242480;
        Wed, 23 Sep 2026 09:00:42 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde197466sm80739325e9.7.2026.09.23.09.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:00:41 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 18:00:28 +0200
Subject: [PATCH v9 7/9] arm64: dts: qcom: agatti: Add OPE node
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-camss-isp-ope-v9-7-86a75dc18b83@oss.qualcomm.com>
References: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
In-Reply-To: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 7PvCHl_zTGCuv0siAQ_11HMYTKlXefp2
X-Proofpoint-ORIG-GUID: 7PvCHl_zTGCuv0siAQ_11HMYTKlXefp2
X-Authority-Analysis: v=2.4 cv=WZuZ+EhX c=1 sm=1 tr=0 ts=6ab3f7ac cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX6Dx22nythmCk
 QWiK6ZjakCBQ8mYFJSnhnfVc8YMQm8AefPiDIJ8i6xRqi50RZkkjAyk8R3dJ32BwUYQUsUh80mG
 NN0eeA22E1KtNOm3+cy99g0bZPCgHMk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX/J+PK4zkiq1C
 J0wahQbcigKRrlu6Kp9gdoHTt0YEM27VOXbrJ5nBP1AVsW5Zb4x/CGYf/DmKEqXDeZlBdOjuZXB
 XbzeQGF52JJRGbYGKPcrqnQJWqbDoii30nPPK7CBCa6O25vk+bFDIvERf3ZoI1xyyhNJjuvXS0T
 zDJh2lsyayg1+R7F4gArt9o1FouZIlQMsTjGQ3jS2xN+NsazDmoD+Qjlsp/DW0PtoYEuZ2zPJtv
 GOjIVIJ6SBrwKEC+SnxbjXgO8okjDJNTPnq/AZH98zy/n/LW8E+EJqZ9KpV4sP4lFVz36gdLjpO
 OVcSfITf7rRtl8oRoSeRV6hN94faY+Q/BQBRbFC0+G/2/EWDhNu8NBpP82MR7Xb+A3K4NRjsvPB
 PH+a9OlbX8HPsheCNG1+74xp0dKMyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230063

Add the Offline Processing Engine (OPE) device tree node for the
Agatti platform (QCM2290). The node describes the six register
regions (cdm, top, qos, pipeline, bus_read, bus_write), clocks,
interrupt, interconnects, IOMMU mappings, and OPP table.

OPE is a memory-to-memory block with no board-level dependencies, so
the node is left enabled for all Agatti boards.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/agatti.dtsi | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/agatti.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
index 397d61a8a27c2505833466bd349acc27ef4ffe0c..7746c58b5b1cb25206e72b888b7559cfe27553b9 100644
--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -2020,6 +2020,83 @@ port@1 {
 			};
 		};
 
+		isp_ope: isp@5c42000 {
+			compatible = "qcom,qcm2290-camss-ope";
+
+			reg = <0x0 0x5c42000 0x0 0x400>,
+			      <0x0 0x5c42400 0x0 0x200>,
+			      <0x0 0x5c42600 0x0 0x200>,
+			      <0x0 0x5c42800 0x0 0x4400>,
+			      <0x0 0x5c46c00 0x0 0x190>,
+			      <0x0 0x5c46d90 0x0 0xa00>;
+			reg-names = "cdm",
+				    "top",
+				    "qos",
+				    "pipeline",
+				    "bus_read",
+				    "bus_write";
+
+			clocks = <&gcc GCC_CAMSS_AXI_CLK>,
+				 <&gcc GCC_CAMSS_OPE_CLK>,
+				 <&gcc GCC_CAMSS_OPE_AHB_CLK>,
+				 <&gcc GCC_CAMSS_NRT_AXI_CLK>,
+				 <&gcc GCC_CAMSS_TOP_AHB_CLK>;
+			clock-names = "axi",
+				      "core",
+				      "iface",
+				      "nrt",
+				      "top";
+
+			interrupts = <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>;
+
+			interconnects = <&bimc MASTER_APPSS_PROC RPM_ACTIVE_TAG
+					 &config_noc SLAVE_CAMERA_CFG RPM_ACTIVE_TAG>,
+					<&mmnrt_virt MASTER_CAMNOC_SF RPM_ALWAYS_TAG
+					 &bimc SLAVE_EBI1 RPM_ALWAYS_TAG>;
+			interconnect-names = "config",
+					     "data";
+
+			iommus = <&apps_smmu 0x800 0x0>,
+				 <&apps_smmu 0x820 0x0>,
+				 <&apps_smmu 0x840 0x0>;
+
+			operating-points-v2 = <&ope_opp_table>;
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>,
+					<&rpmpd QCM2290_VDDCX>;
+			power-domain-names = "camss",
+					     "cx";
+
+			ope_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-19200000 {
+					opp-hz = /bits/ 64 <19200000>;
+					required-opps = <&rpmpd_opp_min_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>;
+					required-opps = <&rpmpd_opp_svs>;
+				};
+
+				opp-266600000 {
+					opp-hz = /bits/ 64 <266600000>;
+					required-opps = <&rpmpd_opp_svs_plus>;
+				};
+
+				opp-465000000 {
+					opp-hz = /bits/ 64 <465000000>;
+					required-opps = <&rpmpd_opp_nom>;
+				};
+
+				opp-580000000 {
+					opp-hz = /bits/ 64 <580000000>;
+					required-opps = <&rpmpd_opp_turbo>;
+					turbo-mode;
+				};
+			};
+		};
+
 		mdss: display-subsystem@5e00000 {
 			compatible = "qcom,qcm2290-mdss";
 			reg = <0x0 0x05e00000 0x0 0x1000>;

-- 
2.34.1

