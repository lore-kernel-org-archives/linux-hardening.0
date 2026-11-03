Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736371;
	b=GQiBsJMTgVbTb462fkb9EClfjQ1g2wZvTVZ4Yhgcn/lbt/k9vua980dmKDIlQ+eM8ATS
	 x7QRrcSrYF/xPG/dYFZVJgtE82cntN/6MmGqLQ7HlwnWAfVh6q7YlPc9wqjgqEaPwFA/V
	 UXo9N1R9ZsBVKcZw1bzUjcUuymKgeUwD2XuB88+eU2PIj7rqpRm7GfR0esCNaCG0RKvwX
	 uZb+ZKUBSFqYRenpOlBqAVhekbwFmBve5D0/lS3ocRVNNAdRZklhHVhJ7YciF/OefR2rP
	 NQkAqZa2R6awCm2HlgyYIk4Gpnb5aWwNHXkTn9pX9LAhsti5G6QNc+bcwmz8EPk6MkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736371;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+i3zCYKlwVyXIoRDbAyxopCOyrLllPYMgSlhQAZy5Ic=;
	b=Lm9/tj42/es79HrNZezw1UlJxS00G2+2ouoTJeW/YZ2nD6yjzUe2o+TJnIZ0EfsiMycA
	 V5YfpahlPbRpfdP6dv94x5Pp88cv5cUchSfMTkHHviodRF1UfzyOcYQA54ueG65WzbZZU
	 MJJiCq9JQBHqTxRRiICgsgJdpHem3tSysX0JA9H2OIoT6rswRMNewAoo+9nonJ/xc1cUF
	 pKJG9og5khArLMEGCuz03QqkpT5UPOVgYg5gVSkOVUXc3a0EtDFB1fHvH4Nv0HC0/klM5
	 Medq+2EEmVIDJpE4z7+axOYFkYfLz5NvKgh6ukFKF5QzsXbHuxuA7H5/E2R7EDwJklw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U5atOivh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kZMkR+lQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D9606A333
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 20:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E56D9606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U5atOivh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kZMkR+lQ
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IZEKi445762
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 20:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+i3zCYKlwVyXIoRDbAyxopCOyrLllPYMgSlhQAZy5Ic=; b=U5atOivhH0SCsF8p
	09cGvJAJjRrz0knPc5pgRbX0oaj/2bBHnowv8XNLNs8FDWWPX0Dff8M7pVzNl6Ks
	E7qKXloiU0AqyE1iVemen0q0/a+T+Z3nuVaBUEPj4zccq9sfq4LLyK7fcEDpiqi7
	nyO7e0FEhlUj9vg6sb8Jxt9EK/8AwLUn/SO9x2BS9s6AAEl7S37jj9nWIsjGrjbV
	juJMHQBm0DHWoQcVAEGCoLNpHx589Zo0CrxfJBbpROCMI/yIXIXV5T4+p/WAsP6O
	B69Mp3vOen+qeV9BG/2LtadSHz7WY5hXUVyF7APL4yhVZOtXuMw3tvsmwEJuoJU4
	HYsn9w==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqm2pgmpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 20:06:10 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7cc1bb97ff8so1020838137.2
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 12:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793736369; x=1794341169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+i3zCYKlwVyXIoRDbAyxopCOyrLllPYMgSlhQAZy5Ic=;
        b=kZMkR+lQgpZmCRRf8GSJ3eoWIgypwrpsxBRrFbn/iuLt9RHUDQjU92YhMnqvVZfIkP
         IJ7rAUBly3G3hh0gEWch6Mv0GZ4yw9Ei4iRRq0oibUDQdq0qEhA6bR/aaYVRxrIUPFzA
         j3FnWT5SzwCWMBrtZaAGMBNU4jOX7lXlgGA1SGJhT+w7OWR1W0O63lE6A2/iW1V7FJrc
         /lKNfcooyjJEXWDiAo/KlDoqc2gBtWpm0WcYUDrpfsXJILaFoZTOpZhbIRQyPxmq97Qa
         BUy6R98cQ6Bx85I5NdDt9oRsdkVtd3LhAPsZiJp+B7M9OkpvVjrk2shsOybAaiR6DztU
         061w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736369; x=1794341169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+i3zCYKlwVyXIoRDbAyxopCOyrLllPYMgSlhQAZy5Ic=;
        b=RpSUV+CTzMOAZu6zrqBsoTG87H1TA5e4GEnlqiB6PpLVpLg0W14TAa2vZtBZFpxZKN
         o283JAZcSuk1KoGj9gBgYEoJOfAGqxXuEc0l/jf4Wg/M1qppy8d6n6AAl+r2wsMfQYbn
         Ow/cMh2Q3+UATdE6x0hYDHphdchg5epVIApvYAkoOZgMbSnIEw3aBq1f/shdiJ7j0Q2X
         yX8dv8POiQwNicdbHOJtbgxwAaWtktfxTmtcOMrhE5OTacJGQl/SeOs2ZMld1cTnlDdx
         wCQwdWFF/f4W1D39dSicaSwN+H4Cugknm/7+c4gSAAIUmI4WHz3oz4OU9tAtQLWPfNs4
         ykSA==
X-Forwarded-Encrypted: i=1; AKwUvBwQjDPobodkCunNULqytIovOP8Jz/W9b/T/k8ypTY3M//N0u5ssEmsNY463rI1KUMd22rWBBjEGLBklRjBH5Cc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Udjg4uM+AJ8t84rdJ/0JvJNkoq/x8aNLjTfmb1QuEf57yTCi4
	dWhK3lj4iJHyYPtoHg62Ib6v185TaUb/ZjFCleikrKybFzCviE2o3J4aAL9OCC0uZu1nsD5Yx+j
	q9lK7p+SyYa/yN9aRMYpCkuv5VdRAH1wZabGvvIU3eF6d5Wv+nCI03kGfbiZqDh4XDyKN2z4=
X-Gm-Gg: AYBFou2WdkGPua7eIXXE6eXbnFhk9j4mHswfA/QLkH+/WQSCD1++iJiupzJ7HCXmW/K
	4sMntX0Ib81I0S+LgzFDKBUHAMow+GvhyANauCIcc6PDdakZWxRvzF5wS7W7TJvX0n6ZeOQZ3Ll
	+IlkSwP9J8igHCa/O8v4WAvRRsyouHd4334GZNbbsT7SMWlPalmeaAoPF2+WhhPK2i6pf24oS/j
	eI3aQHBHmPSSB+qj8CRb74Yz0mZSo7i+C6VUcBJgFsezUeMyjJAhnnlDnYpjkPWir3cq9nwk1S/
	OGfhn2LgLRuknsVYWaBTUqmmmZHnkW0+H7GM7bBMFFIimrnuVrifRiXksmweN3hMjXOIk22YNrD
	amDQ9DFPvrlzQYP0jgIFNw2+VIxFw6F0Pc5JWQoAkeKqzy7YdAfRsn9bydzmtlfkWW8jw2Z3ba1
	dBHkOMNOG8YonWIf+yhMdlWGhNPYLO/xOeUAcJ4/n0MBL+mqCIZQyVlq+F0Tnzv6licasvO5Z0b
	nwuI3gTDkYhUIFwn3f653U/u2nH
X-Received: by 2002:a05:6102:3eca:b0:7d0:5688:f4f3 with SMTP id ada2fe7eead31-7d072775d68mr4767614137.1.1793736369073;
        Tue, 03 Nov 2026 12:06:09 -0800 (PST)
X-Received: by 2002:a05:6102:3eca:b0:7d0:5688:f4f3 with SMTP id ada2fe7eead31-7d072775d68mr4767598137.1.1793736368516;
        Tue, 03 Nov 2026 12:06:08 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm358875f8f.44.2026.11.03.12.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:06:07 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 21:05:52 +0100
Subject: [PATCH v13 8/9] arm64: dts: qcom: shikra: Add OPE node
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
Message-Id: <20261103-camss-isp-ope-v13-8-c2cbf15a39b1@oss.qualcomm.com>
References: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
In-Reply-To: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
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
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXzNXZVU6olfuk
 VVJBOdrG6YZ+I19tQFDLzEw5GNislsxfQCT16JICY7kDq8FhyT8AByB+BDcbTLuxNl601QfC0tV
 eWl8hYwiFBmHwRW5Ye7yp9LqIgRj/FVSR1AhQSf7FiougZpuCzhuTihI6hPmFHz1W4yaTI+5mc3
 nNZQQVWqzNPj3due1BNB3nPOx0/lWaTLutQkTnXsDBTYpz+nrjLLlKy2mPB+hHAUYvHqgKyI/st
 0gTLYz78ePIGtx94Ka46ynPycX8osh0h2iE4f2qpoTva3FwOZLNkRwGp8E6+7VG7/zAK5u+E6W3
 OMA0LogBAq8ESbWit73iI5rkfN0pA9te6CsAdhfvcOfIAKRWiMJi7LELkfd2eug2hNTC9qoymTG
 RnMCc6zyxTdAfQ0wBhUK1W53dR9UK5vh3Nzs0rpU/V2ZbNUq+YxFlR/MkOKKOqUCR4ug7VUpxlz
 BxapmSmIimr/+Xu8mPw==
X-Proofpoint-GUID: TbPoscGb4lmE3yWfQ7UMX37NMBuh74sD
X-Proofpoint-ORIG-GUID: TbPoscGb4lmE3yWfQ7UMX37NMBuh74sD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX3W/04M6LhSuD
 OGCz7HOpLbiSzZAfxvC6O6wJ73CTu6ds2kgxwa3G1i54wQmTAOBVAAHkdNG3e6mGH7b3BscZtty
 8k8ZE46eehjUkNZtHyUDgGnXvMlaL9Q=
X-Authority-Analysis: v=2.4 cv=c64+0h9l c=1 sm=1 tr=0 ts=6aea3eb2 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030080

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add the Offline Processing Engine (OPE) device tree node for Shikra.
The node describes the six register regions (cdm, top, qos, pipeline,
bus_read, bus_write), clocks, interrupt, interconnects, IOMMU mappings,
and OPP table.

OPE is a memory-to-memory block with no board-level dependencies, so
the node is left enabled for all Shikra boards.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Tested-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com> #Shikra CQM
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 2623e139196f6398c57b616879a37f84b83d59ac..b95ad1e61b9b4ecd29a1b7b7fb0c2c52ce31a967 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2357,6 +2357,83 @@ cci_i2c1: i2c-bus@1 {
 			};
 		};
 
+		isp_ope: isp@5c42000 {
+			compatible = "qcom,shikra-camss-ope", "qcom,qcm2290-camss-ope";
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
+			interrupts = <GIC_SPI 209 IRQ_TYPE_EDGE_RISING 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &config_noc SLAVE_CAMERA_CFG RPM_ACTIVE_TAG>,
+					<&mmnrt_virt MASTER_CAMNOC_SF RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+			interconnect-names = "config",
+					     "data";
+
+			iommus = <&apps_smmu 0x600 0x0>,
+				 <&apps_smmu 0x620 0x0>,
+				 <&apps_smmu 0x640 0x0>;
+
+			operating-points-v2 = <&ope_opp_table>;
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>,
+					<&rpmpd RPMPD_VDDCX>;
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
 		remoteproc_mpss: remoteproc@6080000 {
 			compatible = "qcom,shikra-mpss-pas";
 			reg = <0x0 0x06080000 0x0 0x100>;

-- 
2.34.1

