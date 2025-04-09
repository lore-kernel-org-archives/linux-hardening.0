Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED63198E8C
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744220562; cv=none; b=ZDR8/hbbG04sudu5gpZ+RqjQYLkoUDj8ivY+yZOtueG+KCs1AqyY5LFLElslg1R8ysz0LmHa6ur27SHcSjXWmTv+HT9ZRpNuRyWkBijNwhOqC0qvPvjTcIx5OmPMoyWcIZbK/z8vt/v+AWzwIdcy7DlWnnUqCYM01xGG9bIzRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744220562; c=relaxed/simple;
	bh=6nNQatqaorKzv92tvaje0/GNGx2i/9tcg23Gb8LTF+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmBppcpm0f5xxAXnhT1BpjdDnM9PzI5aQNCbMUuw9lZVNLfmr1BG2PRsU4vpbUb1Vo9wXjCpAbcG9RqpZbysa77bXZ6Uu71LUBnpax7zmkHAIU0ui2w0DRqvh8S1IAG6UWZtFPoJZq8pcLt9uHV5m8M1SO/MOrynhp4VCafMKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YKtQ5QIO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YKtQ5QIO"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so12908749a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 10:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744220558; x=1744825358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoBR+vDT5PVn2pWN/hnunYWhxqisiDADqelTleC033g=;
        b=YKtQ5QIOl/K+7u2vBZ/t9McpkRu5hoZZaDJYMwzssuVjUx5nUj5Vf6NzOV3ggNp6iV
         XVdidn5tjIlrd8b1vdQK7MCgFnI92fA4l8M+/ZxLMj/SU79H8OHgRT8BBGVh/jeBadAv
         VXQfaTWm+bRKd/KEWIlyohQSPpbBNWWRwW+m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744220558; x=1744825358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoBR+vDT5PVn2pWN/hnunYWhxqisiDADqelTleC033g=;
        b=uFUld/u4e5B8TqDsW7O10uHJfxNLG2Fuwqd1l9+DA0FUtpHNz+WEcZPZmOktIX9jND
         Un09z+xBmsPJb7lbjbycH2yl4Bj+sLzUl6rbmmGJdIwPfYZZrouMOsIwa5+BPhI2AYM4
         CKMoQ0Zkl6zKgeKOJz+Gyjd9XPAuCbL7YAPFAZ0MY5655BXdE848MgQCRnsYTf4ioDC8
         OSV1B8aZ+kPxsCnlD9+9e3whAoLpJddwf10yxbANLUwXZD9sMCAcoQehejU8pbp/WQZm
         ff7bzmoJoVeZhlhvNdguZcGWkQa/pYElh9t7P5nU5tjaYaPQjUt4tgLP3nVj3vbZEV2D
         KOIA==
X-Forwarded-Encrypted: i=1; AJvYcCUyBzDJD4t9rQR/obYrY/tQGCnx7dz4elO5WqZEB5Jwi5GOtWQatpk0laCyQJM1An1GlBug/bzDgAnNHVJGc1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4QoqMxUTkMptq26speYgmlQVAzzRM/2ndyArGcIvPgesL2Hd
	xTTGTdGaFxUzrQuNS20sdwpwmVobBAE7hJVdVakc4q8HsFcTCMlJPmMFett61LMBfcj7OWFQQn8
	nK4k=
X-Gm-Gg: ASbGncv0k/r0t6sbKAvXXu9smixuBqRW+9rvOx6zU60dHJ4MPHrry6kvM4xzg4SWx3n
	NPT/z7b5Fh/7BtIESs7Yoh3WrHiZg7ziSHRJgL/xMBG/zEo7FbvwHyiuvAuY5pUQ+ZhNE46EcFX
	mPgzqv8BXuSG4+Q4fkQ4vvbaJKIGSl3kCCG+LgVhrYIy8FcIJjJTRZy1qYszs3sfM6+I/mT6eIk
	9ph8HmC/XzIHL/gOOyuxlIPy1B0oav97hlK1Peco7bChyuf1SK1wEB9kfJQHsUtJlCfQD52DAUk
	iG15/zx65CzWRG6xpWMqYJIfrT3J8bGegpprc0IGadIf337/LYDTOY41Y3KiAzvqMljQDi7BrfG
	jRmFCl6eDu/QuMuw=
X-Google-Smtp-Source: AGHT+IGhaJ4FlrZ0cIpdoOemjQdYASmyMrfd47ecO7hiDXpXPyaJRTvhvZqJuuDrNVTD69c7vDBEXQ==
X-Received: by 2002:a05:6402:26d4:b0:5e6:e68c:9d66 with SMTP id 4fb4d7f45d1cf-5f2f76b2c05mr3701640a12.8.1744220558285;
        Wed, 09 Apr 2025 10:42:38 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fbc08388sm1078090a12.22.2025.04.09.10.42.37
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 10:42:37 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso1340326166b.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 10:42:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqJzs20PR5C8WNAePAdsaZ4SQav/VjqymxJ8TLOpRRNY637a+35SyiIdHRNumbKyO2BWZT5Zwz++LOxyBbIDk=@vger.kernel.org
X-Received: by 2002:a17:906:6a1d:b0:ac6:e20f:fa48 with SMTP id
 a640c23a62f3a-aca9b697344mr478182666b.33.1744220557177; Wed, 09 Apr 2025
 10:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook> <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
 <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com> <a9a459c2-674d-43dc-9e27-41de0471f602@sirena.org.uk>
In-Reply-To: <a9a459c2-674d-43dc-9e27-41de0471f602@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Apr 2025 10:42:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKEuQQh2JymabBQLrLs=pEfx0qYVmUnYZRq_tOFj90sA@mail.gmail.com>
X-Gm-Features: ATxdqUG-Bs73VX2eSGz8XZIzzueOW3xC6j3KpNJoIRi6w4YuDwZR8xbIvrtKvKY
Message-ID: <CAHk-=whKEuQQh2JymabBQLrLs=pEfx0qYVmUnYZRq_tOFj90sA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 10:29, Mark Brown <broonie@kernel.org> wrote:
>
> Sadly it seems like the build bots didn't find it, or at least if they
> found it they didn't identify it well enough to end up with reporting
> the issue to someone who'd fix it.

I wouldn't be entirely surpised if a lot of the build bots end up
running old distros (because "enterprise").

So this is presumably only happening with certain compiler versions,
and I expect the build bots have a fairly small set of compilers they
end up testing.

            Linus
