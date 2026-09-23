Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC63AAF7E
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179238; cv=none; b=TpBrDSgxsKhf6jeiRQPhNbwrRcqRqCbB+uk9pvhLXlTGpetd8vJfQPNxN7w9be8LTLdxIiFntzzsCcWdRTTCSvLD/xIOOfateKIal0wH7hGpLTYQZUEkI9euXReY55f7Hc9rxDQs0/LiF3Wr7hADw9Aiqn0cI7nFh2l5CJ8lXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179238; c=relaxed/simple;
	bh=H3FZ7znaCS6E2tCa+3jHj85kDw9yZ0pmbfqMcQI6JqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5D9odwiqediuLJtFmAF88ZEDXZ7AKTwZWdIeQGOVE+5iM3S2JZuSY89rvJMgXQjn5bddFGwldZWn+wZLCjMk7t7SY+rq7li7FM8LCyunvKUdyyZ7eDerMDNV+7OP5hu5hJXWD2BjMzDk8wGTm7VB9qz5ibpWB35HBRHF2b5dIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A5kXIqbu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BuOCg0wS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A5kXIqbu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BuOCg0wS"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NDPFKm2698187
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=; b=A5kXIqbuPJ0A34H6
	boo7mLoML76S9e+io3dj35PspePtna1xhEzhlcIm8Z/aC45JzyCHkNaxpCL3psRI
	7j2xyeKFax9lIVZBXrhn80sFQPiQBND4BnH5xuUkJTg0SmrDdEZVS6n+RTIxikfE
	M5qqOShV2McuIQYw5pROuqgHIPbCcQeuYSh6s8Nft9Mwqh+CFNcCV1R4pdlFMYtI
	OKzGG2RmPx4khe7raJ2hyN+/w7NALGschZYeTD41wOuELJDvUBbWf46lgYX0zZAx
	zr8mwVSnbUFyGeO2UmvjxxK4H7P/700iffUdTvtS1piTezM2kvT9/oqOm2FpYPrG
	aeqGPw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvfmwgphh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 16:00:35 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97cb18cfa04so915610241.0
        for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790179235; x=1790784035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=;
        b=BuOCg0wSGRWmBIuwPa5GHy8ewSClH0Oz+e45acgCTGfrouHHh2GA5LORuccWdtYXry
         A3z0/wMPZF2Lio5yNS3536dajhKZPPDh2c2c8pc7nwoL0ylvOetSRdIHRA3HD7gy2VXm
         gCQJ8rfo0F9TLKYftYmalYnHmw0dUaFKP2D60S2PTLtEPcqw6vBHET4VbauCtS3zLV6z
         RqNLxLTgNo8jqFlO/R0JJOGjDTZ6d6k8NYtEZ635DEUe7dkbT0LngYssOPkVAdW6G1Ql
         d0T/0qEDwovrHZNRrPnJX+9m68lAkiMaoX63MvfQpdgXSBhiXWMDZxHgczLGe9sm/Kip
         NLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790179235; x=1790784035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PagDSuh7l2ZhcYiXNCHSTvc79NuxyK2nfl6x2BVYD44=;
        b=lGVksWVoYmnAO8QNdocL8PyVk5yy2oUkaEqSYrg2yqxSS+PF1hjSh4lLaKRW8O3xT6
         1luu2dZiKQDisbLQJhIW4w3a6AOFcZRsGwjaurdmowZN1fAfOkoPDpwJBUfwkapg9tL/
         CTUb+ZEfF9zKERlrhftrEk/VMeuVjj1/GmBT3VVdyxGlunl9JrOWpHDVI/BSatTRWah8
         5j21PyMmXv9+Ebp2jh3GUymhMDIulQkYnWH3W6djzNzuoRGcozJ5qiKPBVEgOiqzRyka
         gClOtvdoofhJkK5HQRGgZomhEuXhQiyaXkdoPTtXZA5FEgomHmpDuKM9brDnMqu7DTwJ
         nm1g==
X-Forwarded-Encrypted: i=1; AKwUvBzwL9dmOKxsVfmebC3ScH6hNQlNgjqBr6GbkRcjaesp5wAsYEkhmu81nseUJUrQIeCwj+PUslQGyE/sFt8vFqE=@vger.kernel.org
X-Gm-Message-State: AFuF++kQ05+O72zmYAwTic5S9m+z2zTZOKKMlqmXWZY0OZuHArt9fgD6
	mZRYf4JWO2Tv0zrBbOpzql3aEe+eJ0nFJuop8XlggVzXIB0PFxP5ZD1RLmhz2l/mmBjaanL5Bhv
	F8BYDQF0YLqANQZHR9J+ZLhg8HaSYNvbixfeEtEzNLmpdkPaND+2fBjnj2gWEDQdnELsm6tY=
X-Gm-Gg: AYBFou2F2TxTYhjsoTbUQBZ/bc3T2MyndJuq2YEEu7FrvMcYmS1nNviq7SxUwWbyilt
	TfzGUPT6zPLGPPoXeFJWqtHtVi2QZYjAxrt15WD1sOP9jawSblLJxD31uzQz75pN3r120l9w9qS
	p+vVswYPA55dekwvg2o7EFumKyV1amVmWTLEpjPv5UzvKyhhcnRf2FYaCpwAXHGxe+Qyn+zaLb3
	95njeLJdMcex4ytbYgzvc3xPEmaMxaN0zyfyrKILCS4jocqwaNbeymuJKAeSUNd6TrvWpD4r5kN
	oOP5DUrY/6eDK1GDA1oOnJ9cQ7xWb3mASI6sJG+T1rgYEBTf1HUIUTsy/Wo36yafAf5/vcdIGg4
	t8wrZa+UQxkpJqKB7duSgnxls0oOUHFJsCzhLhKz3YNxLL1hTD0lGqxkEbpbIuyVKTiukLlp/5M
	KUDIP27tZaTOueaNgeXbC0FkUNK2esn+8j/rY50kpQHrrsjtLo4fM=
X-Received: by 2002:a05:6102:424d:b0:7a4:ebdb:cc0c with SMTP id ada2fe7eead31-7ac1a8b6edbmr2871908137.6.1790179235335;
        Wed, 23 Sep 2026 09:00:35 -0700 (PDT)
X-Received: by 2002:a05:6102:424d:b0:7a4:ebdb:cc0c with SMTP id ada2fe7eead31-7ac1a8b6edbmr2871877137.6.1790179234906;
        Wed, 23 Sep 2026 09:00:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:d5b5:76d2:82e3:e5fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde197466sm80739325e9.7.2026.09.23.09.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:00:34 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 18:00:24 +0200
Subject: [PATCH v9 3/9] dt-bindings: media: qcom,qcm2290-camss-ope:
 Document shikra compatible
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-camss-isp-ope-v9-3-86a75dc18b83@oss.qualcomm.com>
References: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
In-Reply-To: <20260923-camss-isp-ope-v9-0-86a75dc18b83@oss.qualcomm.com>
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
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfX5q25xqxeQ69Y
 xc65w9g15VVroh4/17uwxrqQMtADr+3p+w4+/aiJGsmxtGotN37SO/7518vh9eEO31qPxAbzikS
 H05T2gI+iEWOMODRZo4Qr1dxGuiJkweBkLbB4lqvMpuIIJSLLL7/hA2TE6VsXRzTwmuJkGzrDBQ
 9L5gVebi6wLIqX0uelQOBo2GVaAJnXxzGcm/4+wc4vpi/L8e2tzZ6O58HZpR+RwstTj4BPB0K/H
 kWAWgZdQAtx+OBtJcGGl+NczGdqEIsUzO5TucRzQRiuvpMir0+mDHWo1Lsq0vSKdhb9g524p6l4
 9qzkMtvuDhgv/YBbnTJ0gZC55sH9B1hZDIUgMQQpsrIiWexjuoQncuuTfCc/yzb2FNVqcapD1/l
 EJxoP6YHBh88o3E2+MZs5DWBIdzD7h5figy93Jp+rWCYjtTa8nAjI5AH1sHhOIMZhIypP9BXgfn
 nmWrmJDo+QMdFCUVzYg==
X-Authority-Analysis: v=2.4 cv=WK/qzXsR c=1 sm=1 tr=0 ts=6ab3f7a3 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=yPTVd8cUMD2GasGf7IAA:9 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA2MyBTYWx0ZWRfXzKGTodCTwZmo
 wnHNyS1F5Axb/98yhOebwhCMo9Bo5l6Pbn1cXZorZ4F9U9iHX4Z3WhP4U54B3SHk+Qvkwbu/gaM
 GIRnAUG1JLomKGd7CmCeIadxG3mbbnA=
X-Proofpoint-ORIG-GUID: UnLKcZK_SKMYLmDEVZbx2SQGP4Y4NI5v
X-Proofpoint-GUID: UnLKcZK_SKMYLmDEVZbx2SQGP4Y4NI5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230063

From: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>

Shikra uses the same Offline Processing Engine hardware as QCM2290,
add qcom,shikra-camss-ope compatible string with qcom,qcm2290-camss-ope
as the fallback.

Signed-off-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
index f9c31bc88e94b028c241060bbd8e56e0bdc49af5..3359581bfb13e918bb4efb3bc41749e60d772ef4 100644
--- a/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,qcm2290-camss-ope.yaml
@@ -19,7 +19,11 @@ description:
 
 properties:
   compatible:
-    const: qcom,qcm2290-camss-ope
+    oneOf:
+      - items:
+          - const: qcom,shikra-camss-ope
+          - const: qcom,qcm2290-camss-ope
+      - const: qcom,qcm2290-camss-ope
 
   reg:
     maxItems: 6

-- 
2.34.1

