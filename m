Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6A1C54BA
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513878; cv=none; b=I/stJbW4PyYKagv/ZLsWufodKhozwJdY4XRM2x5QUEAkb3nxdj2PTXn6gvknr1rCwwk/Lnr29QUPpJaeqgnKRFUi+wuu/LB2xpJICg3mjCGB+Erw86mmpDwEgK69sa20lUJqjQsVT5wkufbmtC4e9G610pkT5x6NaGCOFaJutEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513878; c=relaxed/simple;
	bh=sgM1D5UdnpSKShODYEOogu4j88qbiH6fSVx91HhnxuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELlwkRrQagcf95tyGJe58OvCTOVeCPXUP4x7P2fGbgNA091SK9YYrgFXcz8E+kz2lTzzSS45R6kSsuK2oP4Pfg8IebTuvz3WCPFmLvK/gBIyy/jYj4j0BPbFXBN7ctuAcbqL4NDIdgn5KMxLUEyTx2fYbgadNMQX/Ns6cj0hif8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XlEVgjUN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XlEVgjUN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434e5e71a08so5525e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733513875; x=1734118675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH8wn9taPLs7rRmOJfCxq+RP2lrhMFvIr63QFRJWhdw=;
        b=XlEVgjUNeZxyTQ/g3ak3xfI7ZZ7XTY3UrnEX1IW0tCedKXnj2+RJBylAQWtz4986aC
         1hEkbH8YNzEwWEey8frta7f4eMwccgUpqr9TFy59L2dH1xzFNbqy7xxzTUgHJgBfQTUj
         jsQQjOA8aUgILAi8ceWHKyhqrhcWSDYgwLxcTVKY8v2lAIjwSrXw4tAnHeYcWZxD5k7E
         71YNfR1AKc6dZPNzAk7zZasCfGoyB6y4tFCGvWqo6aw/h5DvJMUe577MlQAtlOiKXS8y
         VJwhicayWTZauocdbJeEnkUuvF87WKPVFVduR9UteyDI2yLPdJ6xFXW0+hk9Pe4K6P3m
         nyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733513875; x=1734118675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH8wn9taPLs7rRmOJfCxq+RP2lrhMFvIr63QFRJWhdw=;
        b=ssLUdE4fiFGSLD08tF2UYi4onUNSkmJlOp0cI6QrSj6h6i4NZUdLxcXSAjaR+qlAIn
         ueJ9Q1MsyvxxaumlSbsSgSyUYxAzdrkWMaAuWDIRHPtCX+OcNieVQRFYRN+1BnGVCcQo
         DkTUQHs8bbzX+152zMaL+9QbdcVJtzOK9wIfXxZO3fkXLLR2gBJJ72d0knsfn56OsIIq
         WCPlOVnl9zCDJIrD729iQkKGcf4P+QvQdljeBOlW3BR2z1CrHQxmFD5IRbGYXg7sr2nh
         z61ZEJLYOu+8ydb1da7LPZ6OigMKfTq5DjouTV5G73hAqtpxxNlnbIDimIVuNjao2F3J
         V3tg==
X-Forwarded-Encrypted: i=1; AJvYcCWnfSOePFXz90q/JPXBHyMKi1HvReqeapoGGS5q3rCpOR0fTTKfNrIj3dx+0RU/HQ293Cu9E2xjxkIUSbcrjYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYkNAGirxyxFZuOARTedyMczAUyWhMd/kmCFOK8fTdk7GUHPc
	KnJlfgt5I2WHT1wxah2ukOexdWVKNdtkleuS7coXOg+SCb3ODIVlHiEDDzG+slnXkFZzm6J+8GZ
	ZT1QdYdB4h2jtQJ5uGnp1pzXYZ/JWfs66qEFu
X-Gm-Gg: ASbGncuhz6+nxt2jqzj9oLLxEHqI1PEWmctC7rvMdod7xq7DACybSYwWGwc0KqA7Ihh
	s2DKh2g5pFxmkt47oyz18tnOuzuUjYJEVQ1T6jlZdLLyOFMLhFKv+0n8QrRs=
X-Google-Smtp-Source: AGHT+IF4T66lh7GZU9E+Oi4ceU8qAQeWcho1lP5iOHEzxMAEhEl+DpomU/fk2punlPnClW4iuixSXLw0OQcyvxyvOFo=
X-Received: by 2002:a05:600c:2d87:b0:434:9e01:cac1 with SMTP id
 5b1f17b1804b1-434e845e7eemr74255e9.7.1733513874878; Fri, 06 Dec 2024 11:37:54
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
 <20241206193309.3026213-1-jeffxu@google.com>
In-Reply-To: <20241206193309.3026213-1-jeffxu@google.com>
From: Jeff Xu <jeffxu@google.com>
Date: Fri, 6 Dec 2024 11:37:18 -0800
X-Gm-Features: AZHOrDka1ANcuB7R0eqXjcFIqGR7_M87OqMPqTDOo3IfONht43psde5_cgPiaD0
Message-ID: <CALmYWFvk75iP3Hha-4-UfwwToSH=Qg=trAhOCqH_t4F2oW4yQA@mail.gmail.com>
Subject: Re: [PATCH] mseal: remove can_do_mseal
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, vbabka@suse.cz, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	keescook@chromium.org, pedro.falcato@gmail.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:33=E2=80=AFAM <jeffxu@chromium.org> wrote:
>
> From: Jeff Xu <jeffxu@google.com>
>
> Hi Andrew,
>
> Is that possible to squash this change on top of
> "mseal: move can_do_mseal to mseal.c" on the mm-unstable ?
>
> This is the first time I m doing this, because I saw dev did this before,
> and saying this is the prefered approach.
>
> I could also send v2 which is what I usually do.
>
Actually, please ignore this, I will send a V2 instead.
(this didn't remove the code, sorry about that)

> Thanks
> -Jeff
>
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/mseal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index e167220a0bf0..08e6f328d9c7 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -225,9 +225,9 @@ int do_mseal(unsigned long start, size_t len_in, unsi=
gned long flags)
>         unsigned long end;
>         struct mm_struct *mm =3D current->mm;
>
> -       ret =3D can_do_mseal(flags);
> -       if (ret)
> -               return ret;
> +       /* Verify flags not set. */
> +       if (flags)
> +               return -EINVAL;
>
>         start =3D untagged_addr(start);
>         if (!PAGE_ALIGNED(start))
> --
> 2.47.0.338.g60cca15819-goog
>
