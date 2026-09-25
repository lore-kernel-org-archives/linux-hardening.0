Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FC47986C
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327397; cv=none; b=pN5kP1tnKi+GU+jJCsPBtM5ZL+NUPKCYxUFz+o6HEIaM4n5Yn/LMwdqsoP7pxx0XIjaRLhzlWRPYyQ4aM0b5rg/JEOC42Mw0W/KAXBSV7LMwqnvZO3mRxqt1/tSmxeabjHwpOK3q7+/A7MykOorolNOBkwiLMTaMayc1ZZgGiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327397; c=relaxed/simple;
	bh=Pca3ctKOhmrPOCfYNEAVj+YOFJrZvzyKHx4YiY7pUUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AzZuA7gzq3E3wjSQzTHHJ5ks7F2QI2p/Cw5zO8XWjssGppZb1jiaq1vlGR6GO3F6TMXc84r8UngnuaiwHdRhJLudQWHDt8JZibr7dIsHfvLc10VqZaM2Mb9T/O/xr42tySkXwZFMS1khg1Hgbrqnhb578pWq5xf+OOpaVJgvDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NzOzQXUW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hMN9nWrL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NzOzQXUW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMN9nWrL"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YqR91056150
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xpQQe6SlNL/jlryCqBsqil
	7MD/XxdIsuooJcbPBbar8=; b=NzOzQXUWLabbxEm87oxHohEYxmeP5hak9CkC55
	vs81ICvSvOjwANmgUJ9/ROFl/C2VuEOOs5jhUiuw2M/0yoVssHacQex1c5h9fI7R
	2Mjxazmto0mkFJ+C2jAALYzGRupkUFVNLGLNggR5Ya7RzT2nF6TA5FIvPe/xXq01
	yTtY+EoNLPgJUhaiI8hy5fi/42x1oNYhnAq6q9FnxZoxbUWeCkiY0aS3Pzdug3hh
	7Tx5Ieumz3bn9M4+lto9JuL83ivm9CaFOxoBbeOdqzDGs0dcotevqdYGvIOQlhy/
	QmyInwSpkIPQP+essBIczD6NP0ry2mn+KCzlqxz1lIUJVKuw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce79ryk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 09:09:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a01d1d1b6so125710085a.1
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790327393; x=1790932193; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xpQQe6SlNL/jlryCqBsqil7MD/XxdIsuooJcbPBbar8=;
        b=hMN9nWrLLMefW8Ki8EJbS3t9oc6eZfkZPBsrFUf4/vhZH4y1VT5lhU8W+ejsCkxeNc
         sR5uJef9HJyNt2vTaKZZxQSLBXLgaYECi3xRm+xuPhe0Yb2suDSxisVbflJGDPJPyvfw
         +nWQMl9WFBpO41T9DuSndGblDb6yG57v9wNDBIAoFpm23ddP5z8q6cz7SUxVN1J0Bo9j
         4v67YBE7Dg2P5KlnTQCQK5tI43eMIR+GWKUHzUYS3nTk4+GLSkRN223DlOkX5roOdGeE
         W4CDgLf0knHDsTxiUC5xp7SdLUHehlqL9Pu7IVupOn8z9zGPNUH5S17TyKmrbvPIgpKs
         8KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790327393; x=1790932193;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xpQQe6SlNL/jlryCqBsqil7MD/XxdIsuooJcbPBbar8=;
        b=PSE1q5cDn+Z+VsXhk3BCIg9wWiKhCYcevhVMxv839w/lIOiSVNNkJzJEYYig5JyfOI
         OpxZzE+IMWNRVKuBfOQ4aLbfSiDIlBXGrLoT+L+vg23DQ60Wbkk9g0wioZ5MXL+48C43
         G2FUi3QQmZtgoTbkZlSLv3gwLX/LlTYC7KiAQgkvM4CMRQSIK8f1y71meHKQ1e4XZobS
         CaIZS2HcjYypntvx5Uv5IEK9cS3zDLS1qmoxplhmMeIv34TRwK9ROXWvr/fZ/Hkb/JKx
         3Chl+UhFo9+a1OFhTE0I5u2vPs6dPa2JQ32Tn3SzboYQ/8klqrzPYmk5eYuM0MlHHdJ9
         la9w==
X-Forwarded-Encrypted: i=1; AKwUvBwGSzlJ9QzX1T5RGMsbKaOdBQyPhKGmkiQfJf+zPjUt96G4m52vFGBXLF1z7TGK/93qMcxJlAuR+SZrgpKAuA8=@vger.kernel.org
X-Gm-Message-State: AFuF++m7+W7PseqAY0T4vFBV/WCLvyx9nfTc5YGuMXAPSeWGHBqNNVxR
	Zs3DNWU2/Uc2H46ILWp//3mKdm64PcizwTa0q78p/yCItF+SnMO8UI49XxiEot521Otutb9Rddm
	HDaoTWuheKoeq/hVV7ld1vrU76tiRl2sGMSNmBVFcJgo1nNXVMYAz0JKfMFqBNcWn4hrCLJo=
X-Gm-Gg: AYBFou3stZq2gpSenliZma3LPyIMoBna0DILNBranmqefNld25T7lbloxCb0oawhaK1
	CTNr8B4xQ7mkRqdfVRgQBw5aq17IE3jaas/TzyS6xzTHaSuoNwOG8aevl4vUn8iQ/xjNjI0+5PR
	ybyKM9sMwa3UeZvrErvbwaIbPbw8PwPBbvkM+vUwrBFDwvU46+9BRAawqocFM9bqe853A4zxllq
	Xofzp3n/C6ZBouNyuptFN5HQGpTOIP7TwODPB7oMut+u/ib+YKxwZiSUOkTqlA1ZxBnJf3qorXE
	WRK7SlXbGjkPPI70muZLZjRxTY2wlDyAG/Ais5zwBVrTZip0yb+nVozd2aHk6i1VAQdj++YN0iA
	CdWk75IbaOPqXOU5YYQAeOGdB//OkLCJSIPguBtOvwLCdkw5nmVIX2r21eSZaaEXeyHYGlH8LX+
	2ytm1xo7/HPldch5kBEfmXpGcGlqumG0l3OyJkhDf/PlRqEa684VQ=
X-Received: by 2002:a05:620a:2688:b0:93c:73a:3996 with SMTP id af79cd13be357-93c43d421e0mr323812385a.57.1790327392741;
        Fri, 25 Sep 2026 02:09:52 -0700 (PDT)
X-Received: by 2002:a05:620a:2688:b0:93c:73a:3996 with SMTP id af79cd13be357-93c43d421e0mr323806785a.57.1790327392078;
        Fri, 25 Sep 2026 02:09:52 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:5c1f:3897:a4a1:99e1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm5269890f8f.9.2026.09.25.02.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:09:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v10 0/9] media: qcom: camss: CAMSS Offline Processing
 Engine support
Date: Fri, 25 Sep 2026 11:09:47 +0200
Message-Id: <20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFs6tmoC/3XRS2rDMBAG4KsEryuj0cOSsuo9Shd6uRbEkWslp
 iXk7p2kCxu13ghGMN/8zNyaEucUS3M83Jo5LqmkfMYC6Muh8YM9f0SSAn40jLKOCqaIt2MpJJW
 J5CkS4aSSfR89i6HBnmmOffp6gm/vWPdzHsllmKNdFc44MKmZaBlAB5IAOeXk2ylfTzadX3Mp7
 efVnnwexxafhzukcsnz9zPnwh/6ryWprhItnFDiHFApmRI47a/3CLaIFVFAa0QgIoFRZSkHE/Q
 OIjcIEzUiEYmK2iB6y42PO0i3IobWC146RDpnQDrjJXDYQdQGwZVWiEJEKQc8oBB42EH0BmFQI
 xqREMDrznKvLd1BzBbhNWIQQUDJ4EE7/d917vf7D9wul6CYAgAA
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
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: mm7pK2O18pglBGTsRMOo2GZeHLcHWIDr
X-Proofpoint-ORIG-GUID: mm7pK2O18pglBGTsRMOo2GZeHLcHWIDr
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab63a62 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=BpD3SHujxDQuqOs0VCIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX+bnb41dnR7x+
 q2cQfM5cmuD1Fmx/W8w42nOrETyhm/7tA13PUYuZYZvD/DwTGDcjrAsmVBthyvb0LMr/GU3RhbR
 I1xciaXTKAAmtURIwVKN+8zSC+DcLZJnnezbf6Fp2JThby8eSMJr9rD/aYIug87prtffuijmpoQ
 KmZv4yhS48lh/MuV6xUj4Wz/61/HjZO3LdB6SkldmKcOrx0KEdsgjpuZ6SczlIcIazll8WqKGK/
 FvPgpTE+Vslcxy661pMD8myGR6OAyzhC8FAulYDFJRq18fS69/8PlLtKTlcB4ivpSFjpzdnqCCc
 8ZCg+U71FYBy3QvD9Yn0qqwXCTGQgHg8/QgyOa8gWDLiAvbZ4C+WxQz6LwWGbGFaw0ZJQgVqLvU
 ZOpH0pDvcswtaEvd9Q5Y/dpHOOfTU1MZLnSMjNZsUkeizNvIlGYcWQWcRH6u+Ia4MO/Cyujli4E
 2zeLnELDSWeBAPCT2lA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX2vbIPMNnWL+D
 i4Tl1gMq2qEtS6LEcKALwPRfd6PS6IMqZIFDY1cZKVbWUkraczqAkGsL57iwIIUgv9Xex3+llls
 DyH2k8rZQPPhx/8YjDY4sLH/Vcd4yR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250036

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
Changes in v10:
- ope: Split the input line evenly across stripes instead of filling
  each one to the maximum. (sashiko)
- ope: Reject VIDIOC_SUBDEV_S_FMT and VIDIOC_SUBDEV_S_SELECTION on the
  active state with -EBUSY while a context is streaming. (sashiko)
- ope: Validate the geometry when generating the stripes.
- ope: Register the media device only once every entity and link
  exists, so userspace cannot observe a partial graph. (sashiko)
- ope: Add the missing MEDIA_CONTROLLER dependency. (sashiko)
- Link to v9: https://lore.kernel.org/r/20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com

Changes in v9:
- ope: Release the vb2 queues owned by a file handle on close, so
  buffers are not leaked when userspace exits without STREAMOFF.
- ope: Clear vq->owner and the queue private data on teardown.
- ope: Align the crop rectangle to the input packing unit (at least a
  Bayer pair) and the compose rectangle to the output chroma
  subsampling, so 10-bit MIPI unpacking and the UV plane stay valid.
- ope: Factor the duplicated format lookups into ope_fmt_from_mbus_code().
- Documentation: Fix the userspace example.
- Link to v8: https://lore.kernel.org/r/20260921-camss-isp-ope-v8-0-dd1c86a3c8a0@oss.qualcomm.com

Changes in v8:
- uapi: Drop the OPE-specific infix from the shared parameter. (Bryan)
- uapi: Describe the gamma LUT behaviour as a property of the block
  rather than of Agatti OPE. (Bryan)
- Documentation: Fix the description of the block enable semantics.
- Documentation: Fix the userspace example. Zero each block before
  filling it in rather than OR-ing flags into uninitialised memory.
- dt-bindings: restore the blank line before the reg property
- ope: Keep the OPE interrupt disabled until probe is complete (IRQF_NO_AUTOEN)
- ope: Rework the scheduler state, drop prev_ctx and ctx->first_start
- defconfig: Reword commit message to explicitely mention Qualcomm
- Link to v7: https://lore.kernel.org/r/20260915-camss-isp-ope-v7-0-77b13d131d3d@oss.qualcomm.com

Changes in v7:
- Tie the driver context lifetime to the v4l2_device refcount
- Free the MC pipeline from the v4l2_device release callback
- Reorder unbind teardown
- Refuse to start jobs or start streaming once the device is disconnected
- Fix a permanent scheduler stall
- Complete the job when a cancel reset times out
- Make the reset-done interrupt terminal (no ctx/job rescheduling)
- Drain the ready queues with the scheduler held off
- Invalidate the gamma LUT cache when a context is destroyed
- Factor the reset-and-wait sequence into ope_hw_reset_sync()
- OPE node enabled by default, this is a pure SoC level feature
- Link to v6: https://lore.kernel.org/r/20260907-camss-isp-ope-v6-0-6b915b9c5131@oss.qualcomm.com

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

Nihal Kumar Gupta (3):
      dt-bindings: media: qcom,qcm2290-camss-ope: Document shikra compatible
      arm64: dts: qcom: shikra: Add OPE node
      arm64: defconfig: Enable Qualcomm CAMSS OPE driver

 .../bindings/media/qcom,qcm2290-camss-ope.yaml     |  155 +
 .../userspace-api/media/v4l/meta-formats.rst       |    1 +
 .../userspace-api/media/v4l/metafmt-qcom-isp.rst   |  147 +
 MAINTAINERS                                        |    2 +
 arch/arm64/boot/dts/qcom/agatti.dtsi               |   77 +
 arch/arm64/boot/dts/qcom/shikra.dtsi               |   77 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/media/platform/qcom/camss/Kconfig          |    2 +
 drivers/media/platform/qcom/camss/Makefile         |    2 +
 drivers/media/platform/qcom/camss/ope/Kconfig      |   17 +
 drivers/media/platform/qcom/camss/ope/Makefile     |    9 +
 drivers/media/platform/qcom/camss/ope/core.c       | 3843 ++++++++++++++++++++
 drivers/media/platform/qcom/camss/ope/params.c     |   78 +
 drivers/media/platform/qcom/camss/ope/params.h     |   95 +
 drivers/media/platform/qcom/camss/ope/pipeline.c   |  405 +++
 drivers/media/platform/qcom/camss/ope/pipeline.h   |  239 ++
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 include/uapi/linux/qcom-camss-config.h             |  212 ++
 include/uapi/linux/videodev2.h                     |    3 +
 19 files changed, 5366 insertions(+)
---
base-commit: 1e15e15a1225e9349fd87fb3f285ecafab73b3fe
change-id: 20260427-camss-isp-ope-4b575ffec2ed

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

