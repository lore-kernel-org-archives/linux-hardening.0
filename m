Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ED33C5DDB
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354812; cv=none; b=c/cgteWUhDQsQ9uLSsLYgpBEmXyh6QLxPcFeOYwJVMfV2Wz01eVopO8Abt4z9MwbLvdzjNUsi46zWqJicsBSZVfFwNzdbeKM9ULWrY++O2Fac8fbhg5gN3rQS6gHAOYQv2R4XNBNnZccS4IgO2h/Up2jOlKhvOKuMx8erwX34KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354812; c=relaxed/simple;
	bh=XwCqQYzPO6KrgWsbPSkf7QsVyNBDZ2WApQ1+GZGiDgE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NHgi70FZLIkAAHjba8hhAqsRrVDorW2PQGtkcAC8nvJy2yQz3zwPX6XqYB2kGpwtg65Mmus91q0HRwwiSDTIgk4V5zMiVeWDYCEo/UdgCcBB8PeDWZ4LBjfcJjJkBqRf2OMOqEQONh8X774Pa7jaya9CaIb3BRRjpAcjH0MXu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLvYPWmz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DJsCbeDl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLvYPWmz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DJsCbeDl"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TIR9kD2831320
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 19:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2tRAYmLteH+nt03LQJDdoe0tABkEsYJ81pf4iLuC0y0=; b=OLvYPWmzEYluUP+u
	23W8iCkhB9zxefi1Is7teD1I0dJhXfuwy48rAr19I5gnGZLwsoAwF7NN7uulqs1p
	9+nShoNt9pP8JvuLJuL77gLxS3c61CXca8s83/HmG1HkJfpbsyhmY1x4EI2ASUDd
	nL3iyIkliTQJ4Ee1+Q+lHKqfprFeytqAx1WgY6IkNMEOAKt2mCtnmtdsdDXr3H2B
	P7aSjEHWs4+shKIDRBO4OSoPgdlfQxp+dAbXrBFq20g9WWpPZIG+3hMP/4kgK4DF
	tLQmyAhaOcjSe2kusarP3cxJcnnGR/UrMhxEerCoWep7zs0qnee6iW2NMo7e4Mkk
	6kNHcg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqhe9aare-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 19:53:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51ebdfceddcso16010201cf.3
        for <linux-hardening@vger.kernel.org>; Wed, 29 Jul 2026 12:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785354807; x=1785959607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2tRAYmLteH+nt03LQJDdoe0tABkEsYJ81pf4iLuC0y0=;
        b=DJsCbeDlqAlqqaj0njwX1d1TZFu27otbPoCLQYWjJrw/KIZ7jtfeUWCkSxFJp/8rpI
         jTxSzPzbKDuFYeaplfmSs8rowJmm21pferV0tEexarbFJGHif7G27w1dqUc5qJ3JUkq5
         zSXWNYV86vy3uIXHS/N8b0ZeCCozRYmLh0TK5KEAwssQTQGSFcak18D9WmlnYJyNrz9x
         705MKUvMIMmhGNQRdkUO4gD5yD+RliKSWn34XQlYJvx+enWSh7xgCWHzGCv9CfkFEUzA
         O26uHymYxGhAjuC6UPoZOEnMkR4WBuxWTAJdC4XpANbW6W9jouFJx6v6PnW7Y8DaEVrZ
         JWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354807; x=1785959607;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2tRAYmLteH+nt03LQJDdoe0tABkEsYJ81pf4iLuC0y0=;
        b=iL5Zu9l4VuVGnQod2o69RDZCCfPdr7pQ0g5vQz6+yCVIqoVmmRgijcKKhia0L+nipJ
         QO+NOFQfgZPpFnaGQm1K2MZzq8z+vR2RlnKCCh4J7FZ9lxaidPZ3fA4OZtY3W2D7cLLg
         QPePQbDEFe0fMPX7Zh13ZJUGh74YUb/z7OARbmdJRMaGytvl7CUxKsbKEFk8zfrxw8UE
         wEITkW/pKuzdU+kzQJLKJgzaWF62Y1j+dZfhnuy+CXjYoaC6efl5g16CaGd3MEufrwzz
         149qEhXA3YrgaPdkbWHXuQ7p1AajDvAfGTERko5NnS1a+0fHzEsSrdFIJsV75ywygai5
         hy4g==
X-Forwarded-Encrypted: i=1; AHgh+Rr1/Dr3jiKpABQzYLuucK+6RB86EHeUigtXmwYTob09M0J7idfp3i/VxaTrq5/9OZwfBCCRLdJPjgbEAPRcLfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhaiHPvqD6esXXERIHMm3e9O0nD1HBs8Cz9wLShwzpzv8ksCYx
	/WKO+baahZR6YrxHuQK3vCEbVdinQE0HRviY7BgrWaJEAH7WuDSjwYAPszvwX9pvuuNsWIQnYhP
	d+qRzDkA4w9pqea/zeFxDVPbeVZGTStpqMLE8ps7L/el2pOpTOb+p3UdHBeaCtp5JqoXVS7I=
X-Gm-Gg: AR+sD13llJmnFnczi5GCPop+uc29+Cp7u2rKa/7YRtMc4rd/JasHuAo+DFKkjaHh+LD
	yJ5EANhpGPse+TLeGuO7QXuo+9iMs/tCcHFpEzGRK5IwnX3eesn3Gd8M2VCs8hNVAe135yVtPVI
	Ms8AGgOJciOB1QXWU4XQ5BqUFs8uoWnKWUiBl+zj2poNg2LXC3lTZYAlG2M5rCG4bCiAnNPTYUv
	9n9WYBxbZZOxKpJH28PWChp2bWiYL/GC/GNeEjKggSpwyIyvWkAJS4bvhgdKf3ykuRUGZHWCooJ
	LAa1Chs9RxFI2/LNDYbPID1Nhlphz6Rp4hkE8hkNY4A9qBhbR7tzyvY4zCeQatkKQGrRcpzHXPt
	OrghZQz8M/pvUr+4LDySkr/aZL2XXHB7GYc9jDstzIyFujNOrtudOGfYpebpyA+VKtn1eIRyc
X-Received: by 2002:a05:622a:2c3:b0:51f:636c:8eae with SMTP id d75a77b69052e-52b37f50591mr103801cf.14.1785354806890;
        Wed, 29 Jul 2026 12:53:26 -0700 (PDT)
X-Received: by 2002:a05:622a:2c3:b0:51f:636c:8eae with SMTP id d75a77b69052e-52b37f50591mr103381cf.14.1785354806190;
        Wed, 29 Jul 2026 12:53:26 -0700 (PDT)
Received: from [192.168.1.31] ([85.196.172.179])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cea5f8sm149219666b.24.2026.07.29.12.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 12:53:25 -0700 (PDT)
Message-ID: <2c81c1b3-59fb-4ae0-bc2e-457b585e0732@oss.qualcomm.com>
Date: Wed, 29 Jul 2026 22:53:21 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Gjorgji Rosikopulos (Consultant)"
 <gjorgji.rosikopulos@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/5] media: qcom: camss: Add CAMSS Offline Processing
 Engine driver
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        devicetree@vger.kernel.org,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
References: <20260724-camss-isp-ope-v5-0-e70ad4fa39ce@oss.qualcomm.com>
 <20260724-camss-isp-ope-v5-4-e70ad4fa39ce@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260724-camss-isp-ope-v5-4-e70ad4fa39ce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfX8XW6X02y+85D
 pNxzezdZ966oUe0FelYkwXwMsjx4Wyig6RfNP5XHAxtS5bb1TgOKcwfp2YdZw6tPOCyQlv4stPF
 wVK73yPz6HH2wyUzZzI1/Hx1M0PpAKLb6QZ9IJPdTLFelpakM5pYVP5n1d2luSio73vVaCcQ+Sl
 utjT++jBoQk+TW/HGCiGD6OMihrvpQsrsl6beTXy/rRhZCrpyD0MRX9KzotZTZfceQa3jKCOsKO
 MiLMwfnVtLdKRbFX81IBw1BoiPxa7G6PFi7eaUmqvKu+PlaYJpx12+Eei4L/Uo3TutmVgJ/Qy69
 3XNIfQ8by0imRrUIfP/6AZpj8ZsUH4cJ6Myy1zYn76srGHHlNEjhXTiKdER6qlzel2aZ3rKSRDs
 fJZ50iKUTziCDHBW8pnqJRiJNcjDbUnlstMQuxgYW51vHWAdNo0RBqZfhY8IkbEoiafb+Qn4wup
 Xz30cijm6jlJAAbEp2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE1MiBTYWx0ZWRfXzyyKGFrhbE98
 SO7sHB8bWPhIBRvZdQajDLHNY5scsbVhv8XPFcrF/bfryqZdRCdWr9DpV4eWK+zjmEG52nsJDn5
 wMYxnnuJQcWQYU7YxYA89MPDiUutOq4=
X-Proofpoint-ORIG-GUID: kHURWmWD7lpocBaSndEbqq0q0rWBOKRd
X-Proofpoint-GUID: kHURWmWD7lpocBaSndEbqq0q0rWBOKRd
X-Authority-Analysis: v=2.4 cv=EsriaycA c=1 sm=1 tr=0 ts=6a6a5a38 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=Q/e3f29T3Hw2hnAEzBPF7w==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=GmEpBn3bsQWiDvAV-tYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290152

Hi Loic,

On 7/24/2026 3:42 PM, Loic Poulain wrote:
> Add an image processing driver for the Qualcomm Offline Processing Engine
> (OPE). OPE is a memory-to-memory ISP block that converts raw Bayer
> frames to YUV, performing white balance, demosaic, chroma enhancement,
> color correction and downscaling.
> 
> The hardware architecture consists of Fetch Engines and Write Engines,
> connected through intermediate pipeline modules for pix processing.
> 
> The driver exposes three video nodes per pipeline instance:
>   - ope_input: Bayer RAW input (V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
>   - ope_disp_output: YUV output     (V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
>   - ope_params: ISP parameters (V4L2_BUF_TYPE_META_OUTPUT)
> 
> Hardware features:
>   - Stripe-based processing (up to 336 pixels wide per stripe)
>   - White balance (CLC_WB)
>   - Demosaic / Bayer-to-RGB (CLC_DEMO)
>   - RGB-to-YUV conversion (CLC_CHROMA_ENHAN)
>   - Color correction matrix (CLC_CC)
>   - MN downscaler for chroma and luma planes
> 
> Default configuration values are based on public standards such as BT.601.
> 
> Processing Model:
> OPE processes frames in stripes of up to 336 pixels. Therefore, frames
> must be split into stripes for processing. Each stripe is configured after
> the previous one has been acquired (double buffered registers). To minimize
> inter-stripe latency, stripe configurations are generated ahead of time.
> 
> The driver is split into three source files under the ope/ directory:
> 
>   - core.c: the OPE m2m driver itself: probe, power management, V4L2/media
>     device setup, format handling, stripe generation and hardware
>     programming.
> 
>   - pipeline.c/.h: a small declarative media-controller topology builder.
>     Drivers describe their entire media graph, entities (video devices,
>     subdevs, or base entities), their pads, and the links between them, in
>     a static descriptor table. The builder validates the table, allocates
>     and registers all entities, and creates all MC pad links. It is kept
>     generic but currently only used by OPE.
> 
>   - params.c/.h: V4L2 ISP parameter buffer validation and dispatch. It
>     wraps the extensible V4L2 ISP parameters buffer format, validating
>     the buffer size and each per-block header before forwarding every
>     block to its driver-supplied handler.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Co-developed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/camss/Kconfig        |    2 +
>  drivers/media/platform/qcom/camss/Makefile       |    2 +
>  drivers/media/platform/qcom/camss/ope/Kconfig    |   16 +
>  drivers/media/platform/qcom/camss/ope/Makefile   |    9 +
>  drivers/media/platform/qcom/camss/ope/core.c     | 3353 ++++++++++++++++++++++
>  drivers/media/platform/qcom/camss/ope/params.c   |   75 +
>  drivers/media/platform/qcom/camss/ope/params.h   |   62 +
>  drivers/media/platform/qcom/camss/ope/pipeline.c |  399 +++
>  drivers/media/platform/qcom/camss/ope/pipeline.h |  237 ++
>  9 files changed, 4155 insertions(+)
> 

<snip>

> +static int ope_open(struct file *file)
> +{
> +	struct video_device *vdev = video_devdata(file);
> +	struct ope_dev *ope = container_of(vdev->v4l2_dev, struct ope_dev, v4l2_dev);
> +	struct ope_ctx *ctx;
> +	struct v4l2_fh *fh;
> +	int ret = 0;
> +
> +	fh = kzalloc(sizeof(*fh), GFP_KERNEL);
> +	if (!fh)
> +		return -ENOMEM;
> +
> +	if (mutex_lock_interruptible(&ope->mutex)) {
> +		kfree(fh);
> +		return -ERESTARTSYS;
> +	}
> +
> +	/*
> +	 * For now, only a single shared context is supported,
> +	 * until media multi-context support is available.
> +	 */
> +	if (!ope->shared_ctx) {
> +		ctx = ope_ctx_create(ope);
> +		if (IS_ERR(ctx)) {
> +			ret = PTR_ERR(ctx);
> +			goto unlock;
> +		}
> +	} else {
> +		ctx = ope->shared_ctx;
> +	}

I am sure there were multiple discussions on how to implement multi-context. But this exact implementation somehow confuses me (maybe just me).

This allows opening the same video node twice (e.g. the output node). vb2_is_busy protection is present everywhere to prevent races,
but if two applications open the same video node the driver may end up in a situation where the format set by the first application is overridden
by the second, but streaming somehow gets started on the first with the wrong format. The danger is not at the format-set call itself but at start_streaming, 
when the hardware gets programmed with whatever format is current in the shared context.

Maybe it makes sense to have a tiny wrapper on each OPE V4L2 video device that holds an open count and prevents opening the same video node twice,
returning -EBUSY on a second open(), until multi-context support is available as mentioned here.

Regards,
~Gjorgji


