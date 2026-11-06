Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973359;
	b=hwlt9Oi5sUBXtjW4OFTateihmBtZxHtE9F1DcYJQQbRO2tBRO9j8EYtvUGhZvUbMmlM5
	 f/Xsjqp/2zZ7XMZpZO4YOVgqNj5DY8HWoZ9A9BIbFtaxYM/lMOHs8DbpZ1zS6AhEoI95J
	 O0JIz6nuUQlBKZj0UIGFdbyrVaEKkK7gQP7yfplB9i4atTSdaQ0Z2DsVvgd+NFBSDteCv
	 BaJ3wz4jRsgFkRu/oDLiNYOd0J3KL4E4q46pmqbF1EgOO8vsUYQydbxPvJwidzzX6Q60V
	 jGuHStEKdT6yhL8pGnvUs5jVlFaeOAnXmpUUb0H/h9OFHaP46tQUJruoXuD4hPLFJsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973359;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zZrkiifivvXgKAhzIe+nSCf+/l9FZzZvEX7NTROoNwU=;
	b=mENAhYT094w7CRAl7mNWyr9qPeH/CJe6s7MvJjaxOj2yNSySJIzQPwCUQdbhxAZ9fa6b
	 +1WNvtwo2XaUO54KuwRTBtlXgJjdeTMBAaBUa7hb32cnxYMqiOH6KQ4rZsqiQQzQ+K00J
	 VE8vXpISYju5jnbSmf3BwG6ODTeQpXmhY775z9RD+lQZOt1bD9eEyEIV2l56KXzU6YgjI
	 zkb3t8lA3md2/KCU6PTFTVlL22+opiWRajVKvWLY0UfGuu3NY0qU8ueb8VtqoV7j3r3Ii
	 jM+QixCw+ImbVuWWkJ8mjDVJs3lxQbltgzWM/RJekjfVSBTijadBmpPZABR49WVG0yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=US2nmvah;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L8KV8Xf6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA8606EE8F
	for <linux-hardening@vger.kernel.org>; Fri,  6 Nov 2026 13:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7AA8606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=US2nmvah;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L8KV8Xf6
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6DoNuE3034442
	for <linux-hardening@vger.kernel.org>; Fri, 6 Nov 2026 13:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zZrkiifivvXgKAhzIe+nSCf+/l9FZzZvEX7NTROoNwU=; b=US2nmvah1yJQhPOR
	tKx9LUKcM/vHdZzQt0Phcfi/T3pbV+zRYzwXi0q5dvCA6MAKy3DETyd/S9viuPZk
	idcXvg2enG5VSWdwNK22WeaSi28jLTvsDVjQZRt2v+A6MCAswGiBOkHqP6UH42Tk
	+3eFXZxFY6mKE9lPUd9sn2e9h5kymEf2vpIq/H0H51rU1sStrMoWxaOHYVYDa+1D
	PvmniTx2gfwR2m/ueGBBxGrs+kKWxSk37d6Z7rq7xkWcOrJLFZ4YjNJ7mceLaum0
	qvoYnQaEETRqARToLchkLRUUtFrvQxRNQxkqQ/e2oSYK2pFbJUF813x0hcHRANpI
	RqShGg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3paayjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 13:55:57 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-99062be02ddso111158241.3
        for <linux-hardening@vger.kernel.org>; Fri, 06 Nov 2026 05:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793973357; x=1794578157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zZrkiifivvXgKAhzIe+nSCf+/l9FZzZvEX7NTROoNwU=;
        b=L8KV8Xf6To1qNWXhKLDVWSBrHCkj02pnREegQV/Z3bNQAT3/bmWN2E5HtwogiE+2PK
         cwNueCDlPrb+eFWTJiG0u9REle69greJajGEL0uTlg9sdEH05NnwRvMuXOK4WHc8iZC8
         cpEHl/9da8Iq2miRu5XxmiilR6iviYKmtTokJOtk6OZ9JwOXBzKlOjn9KCOrV7oI41ae
         tAU43Folq/FrhNbXlE/OGgnGIa6iuyS+CvDeJS4vMJD81L6lPVaFyYkRn1ILrJbgWkX0
         svzBykZxOdDDKfC1Vm1OHmuZ5oN/z4zZPJhgK6qOaQHoNU3m5Ij6cIUvDWuIBWn3kq/N
         ysfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973357; x=1794578157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zZrkiifivvXgKAhzIe+nSCf+/l9FZzZvEX7NTROoNwU=;
        b=YROUaPqDVqnbzW0x/3oNng/u5CuGK9zLe//6hNawteeCcC9jAJEbOnwN2T6ktxJAz0
         GrM8Tn2tBnXA2WDWYvpf1bJHZ1pcunSqjKEL+8YU7+GHcY4abbS+cDB17SgNDNsPAAPl
         ytYnGDDZgXy2qOEvOFHy4xuGS5gNdba42ud7Pedgk24DFEapVvzvHdsVzK8dZHxApQgL
         0/yNBWamTZ2AWa2sch0VvoDv8QPGDzYB67AIk29DzLCmEYKy3KnZ5KVks+94TOBWeZdg
         F27YxtNe3J5T5L5bjf6RECZVV9/nPem8iJbS2K4RbBYyQUmtkeElh3D8qmzMtwU3mCD1
         CmPA==
X-Forwarded-Encrypted: i=1; AKwUvByIsQCNzbSajBz5qZIoVG26jvn/J38BeV5Ge6W/9+RVVjV2tYHEQXfIcZc9sYlXAkyb20H2p3EMBEQYwk78fNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nYH1bXpiaoJESXuZ0WLjHXIbXbAVUiG2lwQZci7FVTc5Fkip/
	4fW8mh49f6/aMjnIJC8x9/ZWe82Vd96I8wwJt3fnhVKQEU0FNFEbcDCvUAhdiNyKo7bzaa3EO+8
	tO7vczLxJZQ5WJ7iFX0mdPNaXsw/G9Co+P9NfMSQcvkTiqVIa9T3whlTvQvULrLiB+eUwWis=
X-Gm-Gg: AYBFou0+Cn4gAoGsh1lh5McJDodrouP1GB0Cw4+QkbF4yUqTwr+SmVQn7LmpHSDwAOz
	9ot9DCrOTTFe14RHRMQeKyg86Rflkpg4GfB/kBLUFDNL90X6wjYGeLB3qIAbwsdnksTe5ljeJDK
	uujvurAlP6sQgKDx04r4kOlVQYQ5H2bAX7/YScxYBydW64Tmb15korXKxv1bZpLYrZD+DHSnfO/
	KjnTIh5giLx8RHALC7nwPSsghyowqG5JOeMpLnKpE8rrugu1fqK6X/9yzdtxAdg2KX8vdznheRX
	SjIoCPQrjfvf/3pFuyIBZM9vIFguIZGyOynIpfeXUqj940TPwbGt8FJKD8SJUFxqs1LJBuyxhZW
	C2myPmDwkWufWOqcGHouQxtORtr7R4fBvj846aN3sFfacytMwsA11a3P8lNJMjBmqkPS6M0JrFm
	hRNQSFfxBPDDCbWQ8Kfhg9uKt7yrCyWZKDhydwk9moQu33R6SOPJPhJv6hxdUAidMJ7yFmUb+iB
	Ak/WHjJFWt+6N7A5/ZQlUf7n4Wv
X-Received: by 2002:a05:6102:390e:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7d2a151678emr1297858137.9.1793973357131;
        Fri, 06 Nov 2026 05:55:57 -0800 (PST)
X-Received: by 2002:a05:6102:390e:b0:7a8:2a34:432e with SMTP id ada2fe7eead31-7d2a151678emr1297841137.9.1793973356609;
        Fri, 06 Nov 2026 05:55:56 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:f048:3e89:c517:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d809df2dsm3963256f8f.51.2026.11.06.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:55:53 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 14:55:25 +0100
Subject: [PATCH v14 9/9] arm64: defconfig: Enable Qualcomm CAMSS OPE driver
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
Message-Id: <20261106-camss-isp-ope-v14-9-49c426cd2715@oss.qualcomm.com>
References: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
In-Reply-To: <20261106-camss-isp-ope-v14-0-49c426cd2715@oss.qualcomm.com>
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
X-Proofpoint-GUID: _6w2r6Zyksm3yMKnM7xPkmFA17jiYKg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfX5KZh/fG756om
 20EEl8jojklg1jL9j1dV0gbH9tncxftmaHfjgY9CmIvK238qhc+aXnRCyCxFWTcbm7lZmzSVzJA
 4XYQQYNS7l7whFaYdG6K15Cug9IGJXCFPJij419L3GxVhytflHJVKkdivVCbSnEJ/t+pfHiq2Rq
 9VDT4w3sQtr9KGXZfqQhSCPozsvi9X/2wdRxp5plDQovpklY9vjLsw9pOdRH70ba4NprSmXF3Cx
 Wxigq3iV7fFwkJxhLEh56glO4UtbPjvtdd0SZh/DcrvGNXpcgV/a6cpEj5I8k3doPCB7F8iVsPa
 Ps/HmhkNiQNcOc9bN+JihXQCwPLZYEjYNUMREuqluK+0CGQZ85SV7Q2oDxmQnFRmoq9V317Rj89
 4JpPA1FQFUXJ/avEtMxaZo76AXG0GljvYCHPcG6ZfsE4wUvoR5DkD1yfRXO4m81ZgcGKajTmnEU
 eW9OgcMu6L4mtu/aYBA==
X-Proofpoint-ORIG-GUID: _6w2r6Zyksm3yMKnM7xPkmFA17jiYKg_
X-Authority-Analysis: v=2.4 cv=X7rHu2Te c=1 sm=1 tr=0 ts=6aeddc6d cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=MWvNLhr-pL88feDBzY0A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NSBTYWx0ZWRfXwCgIZVTbUKpH
 Yf4+Do1VSgj+9bUm8E2LUAavKKX4K7QM5dp6mojqswr8QIMGt4CA90PBEYmjUus36nEmoz5WUwE
 UhUv8tvm0DCAMDf+CpZkdZN/WdyWW2A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060055

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

