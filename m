Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652114C9009
	for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526115; cv=pass; b=sNZxF53jC2YNMLNsbyasRiQxEiYEA6xdeJ7JJHt0pRRrVLBkq8XJN6B9dVqF5fYLuxuJSonN6Nn20c3xY/HsTD6yRoMJaxiHHvnIsxl6jxnOk72HnJB7zUbNxUcLjJD+4Aj4y64s9JgS/DY0Jwi7iw4hnNE0SIq+zTBvNrqj+Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526115; c=relaxed/simple;
	bh=UasgaygcEAyRMWmEw6L6LjHmbIj1q8wLQQcU0N5zRcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l4PmZTmwsHH4TDPJxAXeOsmBIgIgy4/NM2rJ1QEXJSFZkNfqCmwkzqaBCTxBMSCwe9s3jMpx3fi9XT+Nxiu3sk8ZSgvDdvVupLEV8hrfOyW061YJ90uEA3/9XamKjJ2r+CDAyGxzX9XrB3jTUemHL08QdnjfjgtBETWYvxmGaR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TxZp8olQ; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxZp8olQ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso1454a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 May 2026 12:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778526111; cv=none;
        d=google.com; s=arc-20240605;
        b=GsrsRH0PwOsXIiN1R1Bgs7N4f2qyNnS+EGYSiyrRK7QQkKVNcqt6D9t1YEpT7I+tcA
         tJSuKIFsJ6+9gfY4WuTP02s3T4QPNNlJOvSQ3GMpQ+720OkuoYdPtDecWO3Q516C1T4w
         RzKYflmedGuf1A9iJ7ngte1x07V/Su0aneeICswOe6weIYtkwjS4z3RHBYiB103BlJPU
         RiMP/rEINW8f9Cyoc4DUO4vxOlot41rWvtEawDEx3DCIpU/oVarYAEaQup73k0IUxoNm
         FwU/Q8FKFVjblXpKECKfajFUWvjKo8r05SnQvFNYqCZfaxakScg7cchqJuBFq5hkqPmz
         N4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UasgaygcEAyRMWmEw6L6LjHmbIj1q8wLQQcU0N5zRcE=;
        fh=yCJByWkZLCTjOz4+3ldpLz18QO5QEsRr/GueL1nYefY=;
        b=EPq4QFDiRiqqy2vLQuHGKwGm94/Vp523ntQxgEUlW17eigY7q+3TiqMepk7dC4fDUo
         YJQ8+Hg2fs0dFVV3MMroph6jPdmZhJi3Kbf03ofAXuJWl1s+db4h1KtcP67Y40SBUraV
         Itu7h9IGBJYMNuL0FEs+0Ho+YcPoVI5PBmZpOeYc/oVIRfAF0dEYoBpqzq493OFROYh+
         P0Sm3Ws0JFMuRZDFil9B7AkKv/i84ILfpQfjkRbGvbJVJk/UtUy533VjVYDw5q6LcJ0Z
         rGMlMA0OCOMyoazsh82I8kinPdfUcQ30fxICTJnuot3KSbq4du2YrCTMglVwm3IwDHok
         6f8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778526111; x=1779130911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UasgaygcEAyRMWmEw6L6LjHmbIj1q8wLQQcU0N5zRcE=;
        b=TxZp8olQhQk8S4b41TLQdxJxmaVREiDJ4A94lv+CmPuxizIZJZWOkMfSEKpB8gc0qC
         usbN95CL1bTe94+cEd73gLuIkO6StTaGJkwLDK92x9iC5eAZGmmhIfz8taNjecOMQFw6
         fT1p4q/xHNAfI3hUmhK+pQF/npt4JUB5hy9gNVXuS59UlS90LF45WYzU441GkEPkokRI
         M2PC3CmLc+z/8BnoK8+8ygZrsQJ2AXL47icws5np5mxlno/HpV6phU/UijjCt2/dnqg3
         A7NAo3bcSCeofiVrypkGmPnQVcTo45SjWeAapyGjGzpeZx6Ai0sp3GTDMt7TwdA1zXPM
         n1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778526111; x=1779130911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UasgaygcEAyRMWmEw6L6LjHmbIj1q8wLQQcU0N5zRcE=;
        b=dTvnKS8cNrgjLhwinGa+waAb/v6feks64F8UY8qk5sr+DifhOI2hN8pUq/PAm6b9PH
         JiUt9k3LmQQcOe/XJfxKGjmug3GVTqykTW9t6XfiqK8og0xK+x/TyFkQlESsPdxZgJmz
         HeDdKBZUqEQyv0c6tqmTdATb/obz5B4wX46rRJ4VCb4jkFCqvI5AWh/9unr950N8A+Lo
         mn34588OqU3DfxKkKrb/Vn29koeP7Ee5GOQxetGkKBexA17MzMa5ZLt1Qigf4YtMr8f1
         BPU4RYOym/XPXGwTmdS3eBAH4ieH/J26fnXTcyJMWQ0iGu9S72IyqFJg/BXQA5XKYxgr
         kzyw==
X-Forwarded-Encrypted: i=1; AFNElJ8MNnKQlnvUOx0uuPO2uPbbjqbc8Ix72bUbZ1BxAAp6mDuXuhglYWHUejz8uVMSkwtAF7caw/Cl2IXtnQB58Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwRInNNjnZU7lfUVwYa10yYSogD8RApi3pZ8AHv7CFeo5qhHF
	YazYHjgjL8iYkhJTHZDLvfGS2jNAWnfzjxmuI03rNXiptd9aBViVc6eXxmV1KPYlURDkRYYOw5D
	+eEY95cHa27KT3e/X9BoCLuAoMr7mh/XkYr8ACbLf
X-Gm-Gg: Acq92OGUjxUysoCXHcqL1/kZj6+j02dPhc9QHO4oU+6glVakCdGXdZduiuHSWZHyNED
	9vsd8Xk0xiQrUP2pYQgnfpL0sgw2WMU4BBnOgypV14WBWPYtAF14tG7rFNtG9KTiY9+iuwGDRNX
	qcAjqRKkU4IKT/hZLROl0qhIM3SaL+s4U0o7wzQeBk/QMREOH4zHaFWwIrIBYYQQW01KeVJCTVO
	fUy7cUDggMtjmFk0UHQRI4LEQmR1WFfqiEelUIiSw7u7m6AMGE4UuTJTFHT3rXoi/3/cYAAhTAp
	UZJMeK/V+nRd+MQFiOH90ZcztxiNRXqPXvW0SRvkjdTXBzjZ
X-Received: by 2002:aa7:c399:0:b0:668:c2b6:9fa2 with SMTP id
 4fb4d7f45d1cf-680b4539f8bmr5944a12.7.1778526111017; Mon, 11 May 2026 12:01:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com> <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>
 <202605111144.349EF737E@keescook>
In-Reply-To: <202605111144.349EF737E@keescook>
From: Jann Horn <jannh@google.com>
Date: Mon, 11 May 2026 21:01:14 +0200
X-Gm-Features: AVHnY4J61JG6Vq5BHLoEJWjDPI-cUqKQQzYAmbcRiKqmBdXYMvgpf6b8RTG6Wkg
Message-ID: <CAG48ez3q2kW9GD-KVDQ_T=C=ADXmSqY2UyfXq_EMJeEsQ6KgRA@mail.gmail.com>
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
To: Kees Cook <kees@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 8:45=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On Fri, May 08, 2026 at 07:02:51PM +0200, Jann Horn wrote:
> > On Mon, Apr 27, 2026 at 5:44=E2=80=AFPM Ard Biesheuvel <ardb+git@google=
.com> wrote:
> > > The empty zero page is used to back any kernel or user space mapping
> > > that is supposed to remain cleared, and so the page itself is never
> > > supposed to be modified.
> > >
> > > So make it __ro_after_init rather than __page_aligned_bss: on most
> > > architectures, this ensures that both the kernel's mapping of it and =
any
> > > aliases that are accessible via the kernel direct (linear) map are
> > > mapped read-only, and cannot be used (inadvertently or maliciously) t=
o
> > > corrupt the contents of the zero page.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Reviewed-by: Jann Horn <jannh@google.com>
> >
> > Sorry, I should have looked at this properly earlier instead of ending
> > up duplicating this patch with
> > <https://lore.kernel.org/all/20260508-ro-zeropage-v1-1-9808abc20b49@goo=
gle.com/>.
>
> As you mention in your testing of the patch, could we add an LKDTM test
> that does the same to catch any regressions?

Shouldn't be too hard - LKDTM crashtypes don't accept arguments, so we
couldn't easily pass in a userspace pointer, I think, but we could
make a crashtype that allocates anon memory with do_mmap() (under
mmap_lock), then GUP on the allocated userspace address, then writes
into the obtained address with something like atomic_add(0, <pointer
from kmap(page)>) to trigger a write access without actually changing
memory contents...
