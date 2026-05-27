Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546F3563DD
	for <linux-hardening@vger.kernel.org>; Wed, 27 May 2026 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779874291; cv=none; b=GSq4WmQc8ndsu77cd6HBRD/S3OteI8ZqsUAIZnyshczw5vWfSLoueFUlvLideR0CXSZIRMJeuQRODjeULrnbbBLLPEJQcHuNs5PriISbWSrkPvDb5guP0Jqt8HGkNkrP+E2gZUCxYDxAvk4T8cf14b6VhHgZfzted+jsvPmYORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779874291; c=relaxed/simple;
	bh=MIwNRIQhmMvHp1RJPcezhJTrNh/CER1g8LrsudZZBhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xkq5FavzaQlE60OW7XL+Q3CcdWYqkNzHIKss4JE0LIWb5fIsepuCEoDH1S2whlHsa62QAkjOM5QZQ0TwEQVYrJchLDD5XBJjhFHNdL/FK2I+qp0OekzjPCvCQWbXtNTiracKUDZYR9XoQaHUr0rk1ygqXwGBZdfkImlCb5FXxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5774680983dso4018700e0c.0
        for <linux-hardening@vger.kernel.org>; Wed, 27 May 2026 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779874289; x=1780479089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jh4B5AC2q6XDT+EhwYr9A0M1dYuh/w8VgN+zze6pNI=;
        b=VPyo4uytHV1VVN90j+6mxbT7Ux5dm1iTZe7Hs2AliM1F9/tQ0lq7I5565VqMisDO9y
         nsQRj80Qh/244kinxwwf2WO/shA2YAdPUF296WVsaZgQPWJkesZbEh9sPnMrlF8nSSoi
         CMHovR3IhrNy7toHwTCoNZt/6JWU1sBcVtGcnW+vx1VTZgu3mk2PSD1oDbyW4FHMI4we
         FPM6Zf+yed7Rxa+M/vEmXbIrQnMSusqZgvR8wcy6FfZI5FnJfmRgjIhqEjvW3ao+T+4W
         moZYfHnV6Z85MNhQl2oj7yAB1LmxMtJiu4NBiRtmoGxsvmZrDNu38F6sWYekAzd6PH70
         BahA==
X-Forwarded-Encrypted: i=1; AFNElJ/brWoFWEP6CxAIi3nWW3Ji/TpzAsCWGrXWJPgvKZJPtxCnbgkkk9RkbtrgSJJoZH1XrZlUHNiM/yCgBdAsMQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFZAKUlrrGRHmucp/yJWG3s7fathEAq7CbqGrtFBYEP5MvTHjy
	/RTB0IbWkEey6lfqdSo6DGhKIAxsLitRwJYnnING5gk23/4TLy8J589LhdDUNZKyxQo=
X-Gm-Gg: Acq92OEskuvOO88FtP8lbjeVdoa2WQbJKklv1AovKe+B4yuti3QgYdwKP0jUfd5mylg
	zBXDm0etTTaiRw5AftsIt8ATb3uOmK64pxgZl25hDDI/dFlOtibYFvuidGoYJNGZCnSvbHCe0Oy
	QDdA61YKEBVbMB1daEv5H7KDb0bKIBs9mXWaawY3DmGbEZ6p1F4x8bh59g1C5MCeLZnfXBfuL7w
	oQFfHXUykAmY+axYrtRsZ7TzaxL5RS8LOw3gp2w7VIgTlftrBsNT01WcjaiFtyclgVP+oBWqSQ6
	OLUUisPAXkP8iYhH8cdwY6G+XH01Oya0MPyM8Wm4+kCxBtFnBrWyF83NobPO+IDgx38T0InbA5k
	6YDdoy3E6gpmqTtPcY66+SFwHlcexfLGTwO+fBXTCvG57svc5BqURA1ZD/RUHutGbkwr6ysHEuC
	XMT8kqVBUvCVD1rXe5PTpgtuCOYQUtmckc6zWmGq2W6QJgJqn2RZX5qDDNREBYSCF+/O+bpWs=
X-Received: by 2002:a05:6122:488b:b0:56d:9e98:4676 with SMTP id 71dfb90a1353d-5866357db32mr13048625e0c.13.1779874288841;
        Wed, 27 May 2026 02:31:28 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f25d708bsm20660501e0c.1.2026.05.27.02.31.27
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 02:31:28 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-63133de7abcso3682973137.1
        for <linux-hardening@vger.kernel.org>; Wed, 27 May 2026 02:31:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+QgxRoMb9mpNmZ4MFwYRYERYwgio1WI9H50Y6IweVW1vGAZky6daXRqlqQ8lDqpxSULj3efGuQ4tZHgi05E1I=@vger.kernel.org
X-Received: by 2002:a05:6102:54aa:b0:633:75d3:3545 with SMTP id
 ada2fe7eead31-67c84ad8af0mr10485506137.30.1779874287601; Wed, 27 May 2026
 02:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com> <20260526175846.2694125-30-ardb+git@google.com>
In-Reply-To: <20260526175846.2694125-30-ardb+git@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 May 2026 11:31:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBcpw8NTg+EVBmwiRWY1001EN94J9XstHG9o_hyUg8yA@mail.gmail.com>
X-Gm-Features: AVHnY4LA7PW8Q0XMk7lUiX1q-1VC5_AKr651tENC3X6CCFiZsD9Tq-B3NK3PBjs
Message-ID: <CAMuHMdWBcpw8NTg+EVBmwiRWY1001EN94J9XstHG9o_hyUg8yA@mail.gmail.com>
Subject: Re: [PATCH v6 13/15] sh: cast away constness from the zero page when
 flushing it from the cache
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 May 2026 at 20:05, Ard Biesheuvel <ardb+git@google.com> wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> SH performs cache maintenance on the zero page during boot, presumably
> to ensure that any clearing of BSS that has occurred at startup is
> visible to other CPUs and DMA devices.
>
> The __flush_wback_region() function takes a void* argument, which is
> conceptually sound, but given that empty_zero_page[] must never be
> modified, it is being repainted as const, making it incompatible with a
> void* formal parameter.
>
> Given the above, and the fact that __flush_wback_region() is in fact a
> function pointer variable with multiple implementations, take the easy
> way out, and cast away the constness in this particular invocation.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
