Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EED612E
	for <linux-hardening@vger.kernel.org>; Thu, 18 Jan 2024 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705555768; cv=none; b=HiIH8nNtsPQRoSE6vrb7fXp1vLYMa+ZQrkCVSa4mdh0Qas8l1g+RijUX+sCfI3Ug1Zv42hVHrtQa99BqgkSm+U0nJwi1pRook/4+2SQtp9EQeV9C0D+Dyi7d2FRFNO0pTWeFa9GFggefW2bsP9vlGXRvCtcDPU3v8F2zilQ5FZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705555768; c=relaxed/simple;
	bh=SBVMA/CPQNcVCfcURUzuwVBCE1qUg3c5WG0zdMGFPQg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=GZlF+xO1gYpFPWm84RhKd+fJO5ZARmfQz85H951t70wo5BwxjL39sFn9GMblr9rGTVMyCWdpzMo3/EXbzl5bpg8CxXpzBuAtGj8Awq9nLi8IYIulZFjDC3aNJ7m3cNC/l9sopI/+8KJti4vsTAxrb0hN72oFtvyTOnvxxNBpf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bies4SxQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bies4SxQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso43152975e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jan 2024 21:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705555764; x=1706160564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wWVOjE9eG7LQZ1p5rDtepmpo2WIDbMJDdYV1+1m1FBU=;
        b=Bies4SxQOMm2y9Btq51UiXzVZwhtvjN5NVmtvQJ0eMUe5gfREJdCIWlM2FxjYkiBL3
         viV/JtBvnRgvSaTfwEus92WDyzUb3MfLjJ5O9zlh/ZVwvyVQBv9ZeiJiF1E7DFlkoLLO
         63j7Xl9jQkNSOsfYa7Ts9+OTe+0uab+XRsZ5WD7dEzWzmQQ+NdTwQcWCyP+4CkAEiz+r
         ORCWpnC38A/1yZmryV8RrfSfvJ57rWs9JR8xGuX/rZYA8bP39uLvGBOE2VJtukBhe+Tc
         C7nh4w/yN1i/HRgsTCxOEl+pkZ6R/0O2RS9YvtIv8EHNK1rY8hSfBv0GqE2qbHOeuljq
         YHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705555764; x=1706160564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWVOjE9eG7LQZ1p5rDtepmpo2WIDbMJDdYV1+1m1FBU=;
        b=v+VtN/HB6FkOkwt/fkc6EMCrOrBNU/yBfdj6rsOB/puA0lVJozof3hpP9cYX1+JEmG
         EuFMTfslKEdY3X/oQhJI8rjmHCKGBTcYqygi6STFYVk0u6YSWY1Cgg58ZbMjKLboK8Bi
         hUpOYtgq6eLlnR6rjK2VYVw4t12Ap2oG+VLQsJGf1Xlp/xRWelwEenrC9Xzj1Vd7KHfc
         tpuhgB3jP/oYKswDEG6tcmNqGpQwrC+ksV+6lWQQStlu3mgza6gKWI1u1typ8ul3r+Z4
         j/TuD76FjU9pQ6tmpOyOqQ+QlBgAguV9/mRK/24QXouFNYJIH+0wtE1DQUhuE/mLHpuJ
         SnEg==
X-Gm-Message-State: AOJu0YxzgYVB9YiRcfAFAj77Ncys4MU57NCcl3Jc0lrgiLGJ8HAIEAxk
	MUtTWrKQaM8ppr3hOtyDbYwaGHBqFjfzNjyX2EgrbVzPow4UHUB530E6Djrpw4w=
X-Google-Smtp-Source: AGHT+IHaCjW/5P67xwqKO0g8DnWLu4YQwaK2HHCRSW+8Wlvh81P/g9nOxJOSa7NQjI8+GNuKu6R48Q==
X-Received: by 2002:a05:600c:880e:b0:40e:4799:8a81 with SMTP id gy14-20020a05600c880e00b0040e47998a81mr66295wmb.281.1705555764049;
        Wed, 17 Jan 2024 21:29:24 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b0040e34ca648bsm24586127wmq.0.2024.01.17.21.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 21:29:23 -0800 (PST)
Date: Thu, 18 Jan 2024 08:29:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?G=FCnter_R=F6ck?= <groeck@chromium.org>,
	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] pstore/ram: Return directly after a failed kasprintf()
 call in ramoops_init_prz()
Message-ID: <26759e3b-ff74-4b04-b06f-4d68fbc5f606@moroto.mountain>
References: <644f44ad-7e2b-4a1a-bbd7-ccc79d479242@web.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <644f44ad-7e2b-4a1a-bbd7-ccc79d479242@web.de>

On Wed, Jan 17, 2024 at 09:24:12PM +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Jan 2024 21:09:22 +0100
> 
> The result from a call of the function “kasprintf” was passed to
> a subsequent function call without checking for a null pointer before
> (according to a memory allocation failure).
> This issue was detected by using the Coccinelle software.
> 
> Thus return directly after a failed kasprintf() call.
> 
> Fixes: 1227daa43bce1 ("pstore/ram: Clarify resource reservation labels")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/pstore/ram.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 88b34fdbf759..1a673a4af17c 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -595,6 +595,9 @@ static int ramoops_init_prz(const char *name,
>  	}
> 
>  	label = kasprintf(GFP_KERNEL, "ramoops:%s", name);
> +	if (!label)
> +		return -ENOMEM;
> +
>  	*prz = persistent_ram_new(*paddr, sz, sig, &cxt->ecc_info,
>  				  cxt->memtype, PRZ_FLAG_ZAP_OLD, label);
>  	kfree(label);

This patch is fine as a clean up, but I think it's useful to say that
if you pass a NULL label to persistent_ram_new() then it will return
an error.  It won't crash.  So this patch is a nice cleanup but it's not
a bug fix.

regards,
dan carpenter

