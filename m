Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768190;
	b=FbfVM83JPVY8Qtl+Y8AC8G7eOXNAwqJx0sXOvPkrp2lgkzD401TXYvB+MWQCN6i+IQh2
	 2iiwY9DlgFd8BxzpFFUOT0KwwIF5AUxGKAlNQ8jpjnx7556bT6FAjNtVbsP2WT30atEEp
	 ZaSXYyOX/9bsIeu632VE7xbuPN5NNvwoPU3glFjSGR6CKeBQUhUfjXKj9dzwKeWYE9QsI
	 D6sC35v4og+kdIXmilwieXsMMW8Ns1S/QBek1AIYB8WhoxZDdgqx/08f36iuIYPE83I2N
	 E9Pv3LiBXcekJvxWj1iy7P+IgQeknLwaktTfupRrpVRLgqXzvL0nliHCL8TtCYSHEmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768190;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=;
	b=bRP/SUoWElb1MPDoEKvPfWiDpYmCfqWI+uWeMBF3oHIG5nH+JWuZjqfLiLpGnubxZaQN
	 Vjml/+cMXqXUQUi8sxQOgOVma72Q0sJqxAwKV7AUAsQY4DF1u4/GacnPzf+1h84MDQJ0E
	 vqJn7VfEmC/xe3nOCktjjr3twqFqQ006L4xQ4JcUaB9DiPaBNwYhlNXRYydr6F0wQeG7n
	 Kfs3Q4l7jiijDjcKXBYHMB/SZmtB31gRhR9b4AcVXIVikB7bKSF/7/pGi21Z7QVjC56kx
	 CI0OMvuBAbNkyaLpRMoWqeNF/7Zl0Ec/9q71tPyA2meyPr6rT4++Nq9z7F7tyhZL0GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gJW3TE2b;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jA992zSR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A4860A261B
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A4860A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gJW3TE2b;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jA992zSR
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6ArU2974541
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=; b=gJW3TE2bIskO3wua
	/3CBzsmht76Yuz7pYUp+wSeoplyYb8Pg2ILfWDGyud3mrglqoDcPm/j3KramEURf
	D711hGci5sZyJsQQ25QWjgY8hiNT6YvtRzFuD5GnveCrS1Cb0Ts7ydhP6zHyy6VR
	EEKonPCKU9hlwPwncNFpd0qvpauhuOczcZvuuwCGnjnkIdDCSL2SEOM/BMEEPZ6/
	KPjw0BmI+ssVfbKeE+CyKvEZFSkhG3A+PiIZHt12RumFIHSP8UWUluH8maGQIpD6
	LUhA4SqYwPTf2Ts+FJU+lZt/bNo32x3XOMX78ACvLYzL3QmkUql082SNfzD1cw0o
	JmUhgw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw4qu0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5376f1853bfso3667391cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792768188; x=1793372988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=;
        b=jA992zSRmjtComup/Fjm7SSk7nfKKnbF+9AN2ffLQ7qT9H1YOHcpvCTGeszAkmyb6V
         pjPRTQ3UYl5dodeRC0jp/o74nxfqbU/hu4A5v9sbl0Vbfv/U35Dly9GSG5wc3KN6if0T
         NkSCY/l/Sj1y0rekcV4nozqFrIX1BSlIwX+VkjsXHsIT3iFyxXmOwnVNIoI5C2Q7Jalf
         P8TC6sU32t8sWxQJkO/+zBPcVJwfCspBhN0o+rjpSqxXg17PnN1sAkBYG0f+jhYmBMc4
         w3HW3XLapxRRwVSa6fjrjbmvRw0Q+4IILHDw11vzYlAqSYtT6N6L6l26ehvRCFuuv4m2
         IhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768188; x=1793372988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=;
        b=ppQMbi7NKmYSLo7yJNi6nwrPyUQrf4tWnbU31p3vOjAQxKHMyStV7PBU53dnqcaBic
         +2NW25QhXPrECGBvFK7T2DGcGgVmoCxgQ9W3P0IywFXq/msbzcq1x6uY4GZg5AkgMkAv
         qWXl7+o6apou3xd2odeTODtLuBBQtN6Fc+bRpfVj1dJV6R33EU3wYy5PUzaXmQGcoCe3
         2KVyGfndJOsSBvYLLP5WmG+T2nckCGi3S6N+U9ScmNhE9PSgeLHJt7fK4rHfUlv0od21
         J7OI7DOCydnvhY1hcKaE6aDInanqfBLEb/McDBsARunUm8K6xntCd4Xxxgfok72PYnZc
         //1A==
X-Forwarded-Encrypted: i=1; AKwUvBzPlcAqsajT9lNJIxt8lGxKnXT76PZEkrY+wv3Wk/wHo4JhgXDMxJ3H7p03PIl+zF6WESUtE0B6fE+8YFNglzY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVYfuizhu4GEKE50mGHId16/YIdJU2KRovZCPIChKKHf3A4/YW
	113dBqLmFojDkpcckkugfQ7/PFezExghur/G+CCqSh9/luoY9HGmzKGWNzMPFmljkN1mtI5Vszv
	I1X+3il0iAceJxOvrf+hDlp6iqv9JVSRMsirQiQfhzU7XYJEkywhXFwA/NGYd/TxhnX1jGFU=
X-Gm-Gg: AYBFou1//k7BUFZ/xY6dmQCTnmTyKq1jz2lMvVF6ZIO9S+nrB9y/GggsjZoaaPz2h+J
	SVT1dJ/xOHlgn9KtfKSo7dSFLIZrOXnmbNa34MFbFpcIbUN6ja5oZuZK1X8zu7wvFzEZjS5h/oh
	8pNwFhJTmrBK6Ww2FI0MSIbfDu632MtuBHoosOso4CDUjEHQX8NFsrObAsBkhYettkU1rU9OAF9
	r4xTEiBb/c83o3ktfvA06Xi0vrD69Pa1jrXUHCQASAEoM8hTaiL7qxchLahkUAZktCz6HZBsNsP
	RLPwAKe8dXNVsUVamtTBhE7Zb8VCA6TCA39qYF+NrZb4B5SXZYKYKuaK++7U+qz8XsOpU4efakk
	Zrg0QDQuZK6FxYnyQDjmUXAiX/+nMov0+wZ2hYDWlFDmiNBRhnGM8G8ls9wNpd0JPggFim+3wT1
	mspYTi4jksmlHl+O3jUlFJC9GoSf/4Xh2wwqYyeb7JWQHIQnyveO4=
X-Received: by 2002:a05:620a:3193:b0:93e:48fc:aa85 with SMTP id af79cd13be357-93f6f964439mr447300285a.43.1792768187647;
        Fri, 23 Oct 2026 08:09:47 -0700 (PDT)
X-Received: by 2002:a05:620a:3193:b0:93e:48fc:aa85 with SMTP id af79cd13be357-93f6f964439mr447292385a.43.1792768187049;
        Fri, 23 Oct 2026 08:09:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d0fb:daf1:3106:3697])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4040d3sm323962f8f.27.2026.10.23.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:09:18 +0200
Subject: [PATCH v11 7/9] arm64: dts: qcom: agatti: Add OPE node
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-camss-isp-ope-v11-7-0c2937195298@oss.qualcomm.com>
References: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
In-Reply-To: <20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com>
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
X-Proofpoint-GUID: LjIBnn6P8qkULkqPbHZj6kVB-EOXl5kh
X-Proofpoint-ORIG-GUID: LjIBnn6P8qkULkqPbHZj6kVB-EOXl5kh
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb78bc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX0r+yzvTV8xbc
 ByJ2RFX1KidYqj2qaUfI07M6Cqjmg6jZ7ASLqMTnxkWuVKdSRl6SRllN0/P6kMLsDE7sQVGK0eB
 Nhq9lrlv8WxeYLfOUA9RxQQmEfcNEfk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfXzLQKjZwDC9w4
 YeGIhc4iBAH9x9noX7A8btfX0N2mb8Iqu5XrW+WAopwXB/8sSpPY1V/M3obqAFU4LhJxVQ0Q/Ed
 Yu16F9JwAA3eEQ1ds7JRZ/5RNuNmJRPsKlw08yUtraXXRkVyBmSbcWzXNMhlCXjBW1JGo/qxawU
 e8LrfJEhXKGubfW7v5tYu9gzffAopnpdMc3ss6DoU06rFUD/ptf0a/86Lw4g1yq3Ye6kcz8end0
 WzVFPOAv0Tycpivr9VK7BC+nIYRNN93MDfXj6xseh0xtrc7bEfSyHmQcocnd7NhEUDCNSgnzwmL
 6nFTZ72gjclwe+fJpvbhAwZ9a/PBAwylR/tn5OQbvLgsVwJZkwfONsy8yeiJBy+fQShKqynE2Zj
 EKopWwdUn9V4dCQrzuT4X8mDfzn0gIE8GBrlufCvsGlyw/NFkUIjdaJlf9P/rpl5cIIfW5ztNEu
 mfeNAtB4ezxB/Yy52dQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230059

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

