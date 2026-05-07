Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D63D810D
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194238; cv=none; b=Yf1RWNJ08aj+xA/wJ/U2GQ8LJ/tNKnPoscviKKBQpGEmLmQ/1RCjyv8h9wSNe9U3ryim6uIg0whtJ4SenqxZCKPqtAWgqyt5eHvFR6m++WBNi8wC5myDIA1g9+b7iXu/bdLngcXNYpcAC/RjI2OOeHDvycBU8yv203tMMnGd+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194238; c=relaxed/simple;
	bh=y/+a20YL+ysQIFGE4+AK114lY8/mBSFRbp2rnNsk+9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gmwn3qJX65jGeVYigGWfsuIEW1L5SsZR8si9n80qqSFawOAFMCch6aThuui5Onmk1hGiyY59u4+fmxEFSTpQV+QXpLPpnA3KpukzH916TaWI3iGlfoXGAljiuGB7cp9v2s+YGm7BqsSMx393ab9BMX/BZuLn4fLztZnqG905YRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LihrcusZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TBU+4Uj/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LihrcusZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TBU+4Uj/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647JDejk2183596
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fWBniTwp1rVPBTuTnmxciCl5iow63nGmhGyjthKvyds=; b=LihrcusZCPNaVV8G
	/hcNguhVavhDf3AN2SifQLSR7abJ7MknEWJyaSPOQ54/J7nV2i3nbNXDy0sbMx7b
	TGJ2FYEFkO1HIqciqVsVVyJJc2j7ExC5M/1TxuwMtBYv+yhstnBx0xq9IBN8WtsD
	l9W6KeVz2M9tBSLWBh6Z5EI9dhpObyszrtiPGU8EW+n8QR+7yinUg9UaazD8AAfn
	qNjuafvaImrtgS8ZCQPeViu3nyTi0w4Cp8ut2ktZRhWMVkkwgZsesf63VcYwhu3v
	yweuedmyEbfgTvjQ5jkZ9n8TBqILvjtUFkNr/If2DoOo8aPGWB0B3yarBmBjJKvw
	MXJtKw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e10py8m6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:36 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-95ce07ddc14so1971368241.2
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194236; x=1778799036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWBniTwp1rVPBTuTnmxciCl5iow63nGmhGyjthKvyds=;
        b=TBU+4Uj/UoaKu+Gjxjb3mU0QSsRrG+pT+zcKgmlqKxPiCcgbAMTekVI7zlkUO8j6kJ
         aHGtCIhKcLhejN/jg6EpdpLGQQvXVHeFJRSbNVDc+5ABvre4m2QC+41Hehxps7joaBJg
         Cqw8eHTVO8thp7okVgFncfTxwV8BLl5rXLSklMe282oN2WITs4NX4830XifNWGHpV9ch
         ATln4qWi4cpV5sjqOfYoXYzzZhkk9bZawqVc0SyUOYHteHSwXsA4ma4bqIqV+ZrxDsRQ
         sBeqO65dj2dQYXx/5ob9U0LO9rJBsUx1mO2GmXSnXTFXPpk05bBJNfTAKmcIY0mbbFY0
         to4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194236; x=1778799036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWBniTwp1rVPBTuTnmxciCl5iow63nGmhGyjthKvyds=;
        b=T6zAcy6rYX6VzRQpyePGM2K9RYYm50gTBg6NF+sehgD/6nhMnmOZvh7fYMmi+fogga
         MPoZbAYq2VmZ+m9P6yCdJYcdDOjWkpb9QFomXtdPU3hI2vhjJ1Wf4+Xe14M9MjlPefrC
         /RMENNicz1bhCtWPgQYFSV5vqc8pNy2ElsXXVmLMJn8lkc4Eq+daOW11aRWyEh/a8hdP
         NVa3JDgwtMqhlnHB2x6trdBbizE/hLWx8VGQiHIPSGl7kEWI/vHNHkXB2SCL2dTFx7YN
         SajMUidZZTSz/ASIKX2F/iHN5XutdjEHzS7P8xPKtcbmF4pxb1xwGcC7H7C+12iqPKZ2
         scew==
X-Forwarded-Encrypted: i=1; AFNElJ8recADo7w+fypniEcAjOHGj5BNJiLzSwhpMcXWYpenS8oT2GN5P4ISxq/UNsRexIaaPKpCDdGYV3zpAvjSGpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vRQxYLVkN//EQfTCC3HurXdqGp67UQdQORDr0sKoFuojS+Mk
	qYgeBVUc1lhmV3eBZ7uiwWN4Sxwaaeki06FMdd0roxS9X0dxg7BVwxy9RAqvGHWW4eilX3YpIrr
	RKlrfoCrRywYOk7Ak+JI7y+IroBi/NO9RlkjqffAzeKcckmT4iNbJnp3nNijSqxLAmVTdlZg=
X-Gm-Gg: AeBDieuG7dwSEusTbl1cP3YZSjS9mXyrlcRVogLi146Fv6m/d99CF8rpIZqIUA0PwJd
	sxrOFQm46bPfGDYsgftjMpVj9znDiOA4Ld6TRE8Bd3jvSz+hdx+PE012nx/pitoiXOc2MzgqkDi
	y82nE0uE6173HN9eThxl75WJ2E290jh58Xqv1QWYha4tMni8Z2tos0W4lAvgNHnvYI19aGPx3wn
	tIhorG3j6GAJRljheo+T+PU6WEFyCn4uzrKt6i7xzT/A+pq8zCUIPajTPpnWGQCBrNKLjMupC7l
	D0RLel8ZP26CuRMkxpCZaD+pmLozPzVPUp4+O4mmFXLt/mwqdOrRRfEctqJ8NDJBkygC/lZJfUb
	4ZT/clz+rPrBZbhRJwELUW8mXdz1S5eNYGZ4Tv9tYRUbR63waQatGbcZ2p34BULwczUZw3RZAlZ
	WjZdu4Ap3i2J9TPQxz
X-Received: by 2002:a05:6102:8515:10b0:631:2973:5c2c with SMTP id ada2fe7eead31-63129736518mr1766703137.21.1778194235696;
        Thu, 07 May 2026 15:50:35 -0700 (PDT)
X-Received: by 2002:a05:6102:8515:10b0:631:2973:5c2c with SMTP id ada2fe7eead31-63129736518mr1766690137.21.1778194235272;
        Thu, 07 May 2026 15:50:35 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:49:25 +0200
Subject: [PATCH v3 10/15] dt-bindings: media: qcom,qcm2290-camss: Add OPE
 ISP subnode
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-camss-isp-ope-v3-10-bb1055274603@oss.qualcomm.com>
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
In-Reply-To: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
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
        kieran.bingham@ideasonboard.com, johannes.goede@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=DZUnbPtW c=1 sm=1 tr=0 ts=69fd173c cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: sNk6nf6Pyq0NTj2vUkvogCupNhYCV_Ng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMiBTYWx0ZWRfX9Gcw6LVOT424
 Zd8kpBYX7Nj4LfNBlx9xeD2MQzvauPjBbn8CTQyfHd5x189t6/RtWeZ9UV9Ze85HU9/efaH/sAb
 pcKW9225dXQEIwKvB/rIoaIxb5tiI8zi0ConyjEmCp43EpAofZ0mFN7Go2vgnAeWv9yGKvZw+nQ
 p4K4pIvK1CWa3S2xiWdXvEBc8vJ6PsXw8+Jqz8GdlgGvPWHNu/AfVjDgi/4yzGhUbgWr+aIcS+H
 lcm/J13y7qKcj+4g/6J9JrzMohdiM42KpR+vkK4oWJSYCx+ZtXH43WGyr/mwDw3nf36SpyBuS78
 vLCYLYPqJkjI20UzxveqGM47CQa9RQAWDwI0/T5IMBLGQmQnsrLO6IoE9/+0h4zn7vq/7Mbzv7K
 d5bZHahdkqarHX2wK0+kqE1d39e18uvTVdP2FmvelCO/o1q9K50JfGWfuCcsIvIuBkX5M0wgwAA
 ja/4/gDx3+0cMEnViAw==
X-Proofpoint-ORIG-GUID: sNk6nf6Pyq0NTj2vUkvogCupNhYCV_Ng
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070232

Extend the qcm2290 CAMSS binding to describe CAMSS as a simple bus by
allowing child ISP nodes. Add the required address and size cells, as
well as ranges, and validate ISP subnodes against the existing
qcom,qcm2290-camss-ope schema.

On qcm2290 the OPE (Offline Processing Engine) is a memory-to-memory
ISP (Image Signal Processor).

The address-cells for the CAMSS bus is <2> (64-bit) as related
DMA/IOMMUs offer 36-bit addressing support.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/media/qcom,qcm2290-camss.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
index 391d0f6f67ef5fdfea31dd3683477561516b1556..e70f4cd1348b8065ee9f0e4448185cfd8a8fb7de 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss.yaml
@@ -52,6 +52,14 @@ properties:
       - const: vfe1
       - const: vfe1_cphy_rx
 
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
   interrupts:
     maxItems: 8
 
@@ -117,6 +125,11 @@ properties:
             required:
               - data-lanes
 
+patternProperties:
+  "^isp@[0-9a-f]+$":
+    $ref: /schemas/media/qcom,qcm2290-camss-ope.yaml
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg

-- 
2.34.1

