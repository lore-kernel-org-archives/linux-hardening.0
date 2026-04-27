Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55EE3B95F6
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294002; cv=none; b=UGJKfVD4tCiqHMRyEhINqS85NqIq19tmHT43pA4M0mp1WRImxW0IpoLoKSk55YBLgpCb0Edp7rXHJge+0q/TrdvisRDJSnWZhrN7NyCZVOMN76QA6eK1k0Kqrsye/ygPNlHu/wNZxZ+RYbQZWdDxxdslBi9MaHM7974dCpI02F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294002; c=relaxed/simple;
	bh=V0JA11tC547dVjIXETBYVhT0ZhmrOZQRJ965d5IsRe0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Tv5d/SVx9OVAtzLvWWDlJYiyqtPBFHseV0ORBNd7hoo14xosEvSZuKh6sqYMdeTKVYpLQbDXQG+e/aOvdSu8tQRCLw/t6mZb3woXX3Go2Jm+2O/EOXRq4zqamkIL3M7LmIVi91s15q5D0rytCFCKWYA6WYRGJTlMG5bi97SxEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FqneaEx7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T6BzQESD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FqneaEx7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T6BzQESD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TBd1665650
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m4HidIRDPD/ENeg1siawkt
	AX3FHiD1tFgd6YIKBm+ZI=; b=FqneaEx7FpYFgqOPMwzx93G7aQfGPdCil7J8jY
	lKuThXD/GdVUcGBBv6NjVR0gymCE9EfUQ1AkhFFNMgkeoj6y53sg53Q1J3quVxAO
	Az12chcitRfKXDcM1lkczMDVUUSoWrUQWeo2+DGnLPly9QIVV5gRGDfhS2t+iKtp
	DySAPotw18UFN9vxVZ5rUNrosJU6XaKIx7qfJMpW9nfJs7ruTm57lvymy5wBCFWx
	v2VT+0ESWovcfNw9XDH1ODJSm9vBlFfgU+pq6IWKnW4++rzyzMYC/cWEv5ubk6o0
	6jiUgsKBrcniRbLPt6Fql0LLI1P0M6UxPuW1iS35B9E5PWZw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n1d1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:46:36 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9570d05becaso11737431241.0
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777293996; x=1777898796; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4HidIRDPD/ENeg1siawktAX3FHiD1tFgd6YIKBm+ZI=;
        b=T6BzQESD+YiNk6/JJU7TB8YSWWfXXq/YmkcGbXalFWqwwhQMIfIvp4f6kKa/wCtIsq
         jrNvur2veuwJWUPDWuGtnhOrYK+27rdf2wiKgYFU14gUelDe5+PS92MqI4Ym9hcjJQTP
         5ZpdGgnirlqNoDjubzi+lNPcYP8wWXMYaHWIwKyEGr2/LxuvYKLyCe1XI/y1Y/EoJCtZ
         MqTIefSHk4YxXmxvhqzo7qMT4nhhYaGySIFMNLH6MMMhBR7IF5fuwSXC4SVHrSRkaCNH
         cOCn12GSpsybdNcONb1yQGLmOzIu4q0+FDxq4VoRiDIVAFnSB7laa9QIUhOhudWhJgII
         f/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293996; x=1777898796;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4HidIRDPD/ENeg1siawktAX3FHiD1tFgd6YIKBm+ZI=;
        b=PUgfGXo1Wj/U98qAo2dJYZ5/VUL1tdenQh4UOj2xL/ppAPi7ahXalp+STM8vRDLklJ
         hW2Ceddv7MYDUBss0RILvDzcgHU4zaW+MlOaMRsdW/LI1/qjGnvEEDWCpexu1PYwc8HT
         0U9meGbf5O4OWosj4Auh5WHG3ci61EskIIIk3S9i0LG/kC1rxWW6eIgytsP+9YWg9Fr7
         AO/y1W2Uy4Zju5s6Z/m/LqpW04PuIa0LU86sFuHqYHBkdEIjStsLpVS2V7NcKlCSoFlz
         +rZXv/IrRfSAz6k/nd02TsaB3k1zdT3Sw7sZNZlVHWopkl79ywz4Wl9WV5BQzDbOwcv1
         dFtw==
X-Forwarded-Encrypted: i=1; AFNElJ90SuGBnIct1R0hcQC4ezC/6YzHkS0RZgLRmFdHXOY2sq/Mr0mceCqTaLH3N1DMujMKBqFZ5lLXI3blpfV2Wak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJs0v5khBu6ZO0pADry5pEk/5otYq0QKN0e3SHM7lhkHscHZk
	lJ9+8m7EYmVulNEhOpgmGeD4rsu431jM2yhrNmy74IA49dlGLwTNgt4XQkl/2ZX5ZLqriYvfdu/
	/UkJ5H8Nc95NRUQ1av26enMqLZmmOozaFI18HWDFCCBl1aqA8JejolNDTEhnvjX5MFuhhx5E=
X-Gm-Gg: AeBDiesMIGzgTNDEuY04l73esoZDfWffdUzhR47THGPw5rjm2rmaga24TNLJAOwzbGa
	XW4x2o67YtajEkp0fhGGvDdkR+uFjEFhaNoe7MAkoK/X5+YPi1XqG0IiYBGxVjlTcePrkZpGibP
	6nZV+2feWrtpjaVTDtxfhkf5X0yG8s2CXby2vbgq/h1cIkIJiMyIHuRsLYLw8AVgewf01vojQ6J
	5bLRmO17CSYucqOTOHMucP0LcROBhds0ZaXvQNzUs14ndADUUqfL5uq7ISyY+zHTo3MqByj5cnJ
	XAlt4ejeNl4vbX6i1swqr2edmGNh6eyvkvPxBsYMwcp9ew/kk4Vc8iNdNDSnIEV+7BanNlkQlBZ
	/vOcOkX3dqdGsLpjAFxokcIUXfouzx+xtyf/+zHvTdxJ3lhnm+dMcyEb8Vb1sbqMnUO6hh+7xnf
	LJjHFFi8GwbfWM7vw9YLHaxlmcXRQ=
X-Received: by 2002:a05:6102:41a6:b0:60f:c9ba:b992 with SMTP id ada2fe7eead31-616f68d760dmr22047581137.16.1777293995654;
        Mon, 27 Apr 2026 05:46:35 -0700 (PDT)
X-Received: by 2002:a05:6102:41a6:b0:60f:c9ba:b992 with SMTP id ada2fe7eead31-616f68d760dmr22047540137.16.1777293995204;
        Mon, 27 Apr 2026 05:46:35 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd19sm1091496866b.37.2026.04.27.05.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:46:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v2 00/14] media: qcom: camss: CAMSS Offline Processing
 Engine support
Date: Mon, 27 Apr 2026 14:43:27 +0200
Message-Id: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO9Z72kC/0XMQQrCMBCF4atI1k5opk0rrryHuIjpxA40TcxYE
 UrvbnDj5sG3eP+mhAqTqPNhU4XeLJyWCjwelJ/c8iDgsVphg33T4QDeRRFgyZAyQXe3gw2BPNK
 o6icXCvz59a636lBShNdUyP0rLbYG7Qk7jcb0xoKBObHXOa2z4+WSRPRzdbNPMeo6at+/c2qcU
 qcAAAA=
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
        kieran.bingham@ideasonboard.com
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzMyBTYWx0ZWRfX4eYLHfoI/dst
 3dMrF1AdR1lpJWgJFZnKWytKyyeGTxnxbhPi62sZCErpKJWrjLpa4+9nA4Ywos6PKnJJAJOJ+4D
 lfouEcrAzvWCKCo9A3uWmbACU9W4Z704jGWKw+CckLHkXcYpv3vDmK7wzAamknkNPxl9de/AeXF
 aAyFXhdpw02KEoleiEgGLMEERfc4TdLVXySin5Wi5TXfrp/yzI82InrLcts5F33c5Tqs2fUlUwI
 e2wtO243/uUulQuZaeH3PJXclVZ8XFkzJLZMtl+39ZJxfCXVx9YlMUU8TNFHuEXeh4SDfPozWzK
 gxzoLx2YTBH2zHtE/y2Ifq18wYHgCkQP2GuFUVqBpfy9Mvp6wDqSLfMBXv5TFxgbkRGmCK+OaGH
 nSoeUqmqnC9FLQGmKUOBZQAVKN2XxusMMaJdQWTv/5q6baFN1G7NIn/QnV2/wLg4gznYrEaiXxS
 Co6uv+SyipGrwo66Tkw==
X-Proofpoint-GUID: sGTmkwxCZr1-1ehwQWZqrPg9QutBqibX
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef5aac cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=MYo6ArsnHSpCJc-KhkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: sGTmkwxCZr1-1ehwQWZqrPg9QutBqibX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270133

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
created on the first media‑pipeline open.
This keeps the implementation simple while ensuring the design is
ready for forthcoming multi‑context support at the V4L2/media
framework level.

Since the OPE is a child node of the CAMSS device, the CAMSS driver
is reworked to properly share and manage power‑related resources,
including power domains and common clocks.

Graph:
frame-input --+
              +--> proc --> frame-output
params -------+

Compliance: v4l2-compliance has been executed without any error on
the media and video devices.

Testing: A camss-isp-m2m tool is available at
https://github.com/loicpoulain/camss-isp-m2m-test
The tool can be used to exercise and stress‑test the OPE engine,
as well as to observe performance and latency behavior under
various operating conditions (resolution, format, buf count, etc).

./camss-isp-m2m -s 3840x2160  -n 5

  Name                            Device            Dir       Type
  --------------------------------------------------------------
  frame-input                     /dev/video10      output    video
  frame-output                    /dev/video11      capture   video
  params                          /dev/video12      output    meta

Test: 3840x2160 RGGB -> 3840x2160 NV12  [5 frames]
  Input   /dev/video10  3840x2160 RGGB  bpl=3840  size=8294400
  Output  /dev/video11  3840x2160 NV12  bpl=5760  size=12441600

Buffers:
  /dev/video10    buf[0]  offset=0x00000000  length=8294400   VA=0xffffbcb87000
  /dev/video11    buf[0]  offset=0x00000000  length=12441600  VA=0xffffbbfa9000

Streaming  5 frames...
  seq=0      buf: in=0 out=0   14.833 ms  (67.4 fps)
  seq=1      buf: in=0 out=0   14.874 ms  (67.2 fps)
  seq=2      buf: in=0 out=0   14.902 ms  (67.1 fps)
  seq=3      buf: in=0 out=0   14.960 ms  (66.8 fps)
  seq=4      buf: in=0 out=0   14.896 ms  (67.1 fps)

Changes in V2:
- Not an RFC anymore
- Move from v4l2-m2m to multi-devices design
- Support for parameters
- Helpers for pipeline, job scheduling, buf-queues
- OPE as a child node of CAMSS

---
Bryan O'Donoghue (1):
      media: qcom: camss: Add support to populate sub-devices

Loic Poulain (13):
      media: qcom: camss: Add PM clock support and integrate with runtime PM
      media: qcom: camss: Add PM clock definitions for QCM2290
      media: qcom: camss: Drop top_ahb/axi from QCM2290 subdevice clocks
      media: qcom: camss: Add camss-isp-bufq helper
      media: qcom: camss: Add camss-isp-sched helper
      media: qcom: camss: Add camss-isp-pipeline helper
      media: qcom-camss: Add image formats for Qualcomm CAMSS parameters buffer
      media: qcom: camss: Add camss-isp-params helper
      dt-bindings: media: qcom: Add CAMSS Offline Processing Engine (OPE)
      dt-bindings: media: qcom,qcm2290-camss: Add OPE ISP subnode
      media: uapi: Add CAMSS ISP configuration definition
      media: qcom: camss: Add CAMSS Offline Processing Engine driver
      arm64: dts: qcom: agatti: Add OPE node

 .../bindings/media/qcom,qcm2290-camss-ope.yaml     |  131 ++
 .../bindings/media/qcom,qcm2290-camss.yaml         |   13 +
 arch/arm64/boot/dts/qcom/agatti.dtsi               |   71 +
 drivers/media/platform/qcom/camss/Kconfig          |   32 +
 drivers/media/platform/qcom/camss/Makefile         |   11 +
 drivers/media/platform/qcom/camss/camss-isp-bufq.c |  101 +
 drivers/media/platform/qcom/camss/camss-isp-bufq.h |   85 +
 drivers/media/platform/qcom/camss/camss-isp-ope.c  | 2466 ++++++++++++++++++++
 .../media/platform/qcom/camss/camss-isp-params.c   |   67 +
 .../media/platform/qcom/camss/camss-isp-params.h   |   62 +
 .../media/platform/qcom/camss/camss-isp-pipeline.c |  361 +++
 .../media/platform/qcom/camss/camss-isp-pipeline.h |  228 ++
 .../media/platform/qcom/camss/camss-isp-sched.c    |  223 ++
 .../media/platform/qcom/camss/camss-isp-sched.h    |  174 ++
 drivers/media/platform/qcom/camss/camss.c          |   80 +-
 drivers/media/platform/qcom/camss/camss.h          |    6 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 include/uapi/linux/camss-config.h                  |  118 +
 include/uapi/linux/videodev2.h                     |    3 +
 19 files changed, 4217 insertions(+), 16 deletions(-)
---
base-commit: 143efe4d18f3e221bf6e9c6476296b3dd53de032
change-id: 20260427-camss-isp-ope-4b575ffec2ed

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

