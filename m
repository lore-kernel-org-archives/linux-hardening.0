Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736373;
	b=nGtbyzi0R/e1AbtnQe3GB6aqM8DyTjIrhl0f0mA10Zqnz2V549Q1KalxJ4dYIMCglFI7
	 3cbBHvRM2JbCOSNtyZX3q+TtNMwFMGvlKfpentohmOYNAWjc7XvRqkrpzQsKCVYUZQXth
	 RO6+afg3FVglebVzuxV33YusfNitG+uHavEh117+rd4P3itzW8o+1XKAy5EV3RsRCyvUE
	 17FKCADNHm0VOH3l7K24jPDIyM0hjRhq4hBwKbRyPepyXEw6fJgDH9GDnbSVHxhu4vugG
	 4/Qn3lzhB9vsU+LQXocoHUxOlAqZji4plbRLk+kI2ynr732XWGCaKq5MKDAhrOfYwGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736373;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zZrkiifivvXgKAhzIe+nSCf+/l9FZzZvEX7NTROoNwU=;
	b=rNSNgrIUJ8kAtUjid03+yHzULXL3K7ELPfjS6bLKascJmAGiu/csG+sezZ6pubHk3zpk
	 Ptw3dhM+Dwwc9KaVopoD4XY7C5vLmq9UH68AHF7OXmuM3QHs+sDnjw624+L0xaq1exFoS
	 nUrI7lCOzkwkTW1GSI/jHJJCzG6CB3dpQHJn5cTsarrP/n/FYisixDkZPMY7WRxfH+rmm
	 ZST1oxNjiJUb3+ro5GO+UcWyiElymawz+ufolcVe6dR9AwWNNfT+nTqzkD69NA2ps8/xZ
	 9wtnT9D6E8ECvU/doxyas4VeqaEf5vEJQhhtpCbfA2c8TZKhAmZ0QurdfvPbRwOfGbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dTPtOJ+f;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iUjeFRwu;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE2606A31B
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 20:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63BE2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dTPtOJ+f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iUjeFRwu
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3IpASW3673212
	for <linux-hardening@vger.kernel.org>; Tue, 3 Nov 2026 20:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zZrkiifivvXgKAhzIe+nSCf+/l9FZzZvEX7NTROoNwU=; b=dTPtOJ+frAPEorJS
	bZEoMEy5MLagE9LydR1o2a5KL8mOWL5LJGPzqQozeomkGsOkzzPZfAU1TZ1I20jo
	fAzhG+f5J6G5mWL8NWHg2NcmWT6SvcdqLZK184nFS2ZCg4Tgt1EBpIEFcCoX7i5z
	U5FsxG9HRlL3OqhSE2ZyJkx7Thy83SSmbuSc1q+cEnZNz+U7a0U55AtObRsyYvcX
	2xI10a3ohK5rNmDnMO9qcKPSNLE/z9OxIUFADrdcxCCyloKtxvy6pJkQuagPm+iO
	0oEYWbdgIStIQLWe8cOtOVmyB8RC2N8psgTGg+uPgC4qatSD7jAvAsoRc+smEpzv
	1qIIuA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8ng9as-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 20:06:12 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf45388253so3957120137.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 12:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793736372; x=1794341172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZrkiifivvXgKAhzIe+nSCf+/l9FZzZvEX7NTROoNwU=;
        b=iUjeFRwumnTO7C4i+M6RvgCYXOdfIWovdu7k/uKP/4gkQQT3SO9jzivQls+UTvNI6S
         rgUq05Yja4QeEFZlIjoXp8EnQ2yY6DCK2HPjg9tzNJ0mYJCIaHN/divs0CCEE53pc5G8
         UzWW7S77IkifsxLzpdLYjj2mhLZM+73yRMxGztohsusaV3nz6dCV89cyTPP59R0BdFeJ
         jmh4L+Sf5o14yYycRTDq3/OnuHO+/7YeNJZSdUXQ/TE5eGBO4ZAxwuBc7eyJEOTIseOw
         vdRgk6FM2LjGHKDC2uqwxFxXO8C6gCkxS1Ta+t8bv/v6TyRhNL2G/ZNs8QZ1Sl4jPNH4
         mOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736372; x=1794341172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZrkiifivvXgKAhzIe+nSCf+/l9FZzZvEX7NTROoNwU=;
        b=BOaCXEOQZyBbhN8K2sS+C8j8yCmN0n5BgdMURSYT7Ub1hOGRMBuAIWM3ZausRQue2Q
         m29GjedXjF/Q6sS9new0QzXVN2hz3HlFS3Ghms50zOXRVKrD+2DxfdjtpQgcnF3i2o6A
         AREXcz3X390iQpZyBJUBJVl669hMTommy7PawjClqyRpi77mqw1gqqgR3qDTVl9Uj4Z2
         834oy5I6ZKYUSjJvhmKeqO6Zf0gH/+dZc09U7iY2iqnA8pSQsS3vl3cVlfPMgHMC5a5v
         1OWrlJkWxD2Qo+61iRIv7ddMhl7IJ+wE0tRM1XZZ+YZkGmhp1gl6OnYyG0zDU1atRUJO
         hvVA==
X-Forwarded-Encrypted: i=1; AKwUvBzoMPIwsaOlBpnLKAwXUhhGHFeLhHix2cg/f+o1Fwv7z2Onbf/pR22jrUVRNqrGGFlfOm+pw6fqWNtaBPab/QM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Oz3XcZxWKQ0T09ZTY5DzSrc5FEMOxm05S/yTWpFd6owAQxboE
	x08jxhx+oVGyMs3Sge6rXFIFusOcCRJSzKfSFMjCT3m9oEjxyUp5hXX9Mp3YH2iBRhMwkrmIMCV
	DRC1sVANXorY7hG/Qpxuhn+gMBsM+Ob9yUm90bEajHBErWYUn3yLi8FSmKPGJhjNHZjq6fyY=
X-Gm-Gg: AYBFou3z89Z5CEEum1XMj2EP6Wip/+5CowdH2p2FZTyPQ2uEZdS1ai4b5UkPjN0xo2W
	fxSCUkHBPOo+RBVFW0C6G8fD9xp0E6IykAFWSuUCfYoxzO58dFTjpxjlNwHv2lUFjKnPZG6vcEx
	PmSKSDldK4/N8KHRslWZgm6ex5dXGSCS7UrzC3+TjKrxLoCzLw/nWlSGitwfEFV+HtOCSSf+F5J
	yaodvjNhCei4/QYKeVOsu/6ZXAiGMO6tnr0f/S9fpoHX1ONEvTmS4mVvjee4jzpJakI1/3phxb3
	BZFhGqwA36EUZopjotTjk+DFyyjlNs2gP2jxmxepJ5I5zOCyLXDzV6FVHOtkaX7uva8q54/aKnQ
	uFe6uOktkS8Vg+KBOPyBIkuFaS2JPi89I+f9Idt6rYR4Pk5sn+/qBPqjI4iP4GXUvkS9IMpNQZ7
	SNi1ufFPPI9ZDerAmbkhEelw7pm1ytCrm8367cEFCTs5fw7VqlygXAC4tAE3fmkBvyA6HpZK5gX
	Ds/sFGhl3jSiXcfa/8sjRP+3GNF
X-Received: by 2002:a05:6102:580c:b0:7af:fef2:8ecf with SMTP id ada2fe7eead31-7d072bc7564mr5895196137.8.1793736371781;
        Tue, 03 Nov 2026 12:06:11 -0800 (PST)
X-Received: by 2002:a05:6102:580c:b0:7af:fef2:8ecf with SMTP id ada2fe7eead31-7d072bc7564mr5895172137.8.1793736371275;
        Tue, 03 Nov 2026 12:06:11 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fcd03d01dsm358875f8f.44.2026.11.03.12.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:06:09 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 21:05:53 +0100
Subject: [PATCH v13 9/9] arm64: defconfig: Enable Qualcomm CAMSS OPE driver
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
Message-Id: <20261103-camss-isp-ope-v13-9-c2cbf15a39b1@oss.qualcomm.com>
References: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
In-Reply-To: <20261103-camss-isp-ope-v13-0-c2cbf15a39b1@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfXypUDojFY3HLv
 J9b1Jm/XJYHRQMok1tANXNp+ReGBqNw2hUOK5OHFzbs2S4QPdTOUqnghqVTWvsfcWIhcV1zZcIl
 v0EnN0RGsiAH1dOd7SCLQCwI6psE0ucQlCbSvq25/cO7FQllb88o6VXZzKxSST6oW6dd8P/DToe
 zMcGnuTnE/FYbic9LZRN9TRL/D9z/BqkyCbuWnpNPhhwh9XyPMKtTzvScHwNwIBJ4bN113nQ3+4
 7xHrpBixZViQchxKbMQsnBdNgQy3dyR5a3B+9Khih8Mvq6hH+PbgW6VbWCuwBLKbUme4ePrjVZB
 SNysCF2n5P4e4DEmgdOdvbD2Fmpy2DYEp5dsVQF5A5wUhTMz95nhR7TvqMU5G73rxZQxmmbMsQs
 my7y+MAUqwZrABaxOr3LuFGWkUDmnu+MemU2HioyjPT5AGX6m/9shjmfQp95989UfsqDze9+12K
 4XfftEbqWXR6pUT0ZBQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA4MCBTYWx0ZWRfX8ih3YyOWLQZt
 xDicwmtB8hSC/Xkk/7VdD5cfaU7Anct+eXHh/YCiQH36SEDTbsB3HBi4LV4NOQn4L/NWvSj21dI
 NHsMAp6UGnIO+0rxGFH+hXl+yR7W3lo=
X-Proofpoint-GUID: rjnugMKZyyCS-aTB19foYz31znNQQQQC
X-Proofpoint-ORIG-GUID: rjnugMKZyyCS-aTB19foYz31znNQQQQC
X-Authority-Analysis: v=2.4 cv=As17T+9P c=1 sm=1 tr=0 ts=6aea3eb4 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=MWvNLhr-pL88feDBzY0A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030080

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Add CONFIG_VIDEO_QCOM_CAMSS_OPE=m to enable the Qualcomm Offline Processing
Engine (OPE) driver, an image processing block available on Qualcomm Agatti
and Shikra based platforms such as the Arduino UNO Q.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Link: https://github.com/jwrdegoede/libcamera/commits/camss_pipeline_v2.1/
Link: https://github.com/loicpoulain/camss-isp-m2m-test
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7b4985b29b21c440c7912f0a24665bdb7010d9e4..6ce0907bfa8eedccd05c91dca45ad7c18fdb37cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -942,6 +942,7 @@ CONFIG_VIDEO_IMX8_ISI=m
 CONFIG_VIDEO_IMX8_ISI_M2M=y
 CONFIG_VIDEO_IMX8_JPEG=m
 CONFIG_VIDEO_QCOM_CAMSS=m
+CONFIG_VIDEO_QCOM_CAMSS_OPE=m
 CONFIG_VIDEO_QCOM_IRIS=m
 CONFIG_VIDEO_QCOM_VENUS=m
 CONFIG_VIDEO_RCAR_CSI2=m

-- 
2.34.1

