Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE173D811B
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674310; cv=none; b=Ff3VGIGqtIsl2QdSfoFeDK1Bp8kIIMiluNMJxuFRYjz6cXOoyLRp8ldGs+SG/XBAcqlqacU/WNr6tI9gJL0tbKtBH41ydvwNJJsCWhkmD0/sUunigFR4uwAX0EnQLsShwNuJlB0LFDQ4Uv0V8JCphHyEGCsigF9lQqP7M2Bc7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674310; c=relaxed/simple;
	bh=SzvTslI/0rJw+ojS6p2oVMofrR8mq52q6PRHLns1hqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSX74d8XYGb4oYrO8jglDJgQddDnkB3AySt+hU/8N/QZLnbvbJH2u7EH4ZBYht3lMQPXLSbnV6QbAo6HXCrXk1/KWJjxMmHopwfrq8MTWKkByOL+CFol8uRvhoReAActA2upBTZpVq+KhORjvRwT2pGOku5LGKMBpd1rdyu+jiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b6g0Ju2w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kW+em/Ni; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b6g0Ju2w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kW+em/Ni"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dqa9000903
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C4yczvZPnvjUavtM9iyfNq5RJVHkn2SJJHAhN5SbVGM=; b=b6g0Ju2wuJ4rnKTx
	F7t9LsGn0cpBhoJgBYJQTCK+gDqmIjHboPgtuR0/Uqx3DP2rxw1Jd6qLXxIiVZ+r
	EO7v7SouPiOtBXF7B4kuqcLScjY7o9pz+pUhwe6zyuwImHg7LEVeKc9jtcI/IBW9
	aF3FvuKg38GE/eb1NCT4nefkHM8YuWPOxbsuHl0UBBekQOGpXMoOiEQvJyATnFGd
	iVk3eVTWDZAZFu6bpNbdbhHzA/0BBFn0O3/9VO16YZ4Ty5Sau8TqA0SmAoURGdo8
	mj5NqNH3huYpzuZ899ngpQIO7dKkQCAB5p+f5IIO69V2Jj2wL+kGfxIHO1v7HCUy
	1KTgVg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24ugr0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 09:05:07 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1b4d961dso7196761cf.1
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jul 2026 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783674307; x=1784279107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4yczvZPnvjUavtM9iyfNq5RJVHkn2SJJHAhN5SbVGM=;
        b=kW+em/Nia1uxmyJ6BhN4NkF5Ha4vQum7wwruzfH+yKkiYnVbW5Nm1Ipc8QsPEwzQjb
         hDVUaYUCujF3DlHlsePCoIPr3ueToNdcDh8ZGR4pNL8e/EqnfFence7u5UW8KigCqld9
         NFwuEWONfy/heb2RYPf6j6QyMZp/PZPK0WgnfjL7qoiiSRVZZshJVfUAipdA94Mt3Ful
         5K62BeKf1rDVWVo6cexYU2E1GrfZ9n6U2s2UC5uQFAaqBLrtFJnqmERGZA6ToV9hZf4k
         NgmYyRwptybW+KX8/d+0TouIi8x+s+FNM01o92VdyYr2PCTnD5Ral4d1gx48kE9LNh5W
         yyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674307; x=1784279107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4yczvZPnvjUavtM9iyfNq5RJVHkn2SJJHAhN5SbVGM=;
        b=Ryj+2N5V7wuuGrnGAIGUexj5fS+GeuRpTZ9JpQ5vfaZhT9SMRjrsMQydzYSWC8uTe5
         L4hHnEegsadRwImJ3MwQYeY1v2rlaWJi4Jgo3j5lR2IYWVKmk9T9zwcsP+d5G2CuelrY
         NwE0X4lSiVfTo6HLE3sK4BIY+QMGlOIA4NT2Z0YkKB8RPjpZ06Bu75pKSb+uCrwROk1Y
         Vjb+0z1w6frrEtd8uKU0FAj89na9pzfObt1lbovMIXS1Eyr/B3yn3aLPp66qVW/QWuqr
         HwMb0rb/EBoygriANIdsNBMCKw2/e1YVxXaOOo24UdjRU+VbRRZRogLt68s2vdA1F5a9
         lRcg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0ZBnqYnLAOUVE0vzq+yXP2HldytRhUjYRP8n/EpsIs5SMWoTufD37cubvv5/FbyTgDfZJiZiOlG2vemA9eX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzgFyjuWV0x8k4OV340S7ZeTx3uAeKp9Y1kJEbzMSb54MLe4h2
	x2MLFwd9/pGKSwXmiAY4JX9t4vqtThxrJfUo6n7w5XA3QVq4CwIbSlzQt3ok7ONISKysqfTpJ4M
	+MNEohhaCc3NyqwAqVn6xHI5041Jq9TXXMyqXRNhgIUmtz7/zmxzS6JkdaJXCAgSZJWF4jkY=
X-Gm-Gg: AfdE7clRCWqwezZOK80z/gf1IuGHrj4J0PQyJrnbDqX0xcH/UV0pt9Q70dmIxm/3uas
	1YtIhtvnwhkxMj5GmK6dYUHwXQa9xel+EZBCw8EoQ+R62g8M2cuOLdkOf5CEkjJuZcAWWTXJihS
	QZYzpBHOjhcDXM2fsNgVdpI2jDP/B3DwzvyhS7xuhP7mNgSk6C8ZEB4o+0n9S0AMf24wE+Mh1WW
	Q1rqtGt2BYX5C41K/2JD1E1OQ9R+Y9AUJg3+iU8eKS7WdEwkyi/toH2LlBcgvOVoBAmb9qome9i
	w8HPg2/BiAZA91RFUr3rApetYs8gUWuIoCn829IBz9wY0mbkNLu2mFanseEqvZnJxDoMozbgGpd
	QcV+sJWHgxZNXUAl++HbieMoRXg8F+mkwhHQNSUOJkaYEPQPhaB5PBcnD3uhaMslO/yvJj+AegK
	oMlNVh+D2B0gxft6fIdOO/sZWzMuI4uZmBSsQKJPuqrWvT3eafIPzLY40+JyfaOA==
X-Received: by 2002:a05:622a:11:b0:516:dc75:1aca with SMTP id d75a77b69052e-51caa1286d1mr26301211cf.26.1783674306937;
        Fri, 10 Jul 2026 02:05:06 -0700 (PDT)
X-Received: by 2002:a05:622a:11:b0:516:dc75:1aca with SMTP id d75a77b69052e-51caa1286d1mr26300891cf.26.1783674306432;
        Fri, 10 Jul 2026 02:05:06 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm259932266b.36.2026.07.10.02.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:05:05 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:04:53 +0200
Subject: [PATCH v4 7/7] arm64: dts: qcom: agatti: Add OPE node
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-camss-isp-ope-v4-7-51207a0319d8@oss.qualcomm.com>
References: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
In-Reply-To: <20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 7pf10Lv1kteYa3digiauGa4PKdNkaCCp
X-Proofpoint-ORIG-GUID: 7pf10Lv1kteYa3digiauGa4PKdNkaCCp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX4pYN3l0MQmvu
 03xRJ+WMBRiij7EMWj6EbVCJ/yNwNB1+Ag0ixAPGIPEFsnWOB7OAMYqqyGy9NJl2pGB3SkOIfck
 vabjOf7cXCLXKPTOeMU1Fo+yJaNhop8=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a50b5c3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1BEw5LmG3YzgyHxDt7YA:9 a=iG3BWBHXWT8vAauT:21
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4OCBTYWx0ZWRfX6FmV5T5mkh4O
 g/A18Q7+dRU5OqVugL7xNFhXX6j2hWMqx/L7QalHkmcBABu+WeeD5H9IeXb55Plr+NWFGAwaasQ
 HbtYrpFFy/Va00Rgf9snpGEZvbezn379RTf2JNv/5XRxETm0xkNkNJOET+AismZKxoBImQD2AEx
 4XncybdOY2atxGVl1vIx1xY4vp30lg/Xi5Tcpl8FMRkumLn209xO2ptCvrWMzjymjcZVQ88aHJZ
 0bDTtE/PXhTYk7O5WJdH7V2OaercoDXU/esOp/e+g8arSrHxONqcvJJC71pVoCm1pdwom6s5SYa
 fgTpdHmT04rtE35VZ7BjysPZqvpZdKQL2ZehFnmz7iN/RAVEz9Ym8tOD24HDrXLSLRqxDoU0T4/
 GzSW0Kua85z7Q6xWZsJSbJy4O+8YkbfpWPioKn/eLZCxOEe5l3CgHU3aveqZTeGEsLEefW1wDqJ
 MobFNHrr4oFgpPhx+RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100088

Add the Offline Processing Engine (OPE) device tree node for the
Agatti platform (QCM2290). The node describes the five register
regions (top, bus_read, bus_write, pipeline, qos), clocks, interrupt,
interconnects, IOMMU mappings, and OPP table.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/agatti.dtsi | 74 ++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/agatti.dtsi b/arch/arm64/boot/dts/qcom/agatti.dtsi
index f9b46cf1c6462a89784429565e1636ce2ba68d73..87bdf9df4b16f7f1b9a5129cf8cd81da1ca9da97 100644
--- a/arch/arm64/boot/dts/qcom/agatti.dtsi
+++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
@@ -1935,6 +1935,80 @@ port@1 {
 			};
 		};
 
+		isp_ope: isp@5c42400 {
+			compatible = "qcom,qcm2290-camss-ope";
+
+			reg = <0x0 0x5c42400 0x0 0x200>,
+			      <0x0 0x5c42600 0x0 0x200>,
+			      <0x0 0x5c42800 0x0 0x4400>,
+			      <0x0 0x5c46c00 0x0 0x190>,
+			      <0x0 0x5c46d90 0x0 0xa00>;
+			reg-names = "top",
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
+			iommus = <&apps_smmu 0x820 0x0>,
+				 <&apps_smmu 0x840 0x0>;
+
+			operating-points-v2 = <&ope_opp_table>;
+			power-domains = <&gcc GCC_CAMSS_TOP_GDSC>,
+					<&rpmpd QCM2290_VDDCX>;
+			power-domain-names = "camss",
+					      "cx";
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

