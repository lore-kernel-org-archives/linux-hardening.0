Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530A94C2261
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005015; cv=none; b=bgx1liVZn+3uzNITXPgNAREP3+A0w0ECFHXPBtw6jY5kiHAOOlRv9VPUmMkhcHgzDjQ/Rk02tpSflrJIvbU3jGQK4DwpO8DEAd+IQ3kSJnQQvZ/6qsftbE6+thEHobpopz1xz5tYaxR+pW0Y7hJ1r1an7WuHpM1lEqXQcwJyks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005015; c=relaxed/simple;
	bh=HmeR1l9JD8JvYgGsyzO5QvZGodxO5bhsmjCW69cOhmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpFGHL2HUEBDYKNWXzZF4qCuVhzjmQqG7ok/ry/G+JfpwlzvTbpPdSsI7bH3minkZBx4QkLH4OB8S/2TuOKxM2dOamcpapi39gIevuAdsrmz9LJmhtIyUPVXqxMT66moKkew0jkXHC4y7OmeeTuXpafWKrYQzS1s7T2imbY168U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdIWrzQF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jvv/gubB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdIWrzQF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jvv/gubB"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFA7qW827722
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=; b=QdIWrzQFFkqU6Jb0
	0zzgPyVPcHrlw2A8D5GDZya/Zi8mBpvUaVu0xJyzcPDngkFcIWrCQbMYEMEAG4Ac
	0PU+1Ao/BjnmG3R1CrBLusYorCfG53VBRy0CJ827eJ2HKtW89dsX+kDL/FeS9kMr
	LSydfFjaODh1g5siKTpKYwc/15xBmwzm0NuhDKPjY+MRZY5UHXOQwTPofr4mJV81
	PRbi0FD53Yjg4lOp4HGyQHWaB1GrSuSTyAxfOyMeT/LMkb8b1oYPbueXJiO/5RZc
	f1rKKtjpD3cWIrdst1Ike4Tv0PV3WyWvGMPfnQLr92f9hhVfVjQBWYmJXab92Y2m
	4t+dJw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu17gsqnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 15:36:52 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7a5ed2517b7so855784137.2
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790005011; x=1790609811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=;
        b=Jvv/gubBlmw8NtzBu95hPI/JxjY+5cS27WHZh4eHnxqo3k4oNZyw0cArhUl/b3UbX4
         cQ1te42r2B+fR/ZPZLD20G4AzsyUGgrJRJWl56gBz4tcSaez1ZioNxNfLHRkFQqJTjhG
         e12d7HhVeBtqaK9fQflNY+ayabII8mstfK2rdjhcNHak2PWZVG3Sms+UgquRArq2sLu4
         Fdd+ID0AoJ2wwXmddLo0n88rseiGr60qYwLE6J2vWuzpWmU5o2SyOnisyd4/on08rpqD
         ud7yvESFZjfi5sCXfVy4LxG784JwJ6ujtOT3ospCDfRwwn0LrJb36fJiQRGm5k8iH0XX
         QFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005011; x=1790609811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjzv0biNUKG1BiKaowTeTkIFJcvCjq/9OvYidNdvtc8=;
        b=U7su4HihMyRiX8EFtQlAv7k7PszdaNB8wrzQbraQZ/DR9NDTfuxe1cKLBGoAX9uk5K
         +agqawfbhwIqeTzZ7WcI3Avc8gbbIrgm84TpmYs0oraqaMR+9MmkkfXANWWRZ+R0PjFM
         /OHwP/BWGSY2AEizoFnDzRpoM1/mHvGuGA1JTojg3VWoQXAziPMocQhxwf0S8z8qEuGO
         iUXJ9zi827T61eJ4P2062Z/EtdcctTS1APaHPhRyhotpI69KXn0A6PXIGW4oZStbSoVa
         68mZj24kBsgyecsDGLP4BYbB/EmANyvzwvzUYQXxUlC/S6lp9qsxp2GGG1Tfg8n36Da4
         lpZA==
X-Forwarded-Encrypted: i=1; AKwUvBxoqLJERo+GFuLiOpJdrjLYVbQXlSpTGO9ECvpCso2PMeWWk2rxq3Xo6T9fDOg19BdHstpG4Uxakbt6oOxVudU=@vger.kernel.org
X-Gm-Message-State: AFuF++kh8eNa04U5RjHY0gQf3ZRqQNiAlp5Atip38pZ/ZSFzMfgChWr7
	+PUdOSEe4HjdwauaonQkxxe2KqnHW07POEmp60n1qkfYjiJs/EC2XtKCsqNhC6SKuSuahx1UOk9
	SrKJNgnJTSqWpgdEaE3Zlxw4h3HLkHp35TS4SzS3q+66l5i5KsqgJ1Hn1GhzEHXZkraJv6rw=
X-Gm-Gg: AYBFou2+MZXl9NH6Mi4yfrcY+35bIZYMLUJ6ozCq4rpM40b4Gry5H8GM366ModbXz/x
	/l2LC5WMa47gbSHELFZDFEE1IxNztrZ+DDrSQklLmXmGVn/uwSEPKYtBwDihqK7MvF90MM3N0Bh
	vTmTDSUSOnYS8m2aUhlwWTLVAUjU9ZcPaeRPayVOVnC+tgjb0SCaJOb4h7cdbjqXpp0O6OBBHfl
	Kr6RMca8lvbgHczEZmdgArGxBn94ygPbiJl+F6SWJwOaHjco9IrWJx8C+bMmKkVHFswYUo5KNnv
	7tLlJTAXarwULpvNfTd5zWTt4D96u9q1yKv43bzzvdGNvdU8KuUJgHNsSmCguuYrtv03Gij5yoU
	3x/K7ebopmaaVIvWZxJy4c+MGuH917L5oj5WHlEQHBHEgsyl60Nw/xOXkcpdGmu1sv7gsJdviiL
	JrF1ykj91g1FCPexcrBjF+t5QeN4xMluSJmRU6vRQWg+FydKi9pSM=
X-Received: by 2002:a05:6102:8007:b0:7a2:2632:ee08 with SMTP id ada2fe7eead31-7a55d28cb35mr5213171137.23.1790005011389;
        Mon, 21 Sep 2026 08:36:51 -0700 (PDT)
X-Received: by 2002:a05:6102:8007:b0:7a2:2632:ee08 with SMTP id ada2fe7eead31-7a55d28cb35mr5213126137.23.1790005010739;
        Mon, 21 Sep 2026 08:36:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd07bba7sm231054065e9.9.2026.09.21.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:36:50 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 17:36:27 +0200
Subject: [PATCH v8 7/9] arm64: dts: qcom: agatti: Add OPE node
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-camss-isp-ope-v8-7-dd1c86a3c8a0@oss.qualcomm.com>
References: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
In-Reply-To: <20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com>
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
X-Proofpoint-GUID: kNHDX7NI83a907S2ZWxpu0bbZJHEAjYt
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ab14f14 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1BEw5LmG3YzgyHxDt7YA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfXwqzmOW6gT7BB
 JAigJXhUGUGS4hAd2AiaHdOXxqOdzzJnRwk0A0iH39WQakW1AY4SXVfp0y2YLZalhgOgDS02Ohr
 k8x0mszlsUndIEoHf9zRNGrQHgKjjxPwCuV8vHlV0vxnlWQeGK8YfaSp+y5ikcufnyqgNHTifbL
 OtACn4/r75l2sUnGuLNYpvR5ze3yLhH9TlwqoscVAv26cAqEHOX3xFDoHuahxLK6im+NroJqud/
 OTczxF3LNGMyeLRz8l91AoY7Ce74/viHZWRB5r9w+Lu7ERg2RPe1Jbn+4WmLgZJwGn+Lxd069Ok
 z7+y18ppogB64mA7ddz6UN1nG9kiHB0zO+l1m9UXAMZyZEWbL+chdNii4K8WxbdlVD+p+q7ykKH
 JtIXlvxjmpBI3CP2eUPypzyqNPuDZXEe6Ljd3+y2lo1HwuBZh5AYNen7wxjZ7CVi4oxEQ2BM8ei
 7yhzT3AEECR2mL1S5Fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyNyBTYWx0ZWRfX2SjEokOInH3R
 3vEkD05XGlnJXN99gl7PUlfbuLudy4iZ54RuCpVtUT602Zq3eQyFMKrrIPukp3N/+86MC4EnBjP
 5r+E5ZoFzN4YKLaQ8cRGVvBM+ggnDaE=
X-Proofpoint-ORIG-GUID: kNHDX7NI83a907S2ZWxpu0bbZJHEAjYt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210227

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

