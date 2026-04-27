Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93E3BC673
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294571; cv=none; b=EeKx9V6oBiu7wK0owewpeSUQ7Wfg0UzN/MvlYQNrl44bY3b9wd/S4Vz1S4dmS1SMmlYI/qEeRu1FUyZwwT9x9tYm31EurVLDVvG3+/RJ1uCzjG7t8+rsE0+LnUdB2qEKGXYGF34NW1WvcUR5JpHz6SUjtJ4xQVEgueZ0pcteL3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294571; c=relaxed/simple;
	bh=vszQpynj8bogXIjt53OMrmpaaC7oK9NQMvMAHad9rc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfBtnE2k4VCQNFNKtU6ygZ5fSrDVoAs5Nj4JEjVE/hhD9lZknQ7mub6QYhje7D2ZKsza0Ljuz6IMTeY4WEnSuwvQ9FbH06eBPI8cxnoC/IsaqdOoXLNuyJgvVrK0g4p9fLMvLdpSvwGX5M/e3him1yUeVtw/gcg8VqYzixKVmfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QDr3RaOW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PkL/dX6Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QDr3RaOW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PkL/dX6Q"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8T7jo3639521
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BV7iu4QdBUebS566h1y5fdtOV7ddcUCBmPDbhAJ2XCE=; b=QDr3RaOWeS85NudY
	Qh/kAK98ECAgglsTiJLz2YSus1Yo7Mdi9jaHyfBxB/gzMAeE3ufVpgzS/8zv0pwQ
	PTkLGzQtA5aP5D+OOD4ZS53OrGdIjxznBVbEmrQ+DyEW/tkajLrLS35xhnaX6hbe
	tYAyFjGHREEL8AFj1v5W5Bp3Aon6xFRQEnHcpYHMC5jxrjZA+Rv2ZoKREOq0dC+F
	wK3ZE4kKelOT+GVAHL0BtEJYUc9KwvjSKWRvUoxA8MvmtNbkIJpwPKW/G/UwTOFd
	cO/OL8m5p5UYmNcAA9J+IDGtCOJbk8rW/P/3jTUCBJYWqZ/rKO6iuINYmxCVq+dx
	ZOCixg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dsya023xp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 12:56:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e62562b6aso15481141cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777294567; x=1777899367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BV7iu4QdBUebS566h1y5fdtOV7ddcUCBmPDbhAJ2XCE=;
        b=PkL/dX6Q+i4fZlZtnoZ6LigofsobTgWJJrEf1Z0e6h6Ld5vNKeugX40GJabSxotRME
         7SCbzWMoQgVAsmWxIdBmi6rODfrfigPgMXjt6s+6tXxZ7Ay+VxJOqgzY+X0daA9bFD+l
         smQXCXcH+FCmJHNW5ZJmmo1sUcreTjwwSvI4lN/kc5TFTeyhMH7z4w8XISIYjzz5+dHA
         9W9BSELVC6TlrPXZobMfmyaTKiptctkeC9We1aqUI7x/drwkv5A82x8KMoeLxwWTcUSO
         cRDy5AzL66XWDK8+679vMqRHAh9JsK6e+QowKRqiRXFU35A5sqTQtdNh8WnvwqvuPjMC
         WJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294567; x=1777899367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BV7iu4QdBUebS566h1y5fdtOV7ddcUCBmPDbhAJ2XCE=;
        b=CI3zCFV7Vreh2nXyH6scXUuXMOalOgbvyYtbTNwYICp/nUt4jEfHbgtP1MBFXNu307
         uFs/RCBqRHzavX1pOaVyiBh+zZedHD/J42aGXlzl5p77WHqY1Uv6Psbeav9768UnVnj7
         LOg8NmOaB3GAI++sZfALqpnRcHdy5roOT+AYv7KY3iqKqCRMyj++wLFxWi++3zzZun3r
         ksBHWKljTpH93v2j2nvvuFN53FvfcPF15imeSa3Yfhx/R9LIkRheC3wfi2MQDQYeanm4
         NQB+/zK5zDzPnEk33t8TTEk21tqCjxAmB/0kc2xmPWepDEWN0lxAe2WzhR3gCgUKZFLN
         vxAw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZpQsrQMzWO1PjoX5ZWnkFWZCPnprb8Tz33nEI93zAbZgo05Nq9AE65dPJF2NiWfcwKboOco6fH5f1X4feEHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vZUAa4MJTOygu/6+eyWqkhxGha/5fTn7CoLcnSAknVqoOesV
	RBiJsO90WcEuUC06yJFhN4Cg3+96LSapjrpCjX5DgNW5CBrKDpNCSVdxhf44PHYtnH4OAIB8GV+
	IdXDX5kZc6agD/7IqqktE8WpxOqne1ZvLBcUzM6NWtYcvRweG8+hyo2sW/ag24Kk/MbaED7U=
X-Gm-Gg: AeBDieuHw180Tk7okX3axOV5a+yk3vpPdvQYDbnISLQA7U53jt5qNGb4kaFZqmm4ue2
	e51kmYRVkAzClnOPC+Rl5q8XbFngJNehJBgAILWDv+5CPeSlkqRXptaOQ/YLutBaJ09C8r9GoLf
	lP5Vdsmc136KjO9hnHxC9F8UdLQpGBvtYl8h9VJV0qWZe6Gm3DjWgeprM/OYKU6XilFhH8KhIgt
	PkTOIw2mmgTbL4NP2jVfvEzWiCjEMukNZuhpjMUDPv5bLZ3VTZdIK/sJmh/Bihv554EwqCFNPUE
	SP61pYy/mXMZrjwmkWaVlhykyWx91p9Oehvv/k0iOO1VmlSA4i0pWJRlOvmJWa9IvVkNmXVq4Q4
	nqJlnqniJPuX22uZXojHVix7yNJ/J+AzSF0Q3wXVYUCE2oOrzYJOdh7K9VUWo+AOnnb/nC7t4Zn
	qfif1iTr/FmfNhxQ==
X-Received: by 2002:a05:622a:1918:b0:50f:a53b:9cf with SMTP id d75a77b69052e-50fa53b0c53mr284503631cf.1.1777294567174;
        Mon, 27 Apr 2026 05:56:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1918:b0:50f:a53b:9cf with SMTP id d75a77b69052e-50fa53b0c53mr284503401cf.1.1777294566746;
        Mon, 27 Apr 2026 05:56:06 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c47fe874sm6386349a12.6.2026.04.27.05.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 05:56:04 -0700 (PDT)
Message-ID: <3e72d17c-e46c-42d3-9b17-54627f6e5e28@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:56:00 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] media: uapi: Add CAMSS ISP configuration
 definition
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
        kieran.bingham@ideasonboard.com
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-12-f430e7485009@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260427-camss-isp-ope-v2-12-f430e7485009@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oEWeNRLp0GsfwtMOndOCeCdDnIMQ0m_y
X-Proofpoint-ORIG-GUID: oEWeNRLp0GsfwtMOndOCeCdDnIMQ0m_y
X-Authority-Analysis: v=2.4 cv=DZEnbPtW c=1 sm=1 tr=0 ts=69ef5ce7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KpaCYs1BneEYRrX5G8AA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEzNyBTYWx0ZWRfX/0mpnJmXRuNu
 X5sVMrxWzKOe7Qabg3UtTKUNHikeenwafqzNmNs3hYIZpm/EAYeCKQ8vzAuU1LiUoBKk3PDDXgq
 u3qJT2wWe/hlTxnXLqd00QPcZs7t1qaQO36rPrTRD3JMv9S3Z9SfB6xqDjz38NvgurKYWoH7VYq
 04wQakZjg0FWvJlURhVX87fe0wjvy9qdy+3HbY5eT/qrnRIR0z9tgACdodcTv5qR5ypM9JyWO6f
 jCPtHSkxkK+I/masAEEiP3hIrtg6h2IXQBo3PyjSK0QsGvQjOz7eZlt5YfU8IvlNLMmwFWGv/JV
 UMtAbISeraF4jyWzeCubAEowN8p2WTPW34rFu1bvFijP89fyBbGElU1qNPo5NgaTytdOvNQmxY+
 mN+lVKirXohOOOe5+tnyecz96VD80kdM3UTE7rPZ3cgES3WfYUilgT0C9vxU5qoY2XBFOH2QOlX
 qsHtskChlIKLSB2V7Hw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270137

On 4/27/26 2:43 PM, Loic Poulain wrote:
> Add the uapi header camss-config.h defining the ISP parameter
> structures used by the CAMSS Offline Processing Engine (OPE) driver.
> This includes structures for white balance, chroma enhancement and
> color correction configuration.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

[...]


> +/**
> + * struct camss_params_wb_gain - White Balance gains
> + *
> + * @header:   generic block header; @header.type = CAMSS_PARAMS_WB_GAIN
> + * @g_gain:   green channel gain (15uQ10)
> + * @b_gain:   blue channel gain (15uQ10)
> + * @r_gain:   red channel gain (15uQ10)
> + */
> +struct camss_params_wb_gain {
> +	struct v4l2_isp_params_block_header header;
> +	__u16 g_gain;
> +	__u16 b_gain;
> +	__u16 r_gain;
> +	__u16 _pad;
> +} __attribute__((aligned(8)));

Should this be __le for all of the related types?

Konrad
