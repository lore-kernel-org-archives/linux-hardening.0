Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623713EFE5
	for <linux-hardening@vger.kernel.org>; Tue, 28 May 2024 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938920; cv=none; b=ttmzlBW4aS9dhYc36eGP9VISICnzRDl1qbEU2RY2Tu31XkNJo70XOK50mprS7S6UEpd9jG0wkPUL97WML6NOQ1SPg1ljmHPfLJkm8/5pFJiJONA6hvu0ByXYn3oCveQd8RBkeZDbBiQHB23d+BTDXRjzpKf8jjQ/WL90qyITpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938920; c=relaxed/simple;
	bh=bfi4+LMwCHwMea1ovFOy2O6UVoaZsvFQiHCHFQXFrk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqDnujUVBDMkEsRGSoDYNZwic37JU7uqsgQ1TPT59r0f96XmiLnSrcfvJOlWHyPcpaVprqNc66a1Wk4kcjAYpjskTGN25WzgZXuB27SFoWqIWVmyKfBtq4AGY2DatV74cio0IxxOo7RYGIa3v40bDCCf8sxewHwQY7+7dr/j74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FjMOZBB/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FjMOZBB/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5755fafa5a7so1732891a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 28 May 2024 16:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716938916; x=1717543716; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JiDK4ZNWMQz5BoArs3vVBPa3TrnNYFfX0vRjhOrW4Y4=;
        b=FjMOZBB/dpj5EWJSDSWXrGWIhj4mD4TeWD1PlPcHsr/keIFp6U+RNGzJqSBeEk3pSg
         neTBSq7i6C7Uojvf2intO6cYW7HUKTPFzBd5h/foEF5a+SED74G0EfCgkTWa9E5EE918
         ku8/W17qBTvcNicWNXwfIs24CUMel2xojIspM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716938916; x=1717543716;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiDK4ZNWMQz5BoArs3vVBPa3TrnNYFfX0vRjhOrW4Y4=;
        b=QNGTkE0rQcL3FQC/b8+Lo8EK2B4a17BAkcO5Y/gAJzxDdM9+gxYDYECgBGHKhfYiTg
         v6AfA/aKfj9/il50DxChbRQfe5WXv/jj+L4OhbGLxG+Ckuf1MX8lJjfj/B8qVDAj7bm2
         5zn37MVI9zjefwS6FdQ91Wp1a1qUnS8rGPXWjX5rweBmmMirjNTrjxKs3lNbRLFwEJJE
         rTRHpa6x+ny8vLsvNJYjTdqJMSjayBPu2EyB9MDBn3OBKmy3yJG9eKp1jG53Im/ZBwr3
         N4ShOnULKxj2YqzfDa1SdV4ec6vwzJfmUSFkNzON4xYST5JlTXNSqKHDjJ60rc2t1D1Z
         PMQw==
X-Forwarded-Encrypted: i=1; AJvYcCXmR8rOssWpzYlMDAh4W1kZIVFQ9lgAYohSLpR8zFNGQ4p7pUAsNLsgoMonNDs1ruzgVIe527ivg3RV99w+gjeEZUjho4qWyxcsMfxl4gsl
X-Gm-Message-State: AOJu0YxZbihLWUTPxLLNy4+GKL0E/STp29N5b/M9/SH97SURIoJwuEOt
	t3z7TKKzwBMxLHGroH5UbyHi49JO9kZkVp8Zi9EUZlsXIMZYm8tUoV9pRtB7Za1Zr7UgZHZJmKg
	L44x0Eg==
X-Google-Smtp-Source: AGHT+IHoBlfWgt+1295VnZacTDpBNJsRZl5uT8iXZwGaZZB79Hzuw1wHYOSodja6QdwERZVK0rccdA==
X-Received: by 2002:a50:c350:0:b0:578:34a4:ea26 with SMTP id 4fb4d7f45d1cf-57851a3e382mr8523482a12.36.1716938916397;
        Tue, 28 May 2024 16:28:36 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c73c771esm4484413a12.65.2024.05.28.16.28.35
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 16:28:36 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so11324835e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 28 May 2024 16:28:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8dC/eQiljUS2PTMj4oqeqRDm5YoYozoecE0gExzEfMwjsD2MEfpDGyDYHM3yhCyHkZ+shSgk5cgMcj2kO0KtVnGoc07HzTDMFsTXjrm6G
X-Received: by 2002:a17:906:339b:b0:a62:28ce:4e98 with SMTP id
 a640c23a62f3a-a62642e96camr856809166b.23.1716938538230; Tue, 28 May 2024
 16:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
In-Reply-To: <87wmnda8mc.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 16:22:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
Message-ID: <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, 
	mat.jonczyk@o2.pl, rdunlap@infradead.org, alexandre.belloni@bootlin.com, 
	mario.limonciello@amd.com, yaolu@kylinos.cn, bhelgaas@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, 
	LeoLiu-oc@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 15:12, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I principle it applies to any clocksource which needs a spinlock to
> serialize access. HPET is not the only insanity here.

HPET may be the main / only one we care about.

Because:

> Think about i8253 :)

I see the smiley, but yeah, I don't think we really care about it.

>   1) Should we provide a panic mode read callback for clocksources which
>      are affected by this?

The current patch under discussion may be ugly, but looks workable.
Local ugliness isn't necessarily a show-stopper.

So if the HPET is the *only* case which has this situation, I vote for
just doing the ugly thing.

Now, if *other* cases exist, and can't be worked around in similar
ways, then that argues for a more "proper" fix.

And no, I don't think i8253 is a strong enough argument. I don't
actually believe you can realistically find a machine that doesn't
have HPET or the TSC and really falls back on the i8253 any more. And
if you *do* find hw like that, is it SMP-capable? And can you find
somebody who cares?

>   2) Is it correct to claim that a MCE which hits user space and ends up in
>      mce_panic() is still just a regular exception or should we upgrade to
>      NMI class context when we enter mce_panic() or even go as far to
>      upgrade to NMI class context for any panic() invocation?

I do think that an NMI in user space should be considered mostly just
a normal exception. From a kernel perspective, the NMI'ness just
doesn't matter.

That said, I find your suggestion of making 'panic()' just basically
act as an NMI context intriguing. And cleaner than the
atomic_read(&panic_cpu) thing.

Are there any other situations than this odd HPET thing where that
would change semantics?

               Linus
