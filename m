Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9AA141987
	for <linux-hardening@vger.kernel.org>; Wed,  3 Apr 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712143423; cv=none; b=rRIFl3b1YQYvGx9xz2VWOJ22Y/MQ9yKMLvNAFopxn/M8B7YaLqlmx7VMvFp4o3YbyLbZrFfOoerZ0UN4lNi01I+y9IFMr9K2kmQ61kIfKwWsS17scC6/fgxNKSR+1Evn6/4kP2nhgiVfeL6lsZ3kUOQ74/sKY2a15n6twS4E12U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712143423; c=relaxed/simple;
	bh=qlbIaZmjqq0figKmIY11feeW5X4Q6m2nbl5U2l0zQJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqC/gFnvtT+7LKEtkfz+BAEWAK4kD/ey5VBKJWp3BYI48BZaGxvYScqwMWCA30Jd4qHnuKtqsZzT16dbybQni6ZwpyDWNVkHvntN53/I03JkYwCrrxtLj8yqv1nux0MevBqpQMEXvJl5DTf7E2HCXMBDDMqheI6H2Xmkkm1mFWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lSVHkoUB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lSVHkoUB"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34356c24701so992476f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 03 Apr 2024 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712143419; x=1712748219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6hgwRkGrrS3Oweenekzl9fFYfPnVmMeLqWDsvPrY+Q=;
        b=lSVHkoUBtf3duAA0NFtoNWId73Dm3E5d742poLvJelI3O+zsm5EflN2KfjDCg7V5yg
         qLY7MVdRpG8SoYphwyqXWK50vtpUADh+bWYxPHFc9B1dzhfNEJKvgN7bxa3Yy5iAMqa9
         wmD24cDh9k4SDwwlesM5CALaCt2QmeJecnzUfDC3YamUAatZdZFlMKUieJ+FaQqvbt0Q
         fOn78kSrnAnwHneKThEzPVRG88S2yFcgunFyNcQvM7f72Bk3xxEUDfbq3eMM01c4EfoQ
         tWHGK5VBrW++e2R7rWC/9knxTkjy4pQTJ2t9ToUgTeUG2dtS7fq7KoS3ZDzSGFTpASDv
         0FJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712143419; x=1712748219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6hgwRkGrrS3Oweenekzl9fFYfPnVmMeLqWDsvPrY+Q=;
        b=uYlp5hheLygcaG3D4cm90A6Z6gs5IWcR327WEvDJj+K/J+MPxE5dMh8bZWvl1fuO3H
         4RdrAgYYFKdIWMrNQZbDT1i31TpLNLzbEeXmgTJMfAcIfUu8lEDhIDIbA6eTkQIqBKKL
         4brDoxvDBGfpYACJo25Z363dHR041jNhbJokIWm4IxmvEd3idEdhDdLo1wPWhxDD4qtF
         sKNb0Xot2M38hLW2q4JcrKsXlpPrngEqXV+rSSAjycRCO8IyqCkA883QO6kCkx74XY8Q
         VbrpBlm28p8WYs6rTOPGMoi/hOU3J92NfOoWkBVo+r67yKyu6vVz6qff1cS8mf6lmR1O
         YHUA==
X-Forwarded-Encrypted: i=1; AJvYcCWT9zQnWIkhzXXz5gk0Ncd7CW1Jjpjzr4NNzLVYRDLZGKbWzQszaN9r3NcmlbwTV4aXt1thHn22M2XDC6/iI15ePDCQL8wb+kTEOTCy0rrd
X-Gm-Message-State: AOJu0YzVMPoJrSzFlTqcihuSwmFdUDl0B+XRbUfS0Ij62aa/PZLx+NZh
	GqfwLwCSrX1BIjKGQSgDwRW1gdQiDs/B5MqCDYxXiD6MddXn/r3kALAum41CS6I=
X-Google-Smtp-Source: AGHT+IHFWDpW0FUgymW8ITy3D3BYi7HZ6Y+HFH0zEcYWOyQNBbE0az1s+xAWdV24ThLFPPOYx/db0g==
X-Received: by 2002:a5d:678d:0:b0:343:2d43:2b00 with SMTP id v13-20020a5d678d000000b003432d432b00mr9887182wru.62.1712143419223;
        Wed, 03 Apr 2024 04:23:39 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id o18-20020adfca12000000b0033ec81ec4aesm17057586wrh.78.2024.04.03.04.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:23:38 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:23:36 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kdb: replace deprecated strncpy
Message-ID: <20240403112336.GD25200@aspen.lan>
References: <20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com>

On Wed, Apr 03, 2024 at 12:52:36AM +0000, Justin Stitt wrote:
> All the other cases in this big switch statement use memcpy or other
> methods for copying string data. Since the lengths are handled manually
> and carefully, using strncpy() is may be misleading. It doesn't
> guarantee any sort of NUL-termination on its destination buffer. At any
> rate, it's deprecated [1] and we want to remove all its uses [2].
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
>
> Found with: $ rg "strncpy\("
> ---
>  kernel/debug/kdb/kdb_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9443bc63c5a2..8bba77b4a39c 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -368,9 +368,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
>  			kdb_printf("%s", buffer);
>  		} else if (tab != 2 && count > 0) {
>  			len_tmp = strlen(p_tmp);
> -			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
> +			memcpy(p_tmp+len_tmp, cp, lastchar-cp+1);

The strncpy() here is obviously wrong because it passes the size of the
source not the destination.

For that reason I'm not clear that memcpy() is the correct approach
here. It's probably not more wrong than what was there before but,
as mentioned, what was there before is already obviously wrong that
should provoke a bit of code review ;-) .

In particular are you sure lastchar-cp+1 can never larger than
buf_size-len_tmp (which is what I think is the remaining space
at p_tmp+len_tmp)?


>  			len_tmp = strlen(p_tmp);
> -			strncpy(cp, p_tmp+len, len_tmp-len + 1);
> +			memcpy(cp, p_tmp+len, len_tmp-len + 1);

Roughly the same question here. The original coded is obviously wrong
so trusting it did the boundary checks properly seems unwise.

Are you sure it is OK to make this copy with checking against bufend?


Daniel.
