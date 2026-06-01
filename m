Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADD3242CA
	for <linux-hardening@vger.kernel.org>; Mon,  1 Jun 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780301522; cv=none; b=Q2IdXlsPZGafqIls/d0SJjsyNsqFarLSefikt4oZh338sjUrSbBNwFQum8eas8bJ2rVK6z22mNVq3taPZLKS1nnsRhHmr6cdjkQ0dkSJvKLrmAOakONpDy8v3X+nPjRe4f4epl5T4i8UK9QugtXNoB9mFlMJTlM81LeHGbcXgx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780301522; c=relaxed/simple;
	bh=nnuOMcbYOCL4y+N/0eemC5pbxvM0uxdM9ZqpwqEbLSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0iEZq4nZ1XDZcJVhnRjQeY6p2WFEzcO4fg8U6rZEvRwl59qmdpw+2OHbJqeK+lW8h8l0Jfof7wMRMdNX3p6dP4GrS7VJVzOKiHJ0RAcdnd/gHxz/TmBNLkN0aDqmxOGRAI0djdmy0z5muVDGbKhTZCYd3H0RvBdmhGRUHeUzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-59e8ededf4dso888535e0c.2
        for <linux-hardening@vger.kernel.org>; Mon, 01 Jun 2026 01:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301519; x=1780906319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6bsjRyMlYCGVZWYk2Y60sUCqRedkIR0Vi6kAvx0wUs=;
        b=qO08518XiyLgipD36PqXaW4mV40xHaHo6jy3V2YsRnC1yB7Rt+ZWT8F3RQdBqMI2Ps
         MFi1Nl9kiU7sv4J3PE19sQL0H94wCHMPTuYRNNQjGZQiDcLTKpPrex0PSe4me0ZjeA/B
         MOoZ5f2JxpFYIN8m6IXFECXZQMANi6CUQ77WhHgrb7BmMKbfXh6ZTmR76vzWIGnxFH0P
         tOvunQRIYZxF2GB6MS1uHzCNe7HG0Jo3OAcvfpoJ6b2qyA8pvNKbfPmFRTKwagGmCgfR
         SPc9032ft5OZoEdRkqJaKpPBWGOD2DpxNyIv0nHkq9HunI8JP8BadUKx66YPBxv4SEJB
         hERQ==
X-Forwarded-Encrypted: i=1; AFNElJ+biYU3R0+L6mJMqbvQtR1u1+qzuXFF7w2lGboQ3QeAViDqg+cLVT7/d5RdD8ixpf8NB3oEfKUlvliXS6n8Cvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwswrVBediOqySRwy08vR+XyqEu9FEUmbF9KFUAyinFfufF16ML
	VeSIv5OZzytW/QuEXs6FbdhRQGiDBAkWzZLnzgCz3PIVu4+h04w/2bNIAgZgo+8o
X-Gm-Gg: Acq92OGGqFQaIKV99b1QsKXL2l3kdG7XL8yAkAU/WaEyvXU6nzFwryyDKkecaMO7/9e
	1WbtXBbUDI7QFBNv71pn7sTxbag0YLvfbZj2cFbUPkC6omkD0W27hCQS9J5X95Pea2a9qI+0mAE
	uKvrSY/XrLwPyUPme4dtFq+/lnGW9Qk03RiuHfRC9vVPhFoJTohXfPrTYesMwFZQSTtKVq4wlpL
	7sHgEJaGYznl8rPL8SUjaIP/Dks0gWKns3QHi4ZQX5zyn1dKh5NL0MCjKxPKnHv/X7uqzbJLF1J
	my/PPVbg5VbPl7dK59tAvdqPy4NS8cLyY9Jekn0J0GAA9JOpE3uZeNmsgilAr04z4spjKP6gdhm
	vPkn+AxXpCBi3mSi9r8aK62UxjrNbzAh+yracl5HNpbP98A+Ad943mPEn3vBILrRtyncSommErf
	k+kG0zB5l6aDThZldnCDEoNBI+YTtu1IMazYNFl/J5DnSecvyCeldo3Y+H4T0TdUYPQPzkvGk=
X-Received: by 2002:a05:6122:7c6:b0:56c:ca03:b668 with SMTP id 71dfb90a1353d-59bf116eafemr3661714e0c.3.1780301519279;
        Mon, 01 Jun 2026 01:11:59 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5a1c3c784a2sm1084467e0c.15.2026.06.01.01.11.58
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 01:11:58 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9639aa8ca17so2384997241.3
        for <linux-hardening@vger.kernel.org>; Mon, 01 Jun 2026 01:11:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+7Oq4q3X5AweMUjo1xCyr4amqx1ClHKsM7mR6ZPm1oLhBmPXF94cT6Fn3l2wz5fLeL8owksCW74ZFVV5B0lDY=@vger.kernel.org
X-Received: by 2002:a05:6102:3ed4:b0:639:4bb7:c916 with SMTP id
 ada2fe7eead31-6c67682807bmr3734166137.3.1780301518249; Mon, 01 Jun 2026
 01:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com> <20260529150150.1670604-29-ardb+git@google.com>
In-Reply-To: <20260529150150.1670604-29-ardb+git@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Jun 2026 10:11:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXp0qp38vHJTDFMrY-AUDXPSJtc5Dds_qu58FSeS_242w@mail.gmail.com>
X-Gm-Features: AVHnY4I0grL2HGASleAgF6ybT4VX0NqDy8gokQJ4KkNhvH_ouOMg7ryFWIbyvcA
Message-ID: <CAMuHMdXp0qp38vHJTDFMrY-AUDXPSJtc5Dds_qu58FSeS_242w@mail.gmail.com>
Subject: Re: [PATCH v7 12/15] sh: Drop cache flush of the zero page at boot
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 May 2026 at 17:02, Ard Biesheuvel <ardb+git@google.com> wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> SuperH performs cache maintenance on the zero page during boot,
> presumably because before commit
>
>   6215d9f4470f ("arch, mm: consolidate empty_zero_page")
>
> the zero page did double duty as a boot params region, and was cleared
> separately, as it was not part of BSS. The memset() in question was
> dropped by that commit, but the __flush_wback_region() call remained.
>
> As empty_zero_page[] has been moved to BSS, it can be treated as any
> other BSS memory, and so the cache flush can be dropped.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
