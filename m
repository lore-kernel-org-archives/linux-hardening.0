Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71D41684F
	for <linux-hardening@vger.kernel.org>; Fri, 24 Jul 2026 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896941; cv=none; b=eWSk2aIxI8FCDAiPxWRxzuPCbSipjtP7BIehlW1GKeKqCZ/WEiKrh2p/CItOeckl6pTtqJb2NOWrsGdnxdoKz4Mc4UaEXJzFKVzGp7kCkL8MPFendtwkcF6AQ6wozNIvMNxHhhrSx3uSiDSW1trB9+4Wj3QgPBVa0xKxgNNVAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896941; c=relaxed/simple;
	bh=P6LNU8zKsK52EexDG9sr03EG75GRsVNOKcLPifAvHfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jxI3pJvb80wvPtDto5yPsGK9bWN9ZMyj6GADZxO7g1zJYmQouw/9zQQhe7JGhLcylwHXBt1amQeU01cTEc4VMRouyMPQ6F7tQb9FHdiXay71Nl9aAeSrKUsaixH0MY3mkq1jCZMHgoxncQkuf9lJazGLalfUSt/Z4DIKA8BQ/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M6wO3a7Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QZOamfDs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M6wO3a7Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZOamfDs"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OCgHPu3057340
	for <linux-hardening@vger.kernel.org>; Fri, 24 Jul 2026 12:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BasHnkJh1AZ7ZcpL5l3uRm
	qruJWcA/bEo+NpmjJe46s=; b=M6wO3a7ZuvIwMd1Z2VmXDAvZ8D4E6GGLeCksJK
	ic0LoICZaklUv/Fu+ra3/e5prLmo3P7k3+A85V7piLq+oDpS4JMID7/WaqNew/SO
	9BQfwv3YVBDB/8krz9SgAXu1DoJMqA70kONekACTfm+tYw/5gXDqtdklmXf0ymMv
	VfMI/mivaWlnvINrSPyOCjkw9wIp3ahd3jTXT9er352xDJmmJN7Ln74zijXhEy4B
	QUyoDLd92GALFaH2+dyPAkXHG9JmaRrl7BPA7oHwUYtXQlFRgnTT9btgkq2b2jFC
	eImBDjw6YPvxD0yjKHOuu6ESGPQjEFqST41LppS733qrtu+Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yagj52-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 24 Jul 2026 12:42:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso6768461cf.2
        for <linux-hardening@vger.kernel.org>; Fri, 24 Jul 2026 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784896937; x=1785501737; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BasHnkJh1AZ7ZcpL5l3uRmqruJWcA/bEo+NpmjJe46s=;
        b=QZOamfDslNagJfKKQ6zf3ICFaPlrnkheSSuWqBFgR6N3ziHW4Gy/SOH6ISsDU1VLZx
         ZPfgpxFAkrMCgt/9b4JKT9i29AnILZ10EE7bV7WsgrpNjFzf8IwhLtibS8t//69u/fEy
         pTKV0ns30/1q605hKEvbC4VudHslhwo4KeIRmf9wc7DIOxOmLfktPeCyr75kiFepQJfe
         zTbPn3GzOYH+jBQqhNDUxcYDlPFt6sHWcKF9d1Nc0vBSTdrBPzDNUxo5+vYJBHsTEYQd
         cwIvbLpFhxfX5s53aCprJUSsKe6fYBhG/SBEHJ13OvlAIM5qo8JxgixwI1RPhzW75Saa
         y9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784896937; x=1785501737;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BasHnkJh1AZ7ZcpL5l3uRmqruJWcA/bEo+NpmjJe46s=;
        b=Lg5ZORsV0jYuoTAoIrmaU1WlEnOdsW9B8GEa9Cl5kWxd0iZln++mloLPSkWs+UnX4l
         0sRPQE0CXKEtCMxw5XmMuKyvfan0+Qxb0SOSSsVCta2JUqbqEELXDtLViW3m+M424Av5
         Wq0bSl0Av+TDurB1nvKG6dc5UniNdMwlVhuwvBg2NO7IW3urG91SxOaWlXj/0o7N3Bsl
         AEYqQw84AgLKbckD9VFUhRzuTUhjCjR9q6MHr1LRBKtnob2616Gorw5qgHS9HJqbh8YO
         uoZt4LBhxwEDP0ABDQQ9pL8dPPQgaV4k4oQxjFHbqACGH2ByafKXYTPtTovUmzQn7XWf
         yG+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rok7zP8bVJPWxjDcwH7162/E5xm5Wvq96e8wczt7TFgHfeyNKunh3E8SSikHmOBdxGk6u7MolXFSm1PPA0Yy3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNwmbF9EHQl2WeIB1gjR9oqPxfoxI7vkHA5Z50lroBeravdW7
	MCE9Q1iuaAfvxtLJsWRPHITi1j+YuLAtBzkuTv8XHZHoULp8huSr3bOq2hAiGiLgYQuwtHbShzY
	ELhFepzLmZNAVF/ATOnsXNNFXGV7z7CCcsM9GorDN4YDt8bxj9elym4RWlfsZotHYueHUwTQ=
X-Gm-Gg: AR+sD10ks2FD7L2GgCntjKc3EoZ6ST8GdN4NSRoF4BXbW1J2/an5JgjxgsDrC1oZCPK
	UJE8exHMOo8Zd2d427JePow95hriGi9YznZk1L0YDuKxXXLHTc2li6xCGmO1YzjhWnSafaWeKwL
	zE78O5kgqndOnoez3YHDRbZjFrM/2ccbfznCSgGJ0F0rOk0YtL9y3XHCXsEVGf8QO1XGMpApNaq
	00US21Ikf0WDW8kKMNPEDivIQSICUUogPNVsJK2eK9652KAjP1xlJV81F2fElGrKs9OyAYBk0kl
	zHjkQKJ3yWxAhW5o6j44jZ3Nt5mScRM2t0pgYeBOQXmj0Emz0TZUzlGAzgJQlbuRYsbL3if4nnP
	t92oR3fWRM3DYJGhlaBKZNLQ3A18lIDZYwFO+DOhaFjhzwVGMwMpu9pU+DbKCVzhzGX6il5x2vx
	IxCPVIJ2ie6TqmnVtCn1/8Ul1POQ4+gKK7pc73cLIeYMCYWZ0Qzg==
X-Received: by 2002:a05:622a:1802:b0:528:325c:2905 with SMTP id d75a77b69052e-5283df7974dmr69250501cf.63.1784896936915;
        Fri, 24 Jul 2026 05:42:16 -0700 (PDT)
X-Received: by 2002:a05:622a:1802:b0:528:325c:2905 with SMTP id d75a77b69052e-5283df7974dmr69250021cf.63.1784896936299;
        Fri, 24 Jul 2026 05:42:16 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:48e:a2cc:6c4:c92a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ebc828sm352591166b.43.2026.07.24.05.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 05:42:15 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v5 0/5] media: qcom: camss: CAMSS Offline Processing Engine
 support
Date: Fri, 24 Jul 2026 14:42:08 +0200
Message-Id: <20260724-camss-isp-ope-v5-0-e70ad4fa39ce@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKBdY2oC/23OQW7CMBAF0Ksgr5nIHntw6Kr3qFg4jtNYSuLUA
 xEVyt3rwAIJuhnpL+b9fxMccgwsPnY3kcMSOaapBNrvhO/d9B0gtiULlHiQBi14NzJD5BnSHMA
 0ZKnrgsfQivIz59DF6937OpXc5TTCuc/BPRWNWiHVaCpU6qAIFAwp+mpOl8HF6TMxVz8XN/g0j
 lU5m9tHPqf8e5+56E1/WCTrl0WLBglNoyQRWlPa3r1t2GKeiFXyFTEFIYXSOqnVsa3/QdZ1/QO
 TDRLHPgEAAA==
X-Change-ID: 20260427-camss-isp-ope-4b575ffec2ed
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
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX11Cx+SozCXHb
 pKdXq6LuzwTx1JsyyctrG1tN98YW4JWDibfmaYfkufSTpPQrRTJy7NLPQrgq+n9CzjTGIWH/Mxg
 TLB0SReWQygVIzO+4O3QO96R3bBOC4M=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a635da9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=rgSWqCNzigiIzMNiINIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JsCu9-C6gLeXcHos0gJQieSqutbOqdJ0
X-Proofpoint-ORIG-GUID: JsCu9-C6gLeXcHos0gJQieSqutbOqdJ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExNSBTYWx0ZWRfX8VMyKLS6wQ2g
 7SjAN3MnrfN7XIr8cb/XiHr+/XHuHC64BWNo6aRp8cnlQLeWyahBvm8BTaodSXlFCBlI1ryDYUr
 Et7C8ccuNTIFVAd0/F8fasiQDBZr6Xg4KxfSHocNS2gq9fc9PPH7kb6u1G9IsZAqvWO77nY3q+0
 iRDoZZsKBxk8O+Gf1RYn7c4HlSQK4HbUP9zJ9Z3BSlmCCQ7/k2vapR7xSfknacsxSrYSDJ1KG12
 U6t901Ohp/NCtZ3dFmtOYN5g7TLAaaazZn4/09dXOo5WyiOh+ytZIhWocdPD+nu8tdddFVe7TMv
 O3jAVKxHptoLIAG91HRktP3FoZgMoXuY3PNbkk7kgnBfp5O7LZTFXYwh07brXeWusJOzl226MaZ
 mT6KhAB0bgLtSzWSyOzpFEG37SJMNpoTfxfpvYCSxntgWlxy7IC5b0+HDVZHNbxt9JEMx0CtzJ6
 NMBTaK2n23QFKyFP05Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_02,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240115

This series introduces support for the Qualcomm CAMSS Offline Processing
Engine (OPE), as found on Agatti-based platforms. Boards such as Arduino
UNO-Q use this SoC family and will benefit from hardware-assisted image
processing enabled by this work.

This represents the first step toward enabling image processing beyond
raw capture on Qualcomm platforms by using hardware blocks for
operations such as debayering, color correction, and scaling.

The OPE sits outside the live capture pipeline. It operates on frames
fetched from system memory and writes processed results back to memory.
Because of this design, the OPE is not tied to any specific capture
interface: frames may come from CAMSS RDI or PIX paths, or from any
other producer capable of providing memory-backed buffers.

The hardware can sustain up to 580 megapixels per second, which is
sufficient to process a 9MPix (4K) stream at 60 fps or to handle
four parallel 2MPix (HD) streams at 60 fps.

The driver is designed to support multiple processing contexts. At
present, however, only a single context is instantiated, which is
created on the first media-pipeline open. This keeps the implementation
simple while ensuring the design is ready for forthcoming multi-context
support at the V4L2/media framework level.

The OPE is a standalone device, independent from the CAMSS device. It
manages its own clocks and power domains (CAMSS GDSC and CX), and does
not require any change to the core CAMSS driver.

Graph:
ope_input ----+
              +--> ope_proc --> ope_disp --> ope_disp_output
ope_params ---+

Compliance: v4l2-compliance has been executed without any error on
the media and video devices.

Testing: A camss-isp-m2m tool is available at
https://github.com/loicpoulain/camss-isp-m2m-test
The tool can be used to exercise and stress-test the OPE engine,
as well as to observe performance and latency behavior under
various operating conditions (resolution, format, buf count, etc).

./camss-isp-m2m -s 3840x2160 -n 5

  Name                            Device            Dir       Type
  --------------------------------------------------------------
  ope_input                       /dev/video10      output    video
  ope_params                      /dev/video11      output    meta
  ope_disp_output                 /dev/video12      capture   video
  ope_proc                        /dev/v4l-subdev13  -        subdev
  ope_disp                        /dev/v4l-subdev14  -        subdev

Test: 3840x2160 RGGB -> 3840x2160 NV12  [5 frames]
  Input   /dev/video10  3840x2160 RGGB  bpl=3840  size=8294400
  Output  /dev/video12  3840x2160 NV12  bpl=5760  size=12441600

Buffers:
  /dev/video10    buf[0]  offset=0x00000000  length=8294400   VA=0xffffbcb87000
  /dev/video11    buf[0]  offset=0x00000000  length=12441600  VA=0xffffbbfa9000

Streaming  5 frames...
  seq=0      buf: in=0 out=0   14.833 ms  (67.4 fps)
  seq=1      buf: in=0 out=0   14.874 ms  (67.2 fps)
  seq=2      buf: in=0 out=0   14.902 ms  (67.1 fps)
  seq=3      buf: in=0 out=0   14.960 ms  (66.8 fps)
  seq=4      buf: in=0 out=0   14.896 ms  (67.1 fps)

---
Changes in v5:
- Make params definition ope specific (Bryan)
- Add pipeline/params helpers to ope driver/subdir.
- driver: fix COLOR_CORRECT base (0xa00, was 0x400) (Bryan).
- driver: fix DEMO INTERP_COEFF lambda masks (G [7:0], RB [23:16]).
- driver: map pipeline blocks individually, dump per-block HW_VERSION (Bryan).
- driver: disp subdev is pass-through, mirror sink format to source
  and make source read-only.
- dt-bindings/dts: map the CDM register block and rename node to isp@5c42000 (Bryan).
- Link to v4: https://lore.kernel.org/r/20260710-camss-isp-ope-v4-0-51207a0319d8@oss.qualcomm.com

Changes in v4:
- Made OPE a standalone device again, sibling of CAMSS rather than
  a child node, following maintainer feedback (Bryan)
- Aligned params with ones suggested by Bryan (when possible) (Bryan)
- Correct usage of subdevice states for configuration (Hans)
- Removed the bufq and scheduling helpers (now in ope driver) (Bryan)
- Moved generic pipeline and params helpers to camms 'core'
- Fixed Green hue with some downscaling factors (reported by Hans)
- Fixed ope_enum_fmt_vid_cap (Hans)
- don't hardcode DT assigned-clock-rates for AXI (Konrad)
- Link to v3: https://lore.kernel.org/all/20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com

Changes in v3:
- Simplified camss_init_pm_clks()- no clk_get, no rate setting;
- Added Assigned clock rate in devicetree for CAMSS AXI clock
- Add Kernel Doc for camss-isp-bufq exported functions
- Added description explaining the 2-cell for CAMSS bus
- Reworked OPE media topology with intermediate ope_disp subdev
- Support for crop and compose in ope_proc sink/source
- Fixed Write Engine violation with some scaling config
- Fixed input/output custom-stride issue (Hans)
- Split uapi header (camss-config.h) into its own dedicated commit
- Patch reordering to respect dependency in regards to ABI/dt-bindings introduction
- Link to v2: https://lore.kernel.org/r/20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com

Changes in v2:
- Not an RFC anymore
- Move from v4l2-m2m to multi-devices design
- Support for parameters
- Helpers for pipeline, job scheduling, buf-queues
- OPE as a child node of CAMSS

To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Kees Cook <kees@kernel.org>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Loic Poulain (5):
      media: qcom: camss: Add V4L2 meta format for CAMSS ISP parameters
      dt-bindings: media: qcom: Add CAMSS Offline Processing Engine (OPE)
      media: uapi: Add CAMSS OPE ISP configuration definition
      media: qcom: camss: Add CAMSS Offline Processing Engine driver
      arm64: dts: qcom: agatti: Add OPE node

 .../bindings/media/qcom,qcm2290-camss-ope.yaml     |  151 +
 arch/arm64/boot/dts/qcom/agatti.dtsi               |   79 +
 drivers/media/platform/qcom/camss/Kconfig          |    2 +
 drivers/media/platform/qcom/camss/Makefile         |    2 +
 drivers/media/platform/qcom/camss/ope/Kconfig      |   16 +
 drivers/media/platform/qcom/camss/ope/Makefile     |    9 +
 drivers/media/platform/qcom/camss/ope/core.c       | 3353 ++++++++++++++++++++
 drivers/media/platform/qcom/camss/ope/params.c     |   75 +
 drivers/media/platform/qcom/camss/ope/params.h     |   62 +
 drivers/media/platform/qcom/camss/ope/pipeline.c   |  399 +++
 drivers/media/platform/qcom/camss/ope/pipeline.h   |  237 ++
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 include/uapi/linux/camss-ope-config.h              |  160 +
 include/uapi/linux/videodev2.h                     |    3 +
 14 files changed, 4549 insertions(+)
---
base-commit: 6b0fbf4352615cc5e542347120f1724ce31837f8
change-id: 20260427-camss-isp-ope-4b575ffec2ed

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

