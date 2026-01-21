Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09914227E95
	for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993042; cv=none; b=qzTLOy2bAa/9lAKThwqn2hZieNexAtE9Mu9l0omKohhGe1hHPnzBHX1i/76kw+g5BIwyzhvZrRQev15ezpn/hOzNJqWKXzUJRsHyHUJPK0cXFQmIyMY4fowX3y1k/K5m157CGf4QTD1vrZRk/dVExKm6rBdg8G5KrzxN6t0lfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993042; c=relaxed/simple;
	bh=6qplPAyVow+/kBcikqN/WhOSwSmC06WyjvGEIzOsqts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NgGExFeLvXA6x52E0GewAsOIa0Dp+ww1LM2TY6QzOvhQnhEsEEv1up0CYQPCs1rr6NISaM6/TuMrunG0ZyCEpvkQOESFhtU6aBeP3rv1RE5AuqmCB0kTf8Ia5XrTDGEXYNh+qi/K54IMsC+y2kLHTMwWJ5NdBwG8tTFM1risjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k6pWLf5b; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6pWLf5b"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801bc32725so32609285e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jan 2026 02:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768993039; x=1769597839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVe0Qk3VMjV2txWtY8q1b+FCjHEWppjlIBEVCNldeh4=;
        b=k6pWLf5bxr5676PqQK9Ku/bSHMv4C9x5WbofSmXmMakGD/MMnzPEGf6wLsgcbkvcns
         bCGGZytiiIhzoNHcIIh+t1WbUdA2qfXaghKJkdlw0plxu9pGWwLHN3he9afpnYnz35XM
         VXbTzDPMfEIuGJzDthkUsXEFsOW47g/YwLxjOED49nJEbNceJs4C+qHQMkhqQLOQ9SA/
         5PxAYGq40U52CJ1Ll8xf3rZyIzGFl8E2wvTFvINhLeSo2emMkDt6O+v1AhsCT9i/6i1t
         TgU1DH3kFpc6yoKokJKnv1p+BSFs64uJ6eIMpwGtLA0ff/lKHi6WI0xNwH6dvjAkghRK
         L5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768993039; x=1769597839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EVe0Qk3VMjV2txWtY8q1b+FCjHEWppjlIBEVCNldeh4=;
        b=JPsyOwZk7WqPKwZCHYPNWL8NrEeqWiEtKCnxEiLfqbEf2YclNZiiTZekPO0vhcNPGs
         9QkWrTj19FjhECQMpPfrb+u7IGapwg9H4J8IswyWzPKouuPG64u0VUgUcZoD5xfRvGaf
         IPEMg/b078AlxXACJ3lVMYcPoifUDte8EwcUtnIJ8q4IOUzFzAxKjMWPVDAOqXK1UINb
         863GPpaVuoh4+uLxLseWX51uBjuyO4cB7WtFIdCuJ6eFxHXmC37Rn5fkFKqa7mT6TLt7
         cmM7Vvp8XRlPQ9r1vQU3gCNIQyIVq5gr72rnTZaI+Y98NNUUtkY/54dGQiMHxdhugmEs
         dI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjiIt4QpiF3rinQ8AvpCLpTCeDZ1cvQN/wXkVRYkmkyMz73Bxu1FE2RVwiCQyxFHpUh3OexV4jxwYxP+YmExY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6mxJCVx5SGNT2xnggWVOZ97DvgYM+O96fWHl8n1cb8gWHkcu
	KIDkGX/zgq731t8SK+75cfJ35vCT4hz05ALLOrYJDcAaqN+0KSylmwoj
X-Gm-Gg: AZuq6aJ/jqK1yJh8/q49OKVdNozy18mud2vz1paTYlT6ivp83JwNO0Y//5EiKH0gXZS
	TruUjMaR/BzK5NIbhedFDCQaTHg0qFrn0ZAbGCq8nvNCfvmcb6gsikQw1adf5W9VEo8kj78ep8V
	s8IvB9KNB67VIUvozalF0rvXvtwdd0wFqdOaOVoe4UE2yLJup2S0RdfkXBSkedpDH/SYYLFD4I6
	RbqS+g6uszhIHoSH6xKhpSsLyC3n/oU2AVUOYbccvVHPLKaBzQ8dwqBGzIkIqSrt6dH94+XUJOy
	qYfMb5uPs9TiCagRo2Og0mScVQ3ptDixpOiHxhHrR2EC1AeJ/dJgqUArULyRMA81krYnbxDtZqb
	52MrejcFiAg5167zlwgcRqxKQBHWmtnAArjzRfveWia6yMqoe6F/q7nhmG/nI5jIDpkhxgoSZHJ
	WjvWXp6c+Dy8xMF4mL9c5VlQO6V1wPPhnYPAUd32DoIaN4Oa+dAtEKuQVL7PH9Pyc=
X-Received: by 2002:a05:600c:34d6:b0:47e:e20e:bbb7 with SMTP id 5b1f17b1804b1-4801eb1080amr246838145e9.25.1768993039340;
        Wed, 21 Jan 2026 02:57:19 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4802dc90068sm259182585e9.7.2026.01.21.02.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 02:57:19 -0800 (PST)
Date: Wed, 21 Jan 2026 10:57:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Feng Jiang <jiangfeng@kylinos.cn>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, akpm@linux-foundation.org,
 kees@kernel.org, andy@kernel.org, ebiggers@kernel.org,
 martin.petersen@oracle.com, ardb@kernel.org, charlie@rivosinc.com,
 conor.dooley@microchip.com, ajones@ventanamicro.com,
 linus.walleij@linaro.org, nathan@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 0/8] riscv: optimize string functions and add kunit
 tests
Message-ID: <20260121105717.04853c5d@pumpkin>
In-Reply-To: <CAHp75Ve_pyVm430FL=aEAw1Cnf-92T3Y23qh7pEOaMYMp9iyvw@mail.gmail.com>
References: <20260120065852.166857-1-jiangfeng@kylinos.cn>
	<aW8whGcAR0x6FSRJ@smile.fi.intel.com>
	<691a0183-6f41-4956-82da-abb69a449919@kylinos.cn>
	<CAHp75Ve_pyVm430FL=aEAw1Cnf-92T3Y23qh7pEOaMYMp9iyvw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 09:01:29 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...
> I understand that. My point is if we move the generic implementation
> to use word-at-a-time technique the difference should not go 4x,
> right? Perhaps 1.5x or so. I believe this will be a very useful
> exercise.

I posted a version earlier.

After the initial setup (aligning the base address and loading
some constants the loop on x86-64 is 7 instructions (should be similar
for other architectures).
I think it will execute in 4 clocks.
You then need to find the byte in the word, easy enough on LE with
a fast ffs() - but harder otherwise.
The real problem is the cost for short strings.
Like memcpy() you need a hint from the source of the 'expected' length
(as a compile-time constant) to compile-time select the algorithm.

OTOH:
	for (;;) {
		if (!ptr[0]) return ptr - start;
		ptr += 2;
	while (ptr[-1]);
	return ptr - start - 1;
has two 'load+compare+branch' and one add per loop.
On x86 that might all overlap and give you a two-clock loop
that checks one byte every clock - faster than 'rep scasb'.
(You can get a two clock loop, but not a 1 clock loop.)
I think unrolling further will make little/no difference.

The break-even for the word-at-a-time version is probably at least 64
characters.

	David
