Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768191;
	b=C0kzcaiTMGcGgso+fsBLs0LTuFz/Pbb7ij2OBmWCKGI0Rvqe1i2juSEhiUfZ6lGTP+qT
	 PAOOjkVCJJVRJZpqrqSn6IDAvZgqIsUaQPVtNIE1Bjj9zSOFn4hXqsjGFhwv9H8oxwQqr
	 F4Zm5OQMBif/kQiGs9xTyfHbiTFb3IDMRlUQPz/x0LNhnS3TQFzfjLSnZ6JfTXkzP8YPb
	 Fg7GWA8Wol+4LtMsYHHJ6iTPN2a2UdFHGRiDb/SZbn5vqlCUTUCn6NFiqfXoxuxieDSSN
	 bknW/mxjbmrcLsY65Y/HPtDWthWVIfeomhwfXT6KoExCE6lwGitwxz/PJGuvvrITWlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768191;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=;
	b=vZm5TaLD5gxSaBvRXzjHh3QAbgfNcitO6FcRzQMFiXbXiK3ndR96KjBWRJmwrfnSEhBU
	 xMCMqjgy4/g3FD1bx2N3+vJRiZdTNAaOVRYNb0nvHcilAiN3BVXpCGvMGGfHi3P+cWWmw
	 LMAWBJy97sIB8OYm7B36ksLHOoYBv9tGGfcFTCTl5HCjYQ3KLSTUqppolb5MH8Qv17Jck
	 +VxJgq/5hjmGBwIA5doAgi2WI1R5CWnoLhuHbsuo+SlqPHYmzhBGxk3zTWg8/MmLm+uxK
	 cgR3v5LvcFRTArU8chLCQXhANVO0LEAQiduoRy5dxIX4oB0X+uekMS+5+Qe4TsStH9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="k1gQCA/N";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A1d8bkNn;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0860A5BEB
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3E0860A5BEB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=k1gQCA/N;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A1d8bkNn
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NE6C772462549
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=; b=k1gQCA/NeRRM0N6X
	bs7GqQN4v3pJZ2NXvC3FNKBxnn7bSUXLLsq84ULAf8uR6U4QfiyHOtUrDI84YLVc
	2Qh1YUmERppSR0THsNUXXzC5IVcWU7l7cFD+Lfs8NV+OTYWHz646ITwqGtk5llVS
	cVjGihIH5zb4edMp2mBbKaMRzljxozQiT+nIzpGyvp+GnlA8ci8E8z3NIpCE2yWn
	71pUOGy1zOLTx0Sb+YH2fhgrgkm0l/LgszOfzOtGhZ4dNnjf2Cx1IlICDYjkLoPe
	uyx3zadceXQyBayASCbhEy5JbIdCPdEkoxgRfV+UJyRu3+xsVLR9dS6jE2bvYL/H
	LX7baA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtv9nq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 15:09:50 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-990ca9607c3so630793241.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2026 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792768189; x=1793372989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=;
        b=A1d8bkNn4ZRwqMGIGJx5IXqEut6BUQhxl43tFro+K37vTm7HBY9NoVndns/Nw1l53w
         4OztkQAfJeM1zDl9pGlgiMuJjVJ9fP/JlYKNF+SG9/4b9DdcZHsm//JLnKo1bZfFfhZU
         cKLHfAc8v2ppLynI4sXBiaBO/EsGXstW5gu0XUay4bFSLhlTMPsXrTGF8LxX6m1arhZt
         zPa2mAvadxwbr+WADRWGR1RquaDYTV8xwdOvli8xnERl3VqVRXEMtbkiNF0dnRgl5Pkr
         Jm8vSkfAl7B/n2tVMspAU6ie8Is+UL67YykxUovYpI6pEMQtjPps+6nMVHyX+Y/aOheb
         NjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792768189; x=1793372989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=posbByi2C22vAqDX2ezu/Vx97adQ0JmvEhOqcNgZPY0=;
        b=a39grsV4wZMPenW8PDA8YZZ92JbDARxROwvQmjplps3SBRTHzqW5e7BUo1KlJFGClN
         dQYtEyZWbJ75TPhn2UpnVuZyb4ZH5G0n32wwFDFr2VudiEhvw5PpmT2rznMTRH2QYaic
         PMIa7NuiudokThmbt7sm84R7fsgpm/JhAMYVZIZZjTBvfVbf6ux2JfnN1A7QUGxJckjw
         RmQF08vRWZHqoAP/XrEY9RlApWxNaFKwYb4FDUTLAY2krTV1duBJv4KSxJEexjP5R6rm
         XN5eBRItyge6gtDSOyWcmA7ptAsfa+fbbMnDl2MZ3ODSDSGOPten+o61jPJ/vvRgirJU
         1n3w==
X-Forwarded-Encrypted: i=1; AKwUvByBVenm5WVe7cDRhVUu6Q3bZfhQ+QENYeQ3ftkKcbSoKzz5dYkOCp7bEXQk+AvmSZca14NZX1v476frtjb5W58=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN7DDTpzw4C5dLaf9fQAOrqM1qz5PG0+eqzQ9yGU7qvvx5z350
	rnT/1SWBs+xG1IZKS8shqxdFfZnnGRt09ReNyFNh3B8a+UDVWnQXTwjoKGHhwa89wN0iJlVNgl9
	E7n7sxM6QwY+KUBNfS+jabqEK4FCRDhdGd1EIWvrgzAmFVnEIAxolltlJqlJmKIUzf0PIVDY=
X-Gm-Gg: AYBFou0gpzMsP2n+bWJr3SzQRvQaXGljlZoQKzBDw5bd0qzYneeJDnH9MDRNc+p3KrK
	Mz3OS0+3Ykw0ULNr2YRhvHUYt92W860faUaN57KlVE6Oh4KAKQhxuPIMbTPscJZtawJEuVVoLQ9
	ImH385aF9vfRq9JBNXgCllfF6bkMC7Wfd6DbdIaqqPtN1HYhTUrp7umREtbOhxxi/eDw24jwc5A
	1QT+R09KbJI3Mnopo9i/539kEYmNN7dHMSYeB8+MzPD7qibZsaHx0mCMjBoZKdRXZJD8LM7voMR
	abxnrXpLHzf/U7m+CXdJMeP47M6MrOiRA2k07RTmK8nIJA/rtQHeWCVSXLeNtQmLRTwGdEZlClI
	J6Phq+/rbaLoVyRnxvrM+7s4gpBX3hWReiJ/CqiDfbwSIx44gPkpLlWwVVkt/rp8UbPe2iYP6P9
	Cf+oAQlJBQ91ksFBU7gTyN0zcJnZpetsK01t8TAlNTEMrOvHlZC3Y=
X-Received: by 2002:a05:6102:5706:b0:7cb:fd69:4155 with SMTP id ada2fe7eead31-7ccc2ffad08mr1256672137.5.1792768189190;
        Fri, 23 Oct 2026 08:09:49 -0700 (PDT)
X-Received: by 2002:a05:6102:5706:b0:7cb:fd69:4155 with SMTP id ada2fe7eead31-7ccc2ffad08mr1256668137.5.1792768188810;
        Fri, 23 Oct 2026 08:09:48 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d0fb:daf1:3106:3697])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d4040d3sm323962f8f.27.2026.10.23.08.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:09:48 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:09:19 +0200
Subject: [PATCH v11 8/9] arm64: dts: qcom: shikra: Add OPE node
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
Message-Id: <20261023-camss-isp-ope-v11-8-0c2937195298@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb78be cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=EzCDy3pf2FPqfMyO2-oA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 0WSWAyv6BpoF6KdHt5PttE9XzbdtVf1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX1FHB42faScWV
 a+vp+kDz4+vkyajnxhAocByWtvlO7c/xPCT4YGHdWliWGCkDwOWlQ43Gmvdk1WOB4a4knp5bBsT
 4qtGAOuUfVkdRdECq3kM316v0q5M+KFpZO9j37w02Lj6HYAmKtKfb54BvI1EwQ/zkwwSb415u35
 yncHgBVoI65HsbFuivJzMu3WflHn/F6bwlBuiSY6mbIUsfPJDvTZ5K1mV/US4zUoDIjaOZVEOhT
 BuXMCFgXhgewSBj2KFkCsZVNrnqRWWlhwLgDHcozzz3oN1tnSCpMn3W0Jm1VJs2tiI4MqSeLpPe
 a8oOySjDubjJPPlTduIbAahyV24d+POML6tKyPCiv6c6afmszxTXJTTBoeIN8Ma/+CjsOV9cQ2r
 ZSNR5TJbdC3/FtvTRY+Xi/h/6voHd6aPOfhaU2PMKgJZix6Zi+mpkMlhB6YzV/YiCPz0Uz2J3RT
 i1jr4B6Sqoqw8HxlLqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1OSBTYWx0ZWRfX7mXm6avfFR68
 SI59u5Eywg6p05uPDOPv1m51ZYIqqRJIAR1trs65rKOpJklrO/A3C3VeNW+/sMReqOr5VcCKpFp
 rGRxhkfpHq06nwFcOdaK5XKvtrJNfX4=
X-Proofpoint-ORIG-GUID: 0WSWAyv6BpoF6KdHt5PttE9XzbdtVf1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230059

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add the Offline Processing Engine (OPE) device tree node for Shikra.
The node describes the six register regions (cdm, top, qos, pipeline,
bus_read, bus_write), clocks, interrupt, interconnects, IOMMU mappings,
and OPP table.

OPE is a memory-to-memory block with no board-level dependencies, so
the node is left enabled for all Shikra boards.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 92d22e3b6931cf49f213d1807f78fc1a261f290d..5adc28e9aa64508366e6c7fdad191a152b8cb6dc 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1828,6 +1828,83 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
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

