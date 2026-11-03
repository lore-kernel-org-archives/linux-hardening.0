Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736354;
	b=o7DbJ+WaxWUS2hOyk4ZIXDmlZhRca/ejLxnFTAN3lrjMuz84jSvrUBkNh3omJQEdtBh0
	 aZmFoFnlB0HKxz0/RltCARc17P/vsXVQ4WkIwi7DBk3Sn5jnL/nHjUlXMCszoFTdf4b+n
	 C0eI5ZBfaU3BLs32bUU1qZ3VbHsTx/0oTeT7BkYQt3tc0kkU/CSFkTqGBU5zwkt9H+dgL
	 ka/cxlf7yK3IFHctZOrTUDFsiSg4rd1CCZi9KKQ0JvSNOBPjhlyZMncOiwAwIKRcpIsCe
	 oSDooz/uUtINOsiOVvEf9qOPk3HhupRT3+wcYl4seRVNRjPf4JwdDX7N0I198EDiNvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736354;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Zg2kWr3Jb/8GmzXidZJwFfDOljBgfLKb/2j2+Pc7JFk=;
	b=Usc8doTV6h1G/pU3IDuvKbIH7B4rM93cmYPqVogGjw2XdkyZ0U/5Rda06pqw4Qqbxk/n
	 0hdgbgt6iisDfmgXL8fN+INopmbF1ItM26OAbUQAtJ52xVDxTlS2u7nZnJd1pOXs6Bjjf
	 OfRJF7AkxrR4WFmYHqcCz7x/48wcjpJ33XS6sbNh5lVsfbfH7lVtnIyRi/LID0WvOnvXk
	 t/JIFYAlTzkud8a4/hg4ydixMCjhRwLV9Gfzo1/eSNd+WunHtxji/4X1D0SwKl2xz/hfk
	 D8kOq0clGmx3LzoYOkj8repnJd4418b21XPiZZvevgmc1lIqjwmqqlBXpQJeiswtsUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jcfK9RV8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IzdXDzmt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2350E606A32D
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 20:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2350E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jcfK9RV8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IzdXDzmt
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IZ7n73666362
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 20:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zg2kWr3Jb/8GmzXidZJwFf
	DOljBgfLKb/2j2+Pc7JFk=; b=jcfK9RV8fjKXQcNrDrhDqnCTPaYadWP/BtM1uD
	zCwv6oLtGLBhz3FbHxt9Kis/nu8h2+AdIz/uPkSHXqsuWBpZa/QtYqEjJDRkHmXL
	+UA8maH3CXPYKJ3aoAg1+e8Mz4utgEqBq1DSAVL4+hXy95rTMTU+JfnJiMrR1neq
	aV7Ah8AuehW78QHc8T8IPsFgactGgLML+hoKqCfX2gYA4wOXAtkDMerv2CHTLq1C
	QT+EM0+65ztiaYNNNUEiO7we7WErQRb47AP/DUyPK9uowcCzdJ0ge4+7LLqYk3JY
	c0oyvIjEDYf+HaOXFPwOWPqk/N2AMlsllH8ihvIGiUcS+0Tw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqjubh26k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 20:05:51 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7cc0a64ad59so732586137.2
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 12:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793736351; x=1794341151; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zg2kWr3Jb/8GmzXidZJwFfDOljBgfLKb/2j2+Pc7JFk=;
        b=IzdXDzmtnmKut7JZ6ph4C0oN1U5oDjiZb3xu0PE4S0S/s8zd1ZYLaKqgVzi9zZY2AP
         xiqn13azVeaxwfYGdz/oLcKkiStu9aaarje2bMZg/o+ROmPmcpKCBk8dim/7nVWnGCis
         Rh4svXPqhElj07uSPEDYiNqp/pLW+iplOmJKegBOLqZzBu/j/uSBJPnTXUiMmfG0a52T
         7MWzsP0LLfD8P7YhxLM12kOpbX6qP0g/CTxqyfxoBZ2smoOxGG2PNtEULlnClYliIy94
         pORVKWy9TnPXpGZ2zQwpVlV0ddpFAGU0O89hXQXblAJ+Ymw6b3vm5FT3TrEtoTT7GwU2
         C03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736351; x=1794341151;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zg2kWr3Jb/8GmzXidZJwFfDOljBgfLKb/2j2+Pc7JFk=;
        b=2NEg3azefY2pMph+W+MlnDj4XjLBrqQNMXqJj4whTjP4OEO7GaE2FI1yvvEzlyrr0x
         5qQMjKUMOtF9+z2vF+XZMTUm1iV8htorgpUvEw46EoFCLfyni5bvxu2dsfLAqbBDI86A
         8qZujnCKQNLETqzyOP18LhQNb86EJmMHRyJEZv7/kSWXzLPnq4vSTD0LXERNzyZTO0SG
         jjfsOFZh903WtwTY3TZBO+ZTMQ/QM4/HD3LUPKI3OnjkgyS7nKYmLP/7FAd1GFV/z6zK
         mn8glQ1uJrEV4+nZYK7MtWgNJzT6jzfwsWd8Y1bHuNiJEetbWoZTT7ojIAU+Zh4XjV/j
         XWrA==
X-Forwarded-Encrypted: i=1; AKwUvBwWzlmgQLo8UsOoPfFrKlI3RelYN3ymsmqxiTWgB4naJxXAwXDRCWgmktgHMcUrrc6TvMUe8rE2X8XB8Atm5uM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/+OK/u5NrV7BgqAX/Mg63StiQZMcy43E5bSrIrqNq9TIjFfFx
	HiF+6JOf2lxqXHChklD/aq5hO27u4UeckKBs9TNk2P0ioWADpuVQSN5tsdc+u6jbra/GdyEWtQu
	piXd9c2iD8cI4+QL9JeqGXFc/IXpeqk0XjylLTbAawFNlL9PdEd578KZUT5rJtFhgAdKnI3Y=
X-Gm-Gg: AYBFou21ZmTIhO9Ivu9EvViD+aeTAFFAICd9F1OdnIh/Bc+sHBBqR5lfey4wyp4Mvja
	6smdqWOU8dvsT+0ruP15xSPwZ4aM1SAHXL2e2pxZo3p5jaTsjgfjmbBhhTW3pCNr9rxsVIkDb4C
	WmfEImtJYVnHn4ivvuks9Rw87LsscJYfwK+IoIu71O32re0mvoD22e++ZgCOnrI2+tsJE1BAY2e
	roaXfpXIbkuzafZTr2yy+BItyB5q5fAFnAlYHekSe+TcxU4Lo0svd530XnQXPj1XvxCWzsyRH13
	x30y9V2DnHmV5doZ6AvIVWNz1aavSJmHCE3/vDeq/ebQKPnhORAV3ZrjzlFHWUwNMXatcmXVGPv
	0tIhZrxfIARplc5xaflJM8d5cn5kTlm6aI0f4lfHvIElpMIbLgdZ7gjVARABguxZM7H5Bk4L176
	QP1ZcujODeC99orAzMgZFsisEUyjTNY8d62vInIjy2J7LrXrIcO1h7FbP8oVwEdj1zE3NA9yqBc
	3Vig3MCUX4m5RYhPvWTT6GqTeHO
X-Received: by 2002:a05:6102:41a7:b0:7cc:2712:cafb with SMTP id ada2fe7eead31-7d0726a8a89mr4966177137.15.1793736350860;
        Tue, 03 Nov 2026 12:05:50 -0800 (PST)
X-Received: by 2002:a05:6102:41a7:b0:7cc:2712:cafb with SMTP id ada2fe7eead31-7d0726a8a89mr4966151137.15.1793736350092;
        Tue, 03 Nov 2026 12:05:50 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm358875f8f.44.2026.11.03.12.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:05:48 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v13 0/9] media: qcom: camss: CAMSS Offline Processing
 Engine support
Date: Tue, 03 Nov 2026 21:05:44 +0100
Message-Id: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAJg+6moC/3XRwW7DIAwG4FeZch6RbSDATnuPaQcCZEVqmyy00
 aaq7z63k5YoXS5IRuLjt32pShpzKtXL06Ua05RL7o9coHx+qsLOHz+SyJEvKgJqQJERwR9KEbk
 Moh+SUK02uutSoBQrfjOMqctfd/Dtnetu7A/itBuTnxVJEklbUjUhNqgFin2fQz30573Px9e+l
 Prz7PehPxxqPm7uLpdTP37fc07ypv9aGuwq0SQFiLZF0JqM4t8evVuwSc2IQVgjihGNBMaDRBf
 tBqIXCKk1ohlJBnxUnZcupA2kmREH6wFPDSNN61C3LmiUuIGYBcIjXSGGEWNalJGFKOMGYhcI4
 RqxjMSIwTZeButhA3FLRK4RxwgDRseAtrVb20FYKg/98MJAUEOkEEGq0G4x+McgPIZBZAYCOWn
 QaXJba0aaGXYeGLqNF4i0aqzr0n9prtfrDwSWqEVtAwAA
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
        Bryan O'Donoghue <bod@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXwISqsmWzC7mU
 WOdzIH7sFvz/dRtMVIFNOx0rkbyxmKXwFk80QHTXYLYBZR+DKbIJOzKPcjF3fK/QbNcfn9+gCx1
 6DF0OZmVMwZwYLzG2k2DAs6KYBlqIrE=
X-Authority-Analysis: v=2.4 cv=JeUpPkKV c=1 sm=1 tr=0 ts=6aea3ea0 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=iLpAc_oAyd6-UMwFnsgA:9
 a=_tt07cvGlRXhqYmt:21 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fvTQPb15RSv9mJ2mRj0YTb5au1P7kegr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXwY6HZaUnT3wA
 4plX6xZBdAZh6TISNrKKiEKVX4ySZrrcfyqjwQ019giuD+g4mhCiSkB6T5oB4vxTo5MHTfEdc+u
 3ykRrxPcvGJ+ULdGhbh29Ib9wTrgtWJnpEJPJCjwVSzDqI2qTWJkDHyPx6fNc7OEh1HWnsevof0
 FYiWG/opNJqPW64ckAeaMq3G0U0Y9sMkOj4Ii58XcqCpxGSLHaRy3mAWKUWukOYqCjDajPjByd2
 +XC7J5G1bPL5pzQYKziKzvE9i0ATnmnmBAPsu8eZOCc4YQyMeFX5lFi/0XpYjl5IEl8vad4l5kY
 XiTloEOciCkCA+CAd+vxdaUwFBGTBXYGJ+sz7u2KLpNCtuFewicOgs2gcCm0ksp2U+8vhLKzSsx
 ntqHhDzZYx6Jb/T3rqKJwq7qe0X24faA524OAPomAfnyIlovpDhYmRL4qwDH5fpPPeuzHUm3Q1I
 Cwxbos/1pWq6bCt/dtQ==
X-Proofpoint-ORIG-GUID: fvTQPb15RSv9mJ2mRj0YTb5au1P7kegr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030080

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
https://github.com/jwrdegoede/libcamera/commits/camss_pipeline_v2.2

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
Changes in v13:
- All the changes below address the sashiko review of v12:
  https://lore.kernel.org/all/sashiko-outbox-193768@kernel.org/
- Claim the job under sched_lock in ope_job_finish(), so a job is
  completed exactly once even if a late interrupt races the cancel path
- Replace ctx->started with a per-queue streaming flag: a job may
  only start once both FRAME_IN and DISP_OUT are streaming, since vb2
  queues buffers before calling start_streaming()
- Read hw_running/hw_ctx under sched_lock in the interrupt handler,
  and treat a negative pm_runtime_get_if_in_use() return as "registers
  not clocked"
- Complete the params buffer when the job starts, where it is
  actually consumed, and return it with ERROR state when the blob is
  rejected
- Count the capture sequence separately from the output one, and
  reset both on STREAMON
- Abort the job in flight on runtime suspend and forget the
  programmed register and gamma LUT state; restore the interrupt masks
  and release the scheduler on resume. System sleep and unbind inherit
  this through pm_runtime_force_suspend()
- Validate the crop rectangle against the input format
- Enforce an even height for chroma-subsampled capture formats
- Clamp to the highest available OPP instead of requesting an
  out-of-range rate
- Move link_validate() to the ope_proc subdev, where the media core
  actually calls it, and dispatch both of its sink pads
- Return EPOLLERR from poll() on a non-streaming or errored queue,
  like vb2_core_poll(), instead of blocking forever
- Destroy the context only on the last close
- Add the CPU latency QoS request before the video nodes are
  published, and drop it on the probe error path
- pipeline: Allocate the pads of every entity before registering any of
  them, so a failure half-way unwinds consistently
- pipeline: Allow entity_ops on subdev descriptors, fix kernel-doc
- Kconfig: select VIDEO_V4L2_SUBDEV_API
- Link to v12: https://lore.kernel.org/r/20261102-camss-isp-ope-v12-0-702254689feb@oss.qualcomm.com

Changes in v12:
- Switch OPE clock handling from pm_clk to the clk_bulk_data API (Nihal)
- Add system sleep PM ops (pm_runtime_force_suspend/resume)
- Update pad ops (set_fmt/get_selection/set_selection) for the new v4l2_subdev_client_info parameter
- Fix probe/remove drvdata ordering to avoid stale drvdata on probe failure
- Update libcamera support branch version (to v2.2)
- Link to v11: https://lore.kernel.org/r/20261023-camss-isp-ope-v11-0-0c2937195298@oss.qualcomm.com

Changes in v11:
- Rework scheduler pause/resume
- ope_sched_cancel(): synchronize_irq() unconditionally
- Add reset_mutex to serialise reset register programming
- Re-run __ope_irq_init() on RST_DONE, a SW reset wipes the IRQ masks
- vb2_queue_error() every queue in ope_unregister() so blocked fds wake
- Take a device reference for ope's lifetime (ope outlives the binding)
- Collapse the three per-queue rdy_spinlocks into one queues_lock
- Use div_u64() in DS_Q21()/DS_OUTPUT_PIX(); fixes the 32-bit build
- ope_run_job(): publish hw_ctx/hw_running before programming the
  hardware, take a typed ctx, drop the redundant resets on error paths
- ope_release(): take ctx->vbq_lock instead of vdev->lock
- Drop ope_adjust_power() from ope_s_parm()
- Adapt to the renamed v4l2-isp API (v4l2_isp_buffer)
- Expand the locking documentation
- params: switch wb_gain coefficients to s16
- Link to v10: https://lore.kernel.org/r/20260925-camss-isp-ope-v10-0-2622411034cb@oss.qualcomm.com

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
 drivers/media/platform/qcom/camss/ope/Kconfig      |   18 +
 drivers/media/platform/qcom/camss/ope/Makefile     |    9 +
 drivers/media/platform/qcom/camss/ope/core.c       | 4072 ++++++++++++++++++++
 drivers/media/platform/qcom/camss/ope/params.c     |   78 +
 drivers/media/platform/qcom/camss/ope/params.h     |   95 +
 drivers/media/platform/qcom/camss/ope/pipeline.c   |  410 ++
 drivers/media/platform/qcom/camss/ope/pipeline.h   |  242 ++
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 include/uapi/linux/qcom-camss-config.h             |  217 ++
 include/uapi/linux/videodev2.h                     |    3 +
 19 files changed, 5609 insertions(+)
---
base-commit: 4ca8b46c95043897a8ddb063db5aaed61edaa264
change-id: 20260427-camss-isp-ope-4b575ffec2ed

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

