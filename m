Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F737755C
	for <linux-hardening@vger.kernel.org>; Fri,  8 May 2026 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234765; cv=none; b=Uxx9UNj+e4hFvqZS++R9BywTmz7oRlfKC5yOMynzWAML0WiqlM4eYxyYyK6dUXe3wVNTHzjVjW04dETwTNATtFSW5+THTuK4ORkEhZ8LA4tfCdDVV+UIuuAwevn58CwEMFbxKw502t4meH43m/LIG8/62VR7U9HtjZy5nTkrRTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234765; c=relaxed/simple;
	bh=7HtEkn1G6Gt+KqI9Inj3vguOrvstZekSSZzl3+vPWJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIV/YTh7f/l/N9ym1FF3bP2PgLi137f+/Xqv7F/2CBkk3xGN/s0ztekSQf1+/oTJkfKgW7FUaXNsiLBl5Diz6Ue78Bxj2Kiy9dCUdI3pDPoEEr/cmu1jB4XOSW9kED3g34WRUYGsc3IMqY16UZFyw1Qe73RqVGcDrGYOOPy25+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mKX3v2cy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mKX3v2cy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67e9b3037dcso1667002a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 May 2026 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778234760; x=1778839560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hxarCXBu2q9FLo6gBfwZV7234oitg8nQDrnEw0Apq8=;
        b=mKX3v2cyUXfWRT5X5osfq2WBcZQATjRgkcPJfkaRqDd7Jxcxcvu1eCHXYuOtLrSzuP
         /uHIAOZEuZdDEsumX7xFK0exxOEh9BeBB/dz1iK3LI2xYClnX6PvHLyOsbZwX6SAgow6
         zTUdzKHj/QI0eqswypAEnd5kEc+IwWBMVxj1E93c4VxjHCD0lvYxFjlXD2KxF21azkCJ
         /+iMtseDkn5OLBKA9kgLSnv1shtQ6u2ho0P179u0jFl21E14BOk6PqgHQKISKlO4whXF
         Z5irl0CBpfpwN7HLPZwUqYSNO4a1o4m58hrOQ4QMU5oo8EagJUoYQWzbAFNmtJICFqAv
         h3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234760; x=1778839560;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hxarCXBu2q9FLo6gBfwZV7234oitg8nQDrnEw0Apq8=;
        b=pCqOGWJvx5iKmXZ0pBjM3dh6RIiOVA0R4tHYBH0xSROONlhOfft8L13U7XxKmkgTme
         WoGcbLlhT+81IPDIuCq/nAjKiA8JP/nEoZn+vkMWdCup5xGFwQNvTdbNAWS6ciJGI2Hh
         weZ3nkymq8ZMI1L5kIiHpS3RC191uToindeyXJebiZeKw2Q+bbeB1Llijm/a6PmaQ24t
         5//MPfwTZoDWB9O2Y9H1uBHR9w6wb2bRiOrmkp01/Zn1E5UggQk7MPwotyT6FwArQHfl
         wYdkswmInB69QdGK1Am10HLnjEteQ2iZd5k8DHmaJKefKtFM87GtnxmOfyBFmFnzH5vm
         Xu9w==
X-Forwarded-Encrypted: i=1; AFNElJ9wnz2GhkjLlHr6ry7gXYbYY6Ztoc7wmR8SQG+Fp1efAbcv1pBuut/yDKFtYjiISWH0/uLd3cYBRnS/W7n/0NI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9ZnVzlil5XZRRX+aWdTxS8KyURs5q2HsGgnXi6OQM21xit+Vp
	sKZoau8zQO3dMyXlOCfXpHl37eHUgkh5HMC+Tmtvy8LMHfYEVvE5FFFIuLb73Oo4bOY=
X-Gm-Gg: Acq92OG37i4OZIbmoaXiowGm4SNn1pUXkdQQ94cl/FDfZ72R6b7Gm+PTtrMJTDzJjVY
	DEfqj5TNqjDc/bkTiUHEZdbD9vviTsVZ85dutHGDH/cWK/Vr7E+IY7rQ1CnE/K+Yv0z3Ug3C+ne
	rrAiK1KSrPdYzOOEsyHOLIJtoyV3imSIWwiTYEbOWWEpTdZRugT+nJsEdZ68IgIbQFUoBD2c0jD
	BxvvgWhFOavXbcdm+B3aSBJxQz5DuX0gFLcdfiiIOusciD1zfyUlWV0JW90nKBthcsjlXjnwRBa
	axSIZrt+DakWIUAftnkcQnZYgCIT9D/Zm7vPqiDJog2vMdCLv4TtVXSGzACqiqWDASntqyaPsNk
	RyCEthie0bgRfZCWiA3C6gGbfYpage2UEaUkJ6YbK5HVulGP5AfI86++20/GgqjOH8ehRrPkPjT
	cUpppsYfxgydFKqe1i5PjjwLlQqKWvFIabmgI=
X-Received: by 2002:a05:6402:5287:b0:674:b1b1:d039 with SMTP id 4fb4d7f45d1cf-67ef0787b80mr978564a12.11.1778234760387;
        Fri, 08 May 2026 03:06:00 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.20.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3bb2asm477788a12.6.2026.05.08.03.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 03:05:59 -0700 (PDT)
Message-ID: <f6121050-3b27-4651-9fa9-9300ad299df7@linaro.org>
Date: Fri, 8 May 2026 11:05:58 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] media: qcom: camss: Add camss-isp-sched helper
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
 kieran.bingham@ideasonboard.com, johannes.goede@oss.qualcomm.com
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
 <20260508-camss-isp-ope-v3-5-bb1055274603@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-camss-isp-ope-v3-5-bb1055274603@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/05/2026 23:49, Loic Poulain wrote:
> +/**
> + * struct camss_isp_job_ops - per-job operation callbacks
> + *
> + * @ready:  Optional; return %true if the job can be submitted to hardware.
> + *          Called outside the scheduler spinlock.  May be NULL (always ready).
> + * @run:    Start the hardware for this job.  Called from workqueue context.
> + *          @ctx_changed is %true when this job differs from the previously
> + *          run job (i.e. first run ever, or a different context took over).
> + * @abort:  Optional; abort a running job (e.g. trigger a HW reset).
> + *          Called from process context during camss_isp_sched_cancel().
> + *          May be NULL.
> + */
> +struct camss_isp_job_ops {
> +	bool	(*ready)(void *priv);
> +	void	(*run)(void *priv, bool ctx_changed);
> +	void	(*abort)(void *priv);
> +};

I'll reiterate, I don't think this is needed and is overkill.

v4l2_m2m_ops already has device_run(), job_abort() and job_ready().

:g/ISP_SCHED_PAUSED/s//v4l2_m2m->suspend()/resume()/g

This seems like codebomb of a parallel implementation, which can be 
largely covered by existing v4l2 stuff and if not then should be 
justified in v4l2 as a new design paradigm.

---
bod
