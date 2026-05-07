Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83328372B5A
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194209; cv=none; b=U798u3uAohGln7Hxi5FfTfCEXiuQBwEAsSMFirxndfPcMFCDvNTcqJo8Ya514qj1qVpFObmvqx0Bd7oS4MSztRiR59oLkuHhd44LAtEWYimCsa2+2bMx10vb3ycE0gzEPRSOgI+mZYfcMqiYKvPSCq5siMX/5mu4ligYKh02MN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194209; c=relaxed/simple;
	bh=5GDnKhmBM1yypsTlKGw6vvvavdKBYfnkdInWhp+vMLE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dnNxpM1x4bBbxRdFDIhHhLRyxkwcMwTVJ+h7eqF43j6wizidFdP3etWgeHKInHo1G6STyKacVO5ubOd3SvXdfjPpWHcrEDPgBWFjz50sshUFPJ3tFYzxKDd8XCyuQ9NIz7IQWDXRueNAgyEjmngbHxWW5peijPa9j6grIgJiSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nJpfz3k3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJXJTmfb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nJpfz3k3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJXJTmfb"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647IBlCc2771502
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PkSeNiGbgA7F4Yd46b6MKb
	ZkR6t+RRbEp49Tj4V3k2k=; b=nJpfz3k3mr8yc6QkzDSrJ92J8inLaEtOezoerF
	1YOvTJNnzJsD4c6IDiAbJkK+QUa2iE10ZuBTG/kJ8yRApG61t66RL1fKusqpAZpZ
	nB5NWDf4XIP8WAujf0QrJEeb/sG/fU9lF59daWUa0hYW2rrpEMRoJ9BzIFJzFb4X
	QQHd3pKjhJWX5yvlH6EIUORB5q2Ao+++87ogW7ULDfrIN9ssbl3tS5PSQ7h1ZB59
	t7dO0CVcFwZ1zwSd8nM8TY8kseEfjwJnRyqdCxndmU2LqVUPRwA6O3OcSHeirCdk
	3yr6iYJX44T0sY6/pv8yUc2+xm7hIVpalguiM00/1K7OL8Xg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0yt5gukg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:05 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-956804755faso1977813241.0
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194205; x=1778799005; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PkSeNiGbgA7F4Yd46b6MKbZkR6t+RRbEp49Tj4V3k2k=;
        b=VJXJTmfbMbu2BgO7nr02MNHKROAI12Tca3rGNcKmz/1Vc9jJfr/4ByOzBMEvocwd+N
         vd7g8ozYOQQeYQM7AuU5hqaGHZ0vQkbf9SBuCU51XKNwlsU5+hr9fV5EQwLp8Ez42p4A
         T1cG5x8z92EkMvtxwQPsuOPlqGjVBwFLJQr3bibqtaz4PDWFLsb4NfMnweZfdGRlkU2Y
         qw8vk+NXDanlQtVEcT6+ci16lMWpzV09QfECImko7wBNQ7u+e8dMBqAqnejTEgEEpn2v
         Ezf2qe3Qu2wyXhZGr5Xj+SM403TL67x45uZjsnrEcJmpluthVo+iUef35VRDMS9HBYnO
         9t3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194205; x=1778799005;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkSeNiGbgA7F4Yd46b6MKbZkR6t+RRbEp49Tj4V3k2k=;
        b=DTWhPnae3IBV1Y9512+OHqKsxzD7Feid32DEBJr6gZdKr+JtVEujhFs2zq+mviSGum
         xQ+cO1S+NmgGcOx8bSfOi7KThHkkbJ0gsNATwnyz3YwXdrpHXsKJi2/tfU0kI8LZ5wS0
         ATpxFBGfn7i8FFLlyZfSz3Obk+nDGp+agaEz/jHu3MXAqDF+DXIhFEdWwJk9bdY0SSC7
         M+VJPP0+N2awU6CNPsq+wu4iHCZTFz5sg7pcZ3oQVT00pYawPVqyN2Zm490flm4U8D6W
         w7Od96Kcm33RXSCxOrlD40PzD8EKC4QVw4J596Uj1YgZWcw8BgGkDjVusBYjzkkSZoxK
         ShnA==
X-Forwarded-Encrypted: i=1; AFNElJ+EN5uU1O9C5TeuNDkNC/nPxCMYL8puakOiH2zEOX4ZNQYiIX8xEC6ECecQ5Geco5gCdDAX0g2YVu9yBej0agE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO6FU7XtK395NmLWHm4XGlCS2FrjbEjQh+h+WikVr+fpEGKn66
	OMjboGbLReG+V7jQfWNQapO9Y+BpD4eVCY1AOH3KsJv8annJ+CaPalXHes5fgvTr+DxY+JKYFYN
	y0CyDCdO4kl81trBR7B72QEG/3agkC4g1NVRZ5See4QyF8IXGSM6/lLszfu0ZiFEQAQ1ud5Y=
X-Gm-Gg: AeBDievARmiX3YNKRksg2c5quzeFP0wgDsWF47RcHSYRzl3V8AyUOEmGJL1V0KCAt7W
	bLzxiEQ50djNnb/py0HjpbjFtklGJn2NyWVsAfnMpxEpZChouwNWPopqNAUpOdo7uoVem2agmuA
	E+FwBc/cexODLWpRd8ZPOntT5RujLCIzrWFxW4dyMntht1xVkSMziXrivh6wgwp/sByb22WhARw
	bN38VLUQJdc6rUN2lbgZKEhf/XV45XuDspVn5MU0vZv789FlBX8Jfj9pB5Q62+rFny73wmVW0sV
	7KOKc0hCZX2Ej+4x8PbysuVp0l/JToDsKez/iX0REgpV5F51qVN0qb40JRf3ABrQ5/HSrj3Jgn1
	ByswM7ZVD/90XdKdS9k5XFoaFfI9SXhI1B3F6oAUDoudSEc9qQETd6XWKapZApDqOwOdCOx+VMa
	s3zEjLnQiYOUt1qpYM
X-Received: by 2002:a05:6102:5813:b0:62f:3686:4b86 with SMTP id ada2fe7eead31-63115d846f7mr2051147137.1.1778194204679;
        Thu, 07 May 2026 15:50:04 -0700 (PDT)
X-Received: by 2002:a05:6102:5813:b0:62f:3686:4b86 with SMTP id ada2fe7eead31-63115d846f7mr2051119137.1.1778194204230;
        Thu, 07 May 2026 15:50:04 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v3 00/15] media: qcom: camss: CAMSS Offline Processing
 Engine support
Date: Fri, 08 May 2026 00:49:15 +0200
Message-Id: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwW/WkC/3XOMQ7CMAyF4augzLhK3IQCE/dADCE41FLblBgqE
 OrdCSwMiMXSP/jTeyqhzCRqu3iqTBMLp6FEvVyo0PrhTMCn0go1rrTFBoLvRYBlhDQS2KNrXIw
 UkE6q/IyZIt8/3v5QOubUw7XN5L9KjbVBt0ZboTEr48BAlzhUY7p1noddEqkuN9+F1PdVOW+3Z
 bmm/PjMnPCt/1s0IWiIttbU2LXTevPrHeZ5fgG2JIlV+QAAAA==
X-Change-ID: 20260427-camss-isp-ope-4b575ffec2ed
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com, johannes.goede@oss.qualcomm.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Dc0nbPtW c=1 sm=1 tr=0 ts=69fd171d cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oJE8aRnLwfUkw7FiLPAA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: UxtTgKigTG2is-SItEUByM4BKxQSWeD-
X-Proofpoint-ORIG-GUID: UxtTgKigTG2is-SItEUByM4BKxQSWeD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMSBTYWx0ZWRfX55k33ECqezyK
 K7bZnf5jHEDHuzzlyXv8OLOxAsrxbm3z1i+B0FFn4iAhz0d9NzoCGA+RwAZ0Je460O0ZkYI9UXH
 Rd6dFqRlevnlX6ovVjhTeASwAv8B+rz/Ejx25jH9vUbzs2XjqU9nc6wKpjwraSZEtVgX2Lccb2J
 H9LE7zecVW9sqXQE75R5AhPbqnxFJi0kZEoYQn0EfmemXF+dnTJRIly0qoehCx9trCDEYywl/ly
 LY5AEhOlQ+KhR5etjbUh2zEj6Nkv8PPwxHx7L98UXtsOAsLRi/6VAl1r3z4+InDz55XeqfwFdTa
 PQi2zsxYxzy5QwSaTYN6WUCBZGQfp14hXjimKtCo/fpYL7EIWGNufZCUrgWrawycjpU/FJTzKjI
 usuYvrqQ6U5AQ5X0DnM83BWCSd5Z5iNC0erctVtK3afRDhnKrtIWNdDH/FjSDgtHeXRMnkp/FEZ
 y8xpIYSoTEmLBeKGsuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070231

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

In order to enable reuse across future CAMSS ISP implementations,
a new camss-isp-common module is introduced, providing common
helpers for:
- buffer queue management
- job scheduling
- pipeline construction
- parameter parsing

While currently tailored for CAMSS ISP drivers, these helpers are
designed in a way that allows further generalization and extension
into the V4L2 ISP framework.

The driver is designed to support multiple processing contexts. At
present, however, only a single context is instantiated, which is
created on the first media-pipeline open. This keeps the implementation
simple while ensuring the design is ready for forthcoming multi-context
support at the V4L2/media framework level.

Since the OPE is a child node of the CAMSS device, the CAMSS driver
is reworked to properly share and manage power-related resources,
including power domains and common clocks.

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

---
Bryan O'Donoghue (1):
      media: qcom: camss: Populate CAMSS child devices via DT

Loic Poulain (14):
      media: qcom: camss: Add PM clock support and integrate with runtime PM
      media: qcom: camss: Add PM clock definitions for QCM2290
      media: qcom: camss: Drop top_ahb/axi from QCM2290 subdevice clocks
      media: qcom: camss: Add camss-isp-bufq helper
      media: qcom: camss: Add camss-isp-sched helper
      media: qcom: camss: Add camss-isp-pipeline helper
      media: qcom: camss: Add V4L2 meta format for CAMSS ISP parameters
      media: qcom: camss: Add camss-isp-params helper
      dt-bindings: media: qcom: Add CAMSS Offline Processing Engine (OPE)
      dt-bindings: media: qcom,qcm2290-camss: Add OPE ISP subnode
      media: uapi: Add CAMSS ISP configuration definition
      media: qcom: camss: Add CAMSS Offline Processing Engine driver
      arm64: dts: qcom: agatti: Assigned clock rate for CAMSS AXI
      arm64: dts: qcom: agatti: Add OPE node

 .../bindings/media/qcom,qcm2290-camss-ope.yaml     |  131 +
 .../bindings/media/qcom,qcm2290-camss.yaml         |   13 +
 arch/arm64/boot/dts/qcom/agatti.dtsi               |   73 +
 drivers/media/platform/qcom/camss/Kconfig          |   32 +
 drivers/media/platform/qcom/camss/Makefile         |   11 +
 drivers/media/platform/qcom/camss/camss-isp-bufq.c |  101 +
 drivers/media/platform/qcom/camss/camss-isp-bufq.h |  122 +
 drivers/media/platform/qcom/camss/camss-isp-ope.c  | 3025 ++++++++++++++++++++
 .../media/platform/qcom/camss/camss-isp-params.c   |   67 +
 .../media/platform/qcom/camss/camss-isp-params.h   |   62 +
 .../media/platform/qcom/camss/camss-isp-pipeline.c |  372 +++
 .../media/platform/qcom/camss/camss-isp-pipeline.h |  230 ++
 .../media/platform/qcom/camss/camss-isp-sched.c    |  223 ++
 .../media/platform/qcom/camss/camss-isp-sched.h    |  174 ++
 drivers/media/platform/qcom/camss/camss.c          |   67 +-
 drivers/media/platform/qcom/camss/camss.h          |    1 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 include/uapi/linux/camss-config.h                  |  115 +
 include/uapi/linux/videodev2.h                     |    3 +
 19 files changed, 4807 insertions(+), 16 deletions(-)
---
base-commit: cb49dcae0241fb3ea59f42ce2edd69367784b51c
change-id: 20260427-camss-isp-ope-4b575ffec2ed

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

