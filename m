Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CC171AF
	for <linux-hardening@vger.kernel.org>; Tue, 13 Feb 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707808927; cv=none; b=mX8jbnNR1MQjaQEBbsDE3hA3CA0B3EqFlLedDJYpxYW6I+H4rvzX85I2ll1exuyO63+Zwd+HpnwXc4V9f93cL8bc2WwtEKowAb+P/WjIvw/D9YYIcs922JTD53xDCjbRzLi9dn6SqZoY1en5q4+KlOAGeffQOfWzlAvqTAeyrX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707808927; c=relaxed/simple;
	bh=DONVtGRnA1valXDHvMXR3w+eZ1ofjI09Edkc2KsjAf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KPh0YrTkL3m81zIu1HWqPgKscqJBb3K9dH7JJdkj0A/dnmnIDEalJeEAyuVqY1DVlFaL6yBT8AQdQuBsmysySSzeh2FUbHtT0kuh4QNUjJOa4FXvQj0cv4myZ7Z1ZeG2wdx5X8kCkhf4BNbbIbDy4EUzEb2BSk1KcjQULcIbTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=IrQ75Qfu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="IrQ75Qfu"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3566c0309fso484034366b.1
        for <linux-hardening@vger.kernel.org>; Mon, 12 Feb 2024 23:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1707808924; x=1708413724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AD0DXnUm1FBXgA9YUMc+TzzukaEUgpwUDBCCVIkam5I=;
        b=IrQ75QfujO74PbxNkhTLvq9ci591E89y0XThGIjyBgV2RjYNUd3kOnhv9jVZVhxU+L
         2ScAl9rLithDNCVRY4mhuDm/OEA4nyyyesbNEf8I6iYeSzztcWLjv0Kdm5sJuCBYtIBA
         yOzOoLabloeTYQtip4yo57hGjI5CKJdHuX8o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707808924; x=1708413724;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AD0DXnUm1FBXgA9YUMc+TzzukaEUgpwUDBCCVIkam5I=;
        b=VH4HwbOqAGtJjfuS43LZrNWIcBouyOyDK6a8xbuqcoYDcBN3xYtAI4sr5cMSDZrGKY
         vRbYrU264QZr9pCENWOsFDHxf4F3yCEFQnl9JD6RJmUqxmJ9mEBpqeptAkJu4OBkKqFb
         TKtiXnKJZY0QAxlriGjW7hjt2Ig84MIjJctzhpIqkobtlVVtYFIFF9HRkERkMc5p/w0O
         2u8HaqNDHejvzgS5CTeqhPy9Z/jFXzhh+nxfz9lzHmhTHdbgv8Xm2SVvYMZBEqeEJTHh
         z8s3Jxw3hocquYbs9+dVsDfjhKTUfSdamhI9s2rLJfpnDcIMoY1KbN9k9vyTkQabIrFh
         UEMw==
X-Forwarded-Encrypted: i=1; AJvYcCWXZJ9eVCyn6ktQcIX/6aF0rz4CyfPhAmoUV59PDD2kPHmtio7cJKvUss/NCPR08CFWKr+SKa3L2oATSjaSTmr+G/M9G+KiKQ+6rg5DLS/6
X-Gm-Message-State: AOJu0YwPcoTETDP8iLChOEQuOA4kYOFTJoSm+YJb8j2z/UK51JVABEXm
	i//nVZ+godwljNUZfKs2UQThpWAAZm2FM4P3XZ9g0HsHkJcnU7M7+a8IANiaC+A=
X-Google-Smtp-Source: AGHT+IGqfRFSCzNsRmUpBjE/amQaT/faAWEXBlMHrAWFflBTmiX9qHATOJ1HJYx7BpFJGLpFDUlwZA==
X-Received: by 2002:a17:906:d118:b0:a3c:98aa:5ad1 with SMTP id b24-20020a170906d11800b00a3c98aa5ad1mr3635223ejz.56.1707808923400;
        Mon, 12 Feb 2024 23:22:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4luXF08VL+zicwLTq9Xh9Y8kYxOhF1kPJ8oNRVthKZvF5fDS8k7GzWn/v2C4YriRdYy6OKFge2XgzXaOfqo+Dacyrr/xdAcYXw2QHv16NvAU0+p1OZ9XCkLVY3W1aEH8W+nJM/QmyL30GQDNC3SpubkgIgY3CFZOZn0Gi4uuTL1N818XMcYBXyOo0c0QYkr+l+0ZDKrzrguP82tn8WI9D27oZYKS3/zTRxlAGVZpcoCaUcleacl/jl2c6hmUejIyVz1/lA0opNJ2mMOHutw2MnE2MqvC9Z3bJU3A/m6RgBaD214WXoF2ChIs5Maf1Q7SlrNK0LMWEOJchld8QTcPwUh5SnCV1LM9CFCqVdAs4TA5FhPdvHpT57nHICPmIdyiHOV68CoqABWDw6UZpkHP0jmLx5ATRMRNGZ/Psly4dQdfUd6dHE2MF+SKITHDjqMOWePMRGoWG5L3achTmGQ==
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id vb1-20020a170907d04100b00a3cfe376116sm379292ejc.57.2024.02.12.23.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 23:22:02 -0800 (PST)
Message-ID: <8ff2496e-925a-4a86-b402-6229767d218d@rasmusvillemoes.dk>
Date: Tue, 13 Feb 2024 08:22:00 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] stddef: Allow attributes to be used when creating
 flex arrays
Content-Language: en-US, da
To: Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Keith Packard <keithp@keithp.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 Dmitry Antipov <dmantipov@yandex.ru>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
 kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240210011452.work.985-kees@kernel.org>
 <20240210011643.1706285-1-keescook@chromium.org>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240210011643.1706285-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02.16, Kees Cook wrote:
> With the coming support for the __counted_by struct member attribute, we
> will need a way to add such annotations to the places where
> DECLARE_FLEX_ARRAY() is used. Introduce DECLARE_FLEX_ARRAY_ATTR() which
> takes a third argument: the attributes to apply to the flexible array.
> 

> - * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> - *
> + * __DECLARE_FLEX_ARRAY_ATTR() - Declare a flexible array usable in a union
>   * @TYPE: The type of each flexible array element
>   * @NAME: The name of the flexible array member
> + * @ATTRS: The list of member attributes to apply
>   *
>   * In order to have a flexible array member in a union or alone in a
>   * struct, it needs to be wrapped in an anonymous struct with at least 1
>   * named member, but that member can be empty.
>   */
> -#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> +#define __DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)	\
>  	struct { \
>  		struct { } __empty_ ## NAME; \
> -		TYPE NAME[]; \
> +		TYPE NAME[] ATTRS; \
>  	}

Is it too ugly to not introduce a separate _ATTR macro but instead just do

#define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...) \
  ...
  TYPE NAME[] __VA_ARGS__;

?

Rasmus

