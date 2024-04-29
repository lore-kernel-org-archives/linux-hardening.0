Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBC38BE2
	for <linux-hardening@vger.kernel.org>; Mon, 29 Apr 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714369804; cv=none; b=C/xDaT+VcksObbI4D4RhB+443oZd35YGDMzeaBNxY3jpgvk9P3/M0gtwYnjvbR17VFjmrFcAlaB47v7TRRcY3dF6hhaSMCa4sv7ESs42ersYxeV/pkjezfowqiDZKpa04v/8nu3FvvCzHH9Jg1MfjYhbpBXU0yfxwTXW87U46lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714369804; c=relaxed/simple;
	bh=IZ0pCnE6LGKSv1BY8600SAA+8YX35szUvdWSAvdru5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faXqGGOgvFGZOjTqXhRphCprBWJf+6jAWDyiU4OddwNYjwGG4sDQAi5l/RETbuFpBCsqJUGlQvSS5tqOxBFAQOSUpafmApusA2c15zyzuplJLuWRSXLMAE+4lKLGHf+V/3c+ErWpqbImeV8WqiiEOWo1a9mqtBcwPVU2DhY2iN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YlXb6sS3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlXb6sS3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572250b7704so4071209a12.2
        for <linux-hardening@vger.kernel.org>; Sun, 28 Apr 2024 22:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714369801; x=1714974601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBC8NsME8FDQrSM2a9ldWs4Dp8svNoY8pDm9JIJNDxs=;
        b=YlXb6sS3ujwm+o9a9CDceLI2kkPoWBbUL5c2obP8o5INol/ZRukYIxrUyCkYbI0JX6
         kLHZmP2y/9/EECjoHqrvIZQGtjs/mh2k4M7EVE3forys27IarOnjUXC6fzDgq5k/jA0n
         LA5JeLu9Y+swpOwHRG1S0ncas+cgNPceLI0I9qJpAfANzCXPI73Nxz8eQyGnh41aqRM6
         R7VV12KxttPfxu6lBnQokCBDQ15gO7tgc8plIs7ASYjB15JRegeQ0cbhPJSGENg85M85
         dDvv4kputOh2lIU3oK5x9QcRnfILZD6cPmxrjRaU37os68tBx2EkRnuvhDxklHeMe4rV
         WxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714369801; x=1714974601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBC8NsME8FDQrSM2a9ldWs4Dp8svNoY8pDm9JIJNDxs=;
        b=MFzdXa8BNNVa5M7OYMkRXgxFiuKOrYwEmFZTeGPl/GHLyuNk/fcm92pqKIjLrLVFD9
         GlPxpMWgGrakFaW4MJLTIc9Nny0igpHRbzdgMOUcreoynxdxvYH8qwh7Oq3e8KH0tHfA
         yvkzi2/TZCJn0VV3R6loFDI5FOQpwpmiSHRq+FfMgwrOEQMJbFaRQX6Irs3prGKAVNcZ
         k9OdiCz5CVSJsnWU+LR0aOTuJeMvMRbBwRmMH0xy/wWML7R8gmolLXtbg2ptqn9jXuaL
         q9el+nDq62TtQXEuIUGjqSsfcZ2LMjTZ7Rr30As/so4fT+nnupaCWGXNv8nceE2iiNe8
         JRvw==
X-Forwarded-Encrypted: i=1; AJvYcCWRrcPgEfPNhw03hBtpaZ/7u5EL7n3IWBRjxviITw7NHCitl6DqzXhfpk+yjMv4CN0jcYfbw+ynLEaEawVE7Ls4YzbdZCKj8Vp6oSigN6V2
X-Gm-Message-State: AOJu0Yy88R2YGJvq2ncd38XoBrbY8bucFunvdecVKoOuKI0rAL+A2JQx
	otKHmKuo9XzLunSvr+5jV5jnGtFKNh0AbQTMruWKTzgZxa849TNREoCgkWs2nHY=
X-Google-Smtp-Source: AGHT+IHz+gH2i2CuUvU4/lWr2eFTF6pfN39+7821KdJqT1JXS0SoRmi+x1kCqWIvwpXfweuET6tjKA==
X-Received: by 2002:a17:907:1b27:b0:a55:b592:7e0a with SMTP id mp39-20020a1709071b2700b00a55b5927e0amr7295555ejc.48.1714369801217;
        Sun, 28 Apr 2024 22:50:01 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090655cd00b00a4739efd7cesm13602468ejp.60.2024.04.28.22.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 22:50:00 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:49:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kees Cook <keescook@chromium.org>
Cc: dm-devel@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [bug report] dm ioctl: harden copy_params()'s copy_from_user()
 from malicious users
Message-ID: <5cde5d51-a8f2-4c30-a016-1fd8e34212e0@moroto.mountain>
References: <f84a96d7-2df4-4f79-8c27-83a1d9574412@moroto.mountain>
 <202404280901.96E2E1AD9@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404280901.96E2E1AD9@keescook>

On Sun, Apr 28, 2024 at 09:20:35AM -0700, Kees Cook wrote:
> On Sun, Apr 28, 2024 at 04:12:07PM +0300, Dan Carpenter wrote:
> > Hi DM Maintainers and kernel hardenning people,
> 
> Hello! :)
> 
> > drivers/md/dm-ioctl.c
> >     1931 static int copy_params(struct dm_ioctl __user *user, struct dm_ioctl *param_kernel,
> >     1932                        int ioctl_flags, struct dm_ioctl **param, int *param_flags)
> >     1933 {
> >     1934         struct dm_ioctl *dmi;
> >     1935         int secure_data;
> >     1936         const size_t minimum_data_size = offsetof(struct dm_ioctl, data);
> >     1937 
> >     1938         /* check_version() already copied version from userspace, avoid TOCTOU */
> >     1939         if (copy_from_user((char *)param_kernel + sizeof(param_kernel->version),
> >     1940                            (char __user *)user + sizeof(param_kernel->version),
> >     1941                            minimum_data_size - sizeof(param_kernel->version)))
> >     1942                 return -EFAULT;
> >     1943 
> >     1944         if (unlikely(param_kernel->data_size < minimum_data_size) ||
> >     1945             unlikely(param_kernel->data_size > DM_MAX_TARGETS * DM_MAX_TARGET_PARAMS)) {
> > 
> > So what's happening here is that struct dm_ioctl->data[] is declared as
> > a 7 byte array, but it's actually a variable size array which could be
> > more or less than 7 bytes.
> 
> Repeating from include/uapi/linux/dm-ioctl.h:
> 
> struct dm_ioctl {
> ...
>         __u32 data_size;        /* total size of data passed in
>                                  * including this struct */
> 
>         __u32 data_start;       /* offset to start of data
>                                  * relative to start of this struct */
> ...
>         char data[7];           /* padding or data */
> };
> 

Ugh...  Those comments are out of date.

What happened was that back in the day we added padding to make the
struct the same size on both 32 bit and 64 bit so that we could do
pointer math like "param + 1" and it would work on both arches.
But they couldn't call it "padding" because there was already a struct
member with that name so it was called "data".

And then people started using it for data and made it a variable length
array.  When it's a variable length array obviously "param + 1" is not
going to work.  So the original purpose of the padding is now gone.

So now to calculate the real, allocated size of the struct we take
the sizeof() of the struct, subtract 7, and add the number of bytes in
->data[].  #LOL


> The Subject in the email is "bug report", though. Is there something
> here that is breaking?
> 

I was going to send an automated email but then I changed it.

regards,
dan carpenter

