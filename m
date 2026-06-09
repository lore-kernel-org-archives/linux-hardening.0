Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59638E5DE
	for <linux-hardening@vger.kernel.org>; Tue,  9 Jun 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998930; cv=none; b=s6tq+TW9dN0VyYBjtUNCFnnxVW7LPQktQ6C1omCkpZ0oXdxrAanIr3FRA6vd+1s9cdBn/PWdNLRTM0Ofv9ulujI2YAyqg5+QrOmmxhCyvTdBrYv/sWECubXjuZsurjIQS/PN65B7qmkwjCTusO977KfUEUejRkzGtItDvDKOjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998930; c=relaxed/simple;
	bh=LMAkeVaZptDMfPIXMRgnhcXwRYr1AtJoIiiI7hhG/Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyKaUK+a9jmOlN9XuMFYZBAr+jLJg1EIYUFDRNlfLr3BH81BsmsiWBbDXUbLhuyzMlvyU/MwXOLKuS1ngnWWCc6ReCl/Gm2F/ZiLulLcOjsoO1Hdr+D6c+K0AzMAMXftak9kF93fN01otYrskL1uyMDsNYPHy8ZMWEQj86NEkdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-96358d0a024so3661141241.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 02:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998927; x=1781603727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/QDHCd1pzNPKIKT6XsNCXh/My/ujozGgvsOiDCA3LA=;
        b=bluZtR48k6pQuYJSxp8m/PDglDJGbIbi8rfbDF06nYZfEASJDeYQgciB9HjHQjZWvy
         5NxbUQfhKwFbZAjG5hHd801WFH6LZ4+Oo9f1lm5e77arxNrVEFnsPt01mr9kzXh50hHx
         DWKvCZ6++pP7nnF9pkmfr73Oy5HgJtxO1HsZuzMJu/xn1szQ93Jli9AFmxTm6SlnlH3m
         ES1ogR/B+y5Xw70LSAFJ60XV2yxXAQvt/scdJ+ArMpgHmUL1TLsTOvhZqfs/tpT0rr/G
         zI+hJbs2mF9KIJfxj+qo5QoiXyFPCHYw0WM0e4Gf19Mi9Kiq2ebOqNuOF0yO/s9SDap9
         8niQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GxlYej2I8XCVr/db3lCwPhxlc+dTCxVgh3vjHPNHFPK9GrN2pTOdt+vv0WS0xdxK5CTDvciYmu0zu+O4+G3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVUl4Cb6/AIQv3b9AY1ySKj6/scJV5oeptl1N7kNRK1TXiDatu
	taWmQLh7iIvkFR68VxJWnemKy6v/5IOulhC8xjRTDCPZV6LhAieMi4ayA1t6adxt
X-Gm-Gg: Acq92OFvOQKn4mISbOHGpsuJvkWaFFMG60fu1y9dP2IVN2l1U+PLLBUw9bmY/gsOJGE
	kYJOfjjCEgN+vxUCu5rc0gXV4LcWIjq44asKl1ovhzwHW1FGy14w4Sb55fONxttLFnRzisVZ+Uu
	GZbJUzR96sm2ECJZPExU2Rsd3VDsm6TOWCbhj9UlmXbSlLeZq2CukMz90LHcek/l1rUnYKLko28
	aUbGrsSPt+aBevEHjGcg8T/pz06GVrPtkD1dmaOoyA+8KRTrpsjdY15yMU/Qe1Ytkt6g5L9S4Ju
	NO4F3Qz5drtAA7a6wkBvArfsBoSWdR/kDCqzYYlbQHs40casF+NyXHTU8iV9XTd8/wZAkVKPXnb
	eX+M9dnAfqRmcev1GCEXxQgjFX0mAWxLNAsbl2IJQEJyV5YvoI2B2v7Jw+8HiCvQRPtwk8cjfSi
	YpLHyWwquIf3sQZUNDiiXEzpV5pF/5dNwGcd7aLAPYhIQKD4wrFuJ19DSMWWbZDTY645mID8A=
X-Received: by 2002:a05:6102:5694:b0:62a:1bba:64ee with SMTP id ada2fe7eead31-6feed1adc0amr10175145137.6.1780998927421;
        Tue, 09 Jun 2026 02:55:27 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6eb551b4c56sm16253913137.2.2026.06.09.02.55.25
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:55:25 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-963b248ef0fso2475612241.2
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jun 2026 02:55:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+2L3bCm4c6g93x6cS6BoYbbWQ8oK6143bGauVAKceH7oFoZ39vhlWIW1FrWc+k/8KIlGKSSJwZ6bQNe0PGO1w=@vger.kernel.org
X-Received: by 2002:a05:6102:149a:b0:636:984a:1e5d with SMTP id
 ada2fe7eead31-6fef05f052fmr11135049137.11.1780998924802; Tue, 09 Jun 2026
 02:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-32-ardb+git@google.com> <CGME20260609062840eucas1p1d49831bfdb3447e38a3cadc803a9afc0@eucas1p1.samsung.com>
 <a1b27e97-182c-485d-a448-56c19c5de2c2@samsung.com> <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
In-Reply-To: <6a9c0f55-fe98-4063-864b-8f7e1f4fefd7@samsung.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jun 2026 11:55:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-rH7s6GD4FtiKP9++3c2ojwZKm=YGLM_S_+nkj+EBtw@mail.gmail.com>
X-Gm-Features: AVVi8CfDur0wzec2mY_1awm30cbHrLvunVYojJnvz6Cb53IUltKkdZGFSORVN6A
Message-ID: <CAMuHMdV-rH7s6GD4FtiKP9++3c2ojwZKm=YGLM_S_+nkj+EBtw@mail.gmail.com>
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jun 2026 at 08:28, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> On 09.06.2026 08:22, Marek Szyprowski wrote:
> > On 29.05.2026 17:02, Ard Biesheuvel wrote:
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> The linear aliases of the kernel text and rodata are also mapped
> >> read-only in the linear map. Given that the contents of these regions
> >> are mostly identical to the version in the loadable image, mapping them
> >> read-only and leaving their contents visible is a reasonable hardening
> >> measure.
> >>
> >> Data and bss, however, are now also mapped read-only but the contents of
> >> these regions are more likely to contain data that we'd rather not leak.
> >> So let's unmap these entirely in the linear map when the kernel is
> >> running normally.
> >>
> >> When going into hibernation or waking up from it, these regions need to
> >> be mapped, so map the region initially, and toggle the valid bit so
> >> map/unmap the region as needed.
> >>
> >> Doing so is required because pages covering the kernel image are marked
> >> as PageReserved, and therefore disregarded for snapshotting by the
> >> hibernate logic unless they are mapped.
> >>
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > This commit landed in yesterday's linux-next as commit 63e0b6a5b693
> > ("arm64: mm: Unmap kernel data/bss entirely from the linear map").
> > In my tests I found that it breaks booting of RaspberryPi3 and
> > RaspberryPi4 boards with the following kernel panic:

Seeing the same panic on R-Car H3 ES2.0 (Cortex A57/A53), but not
on R-Car V4M (Cortex A76).

> One more comment - reverting 63e0b6a5b693 and 53205d56212c (dependent
> change) on top of next-20260608 fixes this issue.

Confirmed, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
