Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4B8175A9D
	for <linux-hardening@vger.kernel.org>; Sat, 28 Mar 2026 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657782; cv=none; b=XnnGyjjnki32zhxVFGqlAVU9JYNL+Mv+khGdSqPpWmgjSFYSZbunm/imB8wU535iSOR03Dw8WkzUZL8xUCfGbA8yFf+4GGhdNazCYYOFpt/1ib4DIjk/MjW7NiKFx4SaD8jq6/aEgYcJJDZOOm4TYCf2Hwx+tuNhyxnMKb1MdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657782; c=relaxed/simple;
	bh=suO3lo2F9dJdqvOxdL9ii/GapbhUXYkyKF+qQSOlxxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c27BbbIN3HRxeGkUIwOY12urQB2F3lGIepsAK2LesglxoKE//sPxzdyjg7ugJZ7mJBnVrQcN1GEQpTDKYi13wtb0PPpf0emmbieGVHMg8qqOC09t6QoC1d43K4/LloANyOgQbiMbbt8iFHzcoSmGmkXzgMQvJQw9z5upfKmAcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZivyTQQB; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZivyTQQB"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66b678e75fdso623686a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 17:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1774657779; x=1775262579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80Hu0q2LFDiBessKiqYmib5y28iWvZjxzN+iLP/E1LM=;
        b=ZivyTQQBZJ5pWAUe74TzxdDrmX6ZBp54joWQ9cxeop9mDenryiYT0LW0LpDzSYIzv5
         kUZVqK5Lo7N6XoEPH5I0RyPAOwsfPbBTxrllKDB9lfIj6tniHGvjkmqZ0YZOEht0Ganv
         6g+tu7xhbAogmcXqTKGEtxK9fKsIrcHBLa5Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774657779; x=1775262579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80Hu0q2LFDiBessKiqYmib5y28iWvZjxzN+iLP/E1LM=;
        b=nGsjJzGKgxZ8tAeB0Rk5YlD8SbBhCQVzRTDLCoiW5i+gLlbLmSJytT0gCQeJ5006NQ
         yFHPxtDH/wYJsjs3lbxfeFCncPGwkG5SO8OMCRk7jylpUlpPgKWQJqNsr7wV3DsCHTKp
         eh0jdEVKjMU1YLiudSJdLcgSDwfbiTwwCvaUnkAlH/9MhESFwWSeQp0aDSpSj859D6bV
         DFkD5hvZPYXzxOZNW36bXWw4SZ1h3Gx+9AIolwYWVulaUDx2oSryc56aUg3Z6t1dZ/Ib
         ayUsN4IRHHDyYq3HmkgFpYLxSgrIOQSqk70MqsHtAJb5GP/TsO+c4ViZdNOHoFsU88g7
         BT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVs6Z9LIDpOECm1EtknubzLvrKxB5Bjhrhm/yv5vrMbAYVhu0i2/PsrGPDvxQWDn2NJy4eVYxADCUR16cc08tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2qnOom23IQNHORLqkc/xpvCkvywiMyO5p2P/pEgFRvk6iTlu
	JReUrsZw/qGBGyMsaWyhR2uonphKbcfHvFWb50EfkHrybWvXD87gRHO3chFSq9+rCaodBVwUCKU
	Y95632n4=
X-Gm-Gg: ATEYQzw7ggPIiCWj8SbSzorlbFhjv6SalEW0+9GEMjl2zbXMunVo2uQ4wIfkO0m+pKw
	9mqcDAG1NRUSn5SWH8oHh4PwJjXwPt0/4niPOBPdUPeet+ZoRKdJ/5ZP3kma9w6EQe/NsD8HY+C
	kBcr5M/6JNsiU4t4mxC7UssxfRFHIsjjCV1713PNQNAisxf7ZlazllAYrAl11Y/HPYhRs/0rVOO
	Tb2m4ygGn0RJUdHpW603h45WDFKroJ70/zQpZbxaG/alpLZpFp9NLNRme+Y2FY6YoiOlpVnSzV+
	wIBdb/4/45zlSjD1oDhdkW7T5GEYX2Tqd8CzqhRDILbY/h6QLSzCdblYPnC24IPv+sP0oLAikYh
	3Wihu7rMBTa0LxldBFY8zdwgUttg+9U0RB+3BCH2zKdAmcZRsfO/1LDXvy0198zvfAqY3Vvt1lk
	jv9looAUI0cXFbZ6Jo3h3U1ESCbbpt6nygmJIXFaWoSZ3zbfdRqjYZCpgEGtIuqwHfPR5Tp0Pa
X-Received: by 2002:a05:6402:4618:b0:665:e9f:9021 with SMTP id 4fb4d7f45d1cf-66b2855f8d5mr2488436a12.9.1774657779078;
        Fri, 27 Mar 2026 17:29:39 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66b72762eabsm216525a12.4.2026.03.27.17.29.38
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 17:29:38 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66b687a8b2eso440337a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 27 Mar 2026 17:29:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCSJxPWfYtlgqB5FoOrsTz/46tvo/1cPUWC4FbD28tl85TramDQ0Ph/Qj46UBS8mER0ldhSM/siNyZgGfILns=@vger.kernel.org
X-Received: by 2002:a05:6402:35c7:b0:663:71dc:1278 with SMTP id
 4fb4d7f45d1cf-66b2836b448mr3122865a12.1.1774657778203; Fri, 27 Mar 2026
 17:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327195737.89537-1-david.laight.linux@gmail.com>
 <CAHk-=wgADjjXEN_8ANbU_E94uxbQHW-3v5p0-pwLOtTvL+0Wrw@mail.gmail.com> <20260327224928.7c4220cb@pumpkin>
In-Reply-To: <20260327224928.7c4220cb@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Mar 2026 17:29:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHK0tyYym=gkq4YRHMywbuETcn835=A7uSTSTPspzf1A@mail.gmail.com>
X-Gm-Features: AQROBzB7tifXJKjULYWA6BpuqofmbetCAlehiETew0gYazpzj_tKkEBE2LPiJNs
Message-ID: <CAHk-=wgHK0tyYym=gkq4YRHMywbuETcn835=A7uSTSTPspzf1A@mail.gmail.com>
Subject: Re: [PATCH next] string: Optimise strlen()
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 15:49, David Laight <david.laight.linux@gmail.com> wrote:
>
> I've not measured strnlen(), but it wouldn't surprise me if argv[]
> processing wouldn't be faster with something like the strlen() in this
> patch.
> After all arguments are usually relatively short.

No, we used to do those a byte at a time. It was not great. execve()
strings are often actually long because of filenames and environment
variables.

The trivial cases don't even matter, because all the cost of execve()
are elsewhere for those cases.

But the cases where the strings *do* matter, they are many and long.

Again - where did you actually see costs in real profiles? We really
don't tend to have strings in the kernel. The strings we do have are
from user space, and by the time they are in the kernel they typically
aren't C strings any more (or, with pathnames, have other termination
than just the NUL character).

           Linus
