Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8434F49F
	for <linux-hardening@vger.kernel.org>; Mon,  7 Sep 2026 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778283; cv=none; b=UpWDao8nd+QRr6HAvHB+8iTm2vyagsKAW/HHM6hh9ywHpGxCbvoF8RcFJ2i7ZJEmQifIpn5k4WtTW3BeH+Ki938BQZlvxp5v0K8TTjGkGYeK0Tywnh+DWUPCGcvA/vQGx5XGjy43pHgVBgQHyCb1jkNHkic6w3cJgRXJhU0FxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778283; c=relaxed/simple;
	bh=3TgDIVxSSZCJZL39Yv1C3A5lcaT6Pna700RU92OE0CQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M/VLKLgLqOiqf/t6jBX5haLS+SHgyEKPzZ20/WQYWqagtIlxj364KYVjfSbLhPS2rYbf6n27yQy+EURiqfA/B6H82lNMyY7x+NUUfgnpnGviXi/nfPOH6R3LG0cpEpzetGzYL90xPexkte+BTj+xHEKpF4ePh18lAWlnov/6l9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oBslNv64; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=edweir40; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oBslNv64";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="edweir40"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AnFds004219
	for <linux-hardening@vger.kernel.org>; Mon, 7 Sep 2026 10:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lnKaBCOd1PrZ+4vRyexQEP
	avEfrOuZnUA7FEcqmIaF0=; b=oBslNv64s7zj5XrHO0Fxfafn/LQd7BPWgM03GM
	tyR4aFM+VR0cYyCu+H5nSGfAAATdWF1PWfrjlHtvuVg6qaauNgRzgmI0KAfs3w5P
	eAS/u6QVRycOF2c0VbpYG/+qeaH+9+TcuchnuMEsm/G+iZTUbyG8eqq5Dici5GUi
	fQH7qaVyqrXTxzjJUwl0QCu+un9uX09zx+RVqMzGGqk6cN+szGIKcTFyfRqeEUtV
	hAinrmJH0dmYm17mnB6grXEuPTNXzyfnOUWaejVaOqhEbvJpqCEN+kiL8Ni4gGbm
	m4GNvBj4qzvYBf6A7lbX0YQDX+eD97T6Bzd0IV9Uc/z8ce5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghssg0mvj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 10:51:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-938153538caso544550385a.1
        for <linux-hardening@vger.kernel.org>; Mon, 07 Sep 2026 03:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788778275; x=1789383075; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lnKaBCOd1PrZ+4vRyexQEPavEfrOuZnUA7FEcqmIaF0=;
        b=edweir40Tgo5oSOgeTo2vNWhvYTU+dt1VCYFkK8S9P3N59a7PS9l1Fl6jtntR8ElK8
         wvk8VBMQW3f0qbhtDlPA9OLzl+eZpDu10IJEKfEAwh0DdDuGre5fGDnNauN/GRWRG6/E
         3G84qKQgsOyOyAvSnVEI27MqR8+Vu0ZHrC/gLlWLew2VgUsfp70xN2avDZMpL0b+r1FR
         avMCBB3aSfssjRyfpLS78b+7b3LDqA0OSOhLYHBQ4I8fYSkyl/C1m+WLRcAlOvhynqL4
         5dNfgEhGdLYvuFvN+H8z5D3fh7pM6gKFPu68haScVxwWXORUourXJycNXrW60Mpfh0pp
         SKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788778275; x=1789383075;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lnKaBCOd1PrZ+4vRyexQEPavEfrOuZnUA7FEcqmIaF0=;
        b=Iy35CJsSiOhwrhbDWIbkwVOBZEsCtvKYx3nau3O++XYNr9Thbvc6WsI46Xl/Bwleo+
         7YTPueP9n/f5UNixY0wSxqnsyxk8QoBxwhhGuftUpLTgxHmZ44UD2oM4nMSdZYTQjIPy
         vQIvfjK9WCe4q/WMwfZoy/hvKOJFM+YPCfqfC44sYjodle65vbvgYWMU4hRJh7fE370X
         pClLkatrX6yavZ6gmhufaePkk1FXjH7IJ6I/VkqB9JSC1EV5vU1tflMrt0VhlSSQDUJe
         3vMO44wQQpcas6cT3T01oh2vBbCrSYEDesGy8zZUfoTtOMRAsQWBnFJ6wxhTfzOPZksz
         5hnQ==
X-Forwarded-Encrypted: i=1; AKwUvBytIVrV1FT52np6ZR52zghn9IQY6k/YRnCpiogU/Tnp7WzFsdvWR9AJzk9bl8Q5TqwLZu4vAy5FGLaNxQtpBs4=@vger.kernel.org
X-Gm-Message-State: AFuF++n/Liug2Ipb3n7498woHCNCAiF1VA5TSHO/qEg5StebeBqIb+Ah
	eTCzgqyfs/3d2wiwh5kCCjPT7beWbBJn8gRkzVzZQ4InXTH000psCNiuWZixrhCFKwa5uECouiv
	i6fOxmZ8Wf+SJYlksnlvI6MuTCQ0OK9Iek6tflPA473cvKqVNA7yzrhbqvwUAqq9nZZNeF1U=
X-Gm-Gg: AYBFou0Q+3iHNdWq3LF4yGnm7HysDQFYeapdwOw0xI5uJOaoSBx4zvprFsu99btJxxG
	qpnRDFTi0B8JtvYV35E8KaQXXxDp6CxYBiPiOmNyWI/meEDAMoL1lnAM4MOgJbuBZ5z7alALWI4
	UoVtGfVXNf+oXQSlJ85PRM62yDsi0/PW9oA0Lzfvhrc8sBoaSYXVesnTEqBeicHMSoHRFPJZPP4
	JOU5tMx3Hbh6fC+zez4doOZHYY5xRDFa4eFyMfkHQ9VSVjWx3q7AjSqwKFXL3zs0zIi5BagYbl8
	XYlJirivoRZ4y9cz6ODsYQxoMMFIRT2BcLRXcTNA76etubeFvh3ha2cPQb2LklXug2dZjN+wFWK
	CVeUjTU4yT/RS5aulZiOGClPz4h1jHP14nDisjSY5NdZ3YbGIpsgB/oU+hITT04D2+Vm6qwpEXd
	jPYlUy8qjhly2fm70yRUXY+EwUcpSLvHbH7SyrPd+tCTPXZnJvd8w=
X-Received: by 2002:a05:620a:6287:b0:939:9e33:6a5e with SMTP id af79cd13be357-9399e33a8d0mr1067595485a.25.1788778274958;
        Mon, 07 Sep 2026 03:51:14 -0700 (PDT)
X-Received: by 2002:a05:620a:6287:b0:939:9e33:6a5e with SMTP id af79cd13be357-9399e33a8d0mr1067589985a.25.1788778274338;
        Mon, 07 Sep 2026 03:51:14 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cefsm410263775e9.5.2026.09.07.03.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 03:51:13 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v6 0/8] media: qcom: camss: CAMSS Offline Processing Engine
 support
Date: Mon, 07 Sep 2026 12:51:10 +0200
Message-Id: <20260907-camss-isp-ope-v6-0-6b915b9c5131@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6XnmoC/3XOQW7DIBAF0KtErDsWDGCcrHqPqguMhxrJNi4kV
 qLIdy9OF6ncdjPSX8z7/84ypUCZnQ53lmgJOcSphPrlwFxvpw+C0JXMkGPNFRpwdswZQp4hzgS
 q1UZ7Tw6pY+VnTuTD9eG9vZfsUxzh3CeyT0WiFKgbVBUKUQsNAoYYXDXHy2DD9Bpzrj4vdnBxH
 KtyNrcP+RzT7TFzkZv+bWne7BYtEji0reBao1Gl7be3DVvUEzGC7xFVEC2QG8ulOHbNP4j+gaD
 aI7ogZLjtlLfy6OgPZF3XL0dWHHSDAQAA
X-Change-ID: 20260427-camss-isp-ope-4b575ffec2ed
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfX8uINxcFZAqK2
 NwykGutkYYdnRlNhMl7J2iTrCuHgO/qDNkB3W7awair1nl4eXCgTt1e8ODG9frbI1nNpf6lPaEW
 fCswh40DuaVs6LAppwow/SHit00HZQ8061Nw0tJr9QchDBtHayqoZ3fKANxzLqdDNhmwCp1UvuL
 Z0bKvevtLhw7+pGjIrccpHXeF9k+0NzUalgI4tJk4HHn0cUbxg/pdPPqOHGuxPpz/vFKmg3IcfI
 pESzca1gNKIrGTKbUP6Sm4tH5GdRRTeY3/EuieUS40koxFp8pu8RyiKc2O7V3/xg1jmVEnsCIV/
 +mMYQmsT/+R06ajAlONZt+bCt3167vZX6qfEC2mrB+Kce6D/UP1YH9AhUP7ZcBUKSUtklubAaJu
 h9FVgKRGJrwTmKmWE/KQnlucyVmPKUCmrJTWwA1MePJrHwWG4He5QjMHmA4PfGzqTvVvMDGB9XB
 Av+XC7J22fXYQIq6Mnw==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a9e9723 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=N-jXyNRho6xf05gtKvgA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: qHbZ3kiVioKWoG4RKVNF8TlQx_SsAJrw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfXzakmxZdH1YvD
 nSVvHuWwwdNMXn3Sqku0uCZhb+9JxPrN1SfgoFZnS4Hu3e5dvYtcmJe+Di1pJFkvZa4i00wz7Ju
 ZnLJZ5LIJdNzMQYMXYTn9whFI9L+Hjo=
X-Proofpoint-GUID: qHbZ3kiVioKWoG4RKVNF8TlQx_SsAJrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070118

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

libcamera: Hans has been leading the userspace work and has submitted
OPE ISP support to libcamera. An implementation is available at:
https://github.com/jwrdegoede/libcamera/commits/camss_pipeline_v2.1

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
Changes in v6:
- uapi: Rename include/uapi/linux/camss-ope-config.h to
  qcom-camss-config.h and make the parameter enum/format generic.
  (Hans, Gjorgji, Bryan).
- videodev2.h: Drop "offline" from the V4L2_META_FMT_QCOM_ISP_PARAMS
  comment as the format is generic to CAMSS ISP, not offline-only
  (Gjorgji).
- ope: Add gamma correction (CLC_GLUT) support: new
  CAMSS_PARAMS_OPE_GAMMA block, camss_params_ope_gamma struct with
  per-channel 256-entry LUTs, and double-banked LUT upload/programming
  in the driver.
- ope: Remove stale .wait_prepare/.wait_finish vb2 ops, which were
  removed upstream and caused a build failure (Nihal).
- doc: Add Documentation/userspace-api/media/v4l/metafmt-qcom-isp.rst
  describing V4L2_META_FMT_QCOM_ISP_PARAMS, the OPE processing pipeline
  (block order and input/output formats) and the uAPI data types.
- Copy the params buffer into a kernel-only scratch buffer before
  validating/parsing it.
- Add locking around ope->ctx_list
- Fuard a NULL/out-of-range stripe pointer
- MAINTAINERS: Add the new metafmt-qcom-isp.rst doc and
  qcom-camss-config.h uapi header to the CAMSS entry.
- Link to v5: https://lore.kernel.org/r/20260724-camss-isp-ope-v5-0-e70ad4fa39ce@oss.qualcomm.com

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
Loic Poulain (6):
      media: qcom: camss: Add V4L2 meta format for CAMSS ISP parameters
      dt-bindings: media: qcom: Add CAMSS Offline Processing Engine (OPE)
      media: uapi: Add CAMSS ISP configuration definition
      media: Documentation: uapi: Add qcom-camss ISP params documentation
      media: qcom: camss: Add CAMSS Offline Processing Engine driver
      arm64: dts: qcom: agatti: Add OPE node

Nihal Kumar Gupta (2):
      dt-bindings: media: qcom,qcm2290-camss-ope: Document shikra compatible
      arm64: defconfig: Enable CAMSS OPE driver

 .../bindings/media/qcom,qcm2290-camss-ope.yaml     |  154 +
 .../userspace-api/media/v4l/meta-formats.rst       |    1 +
 .../userspace-api/media/v4l/metafmt-qcom-isp.rst   |  145 +
 MAINTAINERS                                        |    2 +
 arch/arm64/boot/dts/qcom/agatti.dtsi               |   79 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/media/platform/qcom/camss/Kconfig          |    2 +
 drivers/media/platform/qcom/camss/Makefile         |    2 +
 drivers/media/platform/qcom/camss/ope/Kconfig      |   16 +
 drivers/media/platform/qcom/camss/ope/Makefile     |    9 +
 drivers/media/platform/qcom/camss/ope/core.c       | 3581 ++++++++++++++++++++
 drivers/media/platform/qcom/camss/ope/params.c     |   78 +
 drivers/media/platform/qcom/camss/ope/params.h     |   95 +
 drivers/media/platform/qcom/camss/ope/pipeline.c   |  421 +++
 drivers/media/platform/qcom/camss/ope/pipeline.h   |  247 ++
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 include/uapi/linux/qcom-camss-config.h             |  212 ++
 include/uapi/linux/videodev2.h                     |    3 +
 18 files changed, 5049 insertions(+)
---
base-commit: 1e15e15a1225e9349fd87fb3f285ecafab73b3fe
change-id: 20260427-camss-isp-ope-4b575ffec2ed

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

