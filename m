Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C4126C03
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492499; cv=none; b=MV0rohL4zC3s14239HIHBH5Gh0yiXM8+A55kQGPXB7653+E1PxrUZZ/nlmFjkqe7pGVEtrHY7w8lLD3oeSvQkic//Zw7rF4im83lQ5rseikNEJcr9bGOszOJzGC3HO3a0O+7rmFyaVAZBsClODjvMCdQqOinjVIlExgfPLF8vWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492499; c=relaxed/simple;
	bh=HScNVG27Z3xvF/dML5mlBmrsnq+jXe0FjasO0A8oN8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJFsMohlEI6WsmjrFW3h6mt6MJ/QPTFG9XsPkBcSS1mz1DCw4dgWWvs4ET/k4FboqENpfTAaEG5k/nccOYHRsnnuT5IJ3XUdaSbsF4HYDwFaMcRfZ4ht1zR13exoJt6GZxoXd+rDdtx5SEKDU3aULsRAeUKochmwgqoAepcmDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBzSjZv8; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBzSjZv8"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7636c96b9aso691666b.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763492496; x=1764097296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZQSPFMUc/iR2j6wUuGRdvdyY2tCoFpgaZkwvlQe3PA=;
        b=VBzSjZv83Pm7Y+Phy+ddoEZNxXdYxB8l2fDIe+AhmJncA1PV4gYfEH7VCXk2PuWy7U
         8ltrSgnMU8bO8RrYHvcDXHWD899xuX1Qur7Sg35JeG9127G2tZaO4kahjz5lRCDIts/X
         WjydkETNZq1kKUoGk0Thid2mttQvwma3P2Vh3J1zX+A4EnWht8NWEI/aGUrWh5IACnll
         bu0oC18XDtTKf3f5yUjCVoAqZNzfn8Q4lVTWqHnNaKTYs8nq6EWoigXBQXihLcXS1O4C
         GfO4riaMeTkXKbS7DOizNr8w57+uz+IQBCpff4gdrqaqN1ecTZTW2lwWAkUz4aup+nnK
         gXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763492496; x=1764097296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZQSPFMUc/iR2j6wUuGRdvdyY2tCoFpgaZkwvlQe3PA=;
        b=WzSjHK9AutEPTBiDyFz6Y+dt8QKHsl4qBTnc4S3YRZL/puH/+xJtdcbyzK0+sn/LZb
         OMAgGgplH7Tlii5/IlPLhcXqe+9dp8tBZ9eraf4xcOTlIrKYN1tSZSv3KphFvkUsszsM
         dmhlMEQpujeGmLZeQ16ThR6JkJz4o59Z/YSvJWb5O9gCXJvyi5uQmwoihdrzeJlix2g9
         JofDgTIyAcYO0MCjhIIWiluXPTjLOtwUpTE3oyD/oJHAm30BY6Ama+QhRFk2FK3tOTCB
         r6trGdl1QTbSQ+aLxSiS0/Zngg460aylYMhtZwGXf/I0XoX6LYgFqQvA+rl/YaW3fFDI
         H4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW1Hu06AsHAt7niGSE2/9c7DePDXsRefvvLEqdCD8eZnOFsADWyeO9sSAiUMBlBevieJCEQJEOHeiUYNoJOdfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRVB5DjMJe+JBjvaBsE9Z5ZmW4SbIHL01oVNepSEtgF5BKP/X
	bfFktl78+7k9miNUCVqqJYhGULOVoQvcqVPvwRFvFFHo6oQo/xvLk8FvUFesjztoZk3Hj7LQE/+
	h+aOj7iLawvjAeBS/jvDrWXLTuO9MbOo=
X-Gm-Gg: ASbGncsv4oIy4vk071xNAojbbGFh3XhJ5dYwM4FYIjYmoSgwIkNYlxLuGzndfA7/UoN
	VxY3VnjRRqtoPP0kqyT+FzvCqO7vXBRJRmxfvAlSCtL3j0X409zYocIC7HkgBCXWjcFragi/SlR
	Z4lVGnSBnDSNWYZokyiXObwCNh+yhDlVsQvLu6TxPOC2kN5aChMugmbPOLosml8m0a4c+dQKIaF
	0UDm8SbXCIXwc/sLZCNuKy3Gi5T5JOpUysegOgBluVahDBEBj6+Ag/Jx/xkyKJ5sDTIfIxdFpwe
	0KIaMwUYEh4+GgybZ2h9fQLG5kPvqhBBgwnZSYKbzxHsiu7iCEX9sex8KiztkjJrqMKs35ELNrI
	RZqNaGw==
X-Google-Smtp-Source: AGHT+IFyP+TG9MjJL23/m1prb10DhR3Unt1EdmWMuh8fKkrHBsUDo2385GqDYyCuCDUBq/cu/ng4p3LaukETb+bcQmI=
X-Received: by 2002:a17:907:2d12:b0:b73:572d:3b07 with SMTP id
 a640c23a62f3a-b736782d087mr1883358066b.28.1763492495812; Tue, 18 Nov 2025
 11:01:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118184828.2621595-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20251118184828.2621595-1-kriish.sharma2006@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 18 Nov 2025 21:00:59 +0200
X-Gm-Features: AWmQ_bnddVqXPK31tz6e9vAtlpuIK8CzEPRlTM9nkDL0aNtidlmuyu3e9_ix0wk
Message-ID: <CAHp75VfEUL=BVVFX24hShev+LFPKNToDhpgHf4Z-C8KAG_UJmg@mail.gmail.com>
Subject: Re: [PATCH v2] string: Add missing kernel-doc return descriptions
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: kees@kernel.org, andy@kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 8:50=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
>
> While running kernel-doc validation on linux-next, warnings were emitted
> for functions in include/linux/string.h due to missing return value
> documentation:
>
>     Warning: include/linux/string.h:375 No description found for return v=
alue of 'kbasename'
>     Warning: include/linux/string.h:560 No description found for return v=
alue of 'strstarts'
>
> This patch adds the missing return value descriptions for both functions
> and clears the related kernel-doc warnings.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

...

>   * kbasename - return the last part of a pathname.
>   *

This blank line can be removed, while at it, but I leave it to you and
maintainers.

>   * @path: path to extract the filename from.

--=20
With Best Regards,
Andy Shevchenko
