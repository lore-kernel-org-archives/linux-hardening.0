Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5303D47B1
	for <linux-hardening@vger.kernel.org>; Thu,  7 May 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194241; cv=none; b=ftDkNIlVitFjvxu31xZyzAe+iktXos78py4nPpRbibFIZ6Xc5uyjtMBokEAFQRiYnxiwjoo9JZzx6oSNipkEOMxc2TSh8RkMOz7PQbRt/Hz6/YZfOXo3XwluXunYdcP9t4MV2jgD6lT2mqQgPXbKQFvqF5xUFeA7sQZio73kU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194241; c=relaxed/simple;
	bh=to/mt8DVhWYg+PxpdqvrCs2worc7HH9azPMfci+8vno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDpG7+73N7+W5/nQVDyTcqd3L866kFQhyi7Q30yCulzOV+uaTKj3BCysyvuG63DdJrz4KgAGgunhppgHWM5eZ7wsfxe7dCpA2rD/2XkAY6QKynH4SWWen77TBBCKWImzhTFs3L16D17mK3ceMB/hYVd2dgPU1pVaxo/+DpVhgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JMfRawXS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f4+pxWvd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JMfRawXS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f4+pxWvd"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647HgUj51971787
	for <linux-hardening@vger.kernel.org>; Thu, 7 May 2026 22:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	niYYIC3IDYsrggvEJkZ+xh9PaeYuDpO3NXqcH2ayGgo=; b=JMfRawXSv9QljR4f
	bqyCyWotnAiHLkD+GdZPIG1ly1Ti7cPUFD/VSa609y+Bka8FRxLZFJDXdQkXRa+l
	ivyZd/zWh3at6druFCXLg97FZNgzE01ge5JmgbXKJvsY6++CmYZVZJwmQOoWqw1B
	32e1e840D3buKyhKiEDzJ9CgafHXAyKmY2NB4rpUQud7KKtXkNhJu1LQ/69o4sAi
	4J33dqFqfZwriuHLmVq0AM/FsHveHYuxFg7eHWKYkhGaUQgW0w1b6hXojgs0bF2W
	57yZ3CipxukRrIlbCoUg99MWW1IomkQ9OEH6AuHcJs0pDyLTmZyH2mO5mEDRwt2D
	fU4NoQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tejacft-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 22:50:39 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6312ba5c81aso1226133137.2
        for <linux-hardening@vger.kernel.org>; Thu, 07 May 2026 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778194238; x=1778799038; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niYYIC3IDYsrggvEJkZ+xh9PaeYuDpO3NXqcH2ayGgo=;
        b=f4+pxWvd2NNpTzGM92AnI5MAEmrRth+n+4fOflfARGtzLo6QSmNmlF6HStLu1g6nYq
         rsRibi/g6dRG79qsPJWpTNPS5xD160RZmu0I9ajVU9m4JnMTNLt/Ps+73E/QBsXD0ErJ
         QlIYgkq7KvUcMHDRh7dO6avXCFxcAJ5hTq7j9EvFCiUGm/6sc1mPqCsulQEXQEONfh/8
         BQjMmvaOVxtjAQo2BRCoMvd7lYRe+7O2KQyxGc5wxqNKcNjQVToh7AgBwqZjoQ36dkmA
         vqExyQd8zZS9RuSXqxas1lBYr9ux054mzpi1vQ1nQesp14DBVmC70TKGIkr66jS78Iuf
         6h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194238; x=1778799038;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=niYYIC3IDYsrggvEJkZ+xh9PaeYuDpO3NXqcH2ayGgo=;
        b=DAVztD0ZJH/z7+uO/nQdzBERO3rE0JIeiqIUIoSfjrqvPdv4b5fRNXSW8JR1aVvi/i
         RhNZHzVP9T9Sx1cAfPC+F/HNiTAlNo8mMtOzjbsWTKU1/5/NL8xmxWupgNdR4WQgdtOz
         ICO5JAVLkzjtaZiIb/BDh86BMVvhfEoIaTninGQSMsYrOF1likoykqZHFXBkl7DP6+ex
         If0U5OV4w80eeZep9ipiWl/COvfcEJxF/HmYuZIHIORM4scwJtZT3ar/nWTlVruI147X
         wgy4uWMNar9VBMjDaUyzglekUJlLx8J3MPf0nm1MG+b/SHHYnPXQpzK8VO3qdhMfuih1
         rdNQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZVqcMg2JUg6Ya/5XDetf3gWBNSE7XTKEE7mJLAFNhqKJk+Da6z4W750b0aRnz4vHtjXv77QKRfOJNCp77Xrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIkAr2GgdfIX0zbxb7tFpkX0E8rxzI+VoGmj7o5IDWmkK6zHn
	gRKMMzFPi+KGnnXf4p4xxJYeJOt3S20M8ggc11L2GNtSepuY16R1AmudlCV+uUAsHfarvqYrLTo
	hgv02oR+V8W76oSq+ZWVuLKUwdVEPFDOvuXf0ujK8YznrDa0+dycorqlbzJ7zfZDyO90GEjI=
X-Gm-Gg: AeBDievxXqmQ+7RNEAaShS8MZQtSPkvRijaGNgMm8zjkazaNRfEUiqc4IH88ZgRTDBk
	QUJXIy4m48vRvEwHXmNHwyBH8Ppzx5Sc/puI0mIT+AEoMg+mRMVQm4hGrT4EcjWrBfPolCuxvKM
	EzSukBTj9V/E2N7j7qPyK79ZNjx4nRv4L+4+XNlKnMuU2vfKXOihAHywRhzykhGJr85kQ/+yhCJ
	QBWuLqDKJvOhJtil1jspvR5ucqXMQltU9ZZi4DrfhTb3e/ENA4uDFM5RjI8fThxt8OirZ8w7KTb
	ZAvwyFDiRhmHipdBKWrO0IEZDRqxUzeYNNfMF0GIossSJXKvqDsCNfPqOWAgvqMkINah7TyH2Qh
	vX61VZu/clJQo4H/wJ2/7/Fm9ShiilofIefthejGOnX+REsAb3ToxRmRZ+Xlh8aEEOQTZmENhN0
	/sP44BdfN+cK5ziQvP
X-Received: by 2002:a05:6102:4408:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-630f9017661mr5371536137.25.1778194238035;
        Thu, 07 May 2026 15:50:38 -0700 (PDT)
X-Received: by 2002:a05:6102:4408:b0:5ff:c5c8:2734 with SMTP id ada2fe7eead31-630f9017661mr5371528137.25.1778194237657;
        Thu, 07 May 2026 15:50:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcac4359dbesm102466b.48.2026.05.07.15.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 15:50:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 08 May 2026 00:49:26 +0200
Subject: [PATCH v3 11/15] media: qcom: camss: Populate CAMSS child devices
 via DT
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-camss-isp-ope-v3-11-bb1055274603@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIzMiBTYWx0ZWRfXyH5jPzE9AUxd
 PYKFckd2GECtJ/JLbAiYZjVNlCN/s6pp+gUjVFTHb27r/CBmLwB/V2Rw26LJJJgRvlv6ezq9FNN
 KdNuRb9AqBr0wXdagMddI6hQ8U1qDmnyRttDc+jROPx9g1qA031G2EIqjEzeeC20+jhBRE+xPDm
 TzsShhUriQKKwb5BoibP7nrmo9ugJ+1kdAKM29QCoMV5t70sN/9RIOSqZ8IU/O9EablB47BW/J9
 f10yP1SM49v2/SuBb4h4sJmWnRm+Lzc7ZTpU1Czykv8BNsLoOaggrEIN2n+oFAny8reDN52/w4z
 2PBPMHej0OWC69iBpZlPnvXJAvaKYsmWegik+1veCUsGhY+BZ3g4SR0ScjjDwa3QkYnYD4baN+r
 hSSTBpXoAfv/3v/JRR+ueE/+TMqRoqB5qqftZu1HtcjvBrGb7oFfqNdMrJgV8srta4jt5ESYC2L
 ORYMFitdUJsGGVWzRjQ==
X-Proofpoint-GUID: m0KU7r3qVqTfzG1UZqHOJ8xS6lOcIjW-
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fd173f cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=5bRy6lfvdnCUHtv4pvsA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: m0KU7r3qVqTfzG1UZqHOJ8xS6lOcIjW-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070232

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Use devm_of_platform_populate() so that child nodes declared under the
CAMSS device tree node (e.g. OPE) are automatically instantiated as
platform devices. This is required now that CAMSS is modelled as a
simple-bus and ISP blocks such as OPE are described as child nodes.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/camss.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 0ceab12d573ee7521d44b77d23ee563930d6aac3..6d65b1e08e30246389657a0e46477d33bb5ac27c 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
+#include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_clock.h>
@@ -4631,6 +4632,8 @@ static int camss_probe(struct platform_device *pdev)
 	if (!camss)
 		return -ENOMEM;
 
+	devm_of_platform_populate(dev);
+
 	camss->res = of_device_get_match_data(dev);
 
 	atomic_set(&camss->ref_count, 0);

-- 
2.34.1

