Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C51171A
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jan 2024 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4HAnD2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35855C433A6
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jan 2024 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705392599;
	bh=byEKLkL6nYz7FHH2I12EM71SKWmMWcc1bETeEol6Nxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r4HAnD2tFj202U7I+5EFgguOsA8FSAHv/HGpSFqSbrEQyCkT6AvkCvHFCjXBuC4QM
	 4VLJxiU8e7dlS239FpbZ5U/VuHRHZoUSsBYSwgie+i2Zn2onAJb4rncGlqIcWM8vgH
	 ToOvp+3WAsTzvepf5kA6Yj/ip7zbxoqD1tgzh13cXS68I8h9WCfFDMYPmy3EpQlC8d
	 nNg+ZJBjIJVsBvVKcZC2XGcROGcZBHXoGI5tmV+0Pm6mePTaOFFTbU+cRpH/dIeGeo
	 in7Rks8JWtgVi+3bl60uJFbZG/QVmK+i4lQzPBmEUOtOvBOsfRZek0uGm7ZLCQPXKG
	 m9rZsIJOC5Rvg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso10595852e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jan 2024 00:09:59 -0800 (PST)
X-Gm-Message-State: AOJu0YwoAi6o4zu6b1dO+mk6/XoFXKIYKmv82wy03UzphE/ZHt8m97nl
	f7MdY90PiBKlmQESZlSUXTKzyayaJL1IMH6sBVQ=
X-Google-Smtp-Source: AGHT+IERnctLPAujSEvr6b4uRVZ0JCeFDQ8suHcX9nEcAJU+PGBTdUwP/SllPYMSFKZrJPyzpHfW0BVCrb0X+bIohWY=
X-Received: by 2002:a19:8c17:0:b0:50e:b2aa:1f23 with SMTP id
 o23-20020a198c17000000b0050eb2aa1f23mr1515635lfd.144.1705392597375; Tue, 16
 Jan 2024 00:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69fa6015256613ed10aee996e181ebd4@horotw.com> <87il3ur1ik.fsf@gentoo.org>
 <ZaVi4ij0jgEz+isx@casper.infradead.org> <07c348caaf6b4c457ab4b452f53ed048@horotw.com>
 <ZaWZqnD7XmP5HMA0@casper.infradead.org>
In-Reply-To: <ZaWZqnD7XmP5HMA0@casper.infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 16 Jan 2024 09:09:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGMPeFE_JAKBhAkh9eqmvEJjucsXru2bjc6oa35oyK4=A@mail.gmail.com>
Message-ID: <CAMj1kXGMPeFE_JAKBhAkh9eqmvEJjucsXru2bjc6oa35oyK4=A@mail.gmail.com>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
To: Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: mail@horotw.com, linux-hardening@vger.kernel.org, 
	Jakub Wilk <jwilk@jwilk.net>, Salvatore Bonaccorso <carnil@debian.org>, 
	Linux Memory Management List <linux-mm@kvack.org>, William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"

(cc Kees, LAKML)

https://lkml.kernel.org/r/69fa6015256613ed10aee996e181ebd4%40horotw.com

On Mon, 15 Jan 2024 at 21:46, Matthew Wilcox <willy@infradead.org> wrote:
>
...
> Yeah, I don't know either.  Outside my scope of expertise.
>
> I received a suggestion off-list that we only do the PMD alignment on
> 64-bit, which seems quite reasonable to me.  After all, I don't care
> about performance on 32-bit just as much as I don't care about security
> on 32-bit.
>

For context, the culprit is

commit 1854bc6e2420472676c5c90d3d6b15f6cd640e40
Author: William Kucharski <william.kucharski@oracle.com>
Date:   Sun Sep 22 08:43:15 2019 -0400

    mm/readahead: Align file mappings for non-DAX

    When we have the opportunity to use PMDs to map a file, we want to follow
    the same rules as DAX.

    Signed-off-by: William Kucharski <william.kucharski@oracle.com>
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

which affects *all* 32-bit architectures not just i686. 32-bit ARM
user space is still being deployed widely, even on arm64 Chromebooks
running 64-bit kernels (at least up until recently) so unfortunately,
we're not quite at the point yet where we can just let it rot.
