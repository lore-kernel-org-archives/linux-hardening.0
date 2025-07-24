Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301626A0DD
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354670; cv=none; b=FTmX40yZlXd472q/ed6ubrhLMT+RKUXVhgjVEHIf21mtZNTjxGyXTD38lQ1xfIJuz2swb4DqZ+NmBFr9ab+B2JHxl+Fi26phNMYF8FDQYLsKvz/KQ7qi0Q6bPdbGWchjOAlgtBuo8Ks2t2d3MLgcbc1xZwfJSdq3YNdcCVTxBSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354670; c=relaxed/simple;
	bh=FHUm8JgjLCIAyUcbE9ObMrZ2uKu/jiL8r01fKXYzPAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=km7WFrXDIWNkkAP4cK3OkBO5uYDVL6WxpKXks7ZL7FYQpqNJDKGk74G/xwJh9SVPqAYboQ3ijRaVNNWs089+8/+ucFDjNf4KTeY84QolH6N8wlnKF0naxnlFDgJS0AGuN6blxWvN9Z1d4ZN8n+zdwjrWZcbmFAsTGSATE8eYXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MCM9U+EI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MCM9U+EI"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9hsgo001528
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 10:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	frgttlq1wUpHfs85c6sOB8oFTBM5O4TFBHJ8W4S/2Zg=; b=MCM9U+EIRXdUhkkj
	RnaQHyphmlwj8ufux4uRqT1CeeRyh4WJeQyMhFCoM7HUZE8B54OyMur9MQ7pLAHK
	q7Q1KVrS7BFGTDMUnHwdUrmlCjNOXtf0Rp/Gdwturu54n0TsR+qJU3AtKnFv2WhV
	Ajeq9g9mm1HxhnKm5PMSdv09h5GF5GTeKQLa+UREcjMI+vHbBSZEp5ZsQOJYdrBc
	29cuk/jHFBZqdsYWQeB8ET0R6F2HpIBhXtEQ0eTVFTrqxXZJKuhGlQ4XUWQjybWw
	SQmEEyV1+dpeOxXC5puV3gSzpq8fRjewj3wouaPKzcYBH4zMbbbQ82M9zd+81FQV
	uLJMxQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1uf17s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 10:57:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6fabbaa1937so2435306d6.0
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 03:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354666; x=1753959466;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frgttlq1wUpHfs85c6sOB8oFTBM5O4TFBHJ8W4S/2Zg=;
        b=IG8NEKasg2ImNOEOcJFIOUYsrGRuLnukTBtHWFUTBhoZ+aUnYCmmdSReKP1CM4Bvlp
         mx+jORvplupAxVRhZkrHRBwoetI5RRHo2lSt3ezZdnep34dRxlpfwFcGvuRbU5l7wuLk
         /G5lm7WBsJP8PgBKn8Dr5F5W7N43S31C1sy3oVcwjK0xSG00nYgzSh347BexATCx6xNn
         97rH+xiB/bAX8OjraZGxQhAvEpk76tk7ezfglDQZuer8ceN5WFKlWsozKZAdBOG0CZzB
         eAY/+l1T53wVj2kY4CfM3UanoBKlj1CYS1Z9Q8X7ZJnvpJf0teKdw334u3pjrnKN1OZM
         PO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqhKCJWbT8CRhnfd7HNeqop2BXlsNw0YDOTjTUf9x4lKDkue06+o8nhnFKYpM3YuYs4VKcU0gdl+y+UmD+A0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5s+1RLG5GwrRkVvA62Vie28Dl9zVHUywvoVxcqldSgEPlfDUH
	hxZ7QbSVjc5XevUPsakWa3R3ug2I/frCxcs52UN/Z24knZVMWYtF8AguFi/aTI4sEVEj2caQMUe
	0M1sBWdeActe96Xk5Am1CjJ/MiUw9+VVVmz5gX2+clfMiU448SN3nc0ZCuxVwM52cGmUN2l0=
X-Gm-Gg: ASbGnctzdvMaZr4xLXC68hwtnL7px3QU/fNoIv3LqFBfGIYy+jNaaGhyPfRor5Ufjxq
	Nq/HXn3e90HWQted/alqNRu0IEfCC1PJJKFZxOn4XcpR1yzg5PFFLJJwppEFZgn46GxrlpEHnl/
	MYFz9wuap65PNJpz2afZ32RO9MsHcPI6RdIB1Zrcb7JTOhjc4V2R0t+CC7JoFiF+18HOa8B1z2j
	5AredFEiET5QE1D+8RWsDiogLiYH/NKIa1RKDeLUDBDFC7z6k5uFLo7f/hK9IBqOHVbHBWLuK/6
	45owJiGME8MNA79ovI0aK4bE8UlAfYBFg1BgnEaq2MFakMPD4INZLCkf12TpnKsg8VXjVBXwSTy
	PHgmkNcH6PkcPBpAP1g==
X-Received: by 2002:a05:6214:1d2f:b0:702:d3c5:2bf1 with SMTP id 6a1803df08f44-70700537849mr43874576d6.3.1753354666033;
        Thu, 24 Jul 2025 03:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOPUGD8doV9+jglxqU2GB0DYEWEF7aTYg/TWGqOaOfQBWULvPms9oF3r1fFWzU0hBkNoKlEg==
X-Received: by 2002:a05:6214:1d2f:b0:702:d3c5:2bf1 with SMTP id 6a1803df08f44-70700537849mr43874396d6.3.1753354665532;
        Thu, 24 Jul 2025 03:57:45 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6e753sm95191866b.50.2025.07.24.03.57.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 03:57:44 -0700 (PDT)
Message-ID: <bbb07270-cf7d-4fc6-9a74-334fcaf00f05@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 12:57:39 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/15] pinctrl: qcom: use generic pin function helpers
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexey Klimov <alexey.klimov@linaro.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP S32 Linux Team <s32@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang
 <haojian.zhuang@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        imx@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
 <20250724-pinctrl-gpio-pinfuncs-v3-11-af4db9302de4@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250724-pinctrl-gpio-pinfuncs-v3-11-af4db9302de4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=688211ab cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=jpok1_DMC_Ne8w05vhoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA4MiBTYWx0ZWRfX1DcAUGC2q4gn
 z9jtr/Z5HmjEtR+euIK+LyeAEXMBxrmY8DAcR1J6eRcsk9pEoV9jbRvXtVO5/w9meCEXmfLKKwV
 acMgA6oQ+SSJILjlqi2kYGQ8Sr9OFJMwSIQmJjABeYQ4I37QD4CU7onNSpuFwa3NIA2G8OAKukl
 Qn6RzuMY83zRMY3HLltPFDbS4DvO6VDubRqRwQSc/yOQWB9+wDhMXkpOJfoI/9j0byssouU8+/h
 gDyNbBHvhfkY/OYzwDkoyqZH1frxf4xHIBI0ntf+lU220UA1hOc3yht2QiLl34MWP0t9iy7tAOy
 oLCCrsQ+v9fVFHR8oqIWNXdB/8y5l59Mn0fa2fl2epcgY4S3MRwZyRX2JD3aymNG/6jdWVaMz2x
 4ocpLVTeqgo/fUQQBh5xvVhkH0U5mm33jUwFbVbZ+o2VdRa/9mpa4hyIaEWf5BIsKGqji+TT
X-Proofpoint-ORIG-GUID: 0C--WdN5jv2SzAsHUAzEsO-ZumiP3yj2
X-Proofpoint-GUID: 0C--WdN5jv2SzAsHUAzEsO-ZumiP3yj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=453 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240082

On 7/24/25 11:24 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> With the pinmux core no longer duplicating memory used to store the
> struct pinfunction objects in .rodata, we can now use the existing
> infrastructure for storing and looking up pin functions in qualcomm
> drivers. Remove hand-crafted callbacks.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
