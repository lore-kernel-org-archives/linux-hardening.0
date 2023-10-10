Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447B7FD
	for <linux-hardening@vger.kernel.org>; Tue, 10 Oct 2023 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="PPck21GW"
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691489F
	for <linux-hardening@vger.kernel.org>; Mon,  9 Oct 2023 19:01:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79faba5fe12so198061539f.3
        for <linux-hardening@vger.kernel.org>; Mon, 09 Oct 2023 19:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1696903275; x=1697508075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8W5jicDuFfCto5Rz0a13pdOEWWZtFkes7WHBt5JLjo=;
        b=PPck21GWL+u2Kz2+xAqPoG+3Njc9DnYMxHPMLqb/wap5zMDkndfy6+58OybjVB5mf9
         8mg3lhE9YO95n96UZzWFsbwqYH78K/kMiMhSo39XRrDbfq3fd+sGK+8rUhrl31hUl8FS
         f/KhV6r6je0ihv234UHGQs9Vzs8s0/0isOjog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696903276; x=1697508076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8W5jicDuFfCto5Rz0a13pdOEWWZtFkes7WHBt5JLjo=;
        b=wPsUWwElJ0KF0w0Uqx3xnj7Q1y8Z7xnJRrQEICLoQgYQDfx66DsWTQgP/nSD20KuqH
         Zs8aLoBtMuMIfwnh3vz2S+0H5T+rFh26tHf/nGu3KuqrgZ6NL0tLot6mhCy2ZmLkCETB
         1C9YW1tAB9n5oxLhXuLtGS1NKKV45am29/mMJzgei3APpLZdro5zoD2cqyXK9bbNXZS1
         GX9Y9R95IAdcy7iWbttJJj7BUf8AiKRIhFzwRWKYoG+WqXXrLHTWHT048qwM90Cbldba
         TMxVBiHXtJnB7x1bBOgfoIOAMEkmVAqfPnl98UaovCxk112sbJilM/piYDw/pK1gfVBr
         tiCw==
X-Gm-Message-State: AOJu0YylkBUtNef+RxATfUVxxu/3EdYCposD5UBBQBixqt4wtCkCNqX2
	84OBf6f4kl2dO3S9T50Ws3IOWxrj+JJ8kJW31Oc=
X-Google-Smtp-Source: AGHT+IFxEbsxiAkqgad1NR+N5qEc+xJnzBRXuoUOorumGMCjl3dh8xe9qk/x6WqhsQZNVSqcE/TbYw==
X-Received: by 2002:a05:6e02:1d1a:b0:351:b22:af5c with SMTP id i26-20020a056e021d1a00b003510b22af5cmr19923893ila.32.1696903275665;
        Mon, 09 Oct 2023 19:01:15 -0700 (PDT)
Received: from [10.211.55.3] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id l17-20020a922811000000b003513b7613f3sm3247512ilf.3.2023.10.09.19.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 19:01:15 -0700 (PDT)
Message-ID: <42a24a62-8dba-452c-b460-61ee06171d74@ieee.org>
Date: Mon, 9 Oct 2023 21:01:13 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] staging: greybus: Add __counted_by for struct
 apr_rx_buf and use struct_size()
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZSR2O6zGyT/VX6ve@work>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <ZSR2O6zGyT/VX6ve@work>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/9/23 4:52 PM, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.

Looks good to me, and I like the use of struct_size().

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   drivers/staging/greybus/raw.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/raw.c b/drivers/staging/greybus/raw.c
> index a00978c8e1d2..b9c6eff7cdc1 100644
> --- a/drivers/staging/greybus/raw.c
> +++ b/drivers/staging/greybus/raw.c
> @@ -29,7 +29,7 @@ struct gb_raw {
>   struct raw_data {
>   	struct list_head entry;
>   	u32 len;
> -	u8 data[];
> +	u8 data[] __counted_by(len);
>   };
>   
>   static const struct class raw_class = {
> @@ -73,7 +73,7 @@ static int receive_data(struct gb_raw *raw, u32 len, u8 *data)
>   		goto exit;
>   	}
>   
> -	raw_data = kmalloc(sizeof(*raw_data) + len, GFP_KERNEL);
> +	raw_data = kmalloc(struct_size(raw_data, data, len), GFP_KERNEL);
>   	if (!raw_data) {
>   		retval = -ENOMEM;
>   		goto exit;

