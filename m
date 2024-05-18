Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F423D56D
	for <linux-hardening@vger.kernel.org>; Sat, 18 May 2024 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716053532; cv=none; b=MB0jj0lXfqxuFoWRkHEk95mAnRMU1XucBhQ6dcKq2ZGao9QPqVCPNPWsabkwCOJgxqvN5vPkk2oGDJdMNp/CFa13pAfDfWWSTq0Fx+4ALvQmH3go+Z1+1HwnGcEZyq2mbM1YPdqT9uOyutSGXz9f+stmB/X1+/h+nF/hCA6nrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716053532; c=relaxed/simple;
	bh=IJiHipcwnma/Wz1g3VEiKexsl4J8vJo2pyIKUwi2k54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cq3tZX9I+VhXIjlPUMmsuCrnR0w4hS6xsPrLHIPrqLWI2wQx27ODp3Ku6Bk705uuYdBn4yqv1AOmXSdaRRRdxbUxl2lXDIspa5uATjZ6AoJNDuD13uzySlpabO0aGDF+S4bypc0nHGBuNCQ+OJowaebhKdCKYqMVrR6QTW79hM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AGZD5TTq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGZD5TTq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f0937479f8so37956305ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 18 May 2024 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716053529; x=1716658329; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMb7ysVjI0JLkMqGCgNqLzZAvSpQ0hbRLPRZoUvBT/g=;
        b=AGZD5TTqW+aaF6yo4EzdNN18asuMTXokPB1HJhDpXdk3q/tVlgMdB615n4pLKzjVWC
         C529uJO0IRx5A5T+TDhIms+VlaMuzr3Jmswt5qU+dd8l7wHj8JyWI2TLD07VwhxLsxJw
         22AsONUO7pINFUybiF+iRbtgKXdGILou/3VOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716053529; x=1716658329;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMb7ysVjI0JLkMqGCgNqLzZAvSpQ0hbRLPRZoUvBT/g=;
        b=Ka4F9hNH5hR7a/voWNlCeNh5xgON0zNCqxdzEf4ma7pIauhp+jg8SmrKyHLkrmX9DK
         /8Tufo4DIxBkGyZ+eMBiqtcwmVfN43Pzq7KBSRAyFgBwhEUKfKMbPCvJ6PtfQv+8c+TH
         cD/iNTr0vsIugb4RigBqx7i6LvyTnWtoa1N4l/D2zK/9hZnuUcIyc4I7ssmN68Qck0vR
         sijPo3F5dhVSE9dqfWmIVAT61FCGe555keMqoH8cqATDJcZ7PvLxxit31xkZcAXNfkK+
         xE+6RM3dGUZoGgpG0PzBUPo3zOS5iaXIP1dO2zv6dUVEmV2B6tG9SRBs48fFgnuzCbS8
         wOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvNkalCCcn50uiOXB0hp2MS1Rr89fA6lKf7Sr00ShVCeuCYZyoEzbM55vCGgUDUTPqEBekUV4nim12eMUk6i7x4QKA0rIF1Z7fk55LPxE4
X-Gm-Message-State: AOJu0YxiFqzb+md5mfejF7esI0yFm1M51NRIWCiHzk768nVJAW2BCcLp
	nw+9fp7XMwGrwRL+2i3+6r5OTB7QADW50XOgp1K55pQiNtr3VF/dJzG5NeJIvA==
X-Google-Smtp-Source: AGHT+IHDNO5ydpUr4NNY3Rpyki/cxqgkoUM/sFxM+xVFuU5eQst7LLOHqvPSrbMtdUDKPiyRRzxrWg==
X-Received: by 2002:a05:6a20:1590:b0:1af:939b:d477 with SMTP id adf61e73a8af0-1afde12444bmr30112347637.36.1716053529197;
        Sat, 18 May 2024 10:32:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2bafsm16465777b3a.162.2024.05.18.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 10:32:08 -0700 (PDT)
Date: Sat, 18 May 2024 10:32:07 -0700
From: Kees Cook <keescook@chromium.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Guenter Roeck <linux@roeck-us.net>, airlied@gmail.com, dakr@redhat.com,
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
	jani.nikula@intel.com, javierm@redhat.com, kherbst@redhat.com,
	linux-kernel@vger.kernel.org, lyude@redhat.com, mripard@kernel.org,
	nouveau@lists.freedesktop.org, tzimmermann@suse.de,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/nouveau/nvif: Avoid build error due to potential
 integer overflows
Message-ID: <202405181020.2D0A364F@keescook>
References: <20240518143743.313872-1-linux@roeck-us.net>
 <34a6d812-b4ed-4465-b0ec-e641d185b9b1@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34a6d812-b4ed-4465-b0ec-e641d185b9b1@wanadoo.fr>

On Sat, May 18, 2024 at 06:54:36PM +0200, Christophe JAILLET wrote:
> (adding linux-hardening@vger.kernel.org)
> 
> 
> Le 18/05/2024 à 16:37, Guenter Roeck a écrit :
> > Trying to build parisc:allmodconfig with gcc 12.x or later results
> > in the following build error.
> > 
> > drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_mthd':
> > drivers/gpu/drm/nouveau/nvif/object.c:161:9: error:
> > 	'memcpy' accessing 4294967264 or more bytes at offsets 0 and 32 overlaps 6442450881 bytes at offset -2147483617 [-Werror=restrict]
> >    161 |         memcpy(data, args->mthd.data, size);
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_ctor':
> > drivers/gpu/drm/nouveau/nvif/object.c:298:17: error:
> > 	'memcpy' accessing 4294967240 or more bytes at offsets 0 and 56 overlaps 6442450833 bytes at offset -2147483593 [-Werror=restrict]
> >    298 |                 memcpy(data, args->new.data, size);
> > 
> > gcc assumes that 'sizeof(*args) + size' can overflow, which would result
> > in the problem.
> > 
> > The problem is not new, only it is now no longer a warning but an error since W=1
> > has been enabled for the drm subsystem and since Werror is enabled for test builds.
> > 
> > Rearrange arithmetic and add extra size checks to avoid the overflow.
> > 
> > Fixes: a61ddb4393ad ("drm: enable (most) W=1 warnings by default across the subsystem")
> > Cc: Javier Martinez Canillas <javierm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > Cc: Thomas Zimmermann <tzimmermann-l3A5Bk7waGM@public.gmane.org>
> > Cc: Danilo Krummrich <dakr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > Cc: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> > ---
> > checkpatch complains about the line length in the description and the (pre-existing)
> > assignlemts in if conditions, but I did not want to split lines in the description
> > or rearrange the code further.
> > 
> > I don't know why I only see the problem with parisc builds (at least so far).
> > 
> >   drivers/gpu/drm/nouveau/nvif/object.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
> > index 4d1aaee8fe15..baf623a48874 100644
> > --- a/drivers/gpu/drm/nouveau/nvif/object.c
> > +++ b/drivers/gpu/drm/nouveau/nvif/object.c
> > @@ -145,8 +145,9 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
> >   	u8 stack[128];
> >   	int ret;
> > -	if (sizeof(*args) + size > sizeof(stack)) {
> > -		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL)))
> > +	if (size > sizeof(stack) - sizeof(*args)) {
> > +		if (size > INT_MAX ||
> > +		    !(args = kmalloc(sizeof(*args) + size, GFP_KERNEL)))
> 
> Hi,
> 
> Would it be cleaner or better to use size_add(sizeof(*args), size)?

I think the INT_MAX test is actually better in this case because
nvif_object_ioctl()'s size argument is u32:

ret = nvif_object_ioctl(object, args, sizeof(*args) + size, NULL);
                                      ^^^^^^^^^^^^^^^^^^^^

So that could wrap around, even though the allocation may not.

Better yet, since "sizeof(*args) + size" is repeated 3 times in the
function, I'd recommend:

	...
	u32 args_size;

	if (check_add_overflow(sizeof(*args), size, &args_size))
		return -ENOMEM;
	if (args_size > sizeof(stack)) {
		if (!(args = kmalloc(args_size, GFP_KERNEL)))
			return -ENOMEM;
        } else {
                args = (void *)stack;
        }
	...
        ret = nvif_object_ioctl(object, args, args_size, NULL);

This will catch the u32 overflow to nvif_object_ioctl(), catch an
allocation underflow on 32-bits systems, and make the code more
readable. :)

-Kees

-- 
Kees Cook
