Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973352;
	b=P+7IcLlBLZAjV+TQjgfKiIKLJKbJTYrNO9LyAPCdvY13yBtjGliASPyBF7Wm7Biz26YY
	 HzGKR/n0O8i6UZRUlrxFl8TPmjnhX6CF3jUdw6H0MUI0U+UnCIYTFCgPUUnU7FNKAHdnT
	 bl9WxdQIz+oFw1yrDPB+BhQ+Fa9Hj9LUCb4JmVlu5wgDelwvJzZktxNkLefYxUZpfv5It
	 ZnPJVmvY2EEBmXaIs9YL4tWz0JQxYTsd3WR8EL56QKq6XS7qZTndAo6OfYemXVseXHPOL
	 xSOMjB0ZmTgue5G3S2W7zJ6O8zoqyvEBEqm3gx8p4rZ6R6Go65L/fJ93hXgpL0C/KmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973352;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AaPu75VxAelYWmNT9iLf5IxjvCSV29MNI69Nn2jsYO8=;
	b=PtBxUhJKmx7uY655Aph1oI1WajC/aVQoYp9WV3AiMqtxwFcMJUwrhedFwYvDlXzZi68U
	 ce9l9AI4CWAdbMZgd6xBgcC+TMjhe76onUefvU79IXBIFgDqD1mTpFy5dThVypPQq4orO
	 okuLZpB+dtUMfs8BOKNMY37IkOpG158VNQtal0Babr5a6PLKo+/a+CC5P+gYEqXTWDsIM
	 K8Ko9tTxTAJUIAtAfXT1CavQFUfzXkzDGW5nsRaAQ1H7fvxof7MNTrc72m9MoI0mLP5LV
	 kyLSFSKJxmv7bwyYcGVI/pJBJPJCJfm43dsfoAFT6Zn9KlhG2XROXYpSoV4K/67scaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQoC877H;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="e/qafvTI";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CF76082BED
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CF76082BED
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQoC877H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=e/qafvTI
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoH3f3173950
	for <linux-hardening@vger.kernel.org>; Fri, 6 Nov 2026 13:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AaPu75VxAelYWmNT9iLf5IxjvCSV29MNI69Nn2jsYO8=; b=DQoC877H8WLo/sRk
	r/lnJ/u/crSoiVTKnVhRYCxxizwCG7E9EIOohkuRTNecNQ0kFFrKRktCDnMWHxNH
	ZHYJBl7ROFBp7en3IXgOoKM0kxhAwI1aX9OeUV5+jtsiuAgwkq96NHrWYeBxYQdM
	NARgMePbQrSeGBXJzxTZDhFe/BHPpMJSVWOcRVB7Az4W18CTZJWgNOl3gNoYF4PR
	/m8pKlUqjaiC5KSlwK9733R4ZMcrWHWpVbz2s82bnumXvmP/e0CCZ/TZXpgLFVLX
	UPSStKjqysG4WzX83ZpZuYYbP4THq4xlaui4qvZNaAUqpVJjWzjULX1OQ35OrqpM
	ZU17EQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9b37n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 13:55:49 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-99b715e4f44so37152241.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 05:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973348; x=1794578148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AaPu75VxAelYWmNT9iLf5IxjvCSV29MNI69Nn2jsYO8=;
        b=e/qafvTIRcrdWmDdIafXI7/dx3bB1l8aey4fob6fVgwITlsYTL+DIwA3kxlK8uAg16
         eVnT/b+wOudz8kxsoPMyvNIFENlz7qlqwL+Q0aE0ioVsAgXV7dsV0wMSWQm7qdqwKGks
         dHYrVdl7xK2OkkYHhpzP+Zg+OLqVQ/4IjCqElJ4aDpZABMIdtngA2hDjmw/Qq2D22elS
         LVBtsiNk7yx0+K+5mZXZiY10C+sTgQggQtSuJESJNEV3TcHtY5WZVqvaMu3dAOpsahfC
         lY2aGrlf6nlSZxZHLn/5UFUd/UQatRu4uzFxTJJKT/IQIazarlo/kp7iSNh6WN+hA73d
         kRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973348; x=1794578148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AaPu75VxAelYWmNT9iLf5IxjvCSV29MNI69Nn2jsYO8=;
        b=PkSnsXY4iiyAWrdQmsFRZNFTTNmNb1wWqXJXVP00WBmqxwMQD3+rpL4U9DCB802CU7
         0WEGjVEI0ov7O3kwxW9t09mR7giVbwKv0qt+1j3Wm1Tvg89SkpH6LMhGBqWLcyJtwNjS
         TOO7OC24cRjD9Mh0xUWTBSQEA3qCLRg8Wj3yxodrqAeJGMsBm0CSGCdxhSbVpMcS80J+
         mteLcqnrdmLYS0G3eQNTb1wGa7iU8CD6W4fRtRaV2XGhrBe7szWNXrCHbeCioJAuJqKG
         Shn0ZnKDBwYxQdImzv/j0j+pqDS0JRWfYbHQKWYz0bE03fOFNI8BFCFggeiAIrFLG/1r
         VjDA==
X-Forwarded-Encrypted: i=1; AKwUvBz6h0uA1BXu1K9akUJa0tIq4+WZUXNfu4gnLR+HTWmiajUlP/mjY/Dej9GL9M4JKrgq33zIOiER3Cbjop8zd4s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tHvrHyc5DCe+qOCKEBnjEURVXdF7IH2ZnechmyzH9iaRHTWh+
	/ylbfB6GAtzP/h5iDeOVxLqzY2Eu8p+By5DZsVL3nc5C9ClfwT0YOIfOn8WhoFTW+RItuarAifd
	Q3ZKfpzrytt7xW8xxwXcQkjataSDlmZG2ADWlLcrNm1sil5ToyXGFhIJS0q1nRROf/ezyjLk=
X-Gm-Gg: AYBFou2OzELcXYvKFa7SB1tohAY5dKCTUoQranOKgtFa8/2HDq8ELVo+q2i3Id/3EBQ
	Tr5rpQLs8IHoxkvsZnw0QFPVexLvl9jBLmVIdy/un8mGL8cPhDfwYBIHrKY36VC7VjVTFX7SRus
	Z0YmmpMZEkzJ+J4F6gJ5hFWFdE41WrOWY1YkW/5/sRwb33e2HqGYTw9gLXnu5MPYR6D8fliSMe/
	2vxut7uCSmEJr7ZKuJ7jsm86ln5cmj2nhtY4iRvTOb8K4HY7xBuF9/jw8KVPHvEqyeoMo3AQNMk
	N8l6kXExcEIjv6ZeA1SDUvzzQRABehj6V905CqXtmubaYhuBmtk/AOFgbOf1Wbts/OhVcZC2nhX
	XerncvmvOtz5DTXUaxzxpYdy8RLIg5m+R7AxxlnCJC+nHLkj+z20V42XRPPI3X3x6nx50p9oboC
	N4kN4G0eFgttF9XGcDxwetrqNYwixY9szkkTmPl/0H2wWFDdOikARr2+ZLEcStL+1gBc89NNmfG
	Wt3wke+3I/472ELU1j5TqR+OF7n
X-Received: by 2002:a05:6102:3f9f:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d2a15715c3mr1223547137.15.1793973346012;
        Fri, 06 Nov 2026 05:55:46 -0800 (PST)
X-Received: by 2002:a05:6102:3f9f:b0:7cc:174b:f7bc with SMTP id ada2fe7eead31-7d2a15715c3mr1223509137.15.1793973344358;
        Fri, 06 Nov 2026 05:55:44 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm3963256f8f.51.2026.11.06.05.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:55:42 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:55:22 +0100
Subject: [PATCH v14 6/9] media: qcom: camss: Add CAMSS Offline Processing
 Engine driver
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-camss-isp-ope-v14-6-49c426cd2715@oss.qualcomm.com>
References: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
In-Reply-To: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
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
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: H_4ZfD1Vi4cc1GPP9HTWsSqfKuYEvHgl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX4j/R5WPUoi5g
 s8AMbKY8aZWSG8pPiI+CCqa2sLBs38eHQ6Sf4qwwkd7873AE2psB/IZ84KM6d0/UZliWz4IbI9J
 VqxqFNy1b8aitCHQWyvdzKJC0k+sSJwB5+GzSMNYzo4hST7BFLO6V6tnuQanBZDZZ++NOf0lVye
 /fjZDtiK8uXI2EQmtdqatd8GIDB0Pvr5MMecSx8Yej16Ns1TjbE12x/ylgkFmCa0W4aAFCqNd1N
 EdSQoJ5ZiEFH1JfC/5zLntnh7D8vLbE/NFanYIgWVgHUC8rlEmzJVKYhP3A4bmhCYNw/yFZg6ZR
 n4TWIxAyZdjaikjL6iCE9VPZpwRWJUI01lvlz2cIkAthFNgZ4KKmXIn31p5tXY4y9v0NCXrew36
 Gljns6wOQovfidn0ag9RVHZBIvGWbWfILIW374pW7M/ltlb9XsAQZXVrS72740/K+FdMMbEDgTh
 GUHfKJ1uqcF4lQ5mO0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX/WDp/heOE8EH
 4PkAD1prUjSZ0gO0V1oBNkRLlPzhWm5QBptxMearMKpivpclsXUqdTiE4mWSY89Z/it8/o6/JGy
 aWl0YYoXhm8Pc3IPlJ6diTQfOWhvypw=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aeddc65 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=Gfv5YTIK3ZGOh__6mfIA:9
 a=nsvEtg1wbKX51V2b:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: H_4ZfD1Vi4cc1GPP9HTWsSqfKuYEvHgl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060055

Add an image processing driver for the Qualcomm Offline Processing Engine
(OPE). OPE is a memory-to-memory ISP block that converts raw Bayer
frames to YUV, performing white balance, demosaic, chroma enhancement,
color correction and downscaling.

The hardware architecture consists of Fetch Engines and Write Engines,
connected through intermediate pipeline modules for pix processing.

The driver exposes three video nodes per pipeline instance:
  - ope_input: Bayer RAW input (V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
  - ope_disp_output: YUV output     (V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
  - ope_params: ISP parameters (V4L2_BUF_TYPE_META_OUTPUT)

Hardware features:
  - Stripe-based processing (up to 336 pixels wide per stripe)
  - White balance (CLC_WB)
  - Demosaic / Bayer-to-RGB (CLC_DEMO)
  - Color correction matrix (CLC_CC)
  - Gamma LUT (CLC_GAMMA)
  - RGB-to-YUV conversion (CLC_CHROMA_ENHAN)
  - MN downscaler for chroma and luma planes

Default configuration values are based on public standards such as BT.601.

Processing Model:
OPE processes frames in stripes of up to 336 pixels. Therefore, frames
must be split into stripes for processing. Each stripe is configured after
the previous one has been acquired (double buffered registers). To minimize
inter-stripe latency, stripe configurations are generated ahead of time.

The driver is split into three source files under the ope/ directory:

  - core.c: the OPE m2m driver itself: probe, power management, V4L2/media
    device setup, format handling, stripe generation and hardware
    programming.

  - pipeline.c/.h: a small declarative media-controller topology builder.
    Drivers describe their entire media graph, entities (video devices,
    subdevs, or base entities), their pads, and the links between them, in
    a static descriptor table. The builder validates the table, allocates
    and registers all entities, and creates all MC pad links. It is kept
    generic but currently only used by OPE.

  - params.c/.h: V4L2 ISP parameter buffer validation and dispatch. It
    wraps the extensible V4L2 ISP parameters buffer format, validating
    the buffer size and each per-block header before forwarding every
    block to its driver-supplied handler.

A userspace libcamera support can be found at:
https://github.com/jwrdegoede/libcamera/commits/camss_pipeline_v2.2/

A test tool, camss-isp-m2m, can be found at:
https://github.com/loicpoulain/camss-isp-m2m-test

Assisted-by: LLM
Co-developed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Co-developed-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Link: https://github.com/jwrdegoede/libcamera/commits/camss_pipeline_v2.1/
Link: https://github.com/loicpoulain/camss-isp-m2m-test
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 MAINTAINERS                                      |    1 +
 drivers/media/platform/qcom/camss/Kconfig        |    2 +
 drivers/media/platform/qcom/camss/Makefile       |    2 +
 drivers/media/platform/qcom/camss/ope/Kconfig    |   18 +
 drivers/media/platform/qcom/camss/ope/Makefile   |    9 +
 drivers/media/platform/qcom/camss/ope/core.c     | 4123 ++++++++++++++++++++++
 drivers/media/platform/qcom/camss/ope/params.c   |   78 +
 drivers/media/platform/qcom/camss/ope/params.h   |   95 +
 drivers/media/platform/qcom/camss/ope/pipeline.c |  410 +++
 drivers/media/platform/qcom/camss/ope/pipeline.h |  242 ++
 10 files changed, 4980 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 234c4c69dec7e7264763f1970438c22d0cec11a1..4abd98705e51dde539cc89363b4d0cefd10de5a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22910,6 +22910,7 @@ F:	Documentation/admin-guide/media/qcom_camss.rst
 F:	Documentation/devicetree/bindings/media/qcom,*camss*
 F:	Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
 F:	drivers/media/platform/qcom/camss/
+F:	include/uapi/linux/media/qcom/camss-config.h
 
 QUALCOMM CLOCK DRIVERS
 M:	Bjorn Andersson <andersson@kernel.org>
diff --git a/drivers/media/platform/qcom/camss/Kconfig b/drivers/media/platform/qcom/camss/Kconfig
index b51745c942c9fd71a95d09993213bde4b7e877e2..b66faac2683c9d52a4320d082b0e13970057dded 100644
--- a/drivers/media/platform/qcom/camss/Kconfig
+++ b/drivers/media/platform/qcom/camss/Kconfig
@@ -9,3 +9,5 @@ config VIDEO_QCOM_CAMSS
 	select V4L2_FWNODE
 	select GENERIC_PHY
 	imply PHY_QCOM_MIPI_CSI2
+
+source "drivers/media/platform/qcom/camss/ope/Kconfig"
diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 27898b3cc7d3c8f275567f81f0952e2a0e18f189..b79c40626c401767fe31b3a2fc68c1db38a5a11d 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -31,3 +31,5 @@ qcom-camss-objs += \
 		camss-video.o
 
 obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
+
+obj-$(CONFIG_VIDEO_QCOM_CAMSS_OPE) += ope/
diff --git a/drivers/media/platform/qcom/camss/ope/Kconfig b/drivers/media/platform/qcom/camss/ope/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..72fda2a31a14c52b8700261c9d95fb0a053a9dcb
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/ope/Kconfig
@@ -0,0 +1,18 @@
+config VIDEO_QCOM_CAMSS_OPE
+	tristate "Qualcomm Offline Processing Engine (OPE) driver"
+	depends on V4L_PLATFORM_DRIVERS
+	depends on MEDIA_CONTROLLER
+	depends on VIDEO_DEV
+	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
+	select V4L2_ISP
+	select VIDEO_V4L2_SUBDEV_API
+	select VIDEOBUF2_DMA_CONTIG
+	select VIDEOBUF2_VMALLOC
+	help
+	  Enable support for the Qualcomm Offline Processing Engine (OPE).
+	  OPE is a memory-to-memory ISP block that converts raw Bayer frames
+	  to YUV, performing white balance, demosaic, chroma enhancement and
+	  downscaling. Found on QCM2290 and related SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called qcom-camss-ope.
diff --git a/drivers/media/platform/qcom/camss/ope/Makefile b/drivers/media/platform/qcom/camss/ope/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..02599a7b46e17640cbdda8600c95bb268ef8ab31
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/ope/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Makefile for Qualcomm CAMSS Offline Processing Engine (OPE) driver
+
+qcom-camss-ope-objs := \
+		core.o \
+		pipeline.o \
+		params.o
+
+obj-$(CONFIG_VIDEO_QCOM_CAMSS_OPE) += qcom-camss-ope.o
diff --git a/drivers/media/platform/qcom/camss/ope/core.c b/drivers/media/platform/qcom/camss/ope/core.c
new file mode 100644
index 0000000000000000000000000000000000000000..11dca901e0f652677966a6d535a19cea17f783fb
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/ope/core.c
@@ -0,0 +1,4123 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ope/core.c
+ *
+ * Qualcomm MSM Camera Subsystem - Offline Processing Engine
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/*
+ * This driver provides driver implementation for the Qualcomm Offline
+ * Processing Engine (OPE). OPE is a memory-to-memory hardware block
+ * designed for image processing on a source frame. Typically, the input
+ * frame originates from the SoC CSI capture path, though not limited to.
+ *
+ * The hardware architecture consists of Fetch Engines and Write Engines,
+ * connected through intermediate pipeline modules:
+ *   [FETCH ENGINES] => [Pipeline Modules] => [WRITE ENGINES]
+ *
+ * Current Configuration:
+ *     Fetch Engine: One fetch engine is used for Bayer frame input.
+ *     Write Engines: Two display write engines for Y and UV planes output.
+ *
+ * Only a subset of the pipeline modules are enabled:
+ *   WB: White balance for channel gain configuration
+ *   DEMO: Demosaic for Bayer to RGB conversion
+ *   CC: Color Correct, coefficient based RGB correction
+ *   GLUT: Gamma LUT, redistributes brightness levels
+ *   CHROMA_ENHAN: for RGB to YUV conversion
+ *   DOWNSCALE*: Downscaling for UV (YUV444 -> YUV422/YUV420) and YUV planes
+ *
+ * Default configuration values are based on public standards such as BT.601.
+ *
+ * Processing Model:
+ * OPE processes frames in stripes of up to 336 pixels. Therefore, frames must
+ * be split into stripes for processing. Each stripe is configured after the
+ * previous one has been acquired (double buffered registers). To minimize
+ * inter-stripe latency, the stripe configurations are generated ahead of time.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/interconnect.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+
+#include <media/v4l2-device.h>
+#include <media/media-device.h>
+#include <media/v4l2-ctrls.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-rect.h>
+
+#include "pipeline.h"
+
+#include <media/videobuf2-dma-contig.h>
+#include <media/videobuf2-vmalloc.h>
+
+#include <linux/media/qcom/camss-config.h>
+
+#include "params.h"
+
+#define OPE_NAME	"qcom-camss-ope"
+
+/* Format descriptor */
+struct ope_fmt {
+	u32		fourcc;
+	unsigned int	depth;
+	unsigned int	align;
+	unsigned int	num_planes;
+	u32		mbus_code;
+	unsigned int	c_hsub;
+	unsigned int	c_vsub;
+};
+
+/* Per-queue format state */
+struct ope_fmt_state {
+	const struct ope_fmt	*fmt;
+	unsigned int		width;
+	unsigned int		height;
+	struct v4l2_rect	crop;
+	unsigned int		bytesperline;
+	unsigned int		sizeimage;
+	enum v4l2_colorspace	colorspace;
+	enum v4l2_xfer_func	xfer_func;
+	enum v4l2_ycbcr_encoding	ycbcr_enc;
+	enum v4l2_quantization	quantization;
+	unsigned int		sequence;
+	struct v4l2_fract	timeperframe;
+};
+
+/* -------- Register layout -------- */
+
+#define OPE_TOP_HW_VERSION					0x000
+#define		OPE_TOP_HW_VERSION_STEP		GENMASK(15, 0)
+#define		OPE_TOP_HW_VERSION_REV		GENMASK(27, 16)
+#define		OPE_TOP_HW_VERSION_GEN		GENMASK(31, 28)
+#define OPE_TOP_RESET_CMD					0x004
+#define		OPE_TOP_RESET_CMD_HW		BIT(0)
+#define		OPE_TOP_RESET_CMD_SW		BIT(1)
+#define OPE_TOP_IRQ_STATUS					0x014
+#define OPE_TOP_IRQ_MASK					0x018
+#define		OPE_TOP_IRQ_STATUS_RST_DONE	BIT(0)
+#define		OPE_TOP_IRQ_STATUS_WE		BIT(1)
+#define		OPE_TOP_IRQ_STATUS_FE		BIT(2)
+#define		OPE_TOP_IRQ_STATUS_VIOL		BIT(3)
+#define		OPE_TOP_IRQ_STATUS_IDLE		BIT(4)
+#define OPE_TOP_IRQ_CLEAR					0x01c
+#define OPE_TOP_IRQ_CMD						0x024
+#define		OPE_TOP_IRQ_CMD_CLEAR		BIT(0)
+#define OPE_TOP_VIOLATION_STATUS				0x028
+
+/* Fetch engine */
+#define OPE_BUS_RD_INPUT_IF_IRQ_MASK				0x00c
+#define OPE_BUS_RD_INPUT_IF_IRQ_CLEAR				0x010
+#define OPE_BUS_RD_INPUT_IF_IRQ_CMD				0x014
+#define		OPE_BUS_RD_INPUT_IF_IRQ_CMD_CLEAR	BIT(0)
+#define OPE_BUS_RD_INPUT_IF_IRQ_STATUS				0x018
+#define		OPE_BUS_RD_INPUT_IF_IRQ_STATUS_RST_DONE		BIT(0)
+#define		OPE_BUS_RD_INPUT_IF_IRQ_STATUS_RUP_DONE		BIT(1)
+#define		OPE_BUS_RD_INPUT_IF_IRQ_STATUS_BUF_DONE		GENMASK(3, 2)
+#define		OPE_BUS_RD_INPUT_IF_IRQ_STATUS_CCIF_VIOL	GENMASK(17, 16)
+#define OPE_BUS_RD_INPUT_IF_CMD					0x01c
+#define		OPE_BUS_RD_INPUT_IF_CMD_GO_CMD		BIT(0)
+#define OPE_BUS_RD_CLIENT_0_CORE_CFG				0x050
+#define		OPE_BUS_RD_CLIENT_0_CORE_CFG_EN	BIT(0)
+#define OPE_BUS_RD_CLIENT_0_CCIF_META_DATA			0x054
+#define		OPE_BUS_RD_CLIENT_0_CCIF_MD_PIX_PATTERN GENMASK(7, 2)
+#define OPE_BUS_RD_CLIENT_0_ADDR_IMAGE				0x058
+#define OPE_BUS_RD_CLIENT_0_RD_BUFFER_SIZE			0x05c
+#define OPE_BUS_RD_CLIENT_0_RD_STRIDE				0x060
+#define OPE_BUS_RD_CLIENT_0_UNPACK_CFG_0			0x064
+
+/* Write engines */
+#define OPE_BUS_WR_INPUT_IF_IRQ_MASK_0				0x018
+#define OPE_BUS_WR_INPUT_IF_IRQ_MASK_1				0x01c
+#define OPE_BUS_WR_INPUT_IF_IRQ_CLEAR_0				0x020
+#define OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0			0x028
+#define		OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_RUP_DONE	BIT(0)
+#define		OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_BUF_DONE	BIT(8)
+#define		OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_CONS_VIOL	BIT(28)
+#define		OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_VIOL		BIT(30)
+#define		OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_IMG_SZ_VIOL	BIT(31)
+#define OPE_BUS_WR_INPUT_IF_IRQ_CMD				0x030
+#define		OPE_BUS_WR_INPUT_IF_IRQ_CMD_CLEAR	BIT(0)
+#define OPE_BUS_WR_VIOLATION_STATUS				0x064
+#define OPE_BUS_WR_IMAGE_SIZE_VIOLATION_STATUS			0x070
+#define OPE_BUS_WR_CLIENT_CFG(c)				(0x200 + (c) * 0x100)
+#define		OPE_BUS_WR_CLIENT_CFG_EN		BIT(0)
+#define		OPE_BUS_WR_CLIENT_CFG_AUTORECOVER	BIT(4)
+#define OPE_BUS_WR_CLIENT_ADDR_IMAGE(c)				(0x204 + (c) * 0x100)
+#define OPE_BUS_WR_CLIENT_IMAGE_CFG_0(c)			(0x20c + (c) * 0x100)
+#define OPE_BUS_WR_CLIENT_IMAGE_CFG_1(c)			(0x210 + (c) * 0x100)
+#define OPE_BUS_WR_CLIENT_IMAGE_CFG_2(c)			(0x214 + (c) * 0x100)
+#define OPE_BUS_WR_CLIENT_PACKER_CFG(c)				(0x218 + (c) * 0x100)
+
+/* Pipeline modules */
+
+#define OPE_PP_HW_VERSION(base)				((base) + 0x00)
+#define OPE_PP_HW_STATUS(base)				((base) + 0x04)
+#define OPE_HW_VERSION_GEN(v)	((u32)FIELD_GET(OPE_TOP_HW_VERSION_GEN, (v)))
+#define OPE_HW_VERSION_REV(v)	((u32)FIELD_GET(OPE_TOP_HW_VERSION_REV, (v)))
+#define OPE_HW_VERSION_STEP(v)	((u32)FIELD_GET(OPE_TOP_HW_VERSION_STEP, (v)))
+
+#define OPE_PP_WB_GAIN_BASE			0x200
+#define OPE_PP_WB_GAIN_MODULE_CFG			(OPE_PP_WB_GAIN_BASE + 0x60)
+#define		OPE_PP_WB_GAIN_MODULE_CFG_EN	BIT(0)
+#define OPE_PP_WB_GAIN_WB_CFG(ch)			(OPE_PP_WB_GAIN_BASE + 0x68 + 4 * (ch))
+#define		OPE_PP_WB_GAIN_WB_CFG_GAIN	GENMASK(14, 0)
+#define OPE_PP_WB_GAIN_WB_SUB_CFG(ch)			(OPE_PP_WB_GAIN_BASE + 0x74 + 4 * (ch))
+#define		OPE_PP_WB_GAIN_WB_SUB_CFG_VAL	GENMASK(31, 20)
+#define OPE_PP_WB_GAIN_WB_ADD_CFG(ch)			(OPE_PP_WB_GAIN_BASE + 0x80 + 4 * (ch))
+#define		OPE_PP_WB_GAIN_WB_ADD_CFG_VAL	GENMASK(31, 20)
+
+#define OPE_PP_CC_BASE				0xa00
+#define OPE_PP_CC_MODULE_CFG				(OPE_PP_CC_BASE + 0x60)
+#define		OPE_PP_CC_MODULE_CFG_EN		BIT(0)
+#define OPE_PP_CC_COEFF_A_CFG_0				(OPE_PP_CC_BASE + 0x68)
+#define		OPE_PP_CC_COEFF_A_CFG_0_A0	GENMASK(11, 0)
+#define		OPE_PP_CC_COEFF_A_CFG_0_A1	GENMASK(27, 16)
+#define OPE_PP_CC_COEFF_A_CFG_1				(OPE_PP_CC_BASE + 0x6c)
+#define		OPE_PP_CC_COEFF_A_CFG_1_A2	GENMASK(11, 0)
+#define OPE_PP_CC_COEFF_B_CFG_0				(OPE_PP_CC_BASE + 0x70)
+#define		OPE_PP_CC_COEFF_B_CFG_0_B0	GENMASK(11, 0)
+#define		OPE_PP_CC_COEFF_B_CFG_0_B1	GENMASK(27, 16)
+#define OPE_PP_CC_COEFF_B_CFG_1				(OPE_PP_CC_BASE + 0x74)
+#define		OPE_PP_CC_COEFF_B_CFG_1_B2	GENMASK(11, 0)
+#define OPE_PP_CC_COEFF_C_CFG_0				(OPE_PP_CC_BASE + 0x78)
+#define		OPE_PP_CC_COEFF_C_CFG_0_C0	GENMASK(11, 0)
+#define		OPE_PP_CC_COEFF_C_CFG_0_C1	GENMASK(27, 16)
+#define OPE_PP_CC_COEFF_C_CFG_1				(OPE_PP_CC_BASE + 0x7c)
+#define		OPE_PP_CC_COEFF_C_CFG_1_C2	GENMASK(11, 0)
+#define OPE_PP_CC_COEFF_K_CFG_0				(OPE_PP_CC_BASE + 0x80)
+#define		OPE_PP_CC_COEFF_K_CFG_0_K0	GENMASK(31, 21)
+#define OPE_PP_CC_COEFF_K_CFG_1				(OPE_PP_CC_BASE + 0x84)
+#define		OPE_PP_CC_COEFF_K_CFG_1_K1	GENMASK(31, 21)
+#define OPE_PP_CC_COEFF_K_CFG_2				(OPE_PP_CC_BASE + 0x88)
+#define		OPE_PP_CC_COEFF_K_CFG_2_K2	GENMASK(31, 21)
+#define OPE_PP_CC_COEFF_M_CFG				(OPE_PP_CC_BASE + 0x8c)
+#define		OPE_PP_CC_COEFF_M_CFG_M		GENMASK(1, 0)
+
+#define OPE_PP_GLUT_BASE			0x1000
+#define OPE_PP_GLUT_DMI_CFG				(OPE_PP_GLUT_BASE + 0x08)
+#define		OPE_PP_GLUT_DMI_CFG_AUTO_LOAD_EN	BIT(20)
+#define		OPE_PP_GLUT_DMI_CFG_ADDR	GENMASK(7, 0)
+#define OPE_PP_GLUT_DMI_LUT_CFG				(OPE_PP_GLUT_BASE + 0x0c)
+#define		OPE_PP_GLUT_DMI_LUT_CFG_SEL	GENMASK(1, 0)
+#define OPE_PP_GLUT_DMI_DATA				(OPE_PP_GLUT_BASE + 0x10)
+#define OPE_PP_GLUT_DMI_LUT_BANK_CFG			(OPE_PP_GLUT_BASE + 0x58)
+#define		OPE_PP_GLUT_DMI_LUT_BANK_CFG_SEL	BIT(0)
+#define OPE_PP_GLUT_MODULE_LUT_BANK_CFG			(OPE_PP_GLUT_BASE + 0x5c)
+#define		OPE_PP_GLUT_MODULE_LUT_BANK_CFG_SEL	BIT(0)
+#define OPE_PP_GLUT_MODULE_CFG				(OPE_PP_GLUT_BASE + 0x60)
+#define		OPE_PP_GLUT_MODULE_CFG_EN	BIT(0)
+
+#define OPE_PP_DEMO_BASE				0x800
+#define OPE_PP_DEMO_MODULE_CFG					(OPE_PP_DEMO_BASE + 0x60)
+#define		OPE_PP_DEMO_MODULE_CFG_EN		BIT(0)
+#define		OPE_PP_DEMO_MODULE_CFG_DYN_G_CLAMP_EN	BIT(14)
+#define		OPE_PP_DEMO_MODULE_CFG_DYN_RB_CLAMP_EN	BIT(15)
+#define OPE_PP_DEMO_INTERP_COEFF_CFG				(OPE_PP_DEMO_BASE + 0x68)
+#define		OPE_PP_DEMO_INTERP_COEFF_CFG_LAMBDA_G	GENMASK(7, 0)
+#define		OPE_PP_DEMO_INTERP_COEFF_CFG_LAMBDA_RB	GENMASK(23, 16)
+#define OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_0			(OPE_PP_DEMO_BASE + 0x6c)
+#define		OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_0_AK	GENMASK(31, 20)
+#define OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_1			(OPE_PP_DEMO_BASE + 0x70)
+#define		OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_1_WK	GENMASK(9, 0)
+
+#define OPE_PP_DOWNSCALE_MN_DS_C_PRE_BASE		0x1c00
+#define OPE_PP_DOWNSCALE_MN_DS_Y_DISP_BASE		0x3000
+#define OPE_PP_DOWNSCALE_MN_DS_C_DISP_BASE		0x3200
+#define OPE_PP_CROP_RND_CLAMP_Y_DISP_BASE		0x3400
+#define OPE_PP_CROP_RND_CLAMP_C_DISP_BASE		0x3600
+#define OPE_PP_CROP_RND_CLAMP_HW_STATUS(base)			OPE_PP_HW_STATUS(base)
+#define		OPE_PP_CROP_RND_CLAMP_HEIGHT_VIOL	BIT(2)
+#define		OPE_PP_CROP_RND_CLAMP_WIDTH_VIOL	BIT(1)
+#define OPE_PP_CROP_RND_CLAMP_MODULE_CFG(base)			((base) + 0x60)
+#define		OPE_PP_CROP_RND_CLAMP_EN		BIT(0)
+#define		OPE_PP_CROP_RND_CLAMP_CROP_EN		BIT(9)
+#define OPE_PP_CROP_RND_CLAMP_CROP_LINE_CFG(base)		((base) + 0x68)
+#define OPE_PP_CROP_RND_CLAMP_CROP_PIXEL_CFG(base)		((base) + 0x6c)
+#define		OPE_PP_CROP_RND_CLAMP_CROP_FIRST	GENMASK(29, 16)
+#define		OPE_PP_CROP_RND_CLAMP_CROP_LAST		GENMASK(13, 0)
+#define OPE_PP_DOWNSCALE_MN_CFG(ds)				((ds) + 0x60)
+#define		OPE_PP_DOWNSCALE_MN_CFG_EN		BIT(0)
+#define OPE_PP_DOWNSCALE_MN_DS_CFG(ds)				((ds) + 0x64)
+#define		OPE_PP_DOWNSCALE_MN_DS_CFG_H_SCALE_EN	BIT(9)
+#define		OPE_PP_DOWNSCALE_MN_DS_CFG_V_SCALE_EN	BIT(10)
+#define OPE_PP_DOWNSCALE_MN_DS_IMAGE_SIZE_CFG(ds)		((ds) + 0x68)
+#define OPE_PP_DOWNSCALE_MN_DS_MN_H_CFG(ds)			((ds) + 0x6c)
+#define OPE_PP_DOWNSCALE_MN_DS_MN_H_PHASE_CFG(ds)		((ds) + 0x70)
+#define OPE_PP_DOWNSCALE_MN_DS_MN_V_CFG(ds)			((ds) + 0x74)
+#define OPE_PP_DOWNSCALE_MN_DS_MN_V_PHASE_CFG(ds)		((ds) + 0x78)
+
+#define OPE_PP_CHROMA_ENHAN_BASE			0x1200
+#define OPE_PP_CHROMA_ENHAN_MODULE_CFG				(OPE_PP_CHROMA_ENHAN_BASE + 0x60)
+#define		OPE_PP_CHROMA_ENHAN_MODULE_CFG_EN	BIT(0)
+#define OPE_PP_CHROMA_ENHAN_LUMA_CFG_0				(OPE_PP_CHROMA_ENHAN_BASE + 0x68)
+#define		OPE_PP_CHROMA_ENHAN_LUMA_CFG_0_V0	GENMASK(11, 0)
+#define		OPE_PP_CHROMA_ENHAN_LUMA_CFG_0_V1	GENMASK(27, 16)
+#define OPE_PP_CHROMA_ENHAN_LUMA_CFG_1				(OPE_PP_CHROMA_ENHAN_BASE + 0x6c)
+#define		OPE_PP_CHROMA_ENHAN_LUMA_CFG_1_K	GENMASK(31, 23)
+#define OPE_PP_CHROMA_ENHAN_LUMA_CFG_2				(OPE_PP_CHROMA_ENHAN_BASE + 0x70)
+#define		OPE_PP_CHROMA_ENHAN_LUMA_CFG_2_V2	GENMASK(11, 0)
+#define OPE_PP_CHROMA_ENHAN_COEFF_A_CFG				(OPE_PP_CHROMA_ENHAN_BASE + 0x74)
+#define		OPE_PP_CHROMA_ENHAN_COEFF_A_CFG_AP	GENMASK(11, 0)
+#define		OPE_PP_CHROMA_ENHAN_COEFF_A_CFG_AM	GENMASK(27, 16)
+#define OPE_PP_CHROMA_ENHAN_COEFF_B_CFG				(OPE_PP_CHROMA_ENHAN_BASE + 0x78)
+#define		OPE_PP_CHROMA_ENHAN_COEFF_B_CFG_BP	GENMASK(11, 0)
+#define		OPE_PP_CHROMA_ENHAN_COEFF_B_CFG_BM	GENMASK(27, 16)
+#define OPE_PP_CHROMA_ENHAN_COEFF_C_CFG				(OPE_PP_CHROMA_ENHAN_BASE + 0x7C)
+#define		OPE_PP_CHROMA_ENHAN_COEFF_C_CFG_CP	GENMASK(11, 0)
+#define		OPE_PP_CHROMA_ENHAN_COEFF_C_CFG_CM	GENMASK(27, 16)
+#define OPE_PP_CHROMA_ENHAN_COEFF_D_CFG				(OPE_PP_CHROMA_ENHAN_BASE + 0x80)
+#define		OPE_PP_CHROMA_ENHAN_COEFF_D_CFG_DP	GENMASK(11, 0)
+#define		OPE_PP_CHROMA_ENHAN_COEFF_D_CFG_DM	GENMASK(27, 16)
+#define OPE_PP_CHROMA_ENHAN_CHROMA_CFG_0			(OPE_PP_CHROMA_ENHAN_BASE + 0x84)
+#define		OPE_PP_CHROMA_ENHAN_CHROMA_CFG_0_KCB GENMASK(31, 21)
+#define OPE_PP_CHROMA_ENHAN_CHROMA_CFG_1			(OPE_PP_CHROMA_ENHAN_BASE + 0x88)
+#define		OPE_PP_CHROMA_ENHAN_CHROMA_CFG_1_KCR GENMASK(31, 21)
+
+/* -------- OPE-specific constants -------- */
+
+#define OPE_STRIPE_MAX_W	336
+#define OPE_STRIPE_MAX_H	8192
+#define OPE_STRIPE_MIN_W	16
+#define OPE_STRIPE_MIN_H	OPE_STRIPE_MIN_W
+#define OPE_MAX_STRIPE		16
+#define OPE_ALIGN_H		1
+#define OPE_ALIGN_W		1
+#define OPE_MIN_W		24
+#define OPE_MIN_H		16
+#define OPE_MAX_W		(OPE_STRIPE_MAX_W * OPE_MAX_STRIPE)
+#define OPE_MAX_H		OPE_STRIPE_MAX_H
+#define OPE_MAX_STRIDE		0xffff
+#define OPE_RESET_TIMEOUT_MS	100
+#define OPE_RESET_POLL_US	50
+#define DEFAULT_FRAMERATE	60
+#define OPE_MAX_FRAMERATE	1000
+
+/*
+ * AXI clock is shared across CAMSS blocks and not dynamically scaled,
+ * just request the highest supported rate.
+ */
+#define OPE_AXI_CLK_RATE	(300 * HZ_PER_MHZ)
+
+/* Downscaler fixed-point helpers */
+#define Q21(v)			(((uint64_t)(v)) << 21)
+#define DS_Q21(n, d)		((uint32_t)div_u64((uint64_t)(n) << 21, (d)))
+#define DS_RESOLUTION(in, out) \
+	(((out) * 128 <= (in)) ? 0x0U : \
+	 ((out) * 16  <= (in)) ? 0x1U : \
+	 ((out) * 8   <= (in)) ? 0x2U : 0x3U)
+#define DS_OUTPUT_PIX(in, phase_init, phase_step) \
+	div_u64(Q21(in) - (phase_init), (phase_step))
+#define OPE_WB(n, d)		(((n) << 10) / (d))
+
+enum ope_downscaler {
+	OPE_DS_C_PRE,
+	OPE_DS_C_DISP,
+	OPE_DS_Y_DISP,
+	OPE_DS_MAX,
+};
+
+enum ope_glut_sel {
+	OPE_GLUT_SEL_NONE,
+	OPE_GLUT_SEL_G,
+	OPE_GLUT_SEL_B,
+	OPE_GLUT_SEL_R,
+};
+
+static const u32 ope_ds_base[OPE_DS_MAX] = {
+	OPE_PP_DOWNSCALE_MN_DS_C_PRE_BASE,
+	OPE_PP_DOWNSCALE_MN_DS_C_DISP_BASE,
+	OPE_PP_DOWNSCALE_MN_DS_Y_DISP_BASE,
+};
+
+enum ope_wr_client {
+	OPE_WR_CLIENT_VID_Y,
+	OPE_WR_CLIENT_VID_C,
+	OPE_WR_CLIENT_DISP_Y,
+	OPE_WR_CLIENT_DISP_C,
+	OPE_WR_CLIENT_MAX,
+};
+
+enum ope_pixel_pattern {
+	OPE_PIXEL_PATTERN_RGRGRG,
+	OPE_PIXEL_PATTERN_GRGRGR,
+	OPE_PIXEL_PATTERN_BGBGBG,
+	OPE_PIXEL_PATTERN_GBGBGB,
+	OPE_PIXEL_PATTERN_YCBYCR,
+	OPE_PIXEL_PATTERN_YCRYCB,
+	OPE_PIXEL_PATTERN_CBYCRY,
+	OPE_PIXEL_PATTERN_CRYCBY,
+};
+
+enum ope_stripe_location {
+	OPE_STRIPE_LOCATION_FULL,
+	OPE_STRIPE_LOCATION_LEFT,
+	OPE_STRIPE_LOCATION_RIGHT,
+	OPE_STRIPE_LOCATION_MIDDLE,
+};
+
+enum ope_unpacker_format {
+	OPE_UNPACKER_FMT_PLAIN_8	= 1,
+	OPE_UNPACKER_FMT_PLAIN_16_10BPP	= 2,
+	OPE_UNPACKER_FMT_MIPI_10	= 13,
+};
+
+enum ope_packer_format {
+	OPE_PACKER_FMT_PLAIN_8		= 1,
+	OPE_PACKER_FMT_PLAIN_8_ODD_EVEN = 2,
+	OPE_PACKER_FMT_MIPI_10		= 12,
+};
+
+struct ope_hw_fmt {
+	u32			fourcc;
+	enum ope_pixel_pattern	pattern;
+	enum ope_unpacker_format	unpacker;
+	enum ope_packer_format	packer;
+};
+
+static const struct ope_hw_fmt ope_hw_fmts[] = {
+	{ V4L2_PIX_FMT_SBGGR10P, OPE_PIXEL_PATTERN_BGBGBG,
+	  OPE_UNPACKER_FMT_MIPI_10,  OPE_PACKER_FMT_MIPI_10 },
+	{ V4L2_PIX_FMT_SGBRG10P, OPE_PIXEL_PATTERN_GBGBGB,
+	  OPE_UNPACKER_FMT_MIPI_10,  OPE_PACKER_FMT_MIPI_10 },
+	{ V4L2_PIX_FMT_SGRBG10P, OPE_PIXEL_PATTERN_GRGRGR,
+	  OPE_UNPACKER_FMT_MIPI_10,  OPE_PACKER_FMT_MIPI_10 },
+	{ V4L2_PIX_FMT_SRGGB10P, OPE_PIXEL_PATTERN_RGRGRG,
+	  OPE_UNPACKER_FMT_MIPI_10,  OPE_PACKER_FMT_MIPI_10 },
+	{ V4L2_PIX_FMT_SRGGB8,   OPE_PIXEL_PATTERN_RGRGRG,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
+	{ V4L2_PIX_FMT_SBGGR8,   OPE_PIXEL_PATTERN_BGBGBG,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
+	{ V4L2_PIX_FMT_SGBRG8,   OPE_PIXEL_PATTERN_GBGBGB,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
+	{ V4L2_PIX_FMT_SGRBG8,   OPE_PIXEL_PATTERN_GRGRGR,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
+	{ V4L2_PIX_FMT_NV24,     OPE_PIXEL_PATTERN_YCBYCR,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
+	{ V4L2_PIX_FMT_NV42,     OPE_PIXEL_PATTERN_YCRYCB,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8_ODD_EVEN },
+	{ V4L2_PIX_FMT_NV16,     OPE_PIXEL_PATTERN_CBYCRY,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
+	{ V4L2_PIX_FMT_NV61,     OPE_PIXEL_PATTERN_CBYCRY,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8_ODD_EVEN },
+	{ V4L2_PIX_FMT_NV12,     OPE_PIXEL_PATTERN_CBYCRY,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
+	{ V4L2_PIX_FMT_NV21,     OPE_PIXEL_PATTERN_CBYCRY,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8_ODD_EVEN },
+	{ V4L2_PIX_FMT_GREY,     OPE_PIXEL_PATTERN_RGRGRG,
+	  OPE_UNPACKER_FMT_PLAIN_8,  OPE_PACKER_FMT_PLAIN_8 },
+};
+
+static const struct ope_hw_fmt *ope_find_hw_fmt(u32 fourcc)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(ope_hw_fmts); i++)
+		if (ope_hw_fmts[i].fourcc == fourcc)
+			return &ope_hw_fmts[i];
+
+	return NULL;
+}
+
+static const struct ope_fmt ope_input_fmts[] = {
+	{ V4L2_PIX_FMT_SBGGR10P, 10, 2, 1, MEDIA_BUS_FMT_SBGGR10_1X10 },
+	{ V4L2_PIX_FMT_SGBRG10P, 10, 2, 1, MEDIA_BUS_FMT_SGBRG10_1X10 },
+	{ V4L2_PIX_FMT_SGRBG10P, 10, 2, 1, MEDIA_BUS_FMT_SGRBG10_1X10 },
+	{ V4L2_PIX_FMT_SRGGB10P, 10, 2, 1, MEDIA_BUS_FMT_SRGGB10_1X10 },
+	{ V4L2_PIX_FMT_SRGGB8,    8, 0, 1, MEDIA_BUS_FMT_SRGGB8_1X8 },
+	{ V4L2_PIX_FMT_SBGGR8,    8, 0, 1, MEDIA_BUS_FMT_SBGGR8_1X8 },
+	{ V4L2_PIX_FMT_SGBRG8,    8, 0, 1, MEDIA_BUS_FMT_SGBRG8_1X8 },
+	{ V4L2_PIX_FMT_SGRBG8,    8, 0, 1, MEDIA_BUS_FMT_SGRBG8_1X8 },
+};
+
+static const struct ope_fmt ope_output_fmts[] = {
+	{ V4L2_PIX_FMT_NV24,  24, 0, 1, MEDIA_BUS_FMT_YUV8_1X24,   1, 1 },
+	{ V4L2_PIX_FMT_NV42,  24, 0, 1, MEDIA_BUS_FMT_YUV8_1X24,   1, 1 },
+	{ V4L2_PIX_FMT_NV16,  16, 1, 1, MEDIA_BUS_FMT_YUYV8_2X8,   2, 1 },
+	{ V4L2_PIX_FMT_NV61,  16, 1, 1, MEDIA_BUS_FMT_YUYV8_2X8,   2, 1 },
+	{ V4L2_PIX_FMT_NV12,  12, 1, 1, MEDIA_BUS_FMT_YUYV8_1_5X8, 2, 2 },
+	{ V4L2_PIX_FMT_NV21,  12, 1, 1, MEDIA_BUS_FMT_YUYV8_1_5X8, 2, 2 },
+	{ V4L2_PIX_FMT_GREY,   8, 0, 1, MEDIA_BUS_FMT_Y8_1X8,      1, 1 },
+};
+
+struct ope_dsc_config {
+	u32 input_width;
+	u32 input_height;
+	u32 output_width;
+	u32 output_height;
+	u32 phase_step_h;
+	u32 phase_step_v;
+	u32 crop_last_pixel;
+	u32 crop_last_line;
+};
+
+struct ope_stripe {
+	struct {
+		dma_addr_t addr;
+		u32 width;
+		u32 height;
+		u32 stride;
+		enum ope_stripe_location location;
+		enum ope_pixel_pattern	pattern;
+		enum ope_unpacker_format format;
+	} src;
+	struct {
+		dma_addr_t addr;
+		u32 width;
+		u32 height;
+		u32 stride;
+		u32 x_init;
+		enum ope_packer_format format;
+		bool enabled;
+	} dst[OPE_WR_CLIENT_MAX];
+	struct ope_dsc_config dsc[OPE_DS_MAX];
+};
+
+/* OPE tuning parameter state */
+
+/* Demosaic (CLC_DEMO) coefficients, internal only, not user-configurable. */
+#define CAMSS_PARAMS_INTERNAL	(-1)
+
+struct ope_params_demo {
+	struct v4l2_isp_block_header header;
+	u8 lambda_rb;
+	u8 lambda_g;
+	u16 a_k;
+	u16 w_k;
+	u16 _pad;
+};
+
+/* OPE tuning parameter state */
+struct ope_config {
+	struct camss_params_wb_gain		wb_gain;
+	struct camss_params_chroma_enhan	chroma_enhan;
+	struct camss_params_color_correct	color_correct;
+	struct camss_params_gamma		gamma;
+	struct ope_params_demo			demo;
+};
+
+enum ope_entity {
+	OPE_ENTITY_FRAME_IN,
+	OPE_ENTITY_PARAMS,
+	OPE_ENTITY_PROC,
+	OPE_ENTITY_DISP,
+	OPE_ENTITY_DISP_OUT,
+	OPE_ENTITY_COUNT
+};
+
+enum ope_queue_idx {
+	OPE_QUEUE_FRAME_IN,
+	OPE_QUEUE_DISP_OUT,
+	OPE_QUEUE_PARAMS,
+	OPE_QUEUE_COUNT
+};
+
+struct camss_isp_buf {
+	struct vb2_v4l2_buffer	vb;	/* must be first */
+	struct list_head	list;
+};
+
+struct ope_queue {
+	struct vb2_queue	vq;
+	struct list_head	rdy_queue;
+	bool			streaming;
+};
+
+enum ope_proc_pad {
+	OPE_PROC_PAD_SINK_IN,
+	OPE_PROC_PAD_SINK_PAR,
+	OPE_PROC_PAD_SOURCE,
+	OPE_PROC_PADS_NUM,
+};
+
+enum ope_disp_pad {
+	OPE_DISP_PAD_SINK,
+	OPE_DISP_PAD_SOURCE,
+	OPE_DISP_PADS_NUM,
+};
+
+/* per-context state */
+struct ope_ctx {
+	bool			queued;
+	struct ope_dev		*ope;
+	struct mutex		vbq_lock;
+
+	/* Ready queues for buffers, protected by queues_lock */
+	spinlock_t		queues_lock;
+	struct ope_queue	queues[OPE_QUEUE_COUNT];
+
+	unsigned int		framerate;
+	struct ope_fmt_state	fmt_in;
+	struct ope_fmt_state	fmt_out;
+
+	struct list_head	list;
+
+	struct ope_config	config;
+	u8			current_stripe;
+	struct ope_stripe	stripe[OPE_MAX_STRIPE];
+
+	struct v4l2_isp_buffer *params_buf;
+};
+
+/* Per OPE device state */
+struct ope_dev {
+	struct device		*dev;
+	struct v4l2_device	v4l2_dev;
+	struct media_device	mdev;
+	struct camss_isp_pipeline *pipeline;
+	struct mutex		mutex;
+	struct work_struct	run_work;
+
+	/* Scheduler state, all owned by sched_lock */
+	spinlock_t		sched_lock;
+	struct ope_ctx		*curr_ctx;
+	struct ope_ctx		*hw_ctx;
+	bool			hw_running;
+	unsigned int		sched_paused;
+
+	int			irq;
+	u32			hw_version;
+
+	struct icc_path		*icc_data;
+	struct icc_path		*icc_config;
+	struct pm_qos_request	qos_req;
+	struct clk_bulk_data	*clks;
+	int			nclks;
+
+	void __iomem		*base;
+	void __iomem		*base_rd;
+	void __iomem		*base_wr;
+	void __iomem		*base_pp;
+
+	struct completion	reset_complete;
+	/* Serializes HW reset register programming against concurrent resets */
+	struct mutex		reset_mutex;
+
+	/* Context list, protected by ctx_lock */
+	struct list_head	ctx_list;
+	spinlock_t		ctx_lock;
+
+	struct ope_ctx		*shared_ctx;
+	unsigned int		open_count;
+
+	/* Gamma LUT handling, two banks shared across contexts */
+	struct {
+		struct ope_ctx	*owner;
+		bool		valid;
+	} glut_bank[2];
+	u8			glut_cur_bank;
+	u8			glut_mru_bank;
+};
+
+/* -------- Register accessors -------- */
+
+static inline u32 ope_read(struct ope_dev *ope, u32 reg)
+{
+	return readl(ope->base + reg);
+}
+
+static inline void ope_write(struct ope_dev *ope, u32 reg, u32 val)
+{
+	writel(val, ope->base + reg);
+}
+
+static inline void ope_write_wr(struct ope_dev *ope, u32 reg, u32 val)
+{
+	writel_relaxed(val, ope->base_wr + reg);
+}
+
+static inline u32 ope_read_wr(struct ope_dev *ope, u32 reg)
+{
+	return readl_relaxed(ope->base_wr + reg);
+}
+
+static inline void ope_write_rd(struct ope_dev *ope, u32 reg, u32 val)
+{
+	writel_relaxed(val, ope->base_rd + reg);
+}
+
+static inline void ope_write_pp(struct ope_dev *ope, u32 reg, u32 val)
+{
+	writel_relaxed(val, ope->base_pp + reg);
+}
+
+static inline u32 ope_read_pp(struct ope_dev *ope, u32 reg)
+{
+	return readl_relaxed(ope->base_pp + reg);
+}
+
+static inline void ope_start(struct ope_dev *ope)
+{
+	wmb(); /* ensure all register writes are visible before GO_CMD */
+	ope_write_rd(ope, OPE_BUS_RD_INPUT_IF_CMD, OPE_BUS_RD_INPUT_IF_CMD_GO_CMD);
+}
+
+static inline bool ope_hw_available(struct ope_dev *ope)
+{
+	/* v4l2_device_unregister() clear the dev pointer */
+	return !!ope->v4l2_dev.dev;
+}
+
+/* -------- Stripe helpers -------- */
+
+static inline enum ope_stripe_location ope_stripe_location(unsigned int idx, unsigned int count)
+{
+	if (count == 1)
+		return OPE_STRIPE_LOCATION_FULL;
+	if (idx == 0)
+		return OPE_STRIPE_LOCATION_LEFT;
+	if (idx == count - 1)
+		return OPE_STRIPE_LOCATION_RIGHT;
+
+	return OPE_STRIPE_LOCATION_MIDDLE;
+}
+
+static inline bool ope_stripe_is_last(const struct ope_stripe *s)
+{
+	return s && (s->src.location == OPE_STRIPE_LOCATION_RIGHT ||
+		     s->src.location == OPE_STRIPE_LOCATION_FULL);
+}
+
+static inline struct ope_stripe *ope_current_stripe(struct ope_ctx *ctx)
+{
+	if (ctx->current_stripe >= OPE_MAX_STRIPE)
+		return NULL;
+
+	return &ctx->stripe[ctx->current_stripe];
+}
+
+static inline unsigned int ope_stripe_index(struct ope_ctx *ctx, const struct ope_stripe *stripe)
+{
+	return stripe - &ctx->stripe[0];
+}
+
+static inline struct ope_stripe *ope_prev_stripe(struct ope_ctx *ctx, struct ope_stripe *stripe)
+{
+	unsigned int idx = ope_stripe_index(ctx, stripe);
+
+	return idx ? &ctx->stripe[idx - 1] : NULL;
+}
+
+static unsigned int ope_split_stripes(unsigned int src_width, unsigned int align,
+				      unsigned int *widths, u32 *height)
+{
+	unsigned int nstripes, i;
+	u32 w;
+
+	if (src_width > OPE_MAX_W)
+		return 0;
+
+	nstripes = DIV_ROUND_UP(src_width, OPE_STRIPE_MAX_W);
+	w = ALIGN(DIV_ROUND_UP(src_width, nstripes), max(2u, 1u << align));
+
+	v4l_bound_align_image(&w, OPE_STRIPE_MIN_W, OPE_STRIPE_MAX_W, align,
+			      height, OPE_STRIPE_MIN_H, OPE_STRIPE_MAX_H,
+			      OPE_ALIGN_H, 0);
+
+	for (i = 0; i + 1 < nstripes; i++)
+		widths[i] = w;
+
+	/* The trailing stripe takes what is left */
+	widths[nstripes - 1] = src_width - i * w;
+
+	return nstripes;
+}
+
+static unsigned int ope_calc_h_scale(unsigned int src, unsigned int dst,
+				     const unsigned int *widths, unsigned int nstripes,
+				     unsigned int c_hsub, unsigned int sw_align)
+{
+	unsigned int last_sw = widths[nstripes - 1];
+	unsigned int denom;
+
+	if (src == dst)
+		return DS_Q21(src, src);
+
+	/* Find the smallest h_scale denominator >= dst such that the
+	 * last-stripe adjustment can satisfy both Y and C pixel counts.
+	 */
+	for (denom = dst; denom <= dst + 16 * nstripes; denom++) {
+		unsigned int hs = DS_Q21(src, denom);
+		unsigned int tw = 0, tc = 0;
+		unsigned int ry, rc, s_y, s_c, s, i;
+
+		for (i = 0; i < nstripes - 1; i++) {
+			tw += DS_OUTPUT_PIX(widths[i], 0, hs);
+			tc += DS_OUTPUT_PIX(widths[i] / c_hsub, 0, hs);
+		}
+
+		if (tw > dst || tc > dst / c_hsub)
+			continue;
+
+		ry = dst - tw;
+		rc = dst / c_hsub - tc;
+		s_y = DIV_ROUND_UP((u64)ry * hs, Q21(1));
+		s_c = DIV_ROUND_UP((u64)rc * hs, Q21(1)) * c_hsub;
+		s = ALIGN(max(s_y, s_c), sw_align);
+
+		s = clamp(s, OPE_STRIPE_MIN_W, last_sw);
+		tw += DS_OUTPUT_PIX(s, 0, hs);
+		tc += DS_OUTPUT_PIX(s / c_hsub, 0, hs);
+
+		if (tw == dst && tc * c_hsub == dst)
+			return hs;
+	}
+
+	return DS_Q21(src, dst);
+}
+
+static unsigned int ope_calc_v_scale(unsigned int src, unsigned int dst)
+{
+	return DS_Q21(src, dst);
+}
+
+static void ope_gen_stripe_chroma_dsc(struct ope_ctx *ctx,
+				      struct ope_stripe *stripe)
+{
+	struct ope_dsc_config *dsc = &stripe->dsc[OPE_DS_C_PRE];
+	const struct ope_fmt *fmt = ctx->fmt_out.fmt;
+
+	dsc->input_width  = stripe->src.width;
+	dsc->input_height = stripe->src.height;
+
+	dsc->output_width  = dsc->input_width  / fmt->c_hsub;
+	dsc->output_height = dsc->input_height / fmt->c_vsub;
+
+	dsc->phase_step_h = DS_Q21(dsc->input_width, dsc->output_width);
+	dsc->phase_step_v = DS_Q21(dsc->input_height, dsc->output_height);
+}
+
+static void ope_gen_stripe_dsc(struct ope_ctx *ctx, struct ope_stripe *stripe,
+			       unsigned int h_scale, unsigned int v_scale)
+{
+	struct ope_dsc_config *dsc_c = &stripe->dsc[OPE_DS_C_DISP];
+	struct ope_dsc_config *dsc_y = &stripe->dsc[OPE_DS_Y_DISP];
+	unsigned int sw = stripe->src.width;
+	unsigned int sw_c = stripe->dsc[OPE_DS_C_PRE].output_width;
+
+	dsc_c->phase_step_h = dsc_y->phase_step_h = h_scale;
+	dsc_c->phase_step_v = dsc_y->phase_step_v = v_scale;
+
+	dsc_c->input_width  = stripe->dsc[OPE_DS_C_PRE].output_width;
+	dsc_c->input_height = stripe->dsc[OPE_DS_C_PRE].output_height;
+	dsc_y->input_width  = stripe->src.width;
+	dsc_y->input_height = stripe->src.height;
+
+	/* Clip the output so the WE always receives the expected count */
+	dsc_y->output_width  = DS_OUTPUT_PIX(sw, 0, h_scale);
+	dsc_y->output_height = DS_OUTPUT_PIX(stripe->src.height, 0, v_scale);
+	dsc_c->output_width  = DS_OUTPUT_PIX(sw_c, 0, h_scale);
+	dsc_c->output_height = DS_OUTPUT_PIX(stripe->dsc[OPE_DS_C_PRE].output_height, 0, v_scale);
+
+	dsc_y->output_width  = max_t(unsigned int, dsc_y->output_width, 1);
+	dsc_y->output_height = max_t(unsigned int, dsc_y->output_height, 1);
+	dsc_c->output_width  = max_t(unsigned int, dsc_c->output_width, 1);
+	dsc_c->output_height = max_t(unsigned int, dsc_c->output_height, 1);
+
+	dsc_y->crop_last_pixel = dsc_y->output_width  - 1;
+	dsc_y->crop_last_line  = dsc_y->output_height - 1;
+	dsc_c->crop_last_pixel = dsc_c->output_width  - 1;
+	dsc_c->crop_last_line  = dsc_c->output_height - 1;
+}
+
+static void ope_gen_stripe_yuv_dst(struct ope_ctx *ctx, struct ope_stripe *stripe,
+				   dma_addr_t dst, const struct v4l2_rect *compose)
+{
+	const struct ope_fmt_state *fo = &ctx->fmt_out;
+	const struct ope_hw_fmt *hw = ope_find_hw_fmt(fo->fmt->fourcc);
+	struct ope_stripe *prev = ope_prev_stripe(ctx, stripe);
+	unsigned int bpl = fo->bytesperline;
+	unsigned int img_h = fo->height;
+	unsigned int c_stride;
+	unsigned int x_init;
+	dma_addr_t base;
+
+	stripe->dst[OPE_WR_CLIENT_DISP_Y].enabled = true;
+	stripe->dst[OPE_WR_CLIENT_DISP_C].enabled = true;
+
+	/* Y plane */
+	base = dst + compose->top * bpl;
+
+	if (prev)
+		x_init = prev->dst[OPE_WR_CLIENT_DISP_Y].x_init +
+			 prev->dst[OPE_WR_CLIENT_DISP_Y].width;
+	else
+		x_init = compose->left;
+
+	stripe->dst[OPE_WR_CLIENT_DISP_Y].addr   = base;
+	stripe->dst[OPE_WR_CLIENT_DISP_Y].x_init = x_init;
+	stripe->dst[OPE_WR_CLIENT_DISP_Y].width  = stripe->dsc[OPE_DS_Y_DISP].output_width;
+	stripe->dst[OPE_WR_CLIENT_DISP_Y].height = stripe->dsc[OPE_DS_Y_DISP].output_height;
+	stripe->dst[OPE_WR_CLIENT_DISP_Y].stride = bpl;
+	stripe->dst[OPE_WR_CLIENT_DISP_Y].format = OPE_PACKER_FMT_PLAIN_8;
+
+	/* UV plane (appended to Y plane)*/
+	c_stride = bpl * 2 / fo->fmt->c_hsub;
+	base = dst + bpl * img_h + (compose->top / fo->fmt->c_vsub) * c_stride;
+
+	if (prev)
+		x_init = prev->dst[OPE_WR_CLIENT_DISP_C].x_init +
+			 prev->dst[OPE_WR_CLIENT_DISP_C].width;
+	else
+		x_init = compose->left * 2 / fo->fmt->c_hsub;
+
+	stripe->dst[OPE_WR_CLIENT_DISP_C].addr   = base;
+	stripe->dst[OPE_WR_CLIENT_DISP_C].x_init = x_init;
+	stripe->dst[OPE_WR_CLIENT_DISP_C].format = hw ? hw->packer : OPE_PACKER_FMT_PLAIN_8;
+	stripe->dst[OPE_WR_CLIENT_DISP_C].width  = stripe->dsc[OPE_DS_C_DISP].output_width * 2;
+	stripe->dst[OPE_WR_CLIENT_DISP_C].height = stripe->dsc[OPE_DS_C_DISP].output_height;
+
+	switch (fo->fmt->fourcc) {
+	case V4L2_PIX_FMT_GREY:
+		stripe->dst[OPE_WR_CLIENT_DISP_C].enabled = false;
+		break;
+	default:
+		stripe->dst[OPE_WR_CLIENT_DISP_C].stride = c_stride;
+		break;
+	}
+}
+
+static int ope_gen_stripes(struct ope_ctx *ctx, dma_addr_t src, dma_addr_t dst)
+{
+	const struct ope_fmt_state *fi = &ctx->fmt_in;
+	const struct ope_hw_fmt *src_hw = ope_find_hw_fmt(fi->fmt->fourcc);
+	unsigned int h_scale, v_scale, num_stripes, x_out, x_out_c;
+	const struct ope_fmt_state *fo = &ctx->fmt_out;
+	const struct v4l2_rect *compose, *crop;
+	unsigned int c_hsub = fo->fmt->c_hsub;
+	unsigned int widths[OPE_MAX_STRIPE];
+	struct v4l2_subdev_state *sd_state;
+	struct v4l2_subdev *proc_sd;
+	int ret = 0;
+	u32 height;
+
+	proc_sd = camss_isp_pipeline_get_subdev(ctx->ope->pipeline, OPE_ENTITY_PROC);
+	sd_state = v4l2_subdev_lock_and_get_active_state(proc_sd);
+	crop = v4l2_subdev_state_get_crop(sd_state, OPE_PROC_PAD_SINK_IN);
+	compose = v4l2_subdev_state_get_compose(sd_state, OPE_PROC_PAD_SOURCE);
+
+	if (crop->left + crop->width > fi->width ||
+	    crop->top + crop->height > fi->height) {
+		ret = -ERANGE;
+		goto out;
+	}
+
+	if (compose->left + compose->width > fo->width ||
+	    compose->top + compose->height > fo->height) {
+		ret = -ERANGE;
+		goto out;
+	}
+
+	/* Advance source pointer to the crop origin */
+	src += crop->top * fi->bytesperline + crop->left * fi->fmt->depth / 8;
+
+	height = crop->height;
+	num_stripes = ope_split_stripes(crop->width, fi->fmt->align, widths, &height);
+	if (!num_stripes) {
+		ret = -ERANGE;
+		goto out;
+	}
+
+	h_scale = ope_calc_h_scale(crop->width,  compose->width, widths, num_stripes, c_hsub,
+				   max(2u, 1u << fi->fmt->align));
+	v_scale = ope_calc_v_scale(crop->height, compose->height);
+
+	x_out = x_out_c = 0;
+
+	for (unsigned int i = 0; i < num_stripes; i++) {
+		struct ope_stripe *stripe = &ctx->stripe[i];
+
+		memset(stripe, 0, sizeof(*stripe));
+
+		stripe->src.addr = src;
+		stripe->src.width = widths[i];
+		stripe->src.height = height;
+		stripe->src.stride = fi->bytesperline;
+		stripe->src.location = ope_stripe_location(i, num_stripes);
+		stripe->src.pattern = src_hw ? src_hw->pattern : 0;
+		stripe->src.format = src_hw ? src_hw->unpacker : 0;
+
+		src += stripe->src.width * fi->fmt->depth / 8;
+
+		/* Last-stripe adjustment: compute the minimum input width that
+		 * delivers exactly the remaining output pixels for Y and C.
+		 */
+		if (ope_stripe_is_last(stripe)) {
+			unsigned int rem_y = compose->width - x_out;
+			unsigned int rem_c = compose->width / c_hsub - x_out_c;
+			unsigned int s_y = DIV_ROUND_UP((u64)rem_y * h_scale, Q21(1));
+			unsigned int s_c = DIV_ROUND_UP((u64)rem_c * h_scale, Q21(1)) * c_hsub;
+			unsigned int s = ALIGN(max(s_y, s_c), max(2u, 1u << fi->fmt->align));
+
+			stripe->src.width = clamp(s, OPE_STRIPE_MIN_W, stripe->src.width);
+		}
+
+		ope_gen_stripe_chroma_dsc(ctx, stripe);
+		ope_gen_stripe_dsc(ctx, stripe, h_scale, v_scale);
+		ope_gen_stripe_yuv_dst(ctx, stripe, dst, compose);
+
+		x_out += stripe->dsc[OPE_DS_Y_DISP].output_width;
+		x_out_c += stripe->dsc[OPE_DS_C_DISP].output_width;
+
+		/* Width in bytes for the fetch engine */
+		stripe->src.width = stripe->src.width * fi->fmt->depth / 8;
+	}
+
+	if (x_out != compose->width || x_out_c != compose->width / c_hsub)
+		ret = -ERANGE;
+
+out:
+	v4l2_subdev_unlock_state(sd_state);
+
+	return ret;
+}
+
+/* -------- Pipeline IQ module programming -------- */
+
+static bool ope_module_update(struct ope_ctx *ctx, u32 module_cfg_reg, u32 enable_mask,
+			      struct v4l2_isp_block_header *hdr, bool force)
+{
+	bool enable = !(hdr->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE);
+	bool dirty  = hdr->flags & CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
+
+	/* skip if neither forced (new context) nor dirty (updated params) */
+	if (!force && !dirty)
+		return false;
+
+	hdr->flags &= ~CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
+
+	ope_write_pp(ctx->ope, module_cfg_reg, enable ? enable_mask : 0);
+
+	/* If module is disabled, not need to update content */
+	if (!enable)
+		return false;
+
+	dev_dbg(ctx->ope->dev, "IQ module (%u) update (flags:0x%x)\n", hdr->type, hdr->flags);
+
+	return true;
+}
+
+static void ope_prog_wb(struct ope_ctx *ctx, bool force)
+{
+	struct camss_params_wb_gain *wb = &ctx->config.wb_gain;
+	struct ope_dev *ope = ctx->ope;
+
+	if (!ope_module_update(ctx, OPE_PP_WB_GAIN_MODULE_CFG,
+			       OPE_PP_WB_GAIN_MODULE_CFG_EN,
+			       &wb->header, force))
+		return;
+
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_CFG(0),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_CFG_GAIN, wb->g_gain));
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_CFG(1),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_CFG_GAIN, wb->b_gain));
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_CFG(2),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_CFG_GAIN, wb->r_gain));
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_SUB_CFG(0),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_SUB_CFG_VAL, wb->g_sub));
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_SUB_CFG(1),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_SUB_CFG_VAL, wb->b_sub));
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_SUB_CFG(2),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_SUB_CFG_VAL, wb->r_sub));
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_ADD_CFG(0),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_ADD_CFG_VAL, wb->g_add));
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_ADD_CFG(1),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_ADD_CFG_VAL, wb->b_add));
+	ope_write_pp(ope, OPE_PP_WB_GAIN_WB_ADD_CFG(2),
+		     FIELD_PREP(OPE_PP_WB_GAIN_WB_ADD_CFG_VAL, wb->r_add));
+}
+
+static void ope_prog_bayer2rgb(struct ope_ctx *ctx, bool force)
+{
+	struct ope_params_demo *demo = &ctx->config.demo;
+	struct ope_dev *ope = ctx->ope;
+
+	if (!ope_module_update(ctx, OPE_PP_DEMO_MODULE_CFG,
+			       OPE_PP_DEMO_MODULE_CFG_EN |
+			       OPE_PP_DEMO_MODULE_CFG_DYN_G_CLAMP_EN |
+			       OPE_PP_DEMO_MODULE_CFG_DYN_RB_CLAMP_EN,
+			       &demo->header, force))
+		return;
+
+	ope_write_pp(ope, OPE_PP_DEMO_INTERP_COEFF_CFG,
+		     FIELD_PREP(OPE_PP_DEMO_INTERP_COEFF_CFG_LAMBDA_G,  demo->lambda_g) |
+		     FIELD_PREP(OPE_PP_DEMO_INTERP_COEFF_CFG_LAMBDA_RB, demo->lambda_rb));
+	ope_write_pp(ope, OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_0,
+		     FIELD_PREP(OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_0_AK, demo->a_k));
+	ope_write_pp(ope, OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_1,
+		     FIELD_PREP(OPE_PP_DEMO_INTERP_CLASSIFIER_CFG_1_WK, demo->w_k));
+}
+
+static void ope_prog_rgb2yuv(struct ope_ctx *ctx, bool force)
+{
+	struct camss_params_chroma_enhan *cc = &ctx->config.chroma_enhan;
+	struct ope_dev *ope = ctx->ope;
+
+	if (!ope_module_update(ctx, OPE_PP_CHROMA_ENHAN_MODULE_CFG,
+			       OPE_PP_CHROMA_ENHAN_MODULE_CFG_EN,
+			       &cc->header, force))
+		return;
+
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_LUMA_CFG_0,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_LUMA_CFG_0_V0, cc->luma_v0) |
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_LUMA_CFG_0_V1, cc->luma_v1));
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_LUMA_CFG_1,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_LUMA_CFG_1_K, cc->luma_k));
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_LUMA_CFG_2,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_LUMA_CFG_2_V2, cc->luma_v2));
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_COEFF_A_CFG,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_A_CFG_AP, cc->coeff_ap) |
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_A_CFG_AM, cc->coeff_am));
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_COEFF_B_CFG,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_B_CFG_BP, cc->coeff_bp) |
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_B_CFG_BM, cc->coeff_bm));
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_COEFF_C_CFG,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_C_CFG_CP, cc->coeff_cp) |
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_C_CFG_CM, cc->coeff_cm));
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_COEFF_D_CFG,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_D_CFG_DP, cc->coeff_dp) |
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_COEFF_D_CFG_DM, cc->coeff_dm));
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_CHROMA_CFG_0,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_CHROMA_CFG_0_KCB, cc->kcb));
+	ope_write_pp(ope, OPE_PP_CHROMA_ENHAN_CHROMA_CFG_1,
+		     FIELD_PREP(OPE_PP_CHROMA_ENHAN_CHROMA_CFG_1_KCR, cc->kcr));
+}
+
+static void ope_prog_color_correct(struct ope_ctx *ctx, bool force)
+{
+	struct camss_params_color_correct *cc = &ctx->config.color_correct;
+	struct ope_dev *ope = ctx->ope;
+
+	if (!ope_module_update(ctx, OPE_PP_CC_MODULE_CFG,
+			       OPE_PP_CC_MODULE_CFG_EN,
+			       &cc->header, force))
+		return;
+
+	ope_write_pp(ope, OPE_PP_CC_COEFF_A_CFG_0,
+		     FIELD_PREP(OPE_PP_CC_COEFF_A_CFG_0_A0, cc->a[0]) |
+		     FIELD_PREP(OPE_PP_CC_COEFF_A_CFG_0_A1, cc->a[1]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_A_CFG_1,
+		     FIELD_PREP(OPE_PP_CC_COEFF_A_CFG_1_A2, cc->a[2]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_B_CFG_0,
+		     FIELD_PREP(OPE_PP_CC_COEFF_B_CFG_0_B0, cc->b[0]) |
+		     FIELD_PREP(OPE_PP_CC_COEFF_B_CFG_0_B1, cc->b[1]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_B_CFG_1,
+		     FIELD_PREP(OPE_PP_CC_COEFF_B_CFG_1_B2, cc->b[2]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_C_CFG_0,
+		     FIELD_PREP(OPE_PP_CC_COEFF_C_CFG_0_C0, cc->c[0]) |
+		     FIELD_PREP(OPE_PP_CC_COEFF_C_CFG_0_C1, cc->c[1]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_C_CFG_1,
+		     FIELD_PREP(OPE_PP_CC_COEFF_C_CFG_1_C2, cc->c[2]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_K_CFG_0,
+		     FIELD_PREP(OPE_PP_CC_COEFF_K_CFG_0_K0, cc->k[0]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_K_CFG_1,
+		     FIELD_PREP(OPE_PP_CC_COEFF_K_CFG_1_K1, cc->k[1]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_K_CFG_2,
+		     FIELD_PREP(OPE_PP_CC_COEFF_K_CFG_2_K2, cc->k[2]));
+	ope_write_pp(ope, OPE_PP_CC_COEFF_M_CFG,
+		     FIELD_PREP(OPE_PP_CC_COEFF_M_CFG_M, cc->qfactor));
+}
+
+static void ope_glut_load_lut(struct ope_dev *ope, enum ope_glut_sel ch,
+			      u8 bank, const u16 *lut)
+{
+	ope_write_pp(ope, OPE_PP_GLUT_DMI_LUT_BANK_CFG,
+		     FIELD_PREP(OPE_PP_GLUT_DMI_LUT_BANK_CFG_SEL, bank));
+	ope_write_pp(ope, OPE_PP_GLUT_DMI_LUT_CFG,
+		     FIELD_PREP(OPE_PP_GLUT_DMI_LUT_CFG_SEL, ch));
+	ope_write_pp(ope, OPE_PP_GLUT_DMI_CFG,
+		     OPE_PP_GLUT_DMI_CFG_AUTO_LOAD_EN |
+		     FIELD_PREP(OPE_PP_GLUT_DMI_CFG_ADDR, 0));
+	for (unsigned int i = 0; i < CAMSS_GAMMA_LUT_SIZE; i++)
+		ope_write_pp(ope, OPE_PP_GLUT_DMI_DATA, lut[i]);
+}
+
+static void ope_glut_upload(struct ope_ctx *ctx, u8 bank)
+{
+	struct camss_params_gamma *gamma = &ctx->config.gamma;
+	struct ope_dev *ope = ctx->ope;
+
+	ope_glut_load_lut(ope, OPE_GLUT_SEL_R, bank, gamma->rlut);
+	ope_glut_load_lut(ope, OPE_GLUT_SEL_G, bank, gamma->glut);
+	ope_glut_load_lut(ope, OPE_GLUT_SEL_B, bank, gamma->blut);
+
+	ope_write_pp(ope, OPE_PP_GLUT_DMI_LUT_CFG,
+		     FIELD_PREP(OPE_PP_GLUT_DMI_LUT_CFG_SEL,
+				OPE_GLUT_SEL_NONE));
+
+	ope->glut_bank[bank].owner = ctx;
+	ope->glut_bank[bank].valid = true;
+}
+
+static bool ope_glut_bank_resident(struct ope_dev *ope, u8 bank,
+				    struct ope_ctx *ctx)
+{
+	return ope->glut_bank[bank].valid &&
+	       ope->glut_bank[bank].owner == ctx;
+}
+
+static void ope_prog_gamma(struct ope_ctx *ctx, bool force)
+{
+	struct camss_params_gamma *gamma = &ctx->config.gamma;
+	bool enable = !(gamma->header.flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE);
+	bool dirty = gamma->header.flags & CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
+	struct ope_dev *ope = ctx->ope;
+	u8 bank;
+
+	if (!force && !dirty)
+		return;
+
+	gamma->header.flags &= ~CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
+
+	if (!enable) {
+		ope_write_pp(ope, OPE_PP_GLUT_MODULE_CFG, 0);
+		return;
+	}
+
+	if (!dirty && ope_glut_bank_resident(ope, ope->glut_cur_bank, ctx)) {
+		/* Already active in the read bank: only (re)enable the module. */
+		bank = ope->glut_cur_bank;
+	} else if (!dirty && ope_glut_bank_resident(ope, !ope->glut_cur_bank, ctx)) {
+		/* Resident in the other bank: flip to it, no upload. */
+		bank = !ope->glut_cur_bank;
+	} else {
+		/* Dirty, or miss in both banks: upload into the LRU bank. */
+		bank = !ope->glut_mru_bank;
+		ope_glut_upload(ctx, bank);
+	}
+
+	ope->glut_mru_bank = bank;
+
+	dev_dbg(ope->dev,
+		"IQ module (%u) update (flags:0x%x) glut bank %u->%u)\n",
+		gamma->header.type, gamma->header.flags,
+		ope->glut_cur_bank, bank);
+
+	ope_write_pp(ope, OPE_PP_GLUT_MODULE_LUT_BANK_CFG,
+		     FIELD_PREP(OPE_PP_GLUT_MODULE_LUT_BANK_CFG_SEL, bank));
+	ope->glut_cur_bank = bank;
+
+	ope_write_pp(ope, OPE_PP_GLUT_MODULE_CFG, OPE_PP_GLUT_MODULE_CFG_EN);
+}
+
+static void ope_glut_cache_invalidate(struct ope_dev *ope)
+{
+	ope->glut_bank[0].valid = false;
+	ope->glut_bank[1].valid = false;
+	ope->glut_cur_bank = 0;
+	ope->glut_mru_bank = 0;
+}
+
+static void ope_prog_crop_rnd_clamp(struct ope_dev *ope, const struct ope_stripe *stripe)
+{
+	static const u32 crop_bases[] = {
+		OPE_PP_CROP_RND_CLAMP_Y_DISP_BASE,
+		OPE_PP_CROP_RND_CLAMP_C_DISP_BASE,
+	};
+	static const enum ope_downscaler ds_idx[] = {
+		OPE_DS_Y_DISP,
+		OPE_DS_C_DISP,
+	};
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(crop_bases); i++) {
+		const struct ope_dsc_config *dsc = &stripe->dsc[ds_idx[i]];
+		u32 cbase = crop_bases[i];
+
+		if (!dsc->output_width || !dsc->output_height) {
+			ope_write_pp(ope,  OPE_PP_CROP_RND_CLAMP_MODULE_CFG(cbase), 0);
+			continue;
+		}
+
+		ope_write_pp(ope, OPE_PP_CROP_RND_CLAMP_CROP_PIXEL_CFG(cbase),
+			     FIELD_PREP(OPE_PP_CROP_RND_CLAMP_CROP_FIRST, 0) |
+			     FIELD_PREP(OPE_PP_CROP_RND_CLAMP_CROP_LAST,
+					dsc->crop_last_pixel));
+		ope_write_pp(ope, OPE_PP_CROP_RND_CLAMP_CROP_LINE_CFG(cbase),
+			     FIELD_PREP(OPE_PP_CROP_RND_CLAMP_CROP_FIRST, 0) |
+			     FIELD_PREP(OPE_PP_CROP_RND_CLAMP_CROP_LAST, dsc->crop_last_line));
+		ope_write_pp(ope, OPE_PP_CROP_RND_CLAMP_MODULE_CFG(cbase),
+			     OPE_PP_CROP_RND_CLAMP_EN | OPE_PP_CROP_RND_CLAMP_CROP_EN);
+	}
+}
+
+static void ope_prog_stripe(struct ope_ctx *ctx, struct ope_stripe *stripe)
+{
+	struct ope_dev *ope = ctx->ope;
+
+	dev_dbg(ope->dev, "ctx=%p programming stripe %u\n",
+		ctx, (unsigned int)(stripe - ctx->stripe));
+
+	/* Fetch Engine */
+	ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_UNPACK_CFG_0, stripe->src.format);
+	ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_RD_BUFFER_SIZE,
+		     (stripe->src.width << 16) | stripe->src.height);
+	ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_ADDR_IMAGE, stripe->src.addr);
+	ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_RD_STRIDE, stripe->src.stride);
+	ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_CCIF_META_DATA,
+		     FIELD_PREP(OPE_BUS_RD_CLIENT_0_CCIF_MD_PIX_PATTERN,
+				stripe->src.pattern));
+	ope_write_rd(ope, OPE_BUS_RD_CLIENT_0_CORE_CFG,
+		     OPE_BUS_RD_CLIENT_0_CORE_CFG_EN);
+
+	/* Write Engines */
+	for (int i = 0; i < OPE_WR_CLIENT_MAX; i++) {
+		if (!stripe->dst[i].enabled) {
+			ope_write_wr(ope, OPE_BUS_WR_CLIENT_CFG(i), 0);
+			continue;
+		}
+
+		ope_write_wr(ope, OPE_BUS_WR_CLIENT_ADDR_IMAGE(i),
+			     stripe->dst[i].addr);
+		ope_write_wr(ope, OPE_BUS_WR_CLIENT_IMAGE_CFG_0(i),
+			     (stripe->dst[i].height << 16) | stripe->dst[i].width);
+		ope_write_wr(ope, OPE_BUS_WR_CLIENT_IMAGE_CFG_1(i),
+			     stripe->dst[i].x_init);
+		ope_write_wr(ope, OPE_BUS_WR_CLIENT_IMAGE_CFG_2(i),
+			     stripe->dst[i].stride);
+		ope_write_wr(ope, OPE_BUS_WR_CLIENT_PACKER_CFG(i),
+			     stripe->dst[i].format);
+		ope_write_wr(ope, OPE_BUS_WR_CLIENT_CFG(i),
+			     OPE_BUS_WR_CLIENT_CFG_EN |
+			     OPE_BUS_WR_CLIENT_CFG_AUTORECOVER);
+	}
+
+	/* Downscalers */
+	for (int i = 0; i < OPE_DS_MAX; i++) {
+		struct ope_dsc_config *dsc = &stripe->dsc[i];
+		u32 base = ope_ds_base[i];
+		u32 cfg = 0;
+
+		if (dsc->input_width != dsc->output_width) {
+			dsc->phase_step_h |=
+				DS_RESOLUTION(dsc->input_width,
+					      dsc->output_width) << 30;
+			cfg |= OPE_PP_DOWNSCALE_MN_DS_CFG_H_SCALE_EN;
+		}
+		if (dsc->input_height != dsc->output_height) {
+			dsc->phase_step_v |=
+				DS_RESOLUTION(dsc->input_height,
+					      dsc->output_height) << 30;
+			cfg |= OPE_PP_DOWNSCALE_MN_DS_CFG_V_SCALE_EN;
+		}
+
+		ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_DS_CFG(base), cfg);
+		ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_DS_IMAGE_SIZE_CFG(base),
+			     ((dsc->input_width - 1) << 16) | (dsc->input_height - 1));
+		ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_DS_MN_H_CFG(base),
+			     dsc->phase_step_h);
+		ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_DS_MN_V_CFG(base),
+			     dsc->phase_step_v);
+		ope_write_pp(ope, OPE_PP_DOWNSCALE_MN_CFG(base),
+			     cfg ? OPE_PP_DOWNSCALE_MN_CFG_EN : 0);
+
+		dev_dbg(ope->dev, "DS[%d] cfg=0x%x in=%ux%u out=%ux%u\n",
+			i, cfg, dsc->input_width, dsc->input_height,
+			dsc->output_width, dsc->output_height);
+	}
+
+	ope_prog_crop_rnd_clamp(ope, stripe);
+}
+
+static void ope_params_apply_wb(void *priv, const union camss_isp_params_block *block)
+{
+	struct ope_ctx *ctx = priv;
+
+	if (!camss_isp_params_copy_block(&ctx->config.wb_gain, block, sizeof(ctx->config.wb_gain)))
+		return;
+
+	ctx->config.wb_gain.g_sub = block->wb_gain.g_sub >> 4;
+	ctx->config.wb_gain.b_sub = block->wb_gain.b_sub >> 4;
+	ctx->config.wb_gain.r_sub = block->wb_gain.r_sub >> 4;
+	ctx->config.wb_gain.g_add = block->wb_gain.g_add >> 4;
+	ctx->config.wb_gain.b_add = block->wb_gain.b_add >> 4;
+	ctx->config.wb_gain.r_add = block->wb_gain.r_add >> 4;
+}
+
+static void ope_params_apply_chroma_enhan(void *priv, const union camss_isp_params_block *block)
+{
+	struct ope_ctx *ctx = priv;
+
+	camss_isp_params_copy_block(&ctx->config.chroma_enhan, block,
+				    sizeof(ctx->config.chroma_enhan));
+}
+
+static void ope_params_apply_color_correct(void *priv, const union camss_isp_params_block *block)
+{
+	struct ope_ctx *ctx = priv;
+
+	camss_isp_params_copy_block(&ctx->config.color_correct, block,
+				    sizeof(ctx->config.color_correct));
+}
+
+static void ope_params_apply_gamma(void *priv, const union camss_isp_params_block *block)
+{
+	struct ope_ctx *ctx = priv;
+
+	camss_isp_params_copy_block(&ctx->config.gamma, block, sizeof(ctx->config.gamma));
+}
+
+static const struct v4l2_isp_params_block_type_info ope_params_type_info[] = {
+	[CAMSS_PARAMS_WB_GAIN]       = { sizeof(struct camss_params_wb_gain) },
+	[CAMSS_PARAMS_CHROMA_ENHAN]  = { sizeof(struct camss_params_chroma_enhan) },
+	[CAMSS_PARAMS_COLOR_CORRECT] = { sizeof(struct camss_params_color_correct) },
+	[CAMSS_PARAMS_GAMMA]         = { sizeof(struct camss_params_gamma) },
+};
+
+static const camss_isp_params_handler_fn ope_params_handlers[] = {
+	[CAMSS_PARAMS_WB_GAIN]       = ope_params_apply_wb,
+	[CAMSS_PARAMS_CHROMA_ENHAN]  = ope_params_apply_chroma_enhan,
+	[CAMSS_PARAMS_COLOR_CORRECT] = ope_params_apply_color_correct,
+	[CAMSS_PARAMS_GAMMA]         = ope_params_apply_gamma,
+};
+
+static struct vb2_v4l2_buffer *ope_queue_remove(struct ope_ctx *ctx,
+					 unsigned int idx)
+{
+	struct ope_queue *q = &ctx->queues[idx];
+	struct camss_isp_buf *buf;
+
+	scoped_guard(spinlock_irqsave, &ctx->queues_lock) {
+		buf = list_first_entry_or_null(&q->rdy_queue, struct camss_isp_buf, list);
+		if (buf)
+			list_del(&buf->list);
+	}
+
+	return buf ? &buf->vb : NULL;
+}
+
+static struct vb2_v4l2_buffer *ope_queue_peek(struct ope_ctx *ctx,
+					       unsigned int idx)
+{
+	struct ope_queue *q = &ctx->queues[idx];
+	struct camss_isp_buf *buf;
+
+	scoped_guard(spinlock_irqsave, &ctx->queues_lock)
+		buf = list_first_entry_or_null(&q->rdy_queue, struct camss_isp_buf, list);
+
+	return buf ? &buf->vb : NULL;
+}
+
+static void ope_queue_drain(struct ope_ctx *ctx, unsigned int idx,
+			    enum vb2_buffer_state state)
+{
+	struct vb2_v4l2_buffer *vbuf;
+
+	while ((vbuf = ope_queue_remove(ctx, idx)))
+		vb2_buffer_done(&vbuf->vb2_buf, state);
+}
+
+static void ope_apply_params(struct ope_ctx *ctx)
+{
+	struct vb2_v4l2_buffer *vbuf;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &ctx->queues_lock)
+		if (!ctx->queues[OPE_QUEUE_PARAMS].streaming)
+			return;
+
+	vbuf = ope_queue_remove(ctx, OPE_QUEUE_PARAMS);
+	if (!vbuf)
+		return;
+
+	ret = camss_isp_params_apply(ctx->ope->dev, &vbuf->vb2_buf,
+				     ctx->params_buf,
+				     ope_params_type_info,
+				     ope_params_handlers,
+				     ARRAY_SIZE(ope_params_handlers),
+				     ctx);
+	if (ret)
+		dev_warn_ratelimited(ctx->ope->dev, "invalid parameters\n");
+
+	vb2_buffer_done(&vbuf->vb2_buf, ret ? VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE);
+}
+
+/*
+ * Default/initial tuning parameters.
+ *
+ * Every block is marked dirty so that the defaults are programmed into the
+ * hardware without relying on the first job of a new context being detected
+ * as a context switch.
+ */
+static const struct ope_config ope_default_config = {
+	.wb_gain = {
+		.header.type = CAMSS_PARAMS_WB_GAIN,
+		.header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
+				CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
+		.g_gain = OPE_WB(1, 1),
+		.b_gain = OPE_WB(3, 2),
+		.r_gain = OPE_WB(3, 2),
+	},
+	.demo = {
+		.header.type = CAMSS_PARAMS_INTERNAL,
+		.header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
+				CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
+		.lambda_rb = 0,
+		.lambda_g  = 128,
+		.a_k       = 128,
+		.w_k       = 102,
+	},
+	.chroma_enhan = { /* RGB -> YUV values from BT.601/Full-Range */
+		.header.type = CAMSS_PARAMS_CHROMA_ENHAN,
+		.header.flags = V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
+				CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
+		.luma_v0  =  77, /*  0.301 */
+		.luma_v1  = 150, /*  0.586 */
+		.luma_v2  =  29, /*  0.113 */
+		.luma_k   =   0,
+		.coeff_ap = 119, /*  0.465 */
+		.coeff_am = 112, /*  0.438 */
+		.coeff_bp = -84, /* -0.328 */
+		.coeff_bm = -60, /* -0.234 */
+		.coeff_cp = 134, /*  0.523 */
+		.coeff_cm = 137, /*  0.535 */
+		.coeff_dp =  -1, /* -0.004 */
+		.coeff_dm = -33, /* -0.129 */
+		.kcb      = 128,
+		.kcr      = 128,
+	},
+	.color_correct = {
+		.header.type = CAMSS_PARAMS_COLOR_CORRECT,
+		.header.flags = V4L2_ISP_PARAMS_FL_BLOCK_DISABLE |
+				CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
+	},
+	.gamma = {
+		.header.type = CAMSS_PARAMS_GAMMA,
+		.header.flags = V4L2_ISP_PARAMS_FL_BLOCK_DISABLE |
+				CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY,
+	},
+};
+
+static void ope_try_schedule(struct ope_ctx *ctx);
+static void __ope_irq_init(struct ope_dev *ope);
+
+static int ope_hw_reset_sync(struct ope_dev *ope)
+{
+	guard(mutex)(&ope->reset_mutex);
+
+	reinit_completion(&ope->reset_complete);
+	ope_write(ope, OPE_TOP_RESET_CMD, OPE_TOP_RESET_CMD_SW);
+
+	if (!wait_for_completion_timeout(&ope->reset_complete,
+					 msecs_to_jiffies(OPE_RESET_TIMEOUT_MS)))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ope_hw_reset_poll(struct ope_dev *ope)
+{
+	u32 status;
+	int ret;
+
+	guard(mutex)(&ope->reset_mutex);
+
+	ope_write(ope, OPE_TOP_IRQ_MASK, OPE_TOP_IRQ_STATUS_RST_DONE);
+	ope_write(ope, OPE_TOP_RESET_CMD, OPE_TOP_RESET_CMD_SW);
+
+	ret = read_poll_timeout(ope_read, status,
+				status & OPE_TOP_IRQ_STATUS_RST_DONE,
+				OPE_RESET_POLL_US,
+				OPE_RESET_TIMEOUT_MS * USEC_PER_MSEC, false,
+				ope, OPE_TOP_IRQ_STATUS);
+
+	ope_write(ope, OPE_TOP_IRQ_CLEAR, OPE_TOP_IRQ_STATUS_RST_DONE);
+	ope_write(ope, OPE_TOP_IRQ_CMD, OPE_TOP_IRQ_CMD_CLEAR);
+	__ope_irq_init(ope);
+
+	if (ret)
+		return ret;
+
+	ope_glut_cache_invalidate(ope);
+
+	return 0;
+}
+
+/* -------- Job scheduling -------- */
+
+static bool ope_job_ready(void *priv)
+{
+	struct ope_ctx *ctx = priv;
+
+	guard(spinlock_irqsave)(&ctx->queues_lock);
+
+	return ctx->queues[OPE_QUEUE_FRAME_IN].streaming &&
+	       ctx->queues[OPE_QUEUE_DISP_OUT].streaming &&
+	       !list_empty(&ctx->queues[OPE_QUEUE_FRAME_IN].rdy_queue) &&
+	       !list_empty(&ctx->queues[OPE_QUEUE_DISP_OUT].rdy_queue);
+}
+
+static void ope_job_finish(struct ope_ctx *ctx, enum vb2_buffer_state state)
+{
+	struct vb2_v4l2_buffer *src, *dst;
+	struct ope_dev *ope = ctx->ope;
+
+	scoped_guard(spinlock_irqsave, &ope->sched_lock) {
+		if (ope->curr_ctx != ctx)
+			return;
+
+		ope->curr_ctx = NULL;
+		ope->hw_running = false;
+		ctx->queued = false;
+
+		/* A failed job leaves the configuration in an unknown state */
+		if (state != VB2_BUF_STATE_DONE)
+			ope->hw_ctx = NULL;
+	}
+
+	src = ope_queue_remove(ctx, OPE_QUEUE_FRAME_IN);
+	dst = ope_queue_remove(ctx, OPE_QUEUE_DISP_OUT);
+
+	if (src)
+		src->sequence = ctx->fmt_in.sequence++;
+
+	if (dst) {
+		dst->sequence = ctx->fmt_out.sequence++;
+		if (src)
+			dst->vb2_buf.timestamp = src->vb2_buf.timestamp;
+	}
+
+	if (dst)
+		vb2_buffer_done(&dst->vb2_buf, state);
+	if (src)
+		vb2_buffer_done(&src->vb2_buf, state);
+
+	dev_dbg(ctx->ope->dev, "done ctx=%p state=%u\n", ctx, state);
+
+	ope_try_schedule(ctx);
+}
+
+static dma_addr_t ope_buf_dma_addr(struct ope_ctx *ctx, unsigned int queue_idx)
+{
+	struct vb2_v4l2_buffer *vbuf = ope_queue_peek(ctx, queue_idx);
+
+	if (!vbuf)
+		return 0;
+
+	return vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
+}
+
+static void ope_run_job(struct ope_ctx *ctx, bool ctx_changed)
+{
+	struct ope_dev *ope = ctx->ope;
+	dma_addr_t src, dst;
+
+	src = ope_buf_dma_addr(ctx, OPE_QUEUE_FRAME_IN);
+	dst = ope_buf_dma_addr(ctx, OPE_QUEUE_DISP_OUT);
+
+	if (!src || !dst) {
+		dev_warn(ope->dev, "Job cannot run, missing buffer\n");
+		ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
+		return;
+	}
+
+	dev_dbg(ope->dev, "start ctx=%p->%p src=%pad dst=%pad\n",
+		ope->hw_ctx, ctx, &src, &dst);
+
+	ope_apply_params(ctx);
+
+	if (ope_gen_stripes(ctx, src, dst)) {
+		dev_warn_ratelimited(ope->dev, "Job cannot run, invalid geometry\n");
+		ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
+		return;
+	}
+
+	ope_prog_wb(ctx, ctx_changed);
+	ope_prog_bayer2rgb(ctx, ctx_changed);
+	ope_prog_color_correct(ctx, ctx_changed);
+	ope_prog_gamma(ctx, ctx_changed);
+	ope_prog_rgb2yuv(ctx, ctx_changed);
+
+	/* Program the first stripe and launch processing. */
+	ctx->current_stripe = 0;
+	ope_prog_stripe(ctx, &ctx->stripe[0]);
+
+	/* Hand the job over to the interrupt handler */
+	scoped_guard(spinlock_irqsave, &ope->sched_lock) {
+		ope->hw_ctx = ctx;
+		ope->hw_running = true;
+	}
+
+	ope_start(ope);
+}
+
+static void ope_sched_pause(struct ope_dev *ope)
+{
+	scoped_guard(spinlock_irqsave, &ope->sched_lock)
+		ope->sched_paused++;
+
+	cancel_work_sync(&ope->run_work);
+}
+
+static void ope_flush_hw(struct ope_dev *ope)
+{
+	struct ope_ctx *ctx;
+
+	guard(mutex)(&ope->mutex);
+
+	/* Drain a handler that may still be reading registers */
+	synchronize_irq(ope->irq);
+
+	scoped_guard(spinlock_irqsave, &ope->sched_lock)
+		ctx = ope->curr_ctx;
+
+	if (!ctx)
+		return;
+
+	if (ope_hw_reset_poll(ope))
+		dev_err(ope->dev, "reset timeout while flushing\n");
+
+	scoped_guard(spinlock_irqsave, &ope->sched_lock)
+		ope->hw_ctx = NULL;
+
+	ope_glut_cache_invalidate(ope);
+
+	ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
+}
+
+static void ope_sched_cancel(struct ope_ctx *ctx)
+{
+	struct ope_dev *ope = ctx->ope;
+	bool running;
+
+	ope_sched_pause(ope);
+
+	scoped_guard(spinlock_irqsave, &ope->sched_lock) {
+		running = (ope->hw_running && ope->hw_ctx == ctx);
+		ctx->queued = false;
+		if (running)
+			ope->hw_running = false;
+	}
+
+	/* Drain any handler that loaded ctx before hw_running was cleared */
+	synchronize_irq(ope->irq);
+
+	/* If the hardware is running the context, reset it */
+	if (running) {
+		if (ope_hw_reset_sync(ope))
+			dev_err(ope->dev, "reset timeout during cancel\n");
+
+		ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
+	}
+
+	/* Mark the context as no longer queued/running */
+	scoped_guard(spinlock_irqsave, &ope->sched_lock) {
+		if (ope->curr_ctx == ctx) {
+			ctx->queued = false;
+			ope->curr_ctx = NULL;
+		}
+
+		if (ope->hw_ctx == ctx) {
+			ope->hw_ctx = NULL;
+			ope->hw_running = false;
+		}
+	}
+}
+
+static void ope_sched_resume(struct ope_dev *ope)
+{
+	struct ope_ctx *ctx;
+	bool resume;
+
+	scoped_guard(spinlock_irqsave, &ope->sched_lock) {
+		if (WARN_ON(!ope->sched_paused))
+			return;
+		resume = (--ope->sched_paused == 0);
+	}
+
+	if (!resume)
+		return;
+
+	scoped_guard(spinlock, &ope->ctx_lock)
+		list_for_each_entry(ctx, &ope->ctx_list, list)
+			ope_try_schedule(ctx);
+}
+
+static void ope_run_work(struct work_struct *work)
+{
+	struct ope_dev *ope = container_of(work, struct ope_dev, run_work);
+	struct ope_ctx *ctx;
+	bool ctx_changed;
+
+	if (unlikely(!ope_hw_available(ope)))
+		return;
+
+	scoped_guard(spinlock_irqsave, &ope->sched_lock) {
+		ctx = ope->curr_ctx;
+
+		if (!ctx || !ctx->queued || ope->hw_running)
+			return;
+
+		if (!ope_job_ready(ctx)) {
+			ctx->queued = false;
+			ope->curr_ctx = NULL;
+			return;
+		}
+
+		ctx_changed = (ope->hw_ctx != ctx);
+	}
+
+	ope_run_job(ctx, ctx_changed);
+}
+
+static void ope_try_schedule(struct ope_ctx *ctx)
+{
+	struct ope_dev *ope = ctx->ope;
+
+	if (!ope_job_ready(ctx))
+		return;
+
+	guard(spinlock_irqsave)(&ope->sched_lock);
+
+	if (ope->sched_paused || ctx->queued || ope->curr_ctx)
+		return;
+
+	ctx->queued = true;
+	ope->curr_ctx = ctx;
+
+	schedule_work(&ope->run_work);
+}
+
+/* -------- Interrupt handlers -------- */
+
+static void ope_fe_irq(struct ope_dev *ope)
+{
+	u32 status = readl_relaxed(ope->base_rd + OPE_BUS_RD_INPUT_IF_IRQ_STATUS);
+
+	writel_relaxed(status, ope->base_rd + OPE_BUS_RD_INPUT_IF_IRQ_CLEAR);
+	writel_relaxed(OPE_BUS_RD_INPUT_IF_IRQ_CMD_CLEAR,
+		       ope->base_rd + OPE_BUS_RD_INPUT_IF_IRQ_CMD);
+
+	if (status & OPE_BUS_RD_INPUT_IF_IRQ_STATUS_CCIF_VIOL)
+		dev_err_ratelimited(ope->dev, "FE: CCIF violation (status=0x%08x)\n", status);
+}
+
+static bool ope_we_irq(struct ope_dev *ope, struct ope_ctx *ctx)
+{
+	bool reset = false;
+	u32 status;
+
+	status = ope_read_wr(ope, OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0);
+	ope_write_wr(ope, OPE_BUS_WR_INPUT_IF_IRQ_CLEAR_0, status);
+	ope_write_wr(ope, OPE_BUS_WR_INPUT_IF_IRQ_CMD, OPE_BUS_WR_INPUT_IF_IRQ_CMD_CLEAR);
+
+	if (!ctx)
+		return false;
+
+	if (status & OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_CONS_VIOL) {
+		u32 viol = ope_read_wr(ope, OPE_BUS_WR_VIOLATION_STATUS);
+
+		dev_err_ratelimited(ope->dev, "constraint violation (clients=0x%x)\n", viol);
+		reset = true;
+	}
+
+	if (status & OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_IMG_SZ_VIOL) {
+		u32 viol = ope_read_wr(ope, OPE_BUS_WR_IMAGE_SIZE_VIOLATION_STATUS);
+
+		for (int i = 0; i < OPE_WR_CLIENT_MAX; i++) {
+			if (BIT(i) & viol)
+				dev_err_ratelimited(ope->dev, "WE%d: image size violation\n", i);
+		}
+		reset = true;
+	}
+
+	if (status & OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_VIOL) {
+		u32 viol = ope_read_wr(ope, OPE_BUS_WR_VIOLATION_STATUS);
+
+		dev_err_ratelimited(ope->dev, "fatal violation (status=0x%08x)\n", viol);
+		reset = true;
+	}
+
+	if (reset) {
+		ope_write(ctx->ope, OPE_TOP_RESET_CMD, OPE_TOP_RESET_CMD_SW);
+		return true;
+	}
+
+	if (status & OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_RUP_DONE) {
+		/* Register update done: program next stripe (double-buffered) */
+		struct ope_stripe *stripe = ope_current_stripe(ctx);
+
+		if (stripe && !ope_stripe_is_last(stripe))
+			ope_prog_stripe(ctx, stripe + 1);
+	}
+
+	return false;
+}
+
+static void __ope_irq_init(struct ope_dev *ope)
+{
+	ope_write(ope, OPE_TOP_IRQ_MASK,
+		  OPE_TOP_IRQ_STATUS_RST_DONE |
+		  OPE_TOP_IRQ_STATUS_WE |
+		  OPE_TOP_IRQ_STATUS_FE |
+		  OPE_TOP_IRQ_STATUS_VIOL |
+		  OPE_TOP_IRQ_STATUS_IDLE);
+	ope_write_wr(ope, OPE_BUS_WR_INPUT_IF_IRQ_MASK_0,
+		     OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_RUP_DONE |
+		     OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_CONS_VIOL |
+		     OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_VIOL |
+		     OPE_BUS_WR_INPUT_IF_IRQ_STATUS_0_IMG_SZ_VIOL);
+	/* The fetch engine only needs to report bus errors */
+	writel_relaxed(OPE_BUS_RD_INPUT_IF_IRQ_STATUS_CCIF_VIOL,
+		       ope->base_rd + OPE_BUS_RD_INPUT_IF_IRQ_MASK);
+}
+
+static irqreturn_t __ope_irq(struct ope_dev *ope)
+{
+	struct ope_ctx *ctx;
+	u32 status;
+
+	/*
+	 * Once the job has been claimed and completed, hw_running is clear and
+	 * ctx stays NULL here, so a late interrupt cannot restart a stripe on
+	 * buffers already handed back to vb2.
+	 */
+	scoped_guard(spinlock, &ope->sched_lock)
+		ctx = ope->hw_running ? ope->hw_ctx : NULL;
+
+	status = ope_read(ope, OPE_TOP_IRQ_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	ope_write(ope, OPE_TOP_IRQ_CLEAR, status);
+	ope_write(ope, OPE_TOP_IRQ_CMD, OPE_TOP_IRQ_CMD_CLEAR);
+
+	if (status & OPE_TOP_IRQ_STATUS_RST_DONE) {
+		dev_dbg(ope->dev, "reset done ctx=%p\n", ctx);
+		ope_glut_cache_invalidate(ope);
+		__ope_irq_init(ope);
+		if (ctx)
+			ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
+
+		complete(&ope->reset_complete);
+
+		return IRQ_HANDLED;
+	}
+
+	if (status & OPE_TOP_IRQ_STATUS_VIOL)
+		dev_warn(ope->dev, "OPE violation: 0x%08x\n",
+			 ope_read(ope, OPE_TOP_VIOLATION_STATUS));
+
+	if (status & OPE_TOP_IRQ_STATUS_FE)
+		ope_fe_irq(ope);
+
+	if (status & OPE_TOP_IRQ_STATUS_WE) {
+		if (ope_we_irq(ope, ctx))
+			return IRQ_HANDLED;
+	}
+
+	if ((status & OPE_TOP_IRQ_STATUS_IDLE) && ctx) {
+		struct ope_stripe *stripe = ope_current_stripe(ctx);
+
+		dev_dbg(ope->dev, "stripe %u done ctx=%p\n", ctx->current_stripe, ctx);
+
+		if (unlikely(!stripe)) {
+			dev_err(ope->dev, "stripe index %u out of range\n", ctx->current_stripe);
+			ctx->current_stripe = 0;
+			ope_job_finish(ctx, VB2_BUF_STATE_ERROR);
+		} else if (ope_stripe_is_last(stripe)) {
+			ctx->current_stripe = 0;
+			ope_job_finish(ctx, VB2_BUF_STATE_DONE);
+		} else {
+			ctx->current_stripe++;
+			ope_start(ope);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ope_irq(int irq, void *dev_id)
+{
+	struct ope_dev *ope = dev_id;
+	irqreturn_t ret;
+
+	/*
+	 * Increment the usage counter only to guarantee registers
+	 * accessibility + ensure that IRQ is expected (job running).
+	 * A negative return means runtime PM is disabled, i.e. the device is
+	 * suspending or being unbound, and the registers are not clocked.
+	 */
+	if (pm_runtime_get_if_in_use(ope->dev) <= 0)
+		return IRQ_NONE;
+
+	ret = __ope_irq(ope);
+
+	pm_runtime_put(ope->dev);
+
+	return ret;
+}
+
+/* -------- vb2 queue private data -------- */
+
+struct ope_vq_priv {
+	struct ope_ctx		*ctx;
+	unsigned int		queue_idx;
+	struct video_device	*vdev;
+};
+
+static inline struct ope_ctx *ope_ctx_from_vq(struct vb2_queue *q)
+{
+	return ((struct ope_vq_priv *)vb2_get_drv_priv(q))->ctx;
+}
+
+static inline unsigned int ope_idx_from_vq(struct vb2_queue *q)
+{
+	return ((struct ope_vq_priv *)vb2_get_drv_priv(q))->queue_idx;
+}
+
+static inline struct video_device *ope_vdev_from_vq(struct vb2_queue *q)
+{
+	return ((struct ope_vq_priv *)vb2_get_drv_priv(q))->vdev;
+}
+
+/* -------- vb2 ops -------- */
+
+static int ope_queue_setup(struct vb2_queue *q, unsigned int *nbuffers,
+			   unsigned int *nplanes, unsigned int sizes[],
+			   struct device *alloc_devs[])
+{
+	struct ope_ctx *ctx = ope_ctx_from_vq(q);
+	unsigned int idx = ope_idx_from_vq(q);
+	unsigned int size;
+
+	if (idx == OPE_QUEUE_FRAME_IN)
+		size = ctx->fmt_in.sizeimage ? ctx->fmt_in.sizeimage : PAGE_SIZE;
+	else if (idx == OPE_QUEUE_DISP_OUT)
+		size = ctx->fmt_out.sizeimage ? ctx->fmt_out.sizeimage : PAGE_SIZE;
+	else
+		size = v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOAD);
+
+	if (*nplanes) {
+		if (*nplanes != 1 || sizes[0] < size)
+			return -EINVAL;
+	} else {
+		*nplanes = 1;
+		sizes[0] = size;
+	}
+
+	return 0;
+}
+
+static int ope_buf_prepare(struct vb2_buffer *vb)
+{
+	struct ope_ctx *ctx = ope_ctx_from_vq(vb->vb2_queue);
+	unsigned int idx = ope_idx_from_vq(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	unsigned int sizeimage;
+
+	if (idx == OPE_QUEUE_FRAME_IN)
+		sizeimage = ctx->fmt_in.sizeimage;
+	else if (idx == OPE_QUEUE_DISP_OUT)
+		sizeimage = ctx->fmt_out.sizeimage;
+	else
+		sizeimage = v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOAD);
+
+	if (V4L2_TYPE_IS_OUTPUT(vb->vb2_queue->type)) {
+		if (vb->vb2_queue->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
+			if (vbuf->field == V4L2_FIELD_ANY)
+				vbuf->field = V4L2_FIELD_NONE;
+			if (vbuf->field != V4L2_FIELD_NONE)
+				return -EINVAL;
+		}
+	}
+
+	if (vb2_plane_size(vb, 0) < sizeimage)
+		return -EINVAL;
+
+	if (V4L2_TYPE_IS_CAPTURE(vb->vb2_queue->type))
+		vb2_set_plane_payload(vb, 0, sizeimage);
+
+	return 0;
+}
+
+static void ope_buf_queue(struct vb2_buffer *vb)
+{
+	struct ope_ctx *ctx = ope_ctx_from_vq(vb->vb2_queue);
+	unsigned int idx = ope_idx_from_vq(vb->vb2_queue);
+	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
+	struct camss_isp_buf *buf = container_of(vbuf, struct camss_isp_buf, vb);
+
+	scoped_guard(spinlock_irqsave, &ctx->queues_lock)
+		list_add_tail(&buf->list, &ctx->queues[idx].rdy_queue);
+
+	ope_try_schedule(ctx);
+}
+
+/* -------- Power scaling -------- */
+
+static inline unsigned long ope_pixclk(const struct ope_fmt_state *fs, unsigned int fps)
+{
+	return (unsigned long)fs->width * fs->height * fps;
+}
+
+static inline unsigned int ope_load_avg(const struct ope_fmt_state *fs, unsigned int fps)
+{
+	return mult_frac(ope_pixclk(fs, fps), fs->fmt->depth, 1000) / 8;
+}
+
+static inline unsigned int ope_load_peak(const struct ope_fmt_state *fs, unsigned int fps)
+{
+	return ope_load_avg(fs, fps) * 2;
+}
+
+static inline unsigned int ope_load_config(const struct ope_fmt_state *fs, unsigned int fps)
+{
+	unsigned int stripe_count = fs->width / OPE_STRIPE_MAX_W + 1;
+
+	/* In worst case we have ~50 32-bit registers to write */
+	return mult_frac(stripe_count * 50 * 4, fps, 1000);
+}
+
+static void ope_adjust_power(struct ope_dev *ope)
+{
+	unsigned int loadavg = 0, loadpeak = 0, loadconfig = 0;
+	s32 latency = PM_QOS_DEFAULT_VALUE;
+	unsigned long pixclk = 0;
+	struct dev_pm_opp *opp;
+	struct ope_ctx *ctx;
+	int ret;
+
+	guard(mutex)(&ope->mutex);
+
+	if (unlikely(!ope_hw_available(ope)))
+		return;
+
+	/* ope mutex is held, which is what ctx_list is mutated under: no ctx_lock */
+	list_for_each_entry(ctx, &ope->ctx_list, list) {
+		unsigned int fps;
+
+		if (!ctx->queues[OPE_QUEUE_FRAME_IN].streaming)
+			continue;
+
+		fps = ctx->framerate ? ctx->framerate : DEFAULT_FRAMERATE;
+
+		pixclk     += ope_pixclk(&ctx->fmt_in, fps);
+		loadavg    += ope_load_avg(&ctx->fmt_in,  fps);
+		loadavg    += ope_load_avg(&ctx->fmt_out, fps);
+		loadpeak   += ope_load_peak(&ctx->fmt_in,  fps);
+		loadpeak   += ope_load_peak(&ctx->fmt_out, fps);
+		loadconfig += ope_load_config(&ctx->fmt_in, fps);
+		latency = 100;
+	}
+
+	/* 30% margin for overhead */
+	pixclk = mult_frac(pixclk, 13, 10);
+
+	dev_dbg(ope->dev, "adjust power: clk=%luHz avg=%uKBps peak=%uKBps cfg=%uKBps lat=%dus\n",
+		pixclk, loadavg, loadpeak, loadconfig, latency);
+
+	/* Keep the rate at zero when idle, so that the OPP vote is released */
+	if (pixclk) {
+		opp = dev_pm_opp_find_freq_ceil(ope->dev, &pixclk);
+		if (IS_ERR(opp)) {
+			unsigned long max_freq = ULONG_MAX;
+
+			dev_warn(ope->dev, "Requested pixel clock %luHz exceeds hardware limit\n",
+				 pixclk);
+
+			/* Clamp to the highest available OPP */
+			opp = dev_pm_opp_find_freq_floor(ope->dev, &max_freq);
+			if (!IS_ERR(opp)) {
+				pixclk = max_freq;
+				dev_pm_opp_put(opp);
+			}
+		} else {
+			dev_pm_opp_put(opp);
+		}
+	}
+
+	ret = dev_pm_opp_set_rate(ope->dev, pixclk);
+	if (ret)
+		dev_warn(ope->dev, "Failed to set OPP rate: %d\n", ret);
+
+	ret = icc_set_bw(ope->icc_data, loadavg, loadpeak);
+	if (ret)
+		dev_warn(ope->dev, "Failed to set data path BW: %d\n", ret);
+
+	ret = icc_set_bw(ope->icc_config, loadconfig, loadconfig * 5);
+	if (ret)
+		dev_warn(ope->dev, "Failed to set config path BW: %d\n", ret);
+
+	cpu_latency_qos_update_request(&ope->qos_req, latency);
+}
+
+static int ope_start_streaming(struct vb2_queue *q, unsigned int count)
+{
+	struct ope_ctx *ctx = ope_ctx_from_vq(q);
+	struct video_device *vdev = ope_vdev_from_vq(q);
+	unsigned int idx = ope_idx_from_vq(q);
+	int ret;
+
+	dev_dbg(ctx->ope->dev, "streaming start ctx=%p queue=%u\n", ctx, idx);
+
+	if (!ope_hw_available(ctx->ope)) {
+		ret = -ENODEV;
+		goto err_drain;
+	}
+
+	ret = video_device_pipeline_alloc_start(vdev);
+	if (ret)
+		goto err_drain;
+
+	ret = pm_runtime_resume_and_get(ctx->ope->dev);
+	if (ret) {
+		dev_err(ctx->ope->dev, "resume failed (%d)\n", ret);
+		goto err_pipeline_stop;
+	}
+
+	/* From here on a job is allowed to consume this queue's buffers */
+	scoped_guard(spinlock_irqsave, &ctx->queues_lock)
+		ctx->queues[idx].streaming = true;
+
+	if (idx == OPE_QUEUE_FRAME_IN) {
+		ctx->fmt_in.sequence = 0;
+		ope_adjust_power(ctx->ope);
+	} else if (idx == OPE_QUEUE_DISP_OUT) {
+		ctx->fmt_out.sequence = 0;
+	}
+
+	ope_try_schedule(ctx);
+
+	return 0;
+
+err_pipeline_stop:
+	video_device_pipeline_stop(vdev);
+err_drain:
+	ope_queue_drain(ctx, idx, VB2_BUF_STATE_QUEUED);
+	return ret;
+}
+
+static void ope_stop_streaming(struct vb2_queue *q)
+{
+	struct ope_ctx *ctx = ope_ctx_from_vq(q);
+	struct video_device *vdev = ope_vdev_from_vq(q);
+	unsigned int idx = ope_idx_from_vq(q);
+
+	dev_dbg(ctx->ope->dev, "streaming stop ctx=%p queue=%u\n", ctx, idx);
+
+	scoped_guard(spinlock_irqsave, &ctx->queues_lock)
+		ctx->queues[idx].streaming = false;
+
+	if (idx == OPE_QUEUE_PARAMS) {
+		/* Params are consumed by the CPU, there is no job to abort */
+		flush_work(&ctx->ope->run_work);
+		ope_queue_drain(ctx, idx, VB2_BUF_STATE_ERROR);
+	} else {
+		/* Drain with the scheduler held off, so no job can pick up a buffer */
+		ope_sched_cancel(ctx);
+		ope_queue_drain(ctx, idx, VB2_BUF_STATE_ERROR);
+		ope_sched_resume(ctx->ope);
+	}
+
+	if (idx == OPE_QUEUE_FRAME_IN)
+		ope_adjust_power(ctx->ope);
+
+	pm_runtime_put(ctx->ope->dev);
+
+	if (video_device_pipeline(vdev))
+		video_device_pipeline_stop(vdev);
+}
+
+static const struct vb2_ops ope_vb2_ops = {
+	.queue_setup     = ope_queue_setup,
+	.buf_prepare     = ope_buf_prepare,
+	.buf_queue       = ope_buf_queue,
+	.start_streaming = ope_start_streaming,
+	.stop_streaming  = ope_stop_streaming,
+};
+
+static const unsigned int ope_queue_to_entity[] = {
+	[OPE_QUEUE_FRAME_IN] = OPE_ENTITY_FRAME_IN,
+	[OPE_QUEUE_DISP_OUT] = OPE_ENTITY_DISP_OUT,
+	[OPE_QUEUE_PARAMS]   = OPE_ENTITY_PARAMS,
+};
+
+static int ope_init_vq(struct ope_ctx *ctx, unsigned int idx)
+{
+	struct ope_dev *ope = ctx->ope;
+	struct ope_vq_priv *qpriv;
+	struct vb2_queue *q = &ctx->queues[idx].vq;
+	int ret;
+
+	qpriv = kzalloc_obj(*qpriv);
+	if (!qpriv)
+		return -ENOMEM;
+
+	qpriv->ctx = ctx;
+	qpriv->queue_idx = idx;
+	qpriv->vdev = camss_isp_pipeline_get_vdev(ope->pipeline, ope_queue_to_entity[idx]);
+	q->drv_priv = qpriv;
+	q->ops = &ope_vb2_ops;
+	q->lock = &ctx->vbq_lock;
+	q->dev = ope->dev;
+	q->buf_struct_size    = sizeof(struct camss_isp_buf);
+	q->timestamp_flags    = V4L2_BUF_FLAG_TIMESTAMP_COPY;
+	q->min_queued_buffers = (idx == OPE_QUEUE_PARAMS) ? 0 : 1;
+
+	if (idx == OPE_QUEUE_PARAMS) {
+		q->type = V4L2_BUF_TYPE_META_OUTPUT;
+		q->mem_ops = &vb2_vmalloc_memops;
+		q->io_modes = VB2_MMAP | VB2_USERPTR;
+	} else if (idx == OPE_QUEUE_DISP_OUT) {
+		q->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
+		q->mem_ops = &vb2_dma_contig_memops;
+		q->io_modes = VB2_MMAP | VB2_DMABUF;
+	} else {
+		q->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
+		q->mem_ops = &vb2_dma_contig_memops;
+		q->io_modes = VB2_MMAP | VB2_DMABUF;
+	}
+
+	ret = vb2_queue_init(q);
+	if (ret) {
+		q->drv_priv = NULL;
+		kfree(qpriv);
+		return ret;
+	}
+
+	/* Only valid because there is a single device-wide ope_ctx for now */
+	qpriv->vdev->queue = q;
+
+	return 0;
+}
+
+static void ope_deinit_vq(struct ope_ctx *ctx, unsigned int idx)
+{
+	struct vb2_queue *q = &ctx->queues[idx].vq;
+	struct ope_vq_priv *qpriv = q->drv_priv;
+
+	qpriv->vdev->queue = NULL;
+	vb2_queue_release(q);
+	q->owner = NULL;
+	kfree(q->drv_priv);
+	q->drv_priv = NULL;
+}
+
+/* -------- Format helpers -------- */
+
+static const struct ope_fmt *ope_find_fmt(const struct ope_fmt *fmts,
+				  unsigned int n, u32 fourcc)
+{
+	for (unsigned int i = 0; i < n; i++)
+		if (fmts[i].fourcc == fourcc)
+			return &fmts[i];
+
+	return NULL;
+}
+
+static const struct ope_fmt *ope_fmt_try(struct ope_dev *ope, bool is_output,
+					 struct v4l2_pix_format_mplane *pix)
+{
+	const struct ope_fmt *fmts = is_output ? ope_output_fmts : ope_input_fmts;
+	unsigned int n = is_output ? ARRAY_SIZE(ope_output_fmts) : ARRAY_SIZE(ope_input_fmts);
+	unsigned int max_w = OPE_MAX_W, max_h = OPE_MAX_H;
+	const struct ope_fmt *fmt;
+	unsigned int bytesperline;
+	unsigned int max_bpl;
+	unsigned int align;
+	unsigned int halign;
+
+	fmt = ope_find_fmt(fmts, n, pix->pixelformat);
+	if (!fmt) {
+		fmt = &fmts[0];
+		pix->pixelformat = fmt->fourcc;
+	}
+
+	/* Chroma-subsampled output formats need an even height */
+	halign = (is_output && fmt->c_vsub == 2) ? 1 : 0;
+
+	v4l_bound_align_image(&pix->width,  OPE_MIN_W, max_w, fmt->align,
+			      &pix->height, OPE_MIN_H, max_h, halign, 0);
+
+	pix->num_planes = 1;
+	pix->field = V4L2_FIELD_NONE;
+	if (!pix->colorspace)
+		pix->colorspace = is_output ? V4L2_COLORSPACE_SRGB : V4L2_COLORSPACE_RAW;
+	if (is_output) {
+		pix->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(pix->colorspace);
+		pix->quantization = V4L2_QUANTIZATION_FULL_RANGE;
+	}
+
+	/* Output formats are semi-planar or grey-scale (Y plane only) always
+	 * using 1 byte per Y value. pix->bytesperline stores the Y-plane bpl.
+	 * Depth tracks the total storage size including the second combined
+	 * Cb + Cr plane which directly follows the Y plane and is used for
+	 * sizeimage calculations rather then for bytesperline.
+	 */
+	if (is_output)
+		bytesperline = pix->width;
+	else
+		bytesperline = pix->width * fmt->depth / 8;
+
+	if (pix->plane_fmt[0].bytesperline > bytesperline)
+		bytesperline = pix->plane_fmt[0].bytesperline;
+
+	/* The WE requires the C plane base address to be 16-byte aligned.
+	 * c_base = bpl * img_h + (compose_top / c_vsub) * c_stride with
+	 * c_stride = bpl * 2 / c_hsub, so a 16-byte aligned bpl covers both
+	 * terms for any img_h and compose_top. The WE stride field is 16-bit
+	 * wide, so bpl is also capped to keep c_stride in range.
+	 * GREY: no C plane, no constraint.
+	 */
+	if (is_output && fmt->fourcc != V4L2_PIX_FMT_GREY) {
+		align = 16;
+		max_bpl = OPE_MAX_STRIDE * fmt->c_hsub / 2;
+	} else {
+		align = 1;
+		max_bpl = OPE_MAX_STRIDE;
+	}
+
+	bytesperline = min(bytesperline, ALIGN_DOWN(max_bpl, align));
+	bytesperline = ALIGN(bytesperline, align);
+
+	pix->plane_fmt[0].bytesperline = bytesperline;
+
+	if (is_output)
+		pix->plane_fmt[0].sizeimage = (u64)bytesperline * pix->height * fmt->depth / 8;
+	else
+		pix->plane_fmt[0].sizeimage = (u64)bytesperline * pix->height;
+
+	return fmt;
+}
+
+/* True for the whole vb2 start_streaming()..stop_streaming() window */
+static bool ope_ctx_is_busy(struct ope_ctx *ctx)
+{
+	for (unsigned int i = 0; i < OPE_QUEUE_COUNT; i++)
+		if (vb2_start_streaming_called(&ctx->queues[i].vq))
+			return true;
+
+	return false;
+}
+
+/* -------- ioctl helpers/ops -------- */
+
+static inline unsigned int ope_queue_idx_from_file(struct file *file)
+{
+	return (unsigned int)(uintptr_t)video_get_drvdata(video_devdata(file));
+}
+
+static struct vb2_queue *ope_vq_from_file(struct file *file, struct ope_ctx *ctx)
+{
+	unsigned int idx = ope_queue_idx_from_file(file);
+
+	if (idx >= OPE_QUEUE_COUNT)
+		return NULL;
+
+	return &ctx->queues[idx].vq;
+}
+
+static struct ope_ctx *ope_ctx_from_file(struct file *file)
+{
+	struct ope_dev *ope = container_of(video_devdata(file)->v4l2_dev,
+					   struct ope_dev, v4l2_dev);
+
+	return ope->shared_ctx;
+}
+
+static int ope_querycap(struct file *file, void *priv, struct v4l2_capability *cap)
+{
+	strscpy(cap->driver, OPE_NAME, sizeof(cap->driver));
+	strscpy(cap->card, "Qualcomm CAMSS OPE", sizeof(cap->card));
+
+	return 0;
+}
+
+static int ope_enum_fmt_vid_out(struct file *file, void *priv, struct v4l2_fmtdesc *f)
+{
+	unsigned int i, n = 0;
+
+	for (i = 0; i < ARRAY_SIZE(ope_input_fmts); i++) {
+		if (f->mbus_code && ope_input_fmts[i].mbus_code != f->mbus_code)
+			continue;
+		if (n++ == f->index) {
+			f->pixelformat = ope_input_fmts[i].fourcc;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ope_g_fmt_vid_out(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct ope_fmt_state *fs = &ctx->fmt_in;
+	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
+
+	pix->pixelformat		= fs->fmt->fourcc;
+	pix->width			= fs->width;
+	pix->height			= fs->height;
+	pix->num_planes			= 1;
+	pix->field			= V4L2_FIELD_NONE;
+	pix->colorspace			= fs->colorspace;
+	pix->xfer_func			= fs->xfer_func;
+	pix->ycbcr_enc			= fs->ycbcr_enc;
+	pix->quantization		= fs->quantization;
+	pix->plane_fmt[0].bytesperline	= fs->bytesperline;
+	pix->plane_fmt[0].sizeimage	= fs->sizeimage;
+
+	return 0;
+}
+
+static int ope_try_fmt_vid_out(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+
+	ope_fmt_try(ctx->ope, false, &f->fmt.pix_mp);
+
+	return 0;
+}
+
+static int ope_s_fmt_vid_out(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	const struct ope_fmt *fmt;
+
+	guard(mutex)(&ctx->vbq_lock);
+
+	if (ope_ctx_is_busy(ctx) || vb2_is_busy(&ctx->queues[OPE_QUEUE_FRAME_IN].vq))
+		return -EBUSY;
+
+	fmt = ope_fmt_try(ctx->ope, false, &f->fmt.pix_mp);
+	ctx->fmt_in.fmt		    = fmt;
+	ctx->fmt_in.width	    = f->fmt.pix_mp.width;
+	ctx->fmt_in.height	    = f->fmt.pix_mp.height;
+	ctx->fmt_in.bytesperline    = f->fmt.pix_mp.plane_fmt[0].bytesperline;
+	ctx->fmt_in.sizeimage	    = f->fmt.pix_mp.plane_fmt[0].sizeimage;
+	ctx->fmt_in.colorspace	    = f->fmt.pix_mp.colorspace;
+	ctx->fmt_in.xfer_func	    = f->fmt.pix_mp.xfer_func;
+	ctx->fmt_in.ycbcr_enc	    = f->fmt.pix_mp.ycbcr_enc;
+	ctx->fmt_in.quantization    = f->fmt.pix_mp.quantization;
+
+	return 0;
+}
+
+static int ope_enum_fmt_vid_cap(struct file *file, void *priv, struct v4l2_fmtdesc *f)
+{
+	unsigned int i, n = 0;
+
+	for (i = 0; i < ARRAY_SIZE(ope_output_fmts); i++) {
+		if (f->mbus_code && ope_output_fmts[i].mbus_code != f->mbus_code)
+			continue;
+		if (n++ == f->index) {
+			f->pixelformat = ope_output_fmts[i].fourcc;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ope_g_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct ope_fmt_state *fs = &ctx->fmt_out;
+	struct v4l2_pix_format_mplane *pix = &f->fmt.pix_mp;
+
+	pix->pixelformat		= fs->fmt->fourcc;
+	pix->width			= fs->width;
+	pix->height			= fs->height;
+	pix->num_planes			= 1;
+	pix->field			= V4L2_FIELD_NONE;
+	pix->colorspace			= fs->colorspace;
+	pix->xfer_func			= fs->xfer_func;
+	pix->ycbcr_enc			= fs->ycbcr_enc;
+	pix->quantization		= fs->quantization;
+	pix->plane_fmt[0].bytesperline	= fs->bytesperline;
+	pix->plane_fmt[0].sizeimage	= fs->sizeimage;
+
+	return 0;
+}
+
+static int ope_try_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+
+	ope_fmt_try(ctx->ope, true, &f->fmt.pix_mp);
+
+	return 0;
+}
+
+static int ope_s_fmt_vid_cap(struct file *file, void *priv, struct v4l2_format *f)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	const struct ope_fmt *fmt;
+
+	guard(mutex)(&ctx->vbq_lock);
+
+	if (ope_ctx_is_busy(ctx) || vb2_is_busy(&ctx->queues[OPE_QUEUE_DISP_OUT].vq))
+		return -EBUSY;
+
+	fmt = ope_fmt_try(ctx->ope, true, &f->fmt.pix_mp);
+
+	ctx->fmt_out.fmt	    = fmt;
+	ctx->fmt_out.width	    = f->fmt.pix_mp.width;
+	ctx->fmt_out.height	    = f->fmt.pix_mp.height;
+	ctx->fmt_out.bytesperline   = f->fmt.pix_mp.plane_fmt[0].bytesperline;
+	ctx->fmt_out.sizeimage	    = f->fmt.pix_mp.plane_fmt[0].sizeimage;
+	ctx->fmt_out.colorspace	    = f->fmt.pix_mp.colorspace;
+	ctx->fmt_out.xfer_func	    = f->fmt.pix_mp.xfer_func;
+	ctx->fmt_out.ycbcr_enc	    = f->fmt.pix_mp.ycbcr_enc;
+	ctx->fmt_out.quantization   = f->fmt.pix_mp.quantization;
+
+	return 0;
+}
+
+static int ope_g_fmt_meta(struct file *file, void *priv, struct v4l2_format *f)
+{
+	f->fmt.meta.dataformat = V4L2_META_FMT_QCOM_ISP_PARAMS;
+	f->fmt.meta.buffersize = v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOAD);
+
+	return 0;
+}
+
+static int ope_enum_fmt_meta_out(struct file *file, void *priv, struct v4l2_fmtdesc *f)
+{
+	if (f->index > 0)
+		return -EINVAL;
+
+	if (f->mbus_code && f->mbus_code != MEDIA_BUS_FMT_FIXED)
+		return -EINVAL;
+
+	f->pixelformat = V4L2_META_FMT_QCOM_ISP_PARAMS;
+
+	return 0;
+}
+
+static int ope_g_parm(struct file *file, void *priv, struct v4l2_streamparm *sp)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+
+	if (!V4L2_TYPE_IS_OUTPUT(sp->type))
+		return -EINVAL;
+
+	sp->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+	sp->parm.output.timeperframe = ctx->fmt_in.timeperframe;
+
+	return 0;
+}
+
+static int ope_s_parm(struct file *file, void *priv, struct v4l2_streamparm *sp)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct v4l2_fract *tpf = &sp->parm.output.timeperframe;
+
+	if (!V4L2_TYPE_IS_OUTPUT(sp->type))
+		return -EINVAL;
+
+	guard(mutex)(&ctx->vbq_lock);
+
+	if (vb2_is_busy(&ctx->queues[OPE_QUEUE_FRAME_IN].vq))
+		return -EBUSY;
+
+	if (!tpf->denominator)
+		tpf->denominator = 1;
+	if (!tpf->numerator)
+		tpf->numerator = 1;
+
+	ctx->framerate = clamp(tpf->denominator / tpf->numerator, 1U, (u32)OPE_MAX_FRAMERATE);
+	tpf->numerator = 1;
+	tpf->denominator = ctx->framerate;
+
+	ctx->fmt_in.timeperframe = *tpf;
+	sp->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
+
+	return 0;
+}
+
+static int ope_enum_framesizes(struct file *file, void *priv, struct v4l2_frmsizeenum *fsize)
+{
+	unsigned int idx = ope_queue_idx_from_file(file);
+	const struct ope_fmt *fmts, *fmt;
+	unsigned int n;
+
+	if (idx == OPE_QUEUE_FRAME_IN) {
+		fmts = ope_input_fmts;
+		n = ARRAY_SIZE(ope_input_fmts);
+	} else {
+		fmts = ope_output_fmts;
+		n = ARRAY_SIZE(ope_output_fmts);
+	}
+
+	fmt = ope_find_fmt(fmts, n, fsize->pixel_format);
+	if (fsize->index > 0 || !fmt)
+		return -EINVAL;
+
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise.min_width = OPE_MIN_W;
+	fsize->stepwise.max_width = OPE_MAX_W;
+	fsize->stepwise.step_width = 1 << fmt->align;
+	fsize->stepwise.min_height = OPE_MIN_H;
+	fsize->stepwise.max_height = OPE_MAX_H;
+	fsize->stepwise.step_height = fmt->c_vsub == 2 ? 2 : 1;
+
+	return 0;
+}
+
+static int ope_reqbufs(struct file *file, void *priv, struct v4l2_requestbuffers *rb)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+	int ret;
+
+	if (!vq)
+		return -EINVAL;
+
+	if (vb2_queue_is_busy(vq, file))
+		return -EBUSY;
+
+	ret = vb2_reqbufs(vq, rb);
+	if (!ret)
+		vq->owner = rb->count ? file->private_data : NULL;
+
+	return ret;
+}
+
+static int ope_querybuf(struct file *file, void *priv, struct v4l2_buffer *buf)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+
+	return vq ? vb2_querybuf(vq, buf) : -EINVAL;
+}
+
+static int ope_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct video_device *vdev = video_devdata(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+
+	if (!vq)
+		return -EINVAL;
+	if (vb2_queue_is_busy(vq, file))
+		return -EBUSY;
+
+	return vb2_qbuf(vq, vdev->v4l2_dev->mdev, buf);
+}
+
+static int ope_dqbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+
+	if (!vq)
+		return -EINVAL;
+	if (vb2_queue_is_busy(vq, file))
+		return -EBUSY;
+
+	return vb2_dqbuf(vq, buf, file->f_flags & O_NONBLOCK);
+}
+
+static int ope_prepare_buf(struct file *file, void *priv, struct v4l2_buffer *buf)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct video_device *vdev = video_devdata(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+
+	if (!vq)
+		return -EINVAL;
+	if (vb2_queue_is_busy(vq, file))
+		return -EBUSY;
+
+	return vb2_prepare_buf(vq, vdev->v4l2_dev->mdev, buf);
+}
+
+static int ope_create_bufs(struct file *file, void *priv, struct v4l2_create_buffers *create)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+	int ret;
+
+	if (!vq)
+		return -EINVAL;
+	if (create->count && vb2_queue_is_busy(vq, file))
+		return -EBUSY;
+	ret = vb2_create_bufs(vq, create);
+	if (!ret && create->count)
+		vq->owner = file->private_data;
+
+	return ret;
+}
+
+static int ope_expbuf(struct file *file, void *priv, struct v4l2_exportbuffer *eb)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+
+	if (!vq)
+		return -EINVAL;
+	if (vb2_queue_is_busy(vq, file))
+		return -EBUSY;
+
+	return vb2_expbuf(vq, eb);
+}
+
+static int ope_streamon(struct file *file, void *priv, enum v4l2_buf_type type)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+
+	if (!vq)
+		return -EINVAL;
+	if (vb2_queue_is_busy(vq, file))
+		return -EBUSY;
+
+	return vb2_streamon(vq, type);
+}
+
+static int ope_streamoff(struct file *file, void *priv, enum v4l2_buf_type type)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+
+	if (!vq)
+		return -EINVAL;
+
+	if (vb2_queue_is_busy(vq, file))
+		return -EBUSY;
+
+	return vb2_streamoff(vq, type);
+}
+
+/* -------- proc subdev ops -------- */
+
+static const struct v4l2_rect ope_sd_min_rect = {
+	.width = OPE_MIN_W,
+	.height = OPE_MIN_H,
+};
+
+static const struct ope_fmt *ope_fmt_from_mbus_code(const struct ope_fmt *fmts,
+						    unsigned int num_fmts, u32 code)
+{
+	for (unsigned int i = 0; i < num_fmts; i++)
+		if (fmts[i].mbus_code == code)
+			return &fmts[i];
+
+	return NULL;
+}
+
+static void ope_sd_adjust_crop_rect(struct v4l2_rect *crop, const struct v4l2_rect *bounds,
+				    unsigned int halign, unsigned int valign)
+{
+	v4l2_rect_set_min_size(crop, &ope_sd_min_rect);
+	v4l2_rect_map_inside(crop, bounds);
+
+	crop->width  = ALIGN_DOWN(crop->width, halign);
+	crop->height = ALIGN_DOWN(crop->height, valign);
+	crop->left   = ALIGN_DOWN(crop->left, halign);
+	crop->top    = ALIGN_DOWN(crop->top, valign);
+}
+
+static void ope_sd_adjust_crop(struct v4l2_rect *crop, const struct v4l2_mbus_framefmt *bounds)
+{
+	struct v4l2_rect crop_bounds = {
+		.left = 0, .top = 0,
+		.width = bounds->width, .height = bounds->height,
+	};
+	const struct ope_fmt *fmt;
+	unsigned int halign = 2;
+
+	/* Source packing unit, at least a Bayer pair */
+	fmt = ope_fmt_from_mbus_code(ope_input_fmts, ARRAY_SIZE(ope_input_fmts), bounds->code);
+	if (fmt)
+		halign = max(2u, 1u << fmt->align);
+
+	ope_sd_adjust_crop_rect(crop, &crop_bounds, halign, 2);
+}
+
+static void ope_proc_adjust_src_compose(struct v4l2_subdev_state *state, struct v4l2_rect *compose)
+{
+	const struct v4l2_rect *sink_crop =
+		v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SINK_IN);
+	const struct v4l2_mbus_framefmt *src_fmt =
+		v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SOURCE);
+	unsigned int halign = 1, valign = 1;
+	const struct ope_fmt *fmt;
+	struct v4l2_rect bounds;
+
+	fmt = ope_fmt_from_mbus_code(ope_output_fmts, ARRAY_SIZE(ope_output_fmts),
+				     src_fmt->code);
+	if (fmt) {
+		halign = fmt->c_hsub;
+		valign = fmt->c_vsub;
+	}
+
+	bounds = (struct v4l2_rect){ 0, 0, sink_crop->width, sink_crop->height };
+	ope_sd_adjust_crop_rect(compose, &bounds, halign, valign);
+}
+
+static void ope_proc_set_src_fmt(struct v4l2_subdev_state *state,
+			 struct v4l2_mbus_framefmt *format)
+{
+	struct v4l2_mbus_framefmt *src_fmt;
+	struct v4l2_rect *compose;
+	const struct ope_fmt *fmt;
+
+	src_fmt = v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SOURCE);
+	compose = v4l2_subdev_state_get_compose(state, OPE_PROC_PAD_SOURCE);
+
+	fmt = ope_fmt_from_mbus_code(ope_output_fmts, ARRAY_SIZE(ope_output_fmts), format->code);
+	src_fmt->code = fmt ? fmt->mbus_code : MEDIA_BUS_FMT_YUYV8_1_5X8;
+
+	ope_proc_adjust_src_compose(state, compose);
+
+	src_fmt->width      = compose->width;
+	src_fmt->height     = compose->height;
+	src_fmt->field      = V4L2_FIELD_NONE;
+	src_fmt->colorspace = V4L2_COLORSPACE_SRGB;
+	*format = *src_fmt;
+}
+
+static void ope_proc_set_src_compose(struct v4l2_subdev_state *state, struct v4l2_rect *r)
+{
+	struct v4l2_rect *compose = v4l2_subdev_state_get_compose(state, OPE_PROC_PAD_SOURCE);
+
+	*compose = *r;
+	ope_proc_adjust_src_compose(state, compose);
+	*r = *compose;
+
+	/* Propagate to out format */
+	ope_proc_set_src_fmt(state, v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SOURCE));
+}
+
+static void ope_proc_set_sink_crop(struct v4l2_subdev_state *state, struct v4l2_rect *r)
+{
+	struct v4l2_rect *crop;
+
+	crop = v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SINK_IN);
+
+	*crop = *r;
+	ope_sd_adjust_crop(crop, v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SINK_IN));
+	*r = *crop;
+
+	/* Propagate to out format */
+	ope_proc_set_src_compose(state, v4l2_subdev_state_get_compose(state, OPE_PROC_PAD_SOURCE));
+}
+
+static void ope_proc_set_sink_fmt(struct v4l2_subdev_state *state,
+				  struct v4l2_mbus_framefmt *format)
+{
+	struct v4l2_mbus_framefmt *sink_fmt;
+	const struct ope_fmt *fmt;
+	struct v4l2_rect *crop;
+
+	sink_fmt = v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SINK_IN);
+	crop = v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SINK_IN);
+
+	fmt = ope_fmt_from_mbus_code(ope_input_fmts, ARRAY_SIZE(ope_input_fmts), format->code);
+	sink_fmt->code = fmt ? fmt->mbus_code : ope_input_fmts[0].mbus_code;
+
+	sink_fmt->width = clamp(format->width,  (u32)OPE_MIN_W, (u32)OPE_MAX_W);
+	sink_fmt->height = clamp(format->height, (u32)OPE_MIN_H, (u32)OPE_MAX_H);
+	sink_fmt->field = V4L2_FIELD_NONE;
+	sink_fmt->colorspace = V4L2_COLORSPACE_RAW;
+	*format = *sink_fmt;
+
+	/* Propagate to in crop */
+	ope_proc_set_sink_crop(state, crop);
+}
+
+static int ope_proc_init_state(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state)
+{
+	struct v4l2_mbus_framefmt fmt = {
+		.width  = OPE_MIN_W,
+		.height = OPE_MIN_H,
+		.code   = MEDIA_BUS_FMT_SRGGB8_1X8,
+	};
+
+	/* Params sink: fixed format, width carries the payload size in bytes */
+	*v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SINK_PAR) =
+		(struct v4l2_mbus_framefmt){
+			.code       = MEDIA_BUS_FMT_FIXED,
+			.width      = v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOAD),
+			.height     = 1,
+			.field      = V4L2_FIELD_NONE,
+			.colorspace = V4L2_COLORSPACE_DEFAULT,
+		};
+
+	/* Initialise source compose default before cascade */
+	*v4l2_subdev_state_get_compose(state, OPE_PROC_PAD_SOURCE) =
+		(struct v4l2_rect){ 0, 0, OPE_MIN_W, OPE_MIN_H };
+	v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SOURCE)->code =
+		MEDIA_BUS_FMT_YUYV8_1_5X8;
+
+	/* Drive the full cascade from sink-in fmt */
+	ope_proc_set_sink_fmt(state, &fmt);
+
+	return 0;
+}
+
+/* NULL once v4l2_device_unregister_subdev() has run on teardown */
+static struct ope_dev *ope_from_subdev(struct v4l2_subdev *sd)
+{
+	struct v4l2_device *v4l2_dev = sd->v4l2_dev;
+
+	return v4l2_dev ? container_of(v4l2_dev, struct ope_dev, v4l2_dev) : NULL;
+}
+
+static bool ope_state_is_busy(struct v4l2_subdev *sd, struct v4l2_subdev_state *state)
+{
+	struct ope_dev *ope = ope_from_subdev(sd);
+	struct ope_ctx *ctx;
+	bool busy = false;
+
+	if (!ope || state != sd->active_state)
+		return false;
+
+	scoped_guard(spinlock, &ope->ctx_lock)
+		list_for_each_entry(ctx, &ope->ctx_list, list)
+			busy |= ope_ctx_is_busy(ctx);
+
+	return busy;
+}
+
+static int ope_proc_set_fmt(struct v4l2_subdev *sd,
+			    const struct v4l2_subdev_client_info *info,
+			    struct v4l2_subdev_state *state,
+			    struct v4l2_subdev_format *fmt)
+{
+	if (fmt->pad == OPE_PROC_PAD_SINK_PAR)
+		return v4l2_subdev_get_fmt(sd, state, fmt);
+
+	if (ope_state_is_busy(sd, state))
+		return -EBUSY;
+
+	if (fmt->pad == OPE_PROC_PAD_SINK_IN) {
+		ope_proc_set_sink_fmt(state, &fmt->format);
+		return 0;
+	}
+
+	ope_proc_set_src_fmt(state, &fmt->format);
+
+	return 0;
+}
+
+static int ope_proc_enum_mbus_code(struct v4l2_subdev *sd,
+				   struct v4l2_subdev_state *state,
+				   struct v4l2_subdev_mbus_code_enum *code)
+{
+	const struct ope_fmt *fmts;
+	unsigned int nfmts;
+	unsigned int n = 0;
+
+	if (code->pad == OPE_PROC_PAD_SINK_PAR) {
+		if (code->index)
+			return -EINVAL;
+		code->code = MEDIA_BUS_FMT_FIXED;
+		return 0;
+	}
+
+	if (code->pad == OPE_PROC_PAD_SOURCE) {
+		fmts  = ope_output_fmts;
+		nfmts = ARRAY_SIZE(ope_output_fmts);
+	} else {
+		fmts  = ope_input_fmts;
+		nfmts = ARRAY_SIZE(ope_input_fmts);
+	}
+
+	for (unsigned int i = 0; i < nfmts; i++) {
+		u32 mc = fmts[i].mbus_code;
+		bool seen = false;
+
+		for (unsigned int j = 0; j < i; j++) {
+			if (fmts[j].mbus_code == mc) {
+				seen = true;
+				break;
+			}
+		}
+		if (!seen && n++ == code->index) {
+			code->code = mc;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ope_proc_get_selection(struct v4l2_subdev *sd,
+				  const struct v4l2_subdev_client_info *info,
+				  struct v4l2_subdev_state *state,
+				  struct v4l2_subdev_selection *sel)
+{
+	if (sel->pad == OPE_PROC_PAD_SINK_IN) {
+		const struct v4l2_mbus_framefmt *sink_fmt =
+			v4l2_subdev_state_get_format(state, OPE_PROC_PAD_SINK_IN);
+
+		switch (sel->target) {
+		case V4L2_SEL_TGT_CROP:
+			sel->r = *v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SINK_IN);
+			return 0;
+		case V4L2_SEL_TGT_CROP_DEFAULT:
+		case V4L2_SEL_TGT_CROP_BOUNDS:
+			sel->r = (struct v4l2_rect){ 0, 0, sink_fmt->width, sink_fmt->height };
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (sel->pad == OPE_PROC_PAD_SOURCE) {
+		const struct v4l2_rect *crop =
+			v4l2_subdev_state_get_crop(state, OPE_PROC_PAD_SINK_IN);
+
+		switch (sel->target) {
+		case V4L2_SEL_TGT_COMPOSE:
+			sel->r = *v4l2_subdev_state_get_compose(state, OPE_PROC_PAD_SOURCE);
+			return 0;
+		case V4L2_SEL_TGT_COMPOSE_DEFAULT:
+		case V4L2_SEL_TGT_COMPOSE_BOUNDS:
+			sel->r = *crop;
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ope_proc_set_selection(struct v4l2_subdev *sd,
+				  const struct v4l2_subdev_client_info *info,
+				  struct v4l2_subdev_state *state,
+				  struct v4l2_subdev_selection *sel)
+{
+	if (ope_state_is_busy(sd, state))
+		return -EBUSY;
+
+	if (sel->pad == OPE_PROC_PAD_SINK_IN) {
+		if (sel->target != V4L2_SEL_TGT_CROP)
+			return -EINVAL;
+		ope_proc_set_sink_crop(state, &sel->r);
+		return 0;
+	}
+
+	if (sel->pad == OPE_PROC_PAD_SOURCE) {
+		if (sel->target != V4L2_SEL_TGT_COMPOSE)
+			return -EINVAL;
+		ope_proc_set_src_compose(state, &sel->r);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static const struct v4l2_subdev_pad_ops ope_proc_pad_ops = {
+	.get_fmt	= v4l2_subdev_get_fmt,
+	.set_fmt	= ope_proc_set_fmt,
+	.enum_mbus_code	= ope_proc_enum_mbus_code,
+	.get_selection	= ope_proc_get_selection,
+	.set_selection	= ope_proc_set_selection,
+};
+
+static const struct v4l2_subdev_internal_ops ope_proc_internal_ops = {
+	.init_state = ope_proc_init_state,
+};
+
+static const struct v4l2_subdev_ops ope_proc_ops = {
+	.pad = &ope_proc_pad_ops,
+};
+
+/* -------- disp subdev ops -------- */
+
+static int ope_disp_set_fmt(struct v4l2_subdev *sd,
+			    const struct v4l2_subdev_client_info *info,
+			    struct v4l2_subdev_state *state,
+			    struct v4l2_subdev_format *fmt)
+{
+	struct v4l2_mbus_framefmt *pad_fmt;
+	u32 code = fmt->format.code;
+
+	/* The disp subdev is pass-through: the source pad always mirrors the
+	 * sink pad, so source format is read-only and derived from the sink.
+	 */
+	if (fmt->pad == OPE_DISP_PAD_SOURCE)
+		return v4l2_subdev_get_fmt(sd, state, fmt);
+
+	if (ope_state_is_busy(sd, state))
+		return -EBUSY;
+
+	fmt->format.code = MEDIA_BUS_FMT_YUYV8_1_5X8;
+	for (unsigned int i = 0; i < ARRAY_SIZE(ope_output_fmts); i++) {
+		if (ope_output_fmts[i].mbus_code == code) {
+			fmt->format.code = code;
+			break;
+		}
+	}
+
+	v4l_bound_align_image(&fmt->format.width,  OPE_MIN_W, OPE_MAX_W, 0,
+			      &fmt->format.height, OPE_MIN_H, OPE_MAX_H, 0, 0);
+	fmt->format.field      = V4L2_FIELD_NONE;
+	fmt->format.colorspace = V4L2_COLORSPACE_SRGB;
+
+	pad_fmt  = v4l2_subdev_state_get_format(state, fmt->pad);
+	*pad_fmt = fmt->format;
+
+	/* Propagate to source */
+	*v4l2_subdev_state_get_format(state, OPE_DISP_PAD_SOURCE) = fmt->format;
+
+	return 0;
+}
+
+static int ope_disp_init_state(struct v4l2_subdev *sd,
+			       struct v4l2_subdev_state *state)
+{
+	struct v4l2_mbus_framefmt def = {
+		.width      = OPE_MIN_W,
+		.height     = OPE_MIN_H,
+		.code       = MEDIA_BUS_FMT_YUYV8_1_5X8,
+		.field      = V4L2_FIELD_NONE,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+	};
+
+	*v4l2_subdev_state_get_format(state, OPE_DISP_PAD_SINK)   = def;
+	*v4l2_subdev_state_get_format(state, OPE_DISP_PAD_SOURCE) = def;
+	return 0;
+}
+
+static const struct v4l2_subdev_pad_ops ope_disp_pad_ops = {
+	.get_fmt       = v4l2_subdev_get_fmt,
+	.set_fmt       = ope_disp_set_fmt,
+	.link_validate = v4l2_subdev_link_validate_default,
+};
+
+static const struct media_entity_operations ope_disp_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
+static const struct v4l2_subdev_internal_ops ope_disp_internal_ops = {
+	.init_state = ope_disp_init_state,
+};
+
+static const struct v4l2_subdev_ops ope_disp_ops = {
+	.pad = &ope_disp_pad_ops,
+};
+
+/* -------- disp-output video ops -------- */
+
+static int ope_disp_output_link_validate(struct media_link *link)
+{
+	struct video_device *vdev = media_entity_to_video_device(link->sink->entity);
+	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(link->source->entity);
+	struct ope_dev *ope = container_of(vdev->v4l2_dev, struct ope_dev, v4l2_dev);
+	struct ope_ctx *ctx = ope->shared_ctx;
+	struct v4l2_subdev_state *sd_state;
+	struct v4l2_subdev_format sd_fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad   = link->source->index,
+	};
+	int ret;
+
+	if (!ctx)
+		return 0;
+
+	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
+	ret = v4l2_subdev_call(sd, pad, get_fmt, sd_state, &sd_fmt);
+	v4l2_subdev_unlock_state(sd_state);
+	if (ret)
+		return ret;
+
+	if (ctx->fmt_out.fmt->mbus_code != sd_fmt.format.code) {
+		dev_dbg(ctx->ope->dev, "link validate: mbus 0x%04x incompatible with %p4cc\n",
+			sd_fmt.format.code, &ctx->fmt_out.fmt->fourcc);
+		return -EPIPE;
+	}
+
+	if (sd_fmt.format.width > ctx->fmt_out.width ||
+	    sd_fmt.format.height > ctx->fmt_out.height) {
+		dev_dbg(ctx->ope->dev,
+			"link validate: compose %ux%u exceeds output buffer %ux%u\n",
+			sd_fmt.format.width, sd_fmt.format.height,
+			ctx->fmt_out.width, ctx->fmt_out.height);
+		return -EPIPE;
+	}
+
+	/* Check compose rect (including offset) fits within output buffer */
+	{
+		struct v4l2_subdev *proc_sd =
+			camss_isp_pipeline_get_subdev(ctx->ope->pipeline,
+						      OPE_ENTITY_PROC);
+		struct v4l2_subdev_state *proc_state =
+			v4l2_subdev_lock_and_get_active_state(proc_sd);
+		const struct v4l2_rect *compose =
+			v4l2_subdev_state_get_compose(proc_state,
+						      OPE_PROC_PAD_SOURCE);
+
+		if (compose->left + compose->width  > ctx->fmt_out.width ||
+		    compose->top  + compose->height > ctx->fmt_out.height) {
+			dev_dbg(ctx->ope->dev,
+				"link: compose %ux%u+%u+%u overflows output buffer %ux%u\n",
+				compose->width, compose->height,
+				compose->left, compose->top,
+				ctx->fmt_out.width, ctx->fmt_out.height);
+			v4l2_subdev_unlock_state(proc_state);
+			return -EPIPE;
+		}
+		v4l2_subdev_unlock_state(proc_state);
+	}
+
+	return 0;
+}
+
+static const struct media_entity_operations ope_disp_output_entity_ops = {
+	.link_validate = ope_disp_output_link_validate,
+};
+
+static int ope_input_link_validate(struct media_link *link)
+{
+	struct v4l2_subdev *sd = media_entity_to_v4l2_subdev(link->sink->entity);
+	struct ope_dev *ope = ope_from_subdev(sd);
+	struct ope_ctx *ctx = ope ? ope->shared_ctx : NULL;
+	struct v4l2_subdev_state *sd_state;
+	struct v4l2_subdev_format sd_fmt = {
+		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
+		.pad   = link->sink->index,
+	};
+	int ret;
+
+	if (!ctx)
+		return 0;
+
+	sd_state = v4l2_subdev_lock_and_get_active_state(sd);
+	ret = v4l2_subdev_call(sd, pad, get_fmt, sd_state, &sd_fmt);
+	v4l2_subdev_unlock_state(sd_state);
+	if (ret)
+		return ret;
+
+	if (ctx->fmt_in.fmt->mbus_code != sd_fmt.format.code ||
+	    ctx->fmt_in.width != sd_fmt.format.width ||
+	    ctx->fmt_in.height != sd_fmt.format.height) {
+		dev_dbg(ctx->ope->dev,
+			"link validate: input %dx%d/0x%04x != pad %dx%d/0x%04x\n",
+			ctx->fmt_in.width, ctx->fmt_in.height,
+			ctx->fmt_in.fmt->mbus_code,
+			sd_fmt.format.width, sd_fmt.format.height,
+			sd_fmt.format.code);
+		return -EPIPE;
+	}
+
+	return 0;
+}
+
+static int ope_proc_link_validate(struct media_link *link)
+{
+	switch (link->sink->index) {
+	case OPE_PROC_PAD_SINK_IN:
+		return ope_input_link_validate(link);
+	case OPE_PROC_PAD_SINK_PAR:
+		return 0;
+	default:
+		return -EPIPE;
+	}
+}
+
+static const struct media_entity_operations ope_proc_entity_ops = {
+	.link_validate = ope_proc_link_validate,
+};
+
+static const struct v4l2_ioctl_ops ope_video_ioctl_ops = {
+	.vidioc_querycap		= ope_querycap,
+	.vidioc_enum_fmt_vid_out	= ope_enum_fmt_vid_out,
+	.vidioc_g_fmt_vid_out_mplane	= ope_g_fmt_vid_out,
+	.vidioc_try_fmt_vid_out_mplane	= ope_try_fmt_vid_out,
+	.vidioc_s_fmt_vid_out_mplane	= ope_s_fmt_vid_out,
+	.vidioc_enum_fmt_vid_cap	= ope_enum_fmt_vid_cap,
+	.vidioc_g_fmt_vid_cap_mplane	= ope_g_fmt_vid_cap,
+	.vidioc_try_fmt_vid_cap_mplane	= ope_try_fmt_vid_cap,
+	.vidioc_s_fmt_vid_cap_mplane	= ope_s_fmt_vid_cap,
+	.vidioc_enum_framesizes		= ope_enum_framesizes,
+	.vidioc_g_parm			= ope_g_parm,
+	.vidioc_s_parm			= ope_s_parm,
+	.vidioc_reqbufs			= ope_reqbufs,
+	.vidioc_querybuf		= ope_querybuf,
+	.vidioc_qbuf			= ope_qbuf,
+	.vidioc_dqbuf			= ope_dqbuf,
+	.vidioc_prepare_buf		= ope_prepare_buf,
+	.vidioc_create_bufs		= ope_create_bufs,
+	.vidioc_expbuf			= ope_expbuf,
+	.vidioc_streamon		= ope_streamon,
+	.vidioc_streamoff		= ope_streamoff,
+	.vidioc_subscribe_event		= v4l2_ctrl_subscribe_event,
+	.vidioc_unsubscribe_event	= v4l2_event_unsubscribe,
+};
+
+static const struct v4l2_ioctl_ops ope_meta_ioctl_ops = {
+	.vidioc_querycap		= ope_querycap,
+	.vidioc_enum_fmt_meta_out	= ope_enum_fmt_meta_out,
+	.vidioc_g_fmt_meta_out		= ope_g_fmt_meta,
+	.vidioc_s_fmt_meta_out		= ope_g_fmt_meta,
+	.vidioc_try_fmt_meta_out	= ope_g_fmt_meta,
+	.vidioc_reqbufs			= ope_reqbufs,
+	.vidioc_querybuf		= ope_querybuf,
+	.vidioc_qbuf			= ope_qbuf,
+	.vidioc_dqbuf			= ope_dqbuf,
+	.vidioc_prepare_buf		= ope_prepare_buf,
+	.vidioc_create_bufs		= ope_create_bufs,
+	.vidioc_expbuf			= ope_expbuf,
+	.vidioc_streamon		= ope_streamon,
+	.vidioc_streamoff		= ope_streamoff,
+};
+
+/* -------- File/Context ops -------- */
+
+static struct ope_ctx *ope_ctx_create(struct ope_dev *ope)
+{
+	struct v4l2_pix_format_mplane pix_in = { .pixelformat = ope_input_fmts[0].fourcc };
+	struct v4l2_pix_format_mplane pix_out = { .pixelformat = ope_output_fmts[0].fourcc };
+	struct ope_ctx *ctx;
+	unsigned int i;
+	int ret;
+
+	lockdep_assert_held(&ope->mutex);
+
+	ctx = kvzalloc_obj(*ctx);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->ope = ope;
+
+	mutex_init(&ctx->vbq_lock);
+
+	ctx->params_buf = kvzalloc(v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOAD),
+				   GFP_KERNEL);
+	if (!ctx->params_buf) {
+		ret = -ENOMEM;
+		goto err_destroy_lock;
+	}
+
+	ctx->config = ope_default_config;
+
+	ctx->fmt_in.fmt		 = ope_fmt_try(ope, false, &pix_in);
+	ctx->fmt_in.width	 = pix_in.width;
+	ctx->fmt_in.height	 = pix_in.height;
+	ctx->fmt_in.bytesperline = pix_in.plane_fmt[0].bytesperline;
+	ctx->fmt_in.sizeimage	 = pix_in.plane_fmt[0].sizeimage;
+	ctx->fmt_in.colorspace	 = pix_in.colorspace;
+	ctx->fmt_in.xfer_func	 = pix_in.xfer_func;
+	ctx->fmt_in.ycbcr_enc	 = pix_in.ycbcr_enc;
+	ctx->fmt_in.quantization = pix_in.quantization;
+	ctx->fmt_in.timeperframe.numerator = 1;
+	ctx->fmt_in.timeperframe.denominator = DEFAULT_FRAMERATE;
+
+	ctx->fmt_out.fmt	  = ope_fmt_try(ope, true, &pix_out);
+	ctx->fmt_out.width	  = pix_out.width;
+	ctx->fmt_out.height	  = pix_out.height;
+	ctx->fmt_out.bytesperline = pix_out.plane_fmt[0].bytesperline;
+	ctx->fmt_out.sizeimage	  = pix_out.plane_fmt[0].sizeimage;
+	ctx->fmt_out.colorspace	  = pix_out.colorspace;
+	ctx->fmt_out.xfer_func	  = pix_out.xfer_func;
+	ctx->fmt_out.ycbcr_enc	  = pix_out.ycbcr_enc;
+	ctx->fmt_out.quantization = pix_out.quantization;
+
+	spin_lock_init(&ctx->queues_lock);
+
+	for (i = 0; i < OPE_QUEUE_COUNT; i++) {
+		INIT_LIST_HEAD(&ctx->queues[i].rdy_queue);
+		ret = ope_init_vq(ctx, i);
+		if (ret)
+			goto err_release_vq;
+	}
+
+	INIT_LIST_HEAD(&ctx->list);
+
+	scoped_guard(spinlock, &ope->ctx_lock)
+		list_add(&ctx->list, &ope->ctx_list);
+
+	ope->shared_ctx = ctx;
+
+	return ctx;
+
+err_release_vq:
+	while (i--)
+		ope_deinit_vq(ctx, i);
+	kvfree(ctx->params_buf);
+err_destroy_lock:
+	mutex_destroy(&ctx->vbq_lock);
+	kvfree(ctx);
+	return ERR_PTR(ret);
+}
+
+static void ope_queues_release(struct ope_ctx *ctx, struct v4l2_fh *fh)
+{
+	bool owned = false;
+
+	for (unsigned int i = 0; i < OPE_QUEUE_COUNT; i++)
+		owned |= (ctx->queues[i].vq.owner == fh);
+
+	if (!owned)
+		return;
+
+	ope_sched_cancel(ctx);
+
+	for (unsigned int i = 0; i < OPE_QUEUE_COUNT; i++) {
+		struct vb2_queue *vq = &ctx->queues[i].vq;
+
+		if (vq->owner != fh)
+			continue;
+
+		vb2_queue_release(vq);
+		vq->owner = NULL;
+	}
+
+	ope_sched_resume(ctx->ope);
+}
+
+static void ope_ctx_destroy(struct ope_ctx *ctx)
+{
+	/* Keep the scheduler away from the queues being torn down */
+	scoped_guard(spinlock_irqsave, &ctx->queues_lock)
+		for (unsigned int i = 0; i < OPE_QUEUE_COUNT; i++)
+			ctx->queues[i].streaming = false;
+
+	ope_sched_cancel(ctx);
+
+	for (unsigned int i = 0; i < OPE_QUEUE_COUNT; i++)
+		ope_deinit_vq(ctx, i);
+
+	/* Do not leave the LUT cache pointing at a context about to be freed */
+	ope_glut_cache_invalidate(ctx->ope);
+
+	ope_sched_resume(ctx->ope);
+
+	kvfree(ctx->params_buf);
+	mutex_destroy(&ctx->vbq_lock);
+	kvfree(ctx);
+}
+
+static int ope_open(struct file *file)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct ope_dev *ope = container_of(vdev->v4l2_dev, struct ope_dev, v4l2_dev);
+	struct v4l2_fh *fh;
+	int ret = 0;
+
+	fh = kzalloc_obj(*fh);
+	if (!fh)
+		return -ENOMEM;
+
+	if (mutex_lock_interruptible(&ope->mutex)) {
+		kfree(fh);
+		return -ERESTARTSYS;
+	}
+
+	v4l2_fh_init(fh, vdev);
+	v4l2_fh_add(fh, file);
+
+	if (!ope_hw_available(ope)) {
+		ret = -ENODEV;
+		goto err_fh_del;
+	}
+
+	/*
+	 * For now, only a single shared context is supported,
+	 * until media multi-context support is available.
+	 */
+	if (!ope->shared_ctx) {
+		struct ope_ctx *ctx = ope_ctx_create(ope);
+
+		if (IS_ERR(ctx)) {
+			ret = PTR_ERR(ctx);
+			goto err_fh_del;
+		}
+	}
+
+	ope->open_count++;
+	mutex_unlock(&ope->mutex);
+
+	return 0;
+
+err_fh_del:
+	v4l2_fh_del(fh, file);
+	v4l2_fh_exit(fh);
+	mutex_unlock(&ope->mutex);
+	kfree(fh);
+	return ret;
+}
+
+static int ope_release(struct file *file)
+{
+	struct v4l2_fh *fh = file_to_v4l2_fh(file);
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct ope_dev *ope = ctx->ope;
+
+	scoped_guard(mutex, &ctx->vbq_lock)
+		ope_queues_release(ctx, fh);
+
+	v4l2_fh_del(fh, file);
+	v4l2_fh_exit(fh);
+	kfree(fh);
+
+	scoped_guard(mutex, &ope->mutex) {
+		if (--ope->open_count != 0)
+			return 0;
+		ope->shared_ctx = NULL;
+		scoped_guard(spinlock, &ope->ctx_lock)
+			list_del(&ctx->list);
+		ope_ctx_destroy(ctx);
+	}
+
+	return 0;
+}
+
+static __poll_t ope_poll(struct file *file, poll_table *wait)
+{
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+	struct vb2_queue *vq = ope_vq_from_file(file, ctx);
+	__poll_t rc;
+
+	if (!vq)
+		return EPOLLERR;
+
+	if (mutex_lock_interruptible(&ctx->vbq_lock))
+		return EPOLLERR;
+
+	rc = vb2_poll(vq, file, wait);
+
+	mutex_unlock(&ctx->vbq_lock);
+
+	return rc;
+}
+
+static int ope_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	unsigned int idx = ope_queue_idx_from_file(file);
+	struct ope_ctx *ctx = ope_ctx_from_file(file);
+
+	if (idx >= OPE_QUEUE_COUNT)
+		return -EINVAL;
+
+	return vb2_mmap(&ctx->queues[idx].vq, vma);
+}
+
+static const struct v4l2_file_operations ope_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ope_open,
+	.release	= ope_release,
+	.poll		= ope_poll,
+	.unlocked_ioctl	= video_ioctl2,
+	.mmap		= ope_mmap,
+};
+
+/* Pipeline descriptor  */
+static const struct camss_isp_entity_desc ope_entity_descs[] = {
+	[OPE_ENTITY_FRAME_IN] = {
+		.name      = "ope_input",
+		.obj_type  = MEDIA_ENTITY_TYPE_VIDEO_DEVICE,
+		.function  = MEDIA_ENT_F_IO_V4L,
+		.vdev.caps = V4L2_CAP_VIDEO_OUTPUT_MPLANE | V4L2_CAP_STREAMING,
+		.vdev.drvdata = (void *)(uintptr_t)OPE_QUEUE_FRAME_IN,
+		.vdev.fops = &ope_fops,
+		.vdev.ioctl_ops = &ope_video_ioctl_ops,
+		.pads = (const struct camss_isp_pad_desc[]) {
+			{ MEDIA_PAD_FL_SOURCE, OPE_ENTITY_PROC, OPE_PROC_PAD_SINK_IN, 0 },
+			{ }
+		},
+	},
+	[OPE_ENTITY_DISP_OUT] = {
+		.name      = "ope_disp_output",
+		.obj_type  = MEDIA_ENTITY_TYPE_VIDEO_DEVICE,
+		.function  = MEDIA_ENT_F_IO_V4L,
+		.vdev.caps = V4L2_CAP_VIDEO_CAPTURE_MPLANE | V4L2_CAP_STREAMING,
+		.vdev.drvdata = (void *)(uintptr_t)OPE_QUEUE_DISP_OUT,
+		.vdev.fops = &ope_fops,
+		.vdev.ioctl_ops = &ope_video_ioctl_ops,
+		.vdev.entity_ops = &ope_disp_output_entity_ops,
+		.pads = (const struct camss_isp_pad_desc[]) {
+			{ MEDIA_PAD_FL_SINK, OPE_ENTITY_DISP, OPE_DISP_PAD_SOURCE, 0 },
+			{ }
+		},
+	},
+	[OPE_ENTITY_PARAMS] = {
+		.name      = "ope_params",
+		.obj_type  = MEDIA_ENTITY_TYPE_VIDEO_DEVICE,
+		.function  = MEDIA_ENT_F_IO_V4L,
+		.vdev.caps = V4L2_CAP_META_OUTPUT | V4L2_CAP_STREAMING,
+		.vdev.drvdata = (void *)(uintptr_t)OPE_QUEUE_PARAMS,
+		.vdev.fops = &ope_fops,
+		.vdev.ioctl_ops = &ope_meta_ioctl_ops,
+		.pads = (const struct camss_isp_pad_desc[]) {
+			{ MEDIA_PAD_FL_SOURCE, OPE_ENTITY_PROC, OPE_PROC_PAD_SINK_PAR, 0 },
+			{ }
+		},
+	},
+	[OPE_ENTITY_PROC] = {
+		.name       = "ope_proc",
+		.obj_type   = MEDIA_ENTITY_TYPE_V4L2_SUBDEV,
+		.function   = MEDIA_ENT_F_PROC_VIDEO_ISP,
+		.subdev.ops = &ope_proc_ops,
+		.subdev.internal_ops = &ope_proc_internal_ops,
+		.subdev.entity_ops   = &ope_proc_entity_ops,
+		.pads = (const struct camss_isp_pad_desc[]) {
+			{ MEDIA_PAD_FL_SINK,   OPE_ENTITY_FRAME_IN, 0, 0 },
+			{ MEDIA_PAD_FL_SINK,   OPE_ENTITY_PARAMS, 0, 0 },
+			{ MEDIA_PAD_FL_SOURCE, OPE_ENTITY_DISP, OPE_DISP_PAD_SINK, 0 },
+			{ }
+		},
+	},
+	[OPE_ENTITY_DISP] = {
+		.name     = "ope_disp",
+		.obj_type = MEDIA_ENTITY_TYPE_V4L2_SUBDEV,
+		.function = MEDIA_ENT_F_PROC_VIDEO_SCALER,
+		.subdev.ops          = &ope_disp_ops,
+		.subdev.internal_ops = &ope_disp_internal_ops,
+		.subdev.entity_ops   = &ope_disp_entity_ops,
+		.pads = (const struct camss_isp_pad_desc[]) {
+			{ MEDIA_PAD_FL_SINK,   OPE_ENTITY_PROC, OPE_PROC_PAD_SOURCE, 0 },
+			{ MEDIA_PAD_FL_SOURCE, OPE_ENTITY_DISP_OUT, 0, 0 },
+			{ }
+		},
+	},
+};
+
+static void ope_v4l2_dev_release(struct v4l2_device *v4l2_dev)
+{
+	struct ope_dev *ope = container_of(v4l2_dev, struct ope_dev, v4l2_dev);
+	struct device *dev = ope->dev;
+
+	/* Reached once the V4L2 core has released every video and subdev node */
+	cpu_latency_qos_remove_request(&ope->qos_req);
+	camss_isp_pipeline_free(ope->pipeline);
+	media_device_cleanup(&ope->mdev);
+	mutex_destroy(&ope->mutex);
+	mutex_destroy(&ope->reset_mutex);
+	kfree(ope);
+
+	put_device(dev);
+}
+
+static int ope_v4l2_register(struct ope_dev *ope)
+{
+	int ret;
+
+	ope->mdev.dev = ope->dev;
+	strscpy(ope->mdev.model, OPE_NAME, sizeof(ope->mdev.model));
+	ope->mdev.hw_revision = ope->hw_version;
+	media_device_init(&ope->mdev);
+	ope->v4l2_dev.mdev = &ope->mdev;
+	ope->v4l2_dev.release = ope_v4l2_dev_release;
+
+	ret = v4l2_device_register(ope->dev, &ope->v4l2_dev);
+	if (ret) {
+		/* No v4l2_device reference exists yet, so release @ope directly */
+		ope_v4l2_dev_release(&ope->v4l2_dev);
+		return ret;
+	}
+
+	ope->pipeline = camss_isp_pipeline_alloc(OPE_ENTITY_COUNT);
+	if (IS_ERR(ope->pipeline)) {
+		ret = PTR_ERR(ope->pipeline);
+		ope->pipeline = NULL;
+		goto err_v4l2;
+	}
+
+	ret = camss_isp_pipeline_register(ope->pipeline, &ope->v4l2_dev, ope_entity_descs,
+					  ARRAY_SIZE(ope_entity_descs));
+	if (ret)
+		goto err_v4l2;
+
+	/* Expose the graph to userspace only once every entity and link exists */
+	ret = media_device_register(&ope->mdev);
+	if (ret)
+		goto err_pipeline;
+
+	ope->pipeline->drv_priv = ope;
+	return 0;
+
+err_pipeline:
+	camss_isp_pipeline_unregister(ope->pipeline);
+err_v4l2:
+	/* Rely on the v4l2_device release callback to free @ope */
+	v4l2_device_unregister(&ope->v4l2_dev);
+	v4l2_device_put(&ope->v4l2_dev);
+	return ret;
+}
+
+static void ope_unregister(struct ope_dev *ope)
+{
+	struct ope_ctx *ctx;
+	int ret;
+
+	ope_sched_pause(ope);
+	ope_flush_hw(ope);
+
+	ret = pm_runtime_force_suspend(ope->dev);
+	if (ret)
+		pm_runtime_disable(ope->dev);
+
+	if (ope->pipeline)
+		camss_isp_pipeline_unregister(ope->pipeline);
+
+	scoped_guard(mutex, &ope->mutex) {
+		cpu_latency_qos_update_request(&ope->qos_req, PM_QOS_DEFAULT_VALUE);
+		v4l2_device_unregister(&ope->v4l2_dev);
+	}
+
+	/* Invalidate the MC graph only once the hardware is marked gone */
+	media_device_unregister(&ope->mdev);
+
+	/*
+	 * Wake up any still-open file handle blocked in DQBUF/QBUF so it does
+	 * not hang forever now that the hardware is gone.
+	 */
+	scoped_guard(spinlock, &ope->ctx_lock) {
+		list_for_each_entry(ctx, &ope->ctx_list, list) {
+			for (unsigned int i = 0; i < OPE_QUEUE_COUNT; i++)
+				vb2_queue_error(&ctx->queues[i].vq);
+		}
+	}
+
+	/*
+	 * Drops the reference this driver holds. @ope may be freed here, or
+	 * later by the V4L2 core if userspace still has a node open.
+	 * media_device_cleanup() is deferred to ope_v4l2_dev_release().
+	 */
+	v4l2_device_put(&ope->v4l2_dev);
+}
+
+static void ope_dump_pipeline(struct ope_dev *ope)
+{
+	static const struct {
+		const char	*name;
+		u32		base;
+	} blocks[] = {
+		{ "wb_gain",	OPE_PP_WB_GAIN_BASE },
+		{ "demo",	OPE_PP_DEMO_BASE },
+		{ "cc",		OPE_PP_CC_BASE },
+		{ "glut",	OPE_PP_GLUT_BASE },
+		{ "chroma_enhan", OPE_PP_CHROMA_ENHAN_BASE },
+		{ "ds_c_pre",	OPE_PP_DOWNSCALE_MN_DS_C_PRE_BASE },
+		{ "ds_y_disp",	OPE_PP_DOWNSCALE_MN_DS_Y_DISP_BASE },
+		{ "ds_c_disp",	OPE_PP_DOWNSCALE_MN_DS_C_DISP_BASE },
+		{ "crop_y_disp", OPE_PP_CROP_RND_CLAMP_Y_DISP_BASE },
+		{ "crop_c_disp", OPE_PP_CROP_RND_CLAMP_C_DISP_BASE },
+	};
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(blocks); i++) {
+		u32 version = ope_read_pp(ope, OPE_PP_HW_VERSION(blocks[i].base));
+
+		dev_dbg(ope->dev, "pipeline %-13s HW version %u.%u.%u\n",
+			blocks[i].name,
+			OPE_HW_VERSION_GEN(version),
+			OPE_HW_VERSION_REV(version),
+			OPE_HW_VERSION_STEP(version));
+	}
+}
+
+static int ope_soft_reset(struct ope_dev *ope)
+{
+	u32 version;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(ope->dev);
+	if (ret)
+		return dev_err_probe(ope->dev, ret, "resume failed\n");
+
+	version = ope_read(ope, OPE_TOP_HW_VERSION);
+	ope->hw_version = version;
+	dev_dbg(ope->dev, "HW version %u.%u.%u\n",
+		OPE_HW_VERSION_GEN(version),
+		OPE_HW_VERSION_REV(version),
+		OPE_HW_VERSION_STEP(version));
+
+	ope_dump_pipeline(ope);
+
+	ret = ope_hw_reset_poll(ope);
+	if (ret)
+		dev_err(ope->dev, "Reset timeout\n");
+
+	pm_runtime_put_sync(ope->dev);
+
+	return ret;
+}
+
+static const char * const ope_pds[] = { "camss" };
+static const char * const ope_opp_pds[] = { "cx" };
+
+static const struct dev_pm_domain_attach_data ope_pd_data = {
+	.pd_names = ope_pds,
+	.num_pd_names = ARRAY_SIZE(ope_pds),
+};
+
+static const struct dev_pm_domain_attach_data ope_opp_pd_data = {
+	.pd_names = ope_opp_pds,
+	.num_pd_names = ARRAY_SIZE(ope_opp_pds),
+	.pd_flags = PD_FLAG_DEV_LINK_ON | PD_FLAG_REQUIRED_OPP,
+};
+
+static int ope_init_power(struct ope_dev *ope)
+{
+	struct device *dev = ope->dev;
+	struct dev_pm_domain_list *pmdomains;
+	struct dev_pm_domain_list *opp_pmdomains;
+	struct clk *axi_clk;
+	int ret;
+
+	ope->icc_data = devm_of_icc_get(dev, "data");
+	if (IS_ERR(ope->icc_data))
+		return dev_err_probe(dev, PTR_ERR(ope->icc_data),
+				     "failed to get interconnect data path\n");
+
+	ope->icc_config = devm_of_icc_get(dev, "config");
+	if (IS_ERR(ope->icc_config))
+		return dev_err_probe(dev, PTR_ERR(ope->icc_config),
+				     "failed to get interconnect config path\n");
+
+	ret = devm_pm_domain_attach_list(dev, &ope_pd_data, &pmdomains);
+	if (ret < 0 && ret != -EEXIST)
+		return dev_err_probe(dev, ret, "failed to attach power domains\n");
+
+	ret = devm_pm_domain_attach_list(dev, &ope_opp_pd_data, &opp_pmdomains);
+	if (ret < 0 && ret != -EEXIST)
+		return dev_err_probe(dev, ret, "failed to attach OPP power domain\n");
+
+	axi_clk = devm_clk_get_optional(dev, "axi");
+	if (IS_ERR(axi_clk))
+		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get AXI clock\n");
+
+	ret = clk_set_rate(axi_clk, OPE_AXI_CLK_RATE);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set AXI clock rate\n");
+
+	ret = devm_pm_opp_set_clkname(dev, "core");
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "invalid OPP table\n");
+
+	ret = devm_clk_bulk_get_all(dev, &ope->clks);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
+	else if (!ret)
+		return dev_err_probe(dev, -EINVAL, "not enough clocks in DT\n");
+	ope->nclks = ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ope_init_mmio(struct ope_dev *ope)
+{
+	struct platform_device *pdev = to_platform_device(ope->dev);
+
+	ope->base = devm_platform_ioremap_resource_byname(pdev, "top");
+	if (IS_ERR(ope->base))
+		return PTR_ERR(ope->base);
+
+	ope->base_rd = devm_platform_ioremap_resource_byname(pdev, "bus_read");
+	if (IS_ERR(ope->base_rd))
+		return PTR_ERR(ope->base_rd);
+
+	ope->base_wr = devm_platform_ioremap_resource_byname(pdev, "bus_write");
+	if (IS_ERR(ope->base_wr))
+		return PTR_ERR(ope->base_wr);
+
+	ope->base_pp = devm_platform_ioremap_resource_byname(pdev, "pipeline");
+	if (IS_ERR(ope->base_pp))
+		return PTR_ERR(ope->base_pp);
+
+	return 0;
+}
+
+static int ope_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ope_dev *ope;
+	int ret, irq;
+
+	/* OPE lifetime is refcounted through the embedded v4l2_device */
+	ope = kzalloc_obj(*ope);
+	if (!ope)
+		return -ENOMEM;
+
+	ope->dev = get_device(dev);
+	init_completion(&ope->reset_complete);
+	mutex_init(&ope->mutex);
+	mutex_init(&ope->reset_mutex);
+	INIT_LIST_HEAD(&ope->ctx_list);
+	spin_lock_init(&ope->ctx_lock);
+	spin_lock_init(&ope->sched_lock);
+	INIT_WORK(&ope->run_work, ope_run_work);
+	ope->sched_paused = 1;
+
+	platform_set_drvdata(pdev, ope);
+
+	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to set DMA mask\n");
+		goto err_free;
+	}
+
+	ret = ope_init_power(ope);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Power init failed\n");
+		goto err_free;
+	}
+
+	ret = ope_init_mmio(ope);
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "MMIO init failed\n");
+		goto err_free;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		ret = dev_err_probe(dev, irq, "Unable to get IRQ\n");
+		goto err_free;
+	}
+
+	ope->irq = irq;
+
+	/* Requested before the first resume, so that ope->irq is always valid */
+	ret = devm_request_irq(dev, ope->irq, ope_irq, IRQF_NO_AUTOEN,
+			       "camss-ope", ope);
+	if (ret < 0) {
+		ret = dev_err_probe(dev, ret, "Requesting IRQ failed\n");
+		goto err_free;
+	}
+
+	ret = ope_soft_reset(ope);
+	if (ret)
+		goto err_free;
+
+	cpu_latency_qos_add_request(&ope->qos_req, PM_QOS_DEFAULT_VALUE);
+
+	/* ope ownership is transferred to ope_v4l2_register(), even on failure */
+	ret = ope_v4l2_register(ope);
+	if (ret) {
+		platform_set_drvdata(pdev, NULL);
+		return dev_err_probe(dev, ret, "V4L2 registration failed\n");
+	}
+
+	/* Everything @ope_irq() touches is in place, let interrupts in */
+	enable_irq(ope->irq);
+
+	return 0;
+
+err_free:
+	platform_set_drvdata(pdev, NULL);
+	mutex_destroy(&ope->mutex);
+	mutex_destroy(&ope->reset_mutex);
+	kfree(ope);
+	put_device(dev);
+	return ret;
+}
+
+static void ope_remove(struct platform_device *pdev)
+{
+	struct ope_dev *ope = platform_get_drvdata(pdev);
+
+	disable_irq(ope->irq);
+	ope_unregister(ope);
+}
+
+static int ope_runtime_suspend(struct device *dev)
+{
+	struct ope_dev *ope = dev_get_drvdata(dev);
+
+	ope_sched_pause(ope);
+	ope_flush_hw(ope);
+
+	scoped_guard(spinlock_irqsave, &ope->sched_lock)
+		ope->hw_ctx = NULL;
+
+	ope_glut_cache_invalidate(ope);
+
+	clk_bulk_disable_unprepare(ope->nclks, ope->clks);
+
+	return 0;
+}
+
+static int ope_runtime_resume(struct device *dev)
+{
+	struct ope_dev *ope = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_bulk_prepare_enable(ope->nclks, ope->clks);
+	if (ret)
+		return ret;
+
+	__ope_irq_init(ope);
+
+	ope_sched_resume(ope);
+
+	return 0;
+}
+
+static int ope_suspend(struct device *dev)
+{
+	struct ope_dev *ope = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	/* Hold off jobs until pm_runtime_force_resume() re-enables runtime PM */
+	ope_sched_pause(ope);
+
+	return 0;
+}
+
+static int ope_resume(struct device *dev)
+{
+	struct ope_dev *ope = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+
+	ope_sched_resume(ope);
+
+	return ret;
+}
+
+static const struct of_device_id ope_dt_ids[] = {
+	{ .compatible = "qcom,qcm2290-camss-ope" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ope_dt_ids);
+
+static const struct dev_pm_ops ope_pm_ops = {
+	RUNTIME_PM_OPS(ope_runtime_suspend, ope_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(ope_suspend, ope_resume)
+};
+
+static struct platform_driver ope_driver = {
+	.probe  = ope_probe,
+	.remove = ope_remove,
+	.driver = {
+		.name           = OPE_NAME,
+		.of_match_table = ope_dt_ids,
+		.pm             = pm_ptr(&ope_pm_ops),
+	},
+};
+
+module_platform_driver(ope_driver);
+
+MODULE_DESCRIPTION("CAMSS Offline Processing Engine");
+MODULE_AUTHOR("Loic Poulain <loic.poulain@oss.qualcomm.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/media/platform/qcom/camss/ope/params.c b/drivers/media/platform/qcom/camss/ope/params.c
new file mode 100644
index 0000000000000000000000000000000000000000..3647f1484754b01d6ed0bd2458769fac81d05ede
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/ope/params.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ope/params.c
+ *
+ * CAMSS ISP parameter buffer parser.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <media/videobuf2-core.h>
+#include <media/v4l2-isp.h>
+
+#include "params.h"
+
+int camss_isp_params_apply(struct device *dev,
+			   struct vb2_buffer *vb,
+			   struct v4l2_isp_buffer *scratch,
+			   const struct v4l2_isp_params_block_type_info *type_info,
+			   const camss_isp_params_handler_fn *handlers,
+			   unsigned int num_handlers,
+			   void *priv)
+{
+	const struct v4l2_isp_buffer *buf = scratch;
+	const void *src;
+	unsigned int remaining;
+	unsigned int offset = 0;
+	int ret;
+
+	ret = v4l2_isp_params_validate_buffer_size(dev, vb,
+					v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOAD));
+	if (ret)
+		return ret;
+
+	src = vb2_plane_vaddr(vb, 0);
+
+	if (!src) {
+		dev_dbg(dev, "params: buffer has no kernel mapping\n");
+		return -EFAULT;
+	}
+
+	/*
+	 * The payload lives in a vmalloc'd buffer that userspace keeps mapped
+	 * while the buffer is queued, so it must not be validated in place:
+	 * copy it into kernel-only memory first, then work exclusively on the
+	 * copy.  See the v4l2_isp_params_validate_buffer() documentation.
+	 */
+	memcpy(scratch, src, vb2_get_plane_payload(vb, 0));
+
+	ret = v4l2_isp_params_validate_buffer(dev, vb, buf, type_info, num_handlers);
+	if (ret)
+		return ret;
+
+	dev_dbg(dev, "params: version=%u data_size=%u\n", buf->version, buf->data_size);
+
+	remaining = buf->data_size;
+
+	while (remaining >= sizeof(struct v4l2_isp_block_header)) {
+		const union camss_isp_params_block *block =
+			(const union camss_isp_params_block *)&buf->data[offset];
+		u16 type  = block->header.type;
+		u32 bsize = block->header.size;
+
+		if (type < num_handlers && handlers[type])
+			handlers[type](priv, block);
+		else
+			dev_dbg(dev, "params: no handler for block type %u\n", type);
+
+		offset += bsize;
+		remaining -= bsize;
+	}
+
+	dev_dbg(dev, "params: buffer parsed successfully\n");
+
+	return 0;
+}
diff --git a/drivers/media/platform/qcom/camss/ope/params.h b/drivers/media/platform/qcom/camss/ope/params.h
new file mode 100644
index 0000000000000000000000000000000000000000..708cb8bd2dddd8679088012b60740b90abfb36af
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/ope/params.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ope/params.h
+ *
+ * CAMSS ISP parameter buffer parser.
+ *
+ * Wraps the upstream v4l2_isp_params_validate_buffer() validation and adds
+ * a dispatch layer: after validation each block is forwarded to a
+ * driver-supplied handler.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef CAMSS_PARAMS_H
+#define CAMSS_PARAMS_H
+
+#include <linux/string.h>
+#include <linux/types.h>
+#include <media/v4l2-isp.h>
+#include <linux/media/qcom/camss-config.h>
+
+#define CAMSS_ISP_PARAMS_FMT_INIT \
+	{ .fourcc = V4L2_META_FMT_QCOM_ISP_PARAMS, .depth = 8, .align = 0, .num_planes = 1 }
+
+#define CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY   (1U << V4L2_ISP_FL_DRIVER_FLAGS(0))
+
+struct device;
+struct vb2_buffer;
+struct camss_isp_fmt;
+
+union camss_isp_params_block {
+	struct v4l2_isp_block_header header;
+	struct camss_params_wb_gain         wb_gain;
+	struct camss_params_chroma_enhan   chroma_enhan;
+	struct camss_params_color_correct  color_correct;
+	struct camss_params_gamma          gamma;
+};
+
+typedef void (*camss_isp_params_handler_fn)(void *priv, const union camss_isp_params_block *block);
+
+/**
+ * camss_isp_params_copy_block - copy one validated block into driver state
+ *
+ * @dst:   destination block in the driver's shadow configuration
+ * @block: validated source block
+ * @size:  size of the destination block
+ *
+ * Returns true if the payload was copied, false if only the header was.
+ */
+static inline bool camss_isp_params_copy_block(void *dst,
+					       const union camss_isp_params_block *block,
+					       size_t size)
+{
+	struct v4l2_isp_block_header *hdr = dst;
+	bool header_only = block->header.size == sizeof(block->header);
+
+	if (header_only)
+		*hdr = block->header;
+	else
+		memcpy(dst, block, size);
+
+	hdr->flags |= CAMSS_ISP_PARAMS_FL_BLOCK_DIRTY;
+
+	return !header_only;
+}
+
+/**
+ * camss_isp_params_apply - validate and dispatch a params buffer
+ *
+ * @dev:          device for error logging
+ * @vb:           the vb2 buffer (used for size validation)
+ * @scratch:      kernel-only bounce buffer, at least
+ *                v4l2_isp_buffer_size(CAMSS_PARAMS_OPE_MAX_PAYLOAD) bytes
+ * @type_info:    per-block-type validation info, indexed by block type
+ * @handlers:     per-block-type handlers, indexed by block type
+ * @num_handlers: number of entries in @type_info and @handlers
+ * @priv:         opaque pointer forwarded to each handler
+ *
+ * Copies the buffer payload into @scratch, calls
+ * v4l2_isp_params_validate_buffer_size(), then
+ * v4l2_isp_params_validate_buffer(), then walks the validated block stream
+ * dispatching each block to its handler.  Validation and dispatch operate
+ * only on @scratch, never on the userspace-visible mapping.
+ *
+ * Returns 0 on success, negative errno on validation failure.
+ */
+int camss_isp_params_apply(struct device *dev,
+			   struct vb2_buffer *vb,
+			   struct v4l2_isp_buffer *scratch,
+			   const struct v4l2_isp_params_block_type_info *type_info,
+			   const camss_isp_params_handler_fn *handlers,
+			   unsigned int num_handlers,
+			   void *priv);
+
+#endif /* CAMSS_PARAMS_H */
diff --git a/drivers/media/platform/qcom/camss/ope/pipeline.c b/drivers/media/platform/qcom/camss/ope/pipeline.c
new file mode 100644
index 0000000000000000000000000000000000000000..9a8afbc30d32359c7cf0063a8ba0b1fc2173ca7e
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/ope/pipeline.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * CAMSS ISP pipeline helper — declarative MC topology builder
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/slab.h>
+
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+#include "pipeline.h"
+
+/* -------- Internal helpers -------- */
+
+static enum vfl_devnode_direction isp_caps_to_vfl_dir(u32 caps)
+{
+	if (caps & (V4L2_CAP_VIDEO_M2M | V4L2_CAP_VIDEO_M2M_MPLANE))
+		return VFL_DIR_M2M;
+	if (caps & (V4L2_CAP_VIDEO_OUTPUT | V4L2_CAP_VIDEO_OUTPUT_MPLANE |
+		    V4L2_CAP_META_OUTPUT | V4L2_CAP_VBI_OUTPUT | V4L2_CAP_SDR_OUTPUT))
+		return VFL_DIR_TX;
+	return VFL_DIR_RX;
+}
+
+static unsigned int isp_count_pads(const struct camss_isp_pad_desc *pads)
+{
+	unsigned int n = 0;
+
+	if (!pads)
+		return 0;
+	while (pads[n].flags)
+		n++;
+	return n;
+}
+
+static struct media_entity *isp_pipeline_media_entity(struct camss_isp_pipeline *pipeline,
+						      unsigned int idx)
+{
+	struct camss_isp_pipeline_entity *slot = &pipeline->entities[idx];
+
+	switch (slot->obj_type) {
+	case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
+		return &slot->vdev.entity;
+	case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
+		return &slot->subdev.entity;
+	default:
+		return &slot->entity;
+	}
+}
+
+/* -------- Validation -------- */
+
+static int isp_pipeline_validate(struct device *dev,
+				 const struct camss_isp_entity_desc *descs,
+				 unsigned int num_entities)
+{
+	unsigned int i, pi;
+
+	for (i = 0; i < num_entities; i++) {
+		const struct camss_isp_pad_desc *pads = descs[i].pads;
+		unsigned int num_pads = isp_count_pads(pads);
+
+		for (pi = 0; pi < num_pads; pi++) {
+			const struct camss_isp_pad_desc *pad = &pads[pi];
+			const struct camss_isp_pad_desc *peer_pad;
+			unsigned int peer_num_pads;
+			int peer_ent = pad->peer_entity;
+
+			if (peer_ent < 0)
+				continue;
+
+			if ((unsigned int)peer_ent >= num_entities) {
+				dev_err(dev, "entity[%u].p%u: peer_entity %d out of range\n",
+					i, pi, peer_ent);
+				return -EINVAL;
+			}
+
+			peer_num_pads = isp_count_pads(descs[peer_ent].pads);
+			if (pad->peer_pad >= peer_num_pads) {
+				dev_err(dev, "entity[%u].p%u: peer_pad %u out of range\n",
+					i, pi, pad->peer_pad);
+				return -EINVAL;
+			}
+
+			peer_pad = &descs[peer_ent].pads[pad->peer_pad];
+
+			/* Links are SOURCE->SINK; reject SOURCE->SOURCE or SINK->SINK */
+			if (((pad->flags & MEDIA_PAD_FL_SOURCE) &&
+			     (peer_pad->flags & MEDIA_PAD_FL_SOURCE)) ||
+			    ((pad->flags & MEDIA_PAD_FL_SINK) &&
+			     (peer_pad->flags & MEDIA_PAD_FL_SINK))) {
+				dev_err(dev, "entity[%u].p%u -> entity[%d].p%u: invalid\n",
+					i, pi, peer_ent, pad->peer_pad);
+				return -EINVAL;
+			}
+
+			/* A link must be described symmetrically from both ends */
+			if ((unsigned int)peer_pad->peer_entity != i ||
+			    peer_pad->peer_pad != pi) {
+				dev_err(dev, "entity[%u].p%u <-> entity[%d].p%u: mismatch\n",
+					i, pi, peer_ent, pad->peer_pad);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* -------- Allocation / Release -------- */
+
+struct camss_isp_pipeline *camss_isp_pipeline_alloc(unsigned int num_entities)
+{
+	struct camss_isp_pipeline *pipeline;
+
+	pipeline = kzalloc(struct_size(pipeline, entities, num_entities),
+			   GFP_KERNEL);
+	if (!pipeline)
+		return ERR_PTR(-ENOMEM);
+
+	pipeline->num_entities = num_entities;
+	mutex_init(&pipeline->vdev_lock);
+	return pipeline;
+}
+
+void camss_isp_pipeline_free(struct camss_isp_pipeline *pipeline)
+{
+	unsigned int i;
+
+	if (!pipeline)
+		return;
+
+	/* Release pads and subdevs state */
+	for (i = 0; i < pipeline->num_entities; i++) {
+		struct camss_isp_pipeline_entity *slot = &pipeline->entities[i];
+
+		if (slot->obj_type == MEDIA_ENTITY_TYPE_V4L2_SUBDEV)
+			v4l2_subdev_cleanup(&slot->subdev);
+
+		kfree(slot->pads);
+		slot->pads = NULL;
+	}
+
+	mutex_destroy(&pipeline->vdev_lock);
+	kfree(pipeline);
+}
+
+/* -------- Registration -------- */
+
+void camss_isp_pipeline_unregister(struct camss_isp_pipeline *pipeline)
+{
+	int i;
+
+	/* Unregister entities in reverse order. */
+	for (i = (int)pipeline->num_entities - 1; i >= 0; i--) {
+		struct camss_isp_pipeline_entity *slot = &pipeline->entities[i];
+
+		if (slot->registered) {
+			switch (slot->obj_type) {
+			case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
+				if (video_device_pipeline(&slot->vdev))
+					video_device_pipeline_stop(&slot->vdev);
+				video_unregister_device(&slot->vdev);
+				break;
+			case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
+				v4l2_device_unregister_subdev(&slot->subdev);
+				break;
+			case MEDIA_ENTITY_TYPE_BASE:
+				media_entity_remove_links(&slot->entity);
+				media_device_unregister_entity(&slot->entity);
+				slot->entity.name = NULL;
+				break;
+			}
+
+			slot->registered = false;
+		}
+	}
+
+	pipeline->v4l2_dev = NULL;
+}
+
+static int isp_register_vdev(struct camss_isp_pipeline *pipeline,
+			     struct camss_isp_pipeline_entity *slot,
+			     const struct camss_isp_entity_desc *desc,
+			     struct v4l2_device *v4l2_dev)
+{
+	struct video_device *vdev = &slot->vdev;
+	int ret;
+
+	if (!desc->name || !desc->name[0] || !desc->vdev.fops)
+		return -EINVAL;
+
+	strscpy(vdev->name, desc->name, sizeof(vdev->name));
+	vdev->vfl_dir     = isp_caps_to_vfl_dir(desc->vdev.caps);
+	vdev->v4l2_dev    = v4l2_dev;
+	vdev->device_caps = desc->vdev.caps | V4L2_CAP_IO_MC;
+	vdev->release     = video_device_release_empty;
+	vdev->fops        = desc->vdev.fops;
+	vdev->lock        = &pipeline->vdev_lock;
+	if (desc->vdev.ioctl_ops)
+		vdev->ioctl_ops = desc->vdev.ioctl_ops;
+	if (desc->vdev.entity_ops)
+		vdev->entity.ops = desc->vdev.entity_ops;
+
+	vdev->entity.obj_type = MEDIA_ENTITY_TYPE_VIDEO_DEVICE;
+	vdev->entity.function = desc->function ? desc->function : MEDIA_ENT_F_IO_V4L;
+
+	ret = media_entity_pads_init(&vdev->entity, slot->num_pads, slot->pads);
+	if (ret)
+		return ret;
+
+	video_set_drvdata(vdev, desc->vdev.drvdata);
+
+	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int isp_register_subdev(struct camss_isp_pipeline_entity *slot,
+			       const struct camss_isp_entity_desc *desc,
+			       struct v4l2_device *v4l2_dev)
+{
+	struct v4l2_subdev *sd = &slot->subdev;
+	int ret;
+
+	if (!desc->name || !desc->name[0] || !desc->subdev.ops)
+		return -EINVAL;
+
+	v4l2_subdev_init(sd, desc->subdev.ops);
+	strscpy(sd->name, desc->name, sizeof(sd->name));
+	sd->entity.function = desc->function ?
+			      desc->function : MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
+	/* Create a /dev/v4l-subdevN node so userspace can query pad formats */
+	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
+	if (desc->subdev.internal_ops)
+		sd->internal_ops = desc->subdev.internal_ops;
+	if (desc->subdev.entity_ops)
+		sd->entity.ops = desc->subdev.entity_ops;
+
+	ret = media_entity_pads_init(&sd->entity, slot->num_pads, slot->pads);
+	if (ret)
+		return ret;
+
+	ret = v4l2_subdev_init_finalize(sd);
+	if (ret)
+		return ret;
+
+	ret = v4l2_device_register_subdev(v4l2_dev, sd);
+	if (ret) {
+		v4l2_subdev_cleanup(sd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int isp_register_base_entity(struct camss_isp_pipeline_entity *slot,
+				    const struct camss_isp_entity_desc *desc,
+				    struct v4l2_device *v4l2_dev)
+{
+	struct media_entity *entity = &slot->entity;
+	int ret;
+
+	if (!desc->name || !desc->name[0])
+		return -EINVAL;
+
+	entity->obj_type = MEDIA_ENTITY_TYPE_BASE;
+	entity->name     = desc->name;
+	entity->function = desc->function;
+
+	ret = media_entity_pads_init(entity, slot->num_pads, slot->pads);
+	if (ret) {
+		entity->name = NULL;
+		return ret;
+	}
+
+	ret = media_device_register_entity(v4l2_dev->mdev, entity);
+	if (ret) {
+		entity->name = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int isp_alloc_pads(struct camss_isp_pipeline_entity *slot,
+			  const struct camss_isp_entity_desc *desc)
+{
+	unsigned int num_pads = isp_count_pads(desc->pads);
+	unsigned int i;
+
+	if (!num_pads)
+		goto done;
+
+	slot->pads = kcalloc(num_pads, sizeof(*slot->pads), GFP_KERNEL);
+	if (!slot->pads)
+		return -ENOMEM;
+
+	for (i = 0; i < num_pads; i++)
+		slot->pads[i].flags = desc->pads[i].flags;
+done:
+	slot->num_pads = num_pads;
+	return 0;
+}
+
+int camss_isp_pipeline_register(struct camss_isp_pipeline *pipeline,
+				struct v4l2_device *v4l2_dev,
+				const struct camss_isp_entity_desc *descs,
+				unsigned int num_entities)
+{
+	unsigned int i, pi;
+	int ret;
+
+	if (WARN_ON(num_entities != pipeline->num_entities))
+		return -EINVAL;
+
+	if (WARN_ON(!v4l2_dev || !v4l2_dev->mdev))
+		return -EINVAL;
+
+	ret = isp_pipeline_validate(v4l2_dev->dev, descs, num_entities);
+	if (ret)
+		return ret;
+
+	pipeline->v4l2_dev = v4l2_dev;
+
+	/* Populate every slot before registering anything */
+	for (i = 0; i < num_entities; i++) {
+		struct camss_isp_pipeline_entity *slot = &pipeline->entities[i];
+
+		slot->obj_type = descs[i].obj_type;
+
+		ret = isp_alloc_pads(slot, &descs[i]);
+		if (ret)
+			goto err_unregister;
+	}
+
+	/* Register each entity */
+	for (i = 0; i < num_entities; i++) {
+		const struct camss_isp_entity_desc *desc = &descs[i];
+		struct camss_isp_pipeline_entity *slot = &pipeline->entities[i];
+
+		switch (desc->obj_type) {
+		case MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
+			ret = isp_register_vdev(pipeline, slot, desc, v4l2_dev);
+			break;
+		case MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
+			ret = isp_register_subdev(slot, desc, v4l2_dev);
+			break;
+		case MEDIA_ENTITY_TYPE_BASE:
+		default:
+			ret = isp_register_base_entity(slot, desc, v4l2_dev);
+			break;
+		}
+		if (ret)
+			goto err_unregister;
+
+		slot->registered = true;
+	}
+
+	/* Create links — only from SOURCE side to avoid duplicates */
+	for (i = 0; i < num_entities; i++) {
+		const struct camss_isp_entity_desc *desc = &descs[i];
+		unsigned int num_pads = isp_count_pads(desc->pads);
+
+		for (pi = 0; pi < num_pads; pi++) {
+			const struct camss_isp_pad_desc *pad = &desc->pads[pi];
+			struct media_entity *src_entity, *sink_entity;
+			unsigned int src_pad_idx, sink_pad_idx;
+			u32 lflags;
+
+			if (!(pad->flags & MEDIA_PAD_FL_SOURCE))
+				continue;
+			if (pad->peer_entity < 0)
+				continue;
+
+			src_entity   = isp_pipeline_media_entity(pipeline, i);
+			sink_entity  = isp_pipeline_media_entity(pipeline,
+								 (unsigned int)pad->peer_entity);
+			src_pad_idx  = pi;
+			sink_pad_idx = pad->peer_pad;
+
+			lflags = pad->link_flags ?
+				 pad->link_flags :
+				 (MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED);
+
+			ret = media_create_pad_link(src_entity,  src_pad_idx,
+						    sink_entity, sink_pad_idx,
+						    lflags);
+			if (ret)
+				goto err_unregister;
+		}
+	}
+
+	/* Create /dev/v4l-subdevN nodes for all registered subdevs */
+	ret = v4l2_device_register_subdev_nodes(v4l2_dev);
+	if (ret)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	camss_isp_pipeline_unregister(pipeline);
+	return ret;
+}
diff --git a/drivers/media/platform/qcom/camss/ope/pipeline.h b/drivers/media/platform/qcom/camss/ope/pipeline.h
new file mode 100644
index 0000000000000000000000000000000000000000..62e4116012ad0e4a089e88fbf3a6711bb139ee0e
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/ope/pipeline.h
@@ -0,0 +1,242 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * CAMSS ISP pipeline helper — declarative MC topology builder
+ *
+ * Drivers describe their entire media graph — entities (video devices,
+ * subdevs, or base entities), their pads, and the links between them —
+ * in a single static descriptor table.  The builder validates the table,
+ * allocates and registers all entities, and creates all MC links.
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _CAMSS_PIPELINE_H
+#define _CAMSS_PIPELINE_H
+
+#include <linux/mutex.h>
+#include <media/media-device.h>
+#include <media/media-entity.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
+/**
+ * struct camss_isp_pad_desc - descriptor for one pad and its optional link
+ *
+ * @flags:       Pad flags: MEDIA_PAD_FL_SINK, MEDIA_PAD_FL_SOURCE,
+ *               MEDIA_PAD_FL_MUST_CONNECT.  A zero @flags value acts as
+ *               the sentinel that terminates the pad list.
+ * @peer_entity: Index of the peer entity in the descriptor array, or -1
+ *               if this pad has no link.
+ * @peer_pad:    Pad index on the peer entity to link to.
+ * @link_flags:  MC link flags (MEDIA_LNK_FL_*).  Defaults to
+ *               MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED when zero.
+ *
+ * Links are described from both sides (each endpoint references the other),
+ * but the builder only creates each link once — from the SOURCE side.
+ */
+struct camss_isp_pad_desc {
+	u32          flags;
+	int          peer_entity;
+	unsigned int peer_pad;
+	u32          link_flags;
+};
+
+/**
+ * struct camss_isp_entity_desc - descriptor for one entity in the pipeline
+ *
+ * @name:      Human-readable entity name (also used as video device name
+ *             suffix when @obj_type is MEDIA_ENTITY_TYPE_VIDEO_DEVICE).
+ *             Mandatory and must be non-empty.
+ * @obj_type:  MEDIA_ENTITY_TYPE_VIDEO_DEVICE, MEDIA_ENTITY_TYPE_V4L2_SUBDEV,
+ *             or MEDIA_ENTITY_TYPE_BASE.
+ * @function:  MEDIA_ENT_F_* function identifier.
+ * @pads:      Sentinel-terminated (flags == 0) array of pad descriptors.
+ *
+ * Fields used only for MEDIA_ENTITY_TYPE_VIDEO_DEVICE:
+ * @vdev.caps: V4L2_CAP_* device capabilities.
+ *             The video device direction (VFL_DIR_RX/TX/M2M) is derived
+ *             automatically from @caps by the builder.
+ * @vdev.drvdata: Opaque pointer set via video_set_drvdata() after registration.
+ * @vdev.fops:      File operations (mandatory).
+ * @vdev.ioctl_ops: ioctl operations (may be NULL).
+ * @vdev.entity_ops: Media entity operations (may be NULL).
+ *
+ * Fields used only for MEDIA_ENTITY_TYPE_V4L2_SUBDEV:
+ * @subdev.ops: Subdev operations (mandatory).
+ * @subdev.internal_ops: Internal subdev operations (may be NULL).
+ * @subdev.entity_ops: Media entity operations (may be NULL).
+ */
+struct camss_isp_entity_desc {
+	const char				*name;
+	u32					obj_type;
+	u32					function;
+	const struct camss_isp_pad_desc		*pads;
+
+	union {
+		/* MEDIA_ENTITY_TYPE_VIDEO_DEVICE */
+		struct {
+			u32					caps;
+			void					*drvdata;
+			const struct v4l2_file_operations	*fops;
+			const struct v4l2_ioctl_ops		*ioctl_ops;
+			const struct media_entity_operations	*entity_ops;
+		} vdev;
+		/* MEDIA_ENTITY_TYPE_V4L2_SUBDEV */
+		struct {
+			const struct v4l2_subdev_ops		*ops;
+			const struct v4l2_subdev_internal_ops	*internal_ops;
+			const struct media_entity_operations	*entity_ops;
+		} subdev;
+	};
+};
+
+/**
+ * struct camss_isp_pipeline_entity - one registered entity slot
+ *
+ * Internal to the pipeline; drivers access entities via the accessor helpers.
+ *
+ * @obj_type: mirrors the descriptor's @obj_type.
+ * @registered: set once the entity has been successfully registered, so that
+ *              teardown only undoes what actually succeeded.
+ * @pads:     allocated pad array for this entity.
+ * @num_pads: number of entries in @pads.
+ * @vdev:     valid when @obj_type == MEDIA_ENTITY_TYPE_VIDEO_DEVICE.
+ * @subdev:   valid when @obj_type == MEDIA_ENTITY_TYPE_V4L2_SUBDEV.
+ * @entity:   valid when @obj_type == MEDIA_ENTITY_TYPE_BASE.
+ */
+struct camss_isp_pipeline_entity {
+	u32			 obj_type;
+	bool			 registered;
+	struct media_pad	*pads;
+	unsigned int		 num_pads;
+	union {
+		struct video_device  vdev;
+		struct v4l2_subdev   subdev;
+		struct media_entity  entity;
+	};
+};
+
+/**
+ * struct camss_isp_pipeline - registered ISP pipeline topology
+ *
+ * Allocate with camss_isp_pipeline_alloc(), register with
+ * camss_isp_pipeline_register(), tear down with
+ * camss_isp_pipeline_unregister(), free with camss_isp_pipeline_free().
+ *
+ * @v4l2_dev:     Pointer to the caller-provided V4L2 device.
+ * @drv_priv:     Driver-private pointer; not touched by the framework.
+ * @vdev_lock:    Pipeline-wide mutex assigned to video_device.lock of every
+ *                registered video device, so the V4L2 core serialises ioctl2
+ *                handlers across all of the pipeline's video nodes.
+ * @num_entities: Number of entries in @entities.
+ * @entities:     Per-entity state; flexible array.
+ */
+struct camss_isp_pipeline {
+	struct v4l2_device	*v4l2_dev;
+	void			*drv_priv;
+	struct mutex		 vdev_lock;
+
+	unsigned int		 num_entities;
+	struct camss_isp_pipeline_entity entities[] __counted_by(num_entities);
+};
+
+/**
+ * camss_isp_pipeline_alloc() - allocate a pipeline for @num_entities entities
+ * @num_entities: number of entities the pipeline will hold
+ *
+ * Returns a pointer to the new pipeline or ERR_PTR on failure.
+ * Free with camss_isp_pipeline_free().
+ */
+struct camss_isp_pipeline *camss_isp_pipeline_alloc(unsigned int num_entities);
+
+/**
+ * camss_isp_pipeline_free() - free a pipeline
+ * @pipeline: pipeline to free (may be NULL)
+ */
+void camss_isp_pipeline_free(struct camss_isp_pipeline *pipeline);
+
+/**
+ * camss_isp_pipeline_register() - validate descriptors and register the graph
+ * @pipeline:    pipeline (allocated with camss_isp_pipeline_alloc())
+ * @v4l2_dev:    caller-owned and already-registered V4L2 device; its
+ *               associated media_device (v4l2_dev->mdev) must also be
+ *               initialised and registered before this call.
+ * @descs:       array of @num_entities entity descriptors
+ * @num_entities: number of entities; must equal pipeline->num_entities
+ *
+ * Validates the descriptor table (link direction consistency, index bounds),
+ * then registers all entities into the provided v4l2_device / media_device
+ * and creates all MC pad links.
+ *
+ * Returns 0 on success or a negative error code.
+ */
+int camss_isp_pipeline_register(struct camss_isp_pipeline *pipeline,
+				struct v4l2_device *v4l2_dev,
+				const struct camss_isp_entity_desc *descs,
+				unsigned int num_entities);
+
+/**
+ * camss_isp_pipeline_unregister() - tear down a registered pipeline
+ * @pipeline: pipeline to unregister.
+ */
+void camss_isp_pipeline_unregister(struct camss_isp_pipeline *pipeline);
+
+/**
+ * camss_isp_pipeline_get_vdev() - return the video_device for entity @idx
+ * @pipeline: registered pipeline
+ * @idx:      entity index (must be MEDIA_ENTITY_TYPE_VIDEO_DEVICE)
+ *
+ * Returns NULL if @idx is out of range or the entity is not a video device.
+ */
+static inline struct video_device *
+camss_isp_pipeline_get_vdev(struct camss_isp_pipeline *pipeline,
+			    unsigned int idx)
+{
+	if (WARN_ON(idx >= pipeline->num_entities))
+		return NULL;
+	if (WARN_ON(pipeline->entities[idx].obj_type !=
+		    MEDIA_ENTITY_TYPE_VIDEO_DEVICE))
+		return NULL;
+	return &pipeline->entities[idx].vdev;
+}
+
+/**
+ * camss_isp_pipeline_get_subdev() - return the v4l2_subdev for entity @idx
+ * @pipeline: registered pipeline
+ * @idx:      entity index (must be MEDIA_ENTITY_TYPE_V4L2_SUBDEV)
+ *
+ * Returns NULL if @idx is out of range or the entity is not a subdev.
+ */
+static inline struct v4l2_subdev *
+camss_isp_pipeline_get_subdev(struct camss_isp_pipeline *pipeline,
+			      unsigned int idx)
+{
+	if (WARN_ON(idx >= pipeline->num_entities))
+		return NULL;
+	if (WARN_ON(pipeline->entities[idx].obj_type !=
+		    MEDIA_ENTITY_TYPE_V4L2_SUBDEV))
+		return NULL;
+	return &pipeline->entities[idx].subdev;
+}
+
+/**
+ * camss_isp_pipeline_get_entity() - return the media_entity for entity @idx
+ * @pipeline: registered pipeline
+ * @idx:      entity index (must be MEDIA_ENTITY_TYPE_BASE)
+ *
+ * Returns NULL if @idx is out of range or the entity is not a base entity.
+ */
+static inline struct media_entity *
+camss_isp_pipeline_get_entity(struct camss_isp_pipeline *pipeline,
+			      unsigned int idx)
+{
+	if (WARN_ON(idx >= pipeline->num_entities))
+		return NULL;
+	if (WARN_ON(pipeline->entities[idx].obj_type !=
+		    MEDIA_ENTITY_TYPE_BASE))
+		return NULL;
+	return &pipeline->entities[idx].entity;
+}
+
+#endif /* _CAMSS_PIPELINE_H */

-- 
2.34.1

