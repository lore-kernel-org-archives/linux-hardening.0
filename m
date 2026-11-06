Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973327;
	b=x/itANk9N+rwOT6eZSpdtjL8/J8rR7Vdn1jdGidyOWpML53KMO9CG8kIUTf6Kq1BCKIm
	 ehCzxXx650jCv77P9QW4al1aijivB9SB3XgH5izK1FjHXcMqafN/1qV/vs2bdMdewNX/a
	 DvIi5SE5S3ZWEDxiBlardiTbd3z8V109tUhSgj+qnwoKMeQII7lQCC0GyDaJ16fqKH05U
	 kJ/vpUMzVbNK4kMwGgfxu44hO9sAgGcVhQy/OtFGGTutRx9Tplnc2FhnfPy29Wkh8rva7
	 0w+sTK6eoDcA8O75RNM0zE3+fQpRyS/7PgLq7Xm1qU6wBNUXkcOwH8r1ClTmIHSYaGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973327;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=t3/Z5FEcnN8TtjlG5+2dXBCXIViHv/NFkyMYOO65ns8=;
	b=PXf17PU9dGU75ehcTnD//yKjUHon1dHMp4Xv0OP9Epni2dNfU4dnzDSVO8/oye01nFLi
	 HvF1rBRNz1JOIta83SaSX1RmZznHCo39IYLaC3dRIYSBXSbcoYPbT9AS7RwsxWoj4mr6x
	 FJe49e2WDiYNwaufbEhpigoxk95w3TsI1evEcnC/pcwAHyWJaelUaJggIgnEmKa+3Ek4W
	 SNxEOMuO8y6K79m0juqiM4I6tVvRwryPgRU/+RP67cKMe/3lUuOXDQU2pEj+WpiD7Q31K
	 4y1z5UMcweGuJcqnXVL4XeK62RNrmAb58DUYISoSFVlpn0oh/7v1W03rXdDWMvVXr8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=glmekww2;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MisF4BBw;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A04C606A336
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A04C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=glmekww2;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MisF4BBw
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoT4A4089117
	for <linux-hardening@vger.kernel.org>; Fri, 6 Nov 2026 13:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t3/Z5FEcnN8TtjlG5+2dXB
	CXIViHv/NFkyMYOO65ns8=; b=glmekww2YJvXt+NhjbR900o42j1Ceez27AJdgM
	U+ZePIcwtsGpoDznJjKOq8eTweA9zSD3MqPq62Dv/qSnfR/yjiPCOi68j3I+hpPK
	EnDmvZTkbWwUBPHJdPn/9FID+XChUY/8JHLaJQGunfxGCTuJZCyYDHaPGd6lfShE
	aziDKdq7olTaGGqQ1WSrDM+qOshK8Y6+FAozrYh4kOgKOuFmvwORw+F0X3VxEMYI
	+kV7iNNj/9dB2aeFgZeZZMGWY1ImcMs8eWPgbt8UMZV6dGd17EXUU+qpDVnPuRsr
	rBQe/9NLtuu6zX+qrE/nJ5BUGIhztknLEwzDT60MD0SijidA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa3068-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 13:55:25 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7bf45382794so630325137.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 05:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973324; x=1794578124; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t3/Z5FEcnN8TtjlG5+2dXBCXIViHv/NFkyMYOO65ns8=;
        b=MisF4BBwWRguUT07GNnJIyEk1L9YuTPVP0FKrS0giScIQINjYG3Xq4o0HCuVk/pTbr
         p0dYhZm5VVdkUAIzGWdB2Ws7qEPIgUFVGJ8abQKWfDTzjft/H00uS/BAAlg/QkwHS4DR
         mRivUcIGrTywl/YGJGUBH9WO2yuV1WykKBT4zKw5zBHLgJ+VvFz+iwNAxUa5soszTdOg
         fkxnKr1MqOP5zsENIoc0faWXc9OCBVEk199FzvF7cUvEGyWs0EJUtyJ23CJ7ee4di9mf
         /cRLS3zvrfEM8fVXs/mEjCgSZuls+9DYgJtYOn2iYXK7UkZnXJ2TzmQqawZSo5231CfK
         s3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973324; x=1794578124;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t3/Z5FEcnN8TtjlG5+2dXBCXIViHv/NFkyMYOO65ns8=;
        b=C6DiohlZjKgMMbZ8XRwcfsLYzyJkcZ0tJLOdJYhBlxGSy4gTS8PquYJchqexbv0ydr
         2lb9GB17cD1sRKrpevYlvs/EiXEfdQWYlwUUiXyMVoHXGe8Qru1nmAavsaGsNJjYwHfU
         wKCYaQXJqDnqisku7ubh8XGkSniXt++NHOe7yoyPOPrbZ8ieKYp0PDT54heTNfFcjCrl
         8AJ4X3hzSU4PW5Q9Rluw0//pwzAq4IoeNkxpswNnSCVj2HTHOAv5/t31mWgQRIxz04B6
         4Y9RXkvDFzQGqdZBPVdns9TOJ1yLEdWdgoWs04vfzWk36T/r2L8aMCX+yxfHKwVLk6SZ
         qR8g==
X-Forwarded-Encrypted: i=1; AKwUvBzLjCHKfxbt/ODNwwEqm2suZdKRminaMqRcGt+0Wp16C3K6ZMNSnev8fyyJmNhiUMHCZ52hWjpvSuMPTxFq1DI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cw3FYfyuaoyVyHzepcT7CiuTD3wxaa2/m6t/Z4TOfNO588LYG
	S3jVrMnCcdIz+nq4c/UP+CmANG6NI3msZCWwCGUNn1BinzLy6L5ML0V3lpZH1mHXJbcmqf+RWyu
	+oTRFZTwft9rLAiGLAyeE5gu7yIWUvBZ05NAVd5j9BpzNCM5QsKxYsUZjRchE6EOrNQwdyLE=
X-Gm-Gg: AYBFou15mOcLwu3ukRHJwQqGpqJoV4gKzzxfT6mmdzdlQaWl0YlDthWciCIm24AeOEf
	ToMcccQVdi2V/uOrWCzrRrsUpYjSnV6cfiSjcE1od3e+nDnsrWnGboU9FJ0z3ovRY/0FSPASxP2
	12ZwyeipUAYZih0/4Sc8DV2FbRp4UVHjdGAeezQ3G0z3c5rEydLWJ17dmP02BTS6OcZInmDtr82
	By4s+WhEoOTT2xneK2FMeq3l9DCqGTO/zvkKePtzP4NVi6kbmu3dChZYcKivtb4Lzes0/v81izV
	+y7UQLT7tF0PbQyggEJ028WnR8p1Ut75sWrE6JDuK3zIFE2TjD0j+TfiAIrfZ1Ky/ORHh74Xrts
	Zqn7Sept/Vpxc4EfcaG7znnejWIRdOvQUJDLNP2yqjYMoVzA6vm0zxO6vGfVt2x5kjWMoa+LiBV
	DCoTwY3VgLFD53U1vtFd8+yvgsuL8WKEZ2K7c1OvqWRpYnYReDA1h3p17bkObdKgcuVGSYF3lAW
	+uHzkYhWwAnhwDm6KKJ4GEJV7l9
X-Received: by 2002:a05:6102:50ab:b0:7ce:62a0:6a14 with SMTP id ada2fe7eead31-7d2a153e497mr1499496137.9.1793973324269;
        Fri, 06 Nov 2026 05:55:24 -0800 (PST)
X-Received: by 2002:a05:6102:50ab:b0:7ce:62a0:6a14 with SMTP id ada2fe7eead31-7d2a153e497mr1499479137.9.1793973323643;
        Fri, 06 Nov 2026 05:55:23 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm3963256f8f.51.2026.11.06.05.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:55:21 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v14 0/9] media: qcom: camss: CAMSS Offline Processing
 Engine support
Date: Fri, 06 Nov 2026 14:55:16 +0100
Message-Id: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAETc7WoC/3XSzW7jIBAH8FepfF6imQEM9LTvUfXAlzdISZw1r
 dUqyrvvOCttLHu5IA0SP/7McOtqnkqu3evLrZvyXGoZL1yg+vHSxaO//MqiJN7oCKgHRUZEf65
 VlHoV4zULFbTRw5Aj5dTxmeuUh/L1AN/euR6m8Sw+jlP2T0WSRNKW1IEQe9QCxWks8XAdP0++X
 H6OtR5+f/pTHM/nAy+Leyz1Y5y+Hzlnueh/LQ12k2iWAkQICFqTUXzb3luCzeqJGIQtohjRSGA
 8SHTJNhC9QkhtEc1INuCTGrx0MTeQ/ok42DZ47hnpg0MdXNQosYGYFcIt3SCGEWMCysRCkqmB2
 BVCuEUsIylhtL2X0XpoIG6NyC3iGGHA6BTRBtuaDsJa2b2HBwaCeiKFCFLF0GLwH4OwD4PIDER
 y0qDT5FpjRnoy7OwYWtoLRFr11g25mUaumX2a5edGimFAzf8l/G/U9/v9D/atuFO0AwAA
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
X-Authority-Analysis: v=2.4 cv=PLeaavqC c=1 sm=1 tr=0 ts=6aeddc4d cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=lhwmQhHOVjfK1CBdE0YA:9
 a=kBPMffGaVOLKX5Tw:21 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX7slNqvq9y+H8
 XrWzttEyV/RjFbv+a1k+LUH0vhD78DGJTX/C2xaYONka2YIeSke2omNDtrZ6NIgkdsaOLl35WDA
 yi9bBnVck9fXeZugPp4Vn2p2Xrucak8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX120Ca1UYkO08
 FVjggz3DH0d66V1wt4b6mZ7lVYG75oAOOaUOXljBmJPmPTdhGVQPhe+pm5ct0UZGuxVL0jM7d9D
 XZpYt/4wcx8x4+ChNbDhnrw3GLL7zDDu9EDxAk/khlRs66IETcjQpZjQzNLXZH++HpMJMZB+Wjy
 HBlPmUGnCBYStRznn3mZUyxqnLD6Shmu22al6ii5C6/ZQ0t9Rc0eyrtTH7CB0T6VnaZ/60ZZ8WR
 mwds0yc0xgyaQODPIoWBFeCnST/DmuoJ9Ta8QWYtIaYhB9ikDjEoysfoB9nSGC15JfFkKN3eK99
 QF6SOlXZBJZU2JUV0L1ZSUCiSa8jJTJiqur1Mgb0+ETMRLivGNjcj0Dv+Eav9ylYK7JC9kFQd9a
 X8qvDv0SaOMCTmyzKZskzlQd+mGwFCk7+V5gfWOkObz8DucQU9N8gkP0t0OjhUitAZRjRrZlycB
 OdA1ZtyNwsvqWL09UNA==
X-Proofpoint-GUID: hKw08uucWxd0SfL6wut7jOKH3AX9dxm9
X-Proofpoint-ORIG-GUID: hKw08uucWxd0SfL6wut7jOKH3AX9dxm9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060055

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
Changes in v14:
- uapi: Move the parameter definitions to
  include/uapi/linux/media/qcom/camss-config.h, alongside the other ISP
  configuration headers (Jacopo)
- The changes below address the sashiko review of v13, except the last
  four: https://lore.kernel.org/all/sashiko-outbox-196002@kernel.org/
- probe: Request the interrupt before the first soft reset so that
  ope->irq is always valid, and keep the CPU latency QoS request alive
  until the v4l2_device release callback
- ope_unregister(): Unregister the media device after the V4L2 device,
  so the graph is invalidated only once the hardware is marked gone
- ope_s_fmt_vid_out()/ope_s_fmt_vid_cap()/ope_s_parm(): Serialise on the
  vb2 queue lock and refuse the call for the whole vb2
  start_streaming()..stop_streaming() window
- ope_state_is_busy()/ope_input_link_validate(): Tolerate the NULL
  sd->v4l2_dev that the core leaves behind on teardown
- ope_sched_cancel(): Clear hw_running under sched_lock before
  synchronize_irq(), so a handler cannot restart the DMA across the
  reset; complete the aborted job unconditionally rather than only on
  reset timeout, and only clear curr_ctx when it is the cancelled one
- ope_flush_hw(): synchronize_irq() before sampling curr_ctx
- ope_adjust_power(): Skip the OPP lookup when no context is streaming,
  so the vote is released instead of requesting 0 Hz
- ope_stop_streaming(): Drop the bogus hardware reset on the params
  queue, which has no job to abort, and adjust the power votes once the
  queues are drained
- ope_poll(): Use the exported vb2_poll() instead of open-coding the
  done-list and event checks
- ope_dqbuf(): Add the missing queue-owner check; ope_create_bufs():
  only enforce it when count is non-zero
- ope_enum_fmt_meta_out(): Reject a non-FIXED mbus_code;
  ope_enum_framesizes(): report the real width and height steps instead
  of 1
- ope_fmt_try(): Require a 16-byte aligned capture bytesperline and cap
  it so the write engine's 16-bit chroma stride cannot overflow
- ope_open(): Refuse to open once the hardware is gone
- ope_hw_reset_poll(): Restore the interrupt masks through
  __ope_irq_init() instead of leaving OPE_TOP_IRQ_MASK cleared
- DS_RESOLUTION(): Use unsigned constants
- Pause the scheduler across system sleep instead of relying on
  pm_runtime_force_suspend()/resume() alone
- ope_run_job(): Publish hw_ctx/hw_running once the registers are
  programmed and before the GO command, so that the work item owns the
  stripe index and the gamma LUT state until the hardware is started.
  This reverses the ordering introduced in v11
- ope_ctx_destroy(): Invalidate the gamma LUT cache before releasing the
  scheduler
- ope_apply_params(): Ignore the params queue once it has stopped
  streaming
- Let the ope_proc -> ope_disp link use the default
  MEDIA_LNK_FL_IMMUTABLE | MEDIA_LNK_FL_ENABLED flags
- Link to v13: https://lore.kernel.org/r/20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com

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
 drivers/media/platform/qcom/camss/ope/core.c       | 4123 ++++++++++++++++++++
 drivers/media/platform/qcom/camss/ope/params.c     |   78 +
 drivers/media/platform/qcom/camss/ope/params.h     |   95 +
 drivers/media/platform/qcom/camss/ope/pipeline.c   |  410 ++
 drivers/media/platform/qcom/camss/ope/pipeline.h   |  242 ++
 drivers/media/v4l2-core/v4l2-ioctl.c               |    1 +
 include/uapi/linux/media/qcom/camss-config.h       |  217 ++
 include/uapi/linux/videodev2.h                     |    3 +
 19 files changed, 5660 insertions(+)
---
base-commit: 4ca8b46c95043897a8ddb063db5aaed61edaa264
change-id: 20260427-camss-isp-ope-4b575ffec2ed

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

