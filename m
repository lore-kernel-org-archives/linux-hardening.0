Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7A388895
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 05:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055097; cv=none; b=HHwNCi/0yUNTpd2VtxJgsjA+5MvsTueAvP7pXov5Tn1/gogS8i40EXTrAH0W1+H3bpZ/T/Fi5BO9H1HgmygixcleJrvw8VLpAbywR/+k7/C+ill5jvAtPMf9/FwSsW5uIdz2Kjnri3cQgszY921eXH9TCaeABIY6XMA8rHpIEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055097; c=relaxed/simple;
	bh=ABIa2dnZxJbkTD7vqVOMfkjbVDGiXVjQk1hCuVnse1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kpnAiZd4phK6HcAb29ZAEFWq+L95b6Oq9GJ6kU9OMVLihQ9KTVfd4kvwdtptN7nxALq51CfapsLSpFrqA8M2zhPW56PpbaNZw4+k893AILbnAAtylFH5kyl81eT6NIXFht/o8TNhrsCI0235RWKOCZKdXLi1GXv3aHDmFpzWIJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T9PXqbS5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C377dvxS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T9PXqbS5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C377dvxS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663438xV2839011
	for <linux-hardening@vger.kernel.org>; Fri, 3 Jul 2026 05:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yaM6ECTNt+y7sLb5IR1bYHVjHz4BwlWWghAHWGeWZI4=; b=T9PXqbS5zFqPbSOI
	TchufIj0UyPDKBvN3eNQwjqgYZwUsW8RyTyiyK+JMVilcxetDqFiazu6kG5x7VZb
	Hr4DV5R/3u+z4ZEKCCqaXBMk+42Q0mt2YpSFdUXI8Az4U8Aji5xeEpgWoyGowDEX
	QCHGK8eIA4GlWNaF5Dgq/z9RXY7+Ub2zAotiWkTbfOUSKUfkx3caaRNSONEMMWPs
	pG03As/2kX4VaQeV+MUn4kcO++eZIPxht7xsfdtj1Bc6a9SkseZSipAmeaW0umz2
	CAnK9f0WmskxWVITV3A6f4C4NLwl/Yx/RnAz8iM7rhxID3pdUtkOFvAuanKnnzdo
	1Gpf+A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5mvwvdhd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 03 Jul 2026 05:04:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37fccad2b01so755215a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 22:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783055081; x=1783659881; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaM6ECTNt+y7sLb5IR1bYHVjHz4BwlWWghAHWGeWZI4=;
        b=C377dvxSZYaI+otihL2u+09/AYQaobUnP5MteLo+XMLdh1ddhTSxrjt6uU8C/GjVgp
         7BaUnET3F6lP5jWrnqPTFy5+AssOeJoBn5g/qNLrio07em0H+NmToR6EcuEe172XTEmf
         sWQouL+08G3iyzV51eXTWAngzkctJE2182pImoBGtRw+hRSO0O+UzYm6FNko8kKCtYvj
         CDvzYA1j8d5fuLUu79n/0XvKqByUg82ql67oP9TiXOMQj3jUYkhZcbsYYJwjZCdDYnc0
         VS6EqRDOi3Pp1jRfbWpFn7OcqQL0LGfKNehwL5yjNU4L+UK4xc8LXHguoVshxIzIFd91
         2Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055081; x=1783659881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yaM6ECTNt+y7sLb5IR1bYHVjHz4BwlWWghAHWGeWZI4=;
        b=YAhGS20Y9d/ueLek1twdO5wAE7RPugHcO+sOdLVacDTyUW9HNxz9DZAbFB8mBB/qoP
         ee5/yZ2kC/vWgU+vVrtd7z6O1uv8/M0892+L5bJ9MqeY/ucVVhk19I20i76ii1Y6KMZt
         kM5/lxn7AUvkWNB6U1wO78kVCFBTT8wBTYYe9CK7QY+ZC5SxeGWMKHGsas2cDehEYYz2
         hXo7N7oGcAi3eEEiQ3wbwgCX/aH7PKjG9aunF2bkeBu0RoW8IYdUHgQCkeN8MBkstqAm
         o4+ua/ScLMlmAPLZdqhcXEBeh5PoMluX0wTG8E6lDlzJPj8sJYSIuZSUchdG/jZdLHrM
         qlyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpFGnOgTHBESxqcNLybZLaqLCAY5Hv+3jNKHNZ8GOBV7+66VC6BXqWUtBP1UBztA6kq+WQrR0rGoVSf+o5uAHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySpgnQKZvRipZ+6qMXY99D9NWV+xcBP2MgX/mmVc3GcyvVLu+m
	6oLx5kGNPj8ctMmA/R98xHaefaZWDtTkXfqjNeTBYsLf3egrZzocOenefvf87cRibeZ0+p5Wflu
	ESBsZavx/9AVOXHDJGCSVvZWCuFlyrabx7Aemas+zRpF8w+7o4tDroaZZ+yiiUFaws3leQtw=
X-Gm-Gg: AfdE7cn4qE+/C5fsqg9mhxxkeZ5gVSbgj+Q1wCFqW73NAulvZSWIYK0cxCH2rwus4Ao
	4zap+tIYZoVhMCWqnrSydLZNFz8O6DBVyTXftlCscsNmxVTV8byaHNDhbPBiGLMIOYvTdNAHwhd
	/ZjrbsCdSJMGZop81orkbwTzBZU8BqTnK9nqoW0typiiRBCbZni/g0kA7VmEd5te9XIJzBUaiIN
	cpoyrh7ipIYYGytEI3vW2nFM5hjBr1GIaQ/kO8fDOuRMx+lR37N5NtfddzhfsguQQizqPmg+OS1
	CnkXO4xfWWzZ9PNhZFV/2CVuRfqgMfXZTrASpyx3VURvFNUP4GSA6NWEz4On701Nw9XzpfSijJb
	hjM1fmc0shTRMGQz+7uLIwCR69T/NZeb/VkNVnA9W
X-Received: by 2002:a17:90b:5845:b0:380:7763:3b16 with SMTP id 98e67ed59e1d1-380ba9453c6mr8281707a91.19.1783055080831;
        Thu, 02 Jul 2026 22:04:40 -0700 (PDT)
X-Received: by 2002:a17:90b:5845:b0:380:7763:3b16 with SMTP id 98e67ed59e1d1-380ba9453c6mr8281673a91.19.1783055080342;
        Thu, 02 Jul 2026 22:04:40 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbd2362sm16771941eec.20.2026.07.02.22.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:04:39 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 10:33:12 +0530
Subject: [PATCH v4 09/10] arm64: dts: qcom: monaco: Enable CDSP cooling
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260703-qmi-tmd-v4-9-3882189c1f83@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
In-Reply-To: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783055015; l=4833;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=ABIa2dnZxJbkTD7vqVOMfkjbVDGiXVjQk1hCuVnse1M=;
 b=C3B3kXOPyMnurF2RpED0IwL8hSGIsqTdUydr1v1qHP2nQzRzcLOKVf8dJbsnt6PsED3sarXiu
 FAKixSDQXR3BO63VF+TbkcCa0Aki7qTV69fqwvkOC899zXbH60BXSvb
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-GUID: tQobm9kI7DiZOhZpu3Gl1UrdjIAUHL-p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfXxQAc8jHG2gYg
 OV97yhTzl/zojS+W650S/CTYX8P45AFxi2yJ9fsm0uHm1JY7BKkyB3/B1K7fYT9fp68QGjSYTks
 dMN8MkYzkMq/NgA339X9RLE+eQ2/QVUGib2+/kHxPJGEse0i6H+mre1xY0wVEfBQztiG4Zk/2jK
 F0m8L2tOIi1AyawVtU6FR9b0QKJR3FutoA2yhNS1kPOKI5lBBKUb9b/c86I4WSqjLg/MvK5OwcM
 iMH6Ltsd5LnEMfmPT+19/ktHj6cW6ZyTFUpC806B+ZFdobNqq03lbBWhY2UVbTSDLZWVh+Aj9M8
 5yHk1/ewMh9czjdvADBndL0AAMXsL48Z/3kpdCp3DObA9AnOddRf236PQdyTYydcxxu1VO9WYyI
 e2WMAaNwcuW0DJY3S0JUmKnSnIl96n+8u5aBlzXhZCzYga0THXu8bBVs6W85PDWcHmwS8Wmr3lx
 ysvlR0aRIVZ4YPZvF9w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA0NSBTYWx0ZWRfX+7PxjprdYoCp
 aldLxzdWBPy2a8DmDdORlrS0st22tA+HoAECToeCXl9wB6H97Ax/P4xdXJPDSvsGYHgzbOXgw3A
 vHDeycuMeHO1f/B6gGbg75caNFUqWdM=
X-Authority-Analysis: v=2.4 cv=N+UZ0W9B c=1 sm=1 tr=0 ts=6a4742e9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=WTijfvStGCArOK70lPgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: tQobm9kI7DiZOhZpu3Gl1UrdjIAUHL-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030045

Unlike the CPU, the CDSP does not throttle its speed automatically
when it reaches high temperatures in monaco.

Set up CDSP cooling for both instances by throttling the cdsp, when
it reaches 115°C.

Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco.dtsi | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
index e4c8466f941b..4576f9670962 100644
--- a/arch/arm64/boot/dts/qcom/monaco.dtsi
+++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
 #include <dt-bindings/clock/qcom,sa8775p-videocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,qmi-tmd.h>
 #include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
@@ -7728,6 +7729,8 @@ remoteproc_cdsp: remoteproc@26300000 {
 			qcom,smem-states = <&smp2p_cdsp_out 0>;
 			qcom,smem-state-names = "stop";
 
+			#cooling-cells = <3>;
+
 			status = "disabled";
 
 			glink-edge {
@@ -8160,39 +8163,87 @@ cpu-critical {
 		};
 
 		nsp-0-0-0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens2 5>;
 
 			trips {
+				nsp_0_0_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_0_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
+				nsp_0_1_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_0_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-0-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
+				nsp_0_2_0_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_0_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-0-thermal {
@@ -8280,39 +8331,87 @@ cpu-critical {
 		};
 
 		nsp-0-0-1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens3 5>;
 
 			trips {
+				nsp_0_0_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_0_1_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-1-1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens3 6>;
 
 			trips {
+				nsp_0_1_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_1_1_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		nsp-0-2-1-thermal {
+			polling-delay-passive = <200>;
+
 			thermal-sensors = <&tsens3 7>;
 
 			trips {
+				nsp_0_2_1_alert0: trip-point0 {
+					temperature = <115000>;
+					hysteresis = <5000>;
+					type = "passive";
+				};
+
 				nsp-critical {
 					temperature = <125000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&nsp_0_2_1_alert0>;
+					cooling-device = <&remoteproc_cdsp QCOM_CDSP_TMD_CDSP_SW
+							 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 
 		ddrss-1-thermal {

-- 
2.34.1

