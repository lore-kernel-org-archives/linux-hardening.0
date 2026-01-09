Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B632F1FEC
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946870; cv=none; b=sMivoHTKLSHMrHpZCOeFnE+z5rrVwbW+pS3J2+5SKsZn9ZZQsn6v+U7f6R1e1fbPYDml8zjKqinqrgm3neUPshKa44dH5OujuY/RgD8bjytd1G+8kRzqnwkhN7i7u98yYF7MCroGYVBoqdQv/km0Hm5Cwk56ZnIS9TLwqjE2dqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946870; c=relaxed/simple;
	bh=V+nTC5fnYyAOKAK26TFNavyMLrrdiUNFL/Z+gDdCvi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=obhFGs6/j7iBi7Bfu38/xPLquIcmk1BJgzbNNIstRc+XO0N4Vaz7xZQhtO79T9Zx14iMqpsvrM74fSofOsrq5HKBbUELsM0DtB+hxMzcyHWg5jLhDt4aBzvipEGJRLuGFQO7MOj3vxcaKHKzvUCY9YfpZ/ntmfm2HmYJmMejOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YJqv7fl4; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YJqv7fl4"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso42684205e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jan 2026 00:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767946861; x=1768551661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9uKMSt4+hDezkXTZIi9m3T1AtMKx1vNqIx/d02r4Ps=;
        b=YJqv7fl4paMm4GeTI/uJ+ymJmki0AAl6cVMa8BG6GO8arBlr4pxHKz4nlQKRcnmy/5
         QfLLQFq1UlBsUyzs7bEf6V+hZ6Vo6v1Q3pEz7Yk/aUzlnrpKoCAimtevT8MmaPvXpGsv
         MYCdi2FRErwHOLTD9BOFu812bh3WAIJbaVCuCYAQ6baTt4KDfup4SclQ6gXXuFKEw+7u
         LL6Sr8KmTIVudztdQgVVxfjRJpxrrD3E723Gi6+9PrPFgDnqjNHmQd+TIKj207y13Sm9
         TFrDWu+rm9vbdgfCT42P5UZj/KocJw64Arf4eYZ2NxuSVVSeSVLolAWkfNQGa1DOFo+t
         LXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767946861; x=1768551661;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9uKMSt4+hDezkXTZIi9m3T1AtMKx1vNqIx/d02r4Ps=;
        b=Icyn5y3p9AfRhYj3el4rqEB8+O7XkxQiiRibS5I2ZhIqLvqB/CY2gf90tylEp7P7Kv
         61D75viMbPSNWcK31tc1lUUSiCCo3vAVQHLqr+jD//Ylu6ecF1YN7uf+hrQGJseniGWK
         pIpNEejZa60WnGoG51vAD6OvstsS5NRQGQmsEGxNP/785DJ98RypcDaNTno+8YKD3Zkq
         +5Qiji3NdO8ENb0iVpzav+EgqkQcwHvNEGP7BssjDk1Kad6uvMs2a9Jauvzhhuk2l8le
         y8gvM/0G7ByDJO5Sq+0vyuUFZhUT+amncGYPBEg6iJy7uIFLnlQxXfSLahuXmUcYsBkd
         RrUA==
X-Forwarded-Encrypted: i=1; AJvYcCUVsUgiSR269riFH08TVi+y/PKfIdN5CsVUPJ0FtOFQ2+HRdNj9I1Y0bcqgW5EHWcIiiE4ZCNRCmHYZo+Q4Am4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIiNcFLu78XJXv8jmPw8RXpoJdVU1VwEUPRE5yhpM40oqEsPF
	+GQdIbGJqKCs2TXj3irazXTAnVZo3IXSMJcBFYfApeiPraD+lacl3h31yGq4X+TRoqY=
X-Gm-Gg: AY/fxX7SBzQRYb5KK6xIJZihXxeYR67H+tE/LaUIUqUkFYYIgiGMOHEk6u7hjsitQIx
	lCbOS4An+bH5hspPisXbtyvXrt8gEEJwl7BM/TmzclhSxKzk3fYPMQJZoISw/4l94gCeu9sJ0b6
	A4JmwyWXMx7nPwhr2WuYcsb2dw91xeqNnEK4oMbA803iIeI3bd+4FZZ+ro1th7cx5aO8ZnImByv
	o3j2KizUIrkd60vecS/B195TlOBjwnSVuz1j++d6HqNdkMnf6LuZJbq1t1h//hGGzyM38feSJxo
	STVdLZdjphgNJ+5+0W40tb33TE2WY3/zkU+KWjbf9cEcPZHoVYaO0/X9JFtUEwptB2BdhPjLxXL
	IS6WYH4BNi9npcq6zS8XYWezKadc95OiudV0k0IfJG68bVGnqmyl9o7MbyQXBJ8oUdlHvryc8Pf
	Kb7I0JtMmOFfmtwW5XW9OYOeh2dmbEH71QmGnl2RXstgnRsF4lKdh33kpaPH4FogM=
X-Google-Smtp-Source: AGHT+IH0OJfkjAgMzQqRakprSyrN6tCPxBuCGvpfdT55BzOyLssSQCuBpAQ8A1Mu0tIEefB/dW4VNw==
X-Received: by 2002:a05:600c:8b43:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-47d84b33b7bmr99212625e9.21.1767946860895;
        Fri, 09 Jan 2026 00:21:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d? ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86c6ff40sm123761785e9.2.2026.01.09.00.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 00:21:00 -0800 (PST)
Message-ID: <6ef89318-5fa4-47f5-8027-04a91656d81e@linaro.org>
Date: Fri, 9 Jan 2026 09:20:59 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/3] Retrieve information about DDR from SMEM
To: Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260108-topic-smem_dramc-v3-0-6b64df58a017@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 1/8/26 15:21, Konrad Dybcio wrote:
> SMEM allows the OS to retrieve information about the DDR memory.
> Among that information, is a semi-magic value called 'HBB', or Highest
> Bank address Bit, which multimedia drivers (for hardware like Adreno
> and MDSS) must retrieve in order to program the IP blocks correctly.
> 
> This series introduces an API to retrieve that value, uses it in the
> aforementioned programming sequences and exposes available DDR
> frequencies in debugfs (to e.g. pass to aoss_qmp debugfs). More
> information can be exposed in the future, as needed.
> 
> Patch 3 should really be merged after 1&2


While trying it, I got the following warning:

In function ‘smem_dram_parse_v3_data’,
     inlined from ‘smem_dram_parse’ at drivers/soc/qcom/smem_dramc.c:380:3:
drivers/soc/qcom/smem_dramc.c:216:31: warning: iteration 13 invokes undefined behavior [-Waggressive-loop-optimizations]
   216 |                 if (freq_entry->freq_khz && freq_entry->enabled)
       |                     ~~~~~~~~~~^~~~~~~~~~
drivers/soc/qcom/smem_dramc.c:213:27: note: within this loop
   213 |         for (int i = 0; i < num_freq_entries; i++) {
       |                         ~~^~~~~~~~~~~~~~~~~~

Neil

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
> Changes in v3:
> - Support v6 and v7 DDRInfo (v7 is used on e.g. Hamoa)
> - Handle rare cases of DDRInfo v5 with additional trailing data
> - Rebase/adjust to SSoT UBWC
> - Expose hbb value in debugfs
> - cosmetic changes
> - Link to v2: https://lore.kernel.org/r/20250410-topic-smem_dramc-v2-0-dead15264714@oss.qualcomm.com
> 
> Changes in v2:
> - Avoid checking for < 0 on unsigned types
> - Overwrite Adreno UBWC data to keep the data shared with userspace
>    coherent with what's programmed into the hardware
> - Call get_hbb() in msm_mdss_enable() instead of all UBWC setup
>    branches separately
> - Pick up Bjorn's rb on patch 1
> - Link to v1: https://lore.kernel.org/r/20250409-topic-smem_dramc-v1-0-94d505cd5593@oss.qualcomm.com
> 
> ---
> Konrad Dybcio (3):
>        soc: qcom: smem: Expose DDR data from SMEM
>        soc: qcom: ubwc: Get HBB from SMEM
>        drm/msm/adreno: Trust the SSoT UBWC config
> 
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  11 +-
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  82 +------
>   drivers/gpu/drm/msm/adreno/adreno_gpu.h |   5 -
>   drivers/soc/qcom/Makefile               |   3 +-
>   drivers/soc/qcom/smem.c                 |  14 +-
>   drivers/soc/qcom/smem.h                 |   9 +
>   drivers/soc/qcom/smem_dramc.c           | 408 ++++++++++++++++++++++++++++++++
>   drivers/soc/qcom/ubwc_config.c          |  69 ++++--
>   include/linux/soc/qcom/smem.h           |   4 +
>   9 files changed, 485 insertions(+), 120 deletions(-)
> ---
> base-commit: fc4e91c639c0af93d63c3d5bc0ee45515dd7504a
> change-id: 20250409-topic-smem_dramc-6467187ac865
> 
> Best regards,

