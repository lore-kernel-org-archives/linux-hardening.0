Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CB200BB8
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745836208; cv=none; b=MUd3x2S4+B1mrtxsp6sT5VU1TZYCxBzkZWchpcf4CiooVYWO2rIS4w5HCaW9iz/koni1I+uVJ/dY4I96tAm4zBLbcSai8tf2pHbKike/KBj3P7LxfBd6/cZPwlzn6iV6vj/55GUhsk3FaGVGrYVso5cj8cWlqWWSggFYbmnVWOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745836208; c=relaxed/simple;
	bh=gELjKvJp2t5ySbAVJZJ2+VVCCxZmtZHZpmT45i+SY4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwfDuV05DhXZDwmardVLdc83AGI/wWKTpa0DrIWqEFlLfdux9u4OAaRQc5JecJr9G/rK9erq4W2UnvcrBXF/kqgs1yc5iJn+BLaggaD18cPiz6GdAKBg2pckzq3/5A6RSzpz/zsAekDACFFC0Qlzc9wRVMQy0uJGy9ow2UJ2/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U5fbYIcA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U5fbYIcA"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f4b7211badso7448263a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 03:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745836205; x=1746441005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0X0zwlsw4qUSlbhCxa4+BodiCh0Q7u9EJXcW8gHza8=;
        b=U5fbYIcAi54/ReCj4w03oWTfA27Pozcsc1VuALjuUo5hxEuAK2MeiK5LTjO3WKno1h
         5OPIIu1G+9qHd4Btz4mlGYD2ZHdhhiILtvMkNBHLS+wUcS2g3W9FAVcdNK7jq32SfWRz
         M9LspV2imIpYM21ttvuLam8mjyTqb5tvXFCP72Qe5bqhoB0SBEd8+STz6Y+LJk1jOPI+
         7WhXnRHz1IzJ3dAHdkynbiCaBTLbRCVBPq3u4bhcs8pWIqztTOJniP4oH3QsvWzuA7LT
         2c86Y3kzorim2UgEcmvGp8/eysDQYRP5pZGNFpCszldI+PZP5g4An5GOEYVmNPxpCrs2
         LfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745836205; x=1746441005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u0X0zwlsw4qUSlbhCxa4+BodiCh0Q7u9EJXcW8gHza8=;
        b=cxpC7ioufaAI5uFlNB+W5S3umqL0zTO8XZ5RZKFl7bp0YaIW+NYGw7ThErpEfggeT/
         vMS7Iqk0e4LE6ITQFzZA3kiIRlgpVqO9gHcfOGuuShtZEiUrxltlndEahWhYjLdGGrU0
         6c+0zmqh7G5xNuSh5j8XZghdrNUIfhBDcbOYmgV7lwE07YhjfWTJoN7d6NVMz5yS2EW+
         FZNy4etIAVft+qcnqlNQ9rXbQx99Y6s/nZwKFoJQr1aeM+3ulmSqqg01PJnUIQIFxmkI
         tEM7K22cdaFHnSgZ0il+c+71ADLkhCYQhbFbIKsouNuzM8vSvRhKbnT3E1+GFE4/6mpF
         2EKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpQBOlNxccUBXct3NkvrYjpYJcAh2yTrtN/dCw/znPCZqvBxvicjCHbqUXktMsqM5mw+kiXwu80kUSDaD5Iho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJSpqXMH+bAmezYAIpZIs+1R8vIhNGX+iQVhnW57UGhcyJ2wR
	xunzw4M/3JcKDxFOvcdzYShc1b/APON4XoINUpB602+seU+Vu2y+GpXp7oJie+Q=
X-Gm-Gg: ASbGnctbXJqRMTlhWtEKHsxfULgW7ktCDpEceDnc5LxJGIVILrZHx0l9DK7y0I5wT6g
	P9L8XWTkemt1gU2wxjvv7vsDBHlBu9gxoZarhxvsHYPIwIBOA5U77gwhuTh5dSfLkWi8F/jdna9
	7YHEiXZWenJUBmVM0XzWckDszeR+HbGXTWI9wCSDHZuxl+IgqQhFCIgPEiJd40O/ZfdehVuu3/Q
	Xe6xyYukCJTJxGUlqD1hYQFSmur2kOPW3a4IAtba2xLZnKjCa23eZ5BB5zEJ+dmQeSbocdKywzt
	Tsaya7r1YKqxyFic1Tx31Z0SlGKASuev856AdCxBnWA=
X-Google-Smtp-Source: AGHT+IFrsAckfnQZpitNp6/6THiwG6jBaY8J15t3yrKOGYkSn7ibxSU+FNTcjZoRtyc0GmSJWsluUA==
X-Received: by 2002:a17:906:9fc7:b0:aca:cde4:fac1 with SMTP id a640c23a62f3a-ace71131c2dmr1175485766b.31.1745836204759;
        Mon, 28 Apr 2025 03:30:04 -0700 (PDT)
Received: from [10.100.51.48] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41cf4esm596033466b.29.2025.04.28.03.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 03:30:04 -0700 (PDT)
Message-ID: <d7382c8a-cfb2-4389-b120-f01a17e248ab@suse.com>
Date: Mon, 28 Apr 2025 12:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/decompress: Adjust module_extend_max_pages()
 allocation type
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20250426062359.work.358-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250426062359.work.358-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/25 08:24, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct page **" but the returned type will be
> "struct page ***". These have the same allocation size (pointer size), but
> the types don't match. Adjust the allocation type to match the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: <linux-modules@vger.kernel.org>
> ---
>  kernel/module/decompress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index 474e68f0f063..bbb2a55568cd 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -19,7 +19,7 @@ static int module_extend_max_pages(struct load_info *info, unsigned int extent)
>  	struct page **new_pages;
>  
>  	new_pages = kvmalloc_array(info->max_pages + extent,
> -				   sizeof(info->pages), GFP_KERNEL);
> +				   sizeof(*new_pages), GFP_KERNEL);
>  	if (!new_pages)
>  		return -ENOMEM;
>  

The function has a similar type mismatch a few lines below:

memcpy(new_pages, info->pages, info->max_pages * sizeof(info->pages));

The sizeof operator is used on 'struct page **', but it should be really
on 'struct page *'.

Could you please fix this as well? For consistency with your patch,
I suggest changing it to 'sizeof(*new_pages)'.

-- 
Thanks,
Petr
