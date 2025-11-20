Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1003346AA
	for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641865; cv=none; b=Ag9eAGSXEnDUXI1sPs67pFiVNbWDUb1Pq2pEq9J8WCwZXAhoLGmlOVVMnCjVyYqvD9a5fSBJU8inEIXVs54olqlLfjYbNPZ35keG7PR+hwk8gmfGUDHDaSWinRIltNEIrPvj3UcBeQEpzNCTbeCK2jVoU8bO5BskwcXJpIYbtzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641865; c=relaxed/simple;
	bh=7IwoWSZlfeD5okirxUpGyO7IwlQwYODhU3cln4El7rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ofjf7AQ56AyEwukPDgEpqEP2MhxjIZZFTsj2SpoBOwDWdkqBQXrLh7aipYdre7wP8T1HSZ4RJwPdeJLRWkcRehqM/VQ7iyg6jIthaZbVQ4sJZDg9Th9Dx8UOznQkCnh1YrKAYSlX/D1818a+yy03/jcbUDUF7+vdD3q7OBSacx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fJJi+OBf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fJJi+OBf"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so5582395e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Nov 2025 04:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763641861; x=1764246661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jS56hEMd80c4W90b7ePqVGHkDPIjZ5fhyUWu6DxnmCI=;
        b=fJJi+OBfGFM9GCZnEFoF1MhBSfUq3xlsDysp1Lg3PzWBysuTGBcxIMCrgx+C3dcHVp
         pT1H6w75IwBK5psjAJSj4lY3QubWMt7y1rgixg59qpVHOQFjlQKCUqyrrtt/ct6t7vLZ
         Z7PgVJS6omX+ia+KR2yyYDXofwyKgKxdqqBbxAORyeaXhu8BvBlUAVplRxNXDxevhMm4
         QoLAori+pk0MABy9Ye8mFNYs24dZlIyEnT3VfTkkBGMGQrD7fIWgpn/r87vE+iCwsBYL
         mm7qzDXU8CWpZUZpDaRr5iEd1Dk0DjykQ4F+E4+v3AbPzISynQUkyulqd+D2O+H/0Wrl
         IQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763641861; x=1764246661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jS56hEMd80c4W90b7ePqVGHkDPIjZ5fhyUWu6DxnmCI=;
        b=DJ5hcMO6J0LQcLw0Q9t+zl8JfAN8uJgTkCyBrY0K4yWKcNCkVRhwn7QXFKKh1FEUc9
         gO7aiHb7UEurxG4lTtjgswPtQ8d6XENdSM32BXrmC7J0XepjP2jzNAQ4JcYj5AFHsoJL
         6g9xWRheRzSMwLMfXUuYbA/pgsAO63rw4xardbEM/l+pToZsgCjZ5NFhmtuYT0S4jX+J
         YlRStBUdHZ5jOoyJdMu25IbM22c/r2lI9zmAwdXYsUP3RZcRoU/v31gLed4y+crgpnEO
         YyVT3ZpboaBf0QHFMvqP+vRkId8quNLoiQlta5bpZldXoGa37WwtkQkzAiHCibIU8ZDH
         U7+w==
X-Forwarded-Encrypted: i=1; AJvYcCXeGsA1OhoEW+XYq8OJICvLYRMvKQpffaEzHuuqaTuUlmLkrOL69Ocqsc2UEBH5HUZisNSy5OINesongGPBlbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNnlay0koVoAINpIUeCdn+6+kdTjSOvQx//7VMgfeXwc1gHFK
	VfVTB4XS+JcYWEYahmvxVB7LrgRwzcqpepY0Cqn1SLgHl3lkihCOqStWSt2fJljmYDU=
X-Gm-Gg: ASbGncuRI3gE3Tk5OJJRxM/LKhImzIUXYHeomA4Fh0j0a6Xy8J2KGWG1vzpjzfMTjwY
	2yT6PBBRgXCaeMNjK4YoJcJ/UmTM4rQLCOtzfutgfkcNO5jo810pljM5nQ6d7Ie2gbRbKwoqHyn
	wQMblcZoK06n8wWHYirQZoGgud5tFNgcV5WMYB4SpvM0nt1ksFU0M/w8r7rZCR0JuSt3x4bwiJ5
	6NZ4wpmg4VAFZvIszT1d14TAduZGQvtHwBlhzprd8ahkXAtYQQ0mPZCaTBXHObAj2TH4y348FOj
	SXllPXHZd2fqjqdd4ZQLQx3Atb4heJNlmmdqy/d9wxC0bF0YMTUgvKU3quqk5X31/3qyPdhc+Ky
	u3lORmAvV3MGSGc9f706KifTy7V/cnXgU6bVRYmEqyA25mdNDiXQT7Q4LxqjoenyzkbkSOmyqmr
	VpEuQJBha6cfMJ/1ckzOaaFhgfbZBoRPMJjoweumB7zW43A7ki12D7PcJ4ojD7LrvEpv1gwMWuL
	u97In5MdzdkhGsCYf9+hL1CJEPWSqWYRqk2inriqSIENW/uZ06twz4l7+/vC5CBgYCw
X-Google-Smtp-Source: AGHT+IFwX0UGM0SSqywlXCPNUwgxiVVdpIXKUYy8u1ykfZN73v1I5KjuFyvBESlgJXXjTswqxF6tTw==
X-Received: by 2002:a05:600c:1f86:b0:477:73e9:dc17 with SMTP id 5b1f17b1804b1-477b8c935d2mr35700965e9.35.1763641861394;
        Thu, 20 Nov 2025 04:31:01 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc6b9sm46456965e9.3.2025.11.20.04.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 04:31:01 -0800 (PST)
Message-ID: <d6632fc3-17e2-4d06-abbc-413bb6478db4@suse.com>
Date: Thu, 20 Nov 2025 13:31:00 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/decompress: Avoid open-coded kvrealloc()
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251119225439.work.741-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20251119225439.work.741-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 11:54 PM, Kees Cook wrote:
> Replace open-coded allocate/copy with kvrealloc().
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: <linux-modules@vger.kernel.org>
> ---
>  kernel/module/decompress.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index 474e68f0f063..36f52a232a12 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -17,16 +17,16 @@
>  static int module_extend_max_pages(struct load_info *info, unsigned int extent)
>  {
>  	struct page **new_pages;
> +	unsigned int new_max = info->max_pages + extent;
>  
> -	new_pages = kvmalloc_array(info->max_pages + extent,
> -				   sizeof(info->pages), GFP_KERNEL);
> +	new_pages = kvrealloc(info->pages,
> +			      size_mul(new_max, sizeof(*info->pages)),
> +			      GFP_KERNEL);

Nit: Using the array_size() alias of size_mul() might be clearer in this
context.

It looks ok to me in any case.

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
