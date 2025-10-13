Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215023F40D
	for <linux-hardening@vger.kernel.org>; Mon, 13 Oct 2025 06:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760338753; cv=none; b=hMzPQV1F40SkaaS9eA1H1wpKSE/4rwELmxUbd4dZ2lD1FEISrm7sRUwjdRNyckHMyLGzdWlgxrjfKp6bx5qHQz2i6nDyvgAsUiQ1XZ/io8pDnEkdPNWF+xphqh9lrLau63ZI+WOT7/X/kiEvWBKa9YzsV2B4DbtzWgvChW4wUdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760338753; c=relaxed/simple;
	bh=86ECSOmfJBWcuFGxNNZ2ysv5zZ841yDUPRfso1H+2Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRL0VB1mbjOfsvX2NXJasS56SEhgaPDfhbyocUmLzwsJBYHYxApQJMHDcXXa24jDNP3fwpd1VyUyab5Btim0PchCoWjyM5G9Meu94NMNBlJp8R5EJyqLTR0GY/xG4qFwww1pKXz+XcT5S0ebb4S3BPptHwju/GYdTjV8P/oaKRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IaqCnZ/l; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IaqCnZ/l"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so20215735e9.2
        for <linux-hardening@vger.kernel.org>; Sun, 12 Oct 2025 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760338750; x=1760943550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZpLoWSAxU2G8AVHL931DUMQsZx2voyuF6q/+oeSly4=;
        b=IaqCnZ/l5aYYQi1z4NvHoqKPUTgJBXmXITqIBH7AhnrJoj0FdHC+vOHJG0byNRxsLj
         7qSR3HGN0xwaR8PdY6ntVbDwx0zWWbT7U3K8tQzcL3PyFf+OmR6TbnTQm+TsisrvYK2v
         baJCjg93SAaSzZ5QBTBNoHyAvVaLfMj2kYaJgDMVDThDMMLHl1ejiR7i3l/h4FN0VZrj
         DFFRIgJAQMOULiYvS8tZiMCfsuNNZO1JwS1Cr+kKEIhOUnA41fBWjJ5xx84yAxL39r8s
         QbcMPfN2Av0tvU0qhsiCw5o0NnzO/ADHRBtnkYn7QCWMuXECOC81h/CqhNK3ze0h3ko5
         T/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760338750; x=1760943550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZpLoWSAxU2G8AVHL931DUMQsZx2voyuF6q/+oeSly4=;
        b=oPDGNXlcZgfsjfJHjH2i22ukgQDQnLmraR/xmdua1zMbsIY6NGi18kLgAwVXlMCzuJ
         htwO7fRIOtgqTVJLyWTXAx0x8s/Q+5DJgX5uxf435vPalku6iI25cQ8X5vGmxvXInYWM
         J7orDBpiY1Te8eahjzOdBzVFn8x6+L8gCr+ZuXMOyNLOevqTZxyJqILDlp74t39jlTOC
         ehLdi3/gYYeLKK+2u2JtlL7a7TYrKCluQN5drJusI6YO8TqqxxZzbyY/mJQ1yHoteX/c
         PmYi67U0iw1WS5RbInv2gBrpcR1hKfeub+H5MiBGUcFORAPtoIJvd/xI2iWa/xL915/N
         pyMQ==
X-Gm-Message-State: AOJu0YwLqg8+4WSO8vXnLncrAxoatjv4VKJBkpy9tKdk3wxf03GFk3NS
	/yV00t3VIXxl2RKVypb+oOWB5KauUZ6tWr3JfHkZEA3wZGxVPDyhhhS7Xe58XKVI7A==
X-Gm-Gg: ASbGncsHLELxYqgoJ0SSj4OUjBQj9yVeK4Qd7r1zhiXejDa2Gy72HIEVBEdCTJd+gQz
	HK+ofzRaxhLJxOeQCmHVwKUwxTTg5y01p59AQp58QOj4s8Y3ZCMEkCQlECBsYVC8QVC6i7fY8Tc
	DqKeUJVXXlMHJnMKDOAsfqaFccjR8W0RGXO6zCZpTR9s6LMCeSycsouyYs3ZI7Tu1qr7zxPwxnX
	URXOogSNr8P4s+JLbgatB6TheYusXXxJ0FnhH5biQlws7MQCkVD7Vjrv6EjC+rZvT+I8mTmZoCd
	RdIMvzJPxoXmIytUphoTlS88Me1yPmARjw6d2PvLIIPKEp3cEgc3LEgpP0YY2rmZu7/4NvEnixz
	f2mC39ycLKepg+dq5HjBBrYrHuJQOTKC2Mc2pABPOXmfomt4N62FwqJbECnS3gWWeVQiNZA7naN
	kb81cjttXjbNqQ4wSPKbf/C4Ac2Q==
X-Google-Smtp-Source: AGHT+IH5VvluhJwPowoICILvdjdM0MHl+DmVnGQ43MOA2t6u7NnLqzoJ6LIu68iyp4i8VDiHpwKChg==
X-Received: by 2002:a05:600c:5488:b0:46e:45f7:34fc with SMTP id 5b1f17b1804b1-46fa9b105ffmr133685265e9.29.1760338750080;
        Sun, 12 Oct 2025 23:59:10 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4e22d8sm118354975e9.5.2025.10.12.23.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 23:59:09 -0700 (PDT)
Message-ID: <ebee3406-d515-4e29-9d7c-f54bdb143080@suse.com>
Date: Mon, 13 Oct 2025 08:59:11 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/xen/xenbus: Replace deprecated strcpy in
 xenbus_transaction_end
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Jason Andryuk <jason.andryuk@amd.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
References: <20251012195514.39003-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20251012195514.39003-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.10.2025 21:55, Thorsten Blum wrote:
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -546,16 +546,13 @@ int xenbus_transaction_start(struct xenbus_transaction *t)
>  EXPORT_SYMBOL_GPL(xenbus_transaction_start);
>  
>  /* End a transaction.
> - * If abandon is true, transaction is discarded instead of committed.
> + * If abort is true, transaction is discarded instead of committed.
>   */
> -int xenbus_transaction_end(struct xenbus_transaction t, int abort)
> +int xenbus_transaction_end(struct xenbus_transaction t, bool abort)
>  {
>  	char abortstr[2];
>  
> -	if (abort)
> -		strcpy(abortstr, "F");
> -	else
> -		strcpy(abortstr, "T");

While at least in principle a compiler might be able to transform this into
code not using any library function at all, ...

> +	strscpy(abortstr, abort ? "F" : "T");

... the use of a n on-standard function (without equivalent compiler builtin)
doesn't permit this. IOW why not simply switch to e.g.

    char abortstr[2] = { [0] = abort ? 'F' : 'T' };

Jan
