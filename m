Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AD37D103
	for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327056; cv=none; b=d+DsX8GZaJPLni5d2a2QH0jSva2Wjtpe6VY/LTDIjEOjHtJSt6OSlgWeABZUg9l7QtRW3sRHVIqkV7fwm9vWkPdCwxUdnaajBWNe/IGAWsZDzc/Zh/l3DXp5neOxJEPvvwIUnMNXUk+O+dtLcOH49DwwqJoIp0FcSsoQCBGZssQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327056; c=relaxed/simple;
	bh=OFgtGCn1mfUaoCP8LhdAyM8uQwb3Te8gLBE/Ti+VRMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6ZDWjg1reI9mXyEtZEYPnxsR+7IcGJaQqqQtZxsNmSfAvnECfyZgOg5fCdbnA+/NcnLhbiguZLoY6MQa6ODWVyhMyag/KFfTdjPxIB8aa7WO/zfBiDm44F8d6RKP469kyKwrCftTmX9ZRSQcOgpG0/DeUVuBja3CDRVSMmN4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sMyQxbao; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMyQxbao"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso91794005e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 27 Apr 2026 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777327053; x=1777931853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kV+WIZsj9AmJtT9rTaHxlweLR0VMyPyAnS2ki5QOUJg=;
        b=sMyQxbaoFGJX/irParUdWhOOocCeUXvxFueNP6tsUkKMDA09z0L27fpY339j5ZCWOJ
         eVzCjDzD7vnD2t2iCuSoLzQnv8USvbSt3L5MxtOEvVMMsKRrHEN7CIJ7Ulxt3yKHD9rU
         ztw18e5W+kSqQHS/HYUdoXTEBfEYL5cNNw50k/MGVAFE2645Bh6ZHm8MLFtuOZPFXKs2
         K8cp10m4Ix5aYnNASAg3qCMpay1gY4706zIWd6QX752KDNbqy1i0ZvFqGRtaPrll93QD
         gr9BHek6wJpEQzL+mHVhiOaVsUl6npQ8cQJpWbOeGOtPrZG87br/DgVk19I4KrDSDGtY
         eTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327053; x=1777931853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kV+WIZsj9AmJtT9rTaHxlweLR0VMyPyAnS2ki5QOUJg=;
        b=SO/XwDLZZu172R4+ZmBtZMVcw8dpFQrOImCMnyUe+H+Ci/fdb5HnqeSEaJ8zgpBCgM
         R23YvgGpWAESgkCQviAsi2nEVOmsPUruRdh3m97GgMbi5k+dvIkT43dkvkAr3WUtm+3T
         4D6YTCzzrVQlitUxph/Zt7xp6lB9bntmqlxWQUkZLE3g9o9OHEptpUQbMfKpuUjPS4Gp
         T6o2UdKx0CKuGoR+zxVrtqzFopukNAOJ9j/5swquvWUsJFVeaaelo6DexWalfYow7LQT
         kYJBoCoXNm5jBuO7LdWRjXgrV5fxXYQImBlg7yZCT4RS2KJg5bGyMcFKeIWM27YzIwpK
         mguQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1tVKMJ48QBgxeI4WzIAaErOYEDxHTdrI0RTQ6GlRoJKtR+nEt2NknrQLiT6Wz7VcpTu7+eXOnru+74604qjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8E8ayENsqHJe15sCGKVuOGpkpmP13F3PrLG08ExutTgQjyet
	PTfnKcBJAhnKv8+pUGjs1NJta7oax3HmPOp3DmOCPhKRJyirPiqiX2dwrrJYNr5JAAY=
X-Gm-Gg: AeBDietP3z+G+YMfRAEqtiFBheB1yIkatLqhhU7rIiHo5/ppmURYeGVzQfthv8PkgUG
	j/YDCxnZ9pj28+YQzts1QO6Ag4fIyc1/GO3IH4juoagRymyqcrwO3UJsHTYPTePs3156UMvvQmC
	wx8EqPZxl6P9Lfcp4oHUuTujK6BCsiIA+YAPDxlDHUdBovlJ5BTBrDePPq395FrbxBJaU4OWWIR
	sobXpv/5LXZxA4r6pwm63NStYdiShewR7jgY6CCxb4mqpKJneFABMfzIWhRdwC7tsZYv1nAXtI1
	Udh9jAQoY+6j+zQBKgTlexsqAq0t7/7e6Qihzj4+S0D/SDr2QVtmZ7ZClXzyRVo8Xr08jFAwzAB
	0J8bPjhjLpDkzwjpCPWYVsTvV1T/AQk5q6T6BnhiNpjhY0NmDf7MGNRECNPQiPnRqM7jQrV4Bus
	mQMuOmd6XaBM5EHZAMrfPq1f0pzzX1oPHpq81uuBx84RjGs6nTAw+nCA==
X-Received: by 2002:a05:600c:4f0b:b0:48a:55d8:7882 with SMTP id 5b1f17b1804b1-48a77ae6477mr5384895e9.9.1777327052826;
        Mon, 27 Apr 2026 14:57:32 -0700 (PDT)
Received: from [10.156.67.45] ([89.101.53.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77609a82sm3993585e9.36.2026.04.27.14.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:57:32 -0700 (PDT)
Message-ID: <1b914585-4c27-4f4d-8264-181340c27791@linaro.org>
Date: Mon, 27 Apr 2026 22:57:26 +0100
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
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 kieran.bingham@ideasonboard.com
References: <20260427-camss-isp-ope-v2-0-f430e7485009@oss.qualcomm.com>
 <20260427-camss-isp-ope-v2-12-f430e7485009@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20260427-camss-isp-ope-v2-12-f430e7485009@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2026 13:43, Loic Poulain wrote:
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

So I published a comprehensive list of these structures a few days ago.

https://lore.kernel.org/linux-media/20260426000418.1158716-1-bryan.odonoghue@linaro.org/T/#u

See:

struct camss_params_wb_gain - White balance gains and offsets

The ICP/HFI structures - at least for the stats I believe are how 
hardware writes data to memory.

OTOH on the way in, the params ought to be pretty uniform as again 
HFI/ICP needs to take that representation and either

- Hand it over to CDM or
- Pass it over HFI so that ICP can hand it over to CDM

The ordering and precision is a resolved thing. I'm ~ sure OPE must 
write and consume in the same format.

---
bod
