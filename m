Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C39372EE4
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827548; cv=pass; b=HrEa/rS2zDezu3dsLIkj70Pkqlg/QwHGMXhQnslPnp77qfzWOPQpsoy1X0xlszzM9f1DWNCseVT3sSYB/pVminlA/2pverGB0EloHfC/RuNQFtDHnM72wN3IZ17oqLVQ/0RozlYObWI5mSWFkBLtF+TOHivALpFlk6l0H3AGEvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827548; c=relaxed/simple;
	bh=Ws1Gc+VhxkBNnjLUnFz1PzRw+JkD3xhQsLHCA0yvfdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGK8dQDLBLBImPYROlfRQijeY3Vrnv9zjAaEmD69mKQxDGgSXPPOcK/fYU2szjPD4YdW0JJ0SUt9KJIfLy/7sEHYQ5tgjzTbVADgbxnUPS7gYkVsLzIsRymFM6BUWKQH9qeab3dwAVIKt3KwlVfjqzVuHQmQwaVMTsO715LUNIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeBgTAcN; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeBgTAcN"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd01481e592so711678666b.2
        for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 23:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778827545; cv=none;
        d=google.com; s=arc-20240605;
        b=dD/MBjp78s6L/0EvWgWEXohl0ODQZd8Yvft5yu9bWxXXJmivEgmSNcxjTcxrj69Vp5
         jIhThw+v4iBforUaJLwT7PnpcQvvhCmtdgq8DRFrOnzE90I1kN4TUJT5ox4wFzO8Jauf
         6NYJT/0QALgX7Mj5yfw2Xm8com9yB7MSUt2ZI5OFUfYRcj5yp1bmxKmMFDtxEJg0nziX
         GReYHNCTkQVG+uemvh3hdDSEgtMUI+DzTCM/SMxm2ywL4p2lMsrEkYowf2nRh9KuolCr
         eLDdK96h+I1En/fgAESJeK9jm6NDu7XenJKMqKshRKVLYMkJ/F5TlExVAsMPRhqMThfp
         6BQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CTOsRa7RP9KmtOOJHB8Sv6ZLajXrjnlDy47FiLMqYeQ=;
        fh=jinKPgjxHgT2UxCHCyK7z6aIY0qOM9qRMoH2ReiL6P0=;
        b=POR2J3reMz6AQ6bAHxpM0b+A8df6O3p4KHmyOdxQrr1zGgC0SP3Cl+mErRb2SGVwGb
         8Pi6r7aUk7+i+U2ldraVd1RwXU+FMaDAKn3sWaKV+U0yOmk/4iCacPY+Q7L1t4LCuoaf
         ZIm4Wov2hEZ4ETkkn6vP+I4Fez4ojnEx1DWdqtbpn8IiwOly93rOsSYF1P03OiSty373
         Nt0TuIJ9Nsyl6AqFxsLogFzt7uXtzInRVz2Vok323JkaGJOKkM1cmqq6Ga4eHXF08ZY/
         r7Nmjx8Tho/JrxPmZpDKda2MNTvxHQQKwvZSpuLa7c/Ca/GVBqM1nqzQg5agYAiyb4pR
         k6NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778827545; x=1779432345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTOsRa7RP9KmtOOJHB8Sv6ZLajXrjnlDy47FiLMqYeQ=;
        b=HeBgTAcNAE1rti1EjdFZyD2gSsH6RLZP/eVTZTS+HkI03aHH1gZA+i1EN/yiB4YPfG
         8Pj+50ESgCBKGMjCc8X/CNDjFcDO7c0J8orKlTN3Tzbn1YPTM0zzxjqmmY+sH3fNpHIX
         tlJre9UrfUT1ABRmXlTPaYiuT/GTMoWaf8OvHEDIuIuMPCsPQPrFTFkK2xjnfciatJQn
         7SK7tnmmnR4KMJUCaNK/AlG5XWEVQP0GA6W9ruNsMWb+2S/UvsJIy6KpsXO2bT17zl54
         HsMSgo+GqxF8+zNat5JIvJE1BR5POXwpNAgdrA13Ko8hnxMHP3EZRkcCwxtzsOjMqyP2
         DxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827545; x=1779432345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CTOsRa7RP9KmtOOJHB8Sv6ZLajXrjnlDy47FiLMqYeQ=;
        b=VTL9fCKSc9++QR5+vFXRxutGVv37Wmyinvp+BCSyNenWxzMgqSkZ706o0ZYRizHc6i
         I0cclDQ2Xf6FwLcfNOG9Y9XD2uzjRPMotVZf7eikb+mOMKppu7ftN0/zujqKT5M4En33
         Xrjfuwx8KfU2ymCypuV9I6X+vmx3O5KEoA3JQcASLNkRxq4mTRYLKV7WhWyO9hHOVHwD
         iIrWgrP3D7JVPPq3Ot/7CJLNNv1hxdu0YYsVB5QL50vtsBNxJZ7Y7dYabNqypE5uIAks
         y4P5TxUzc35GwBZ84hv+T5AKP7iZoYZ5ZjiOq6/Wc0G+WLJUYhlkXO7p2xwcftgjcjnS
         TA7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/hIG64zgdEY7TZI0efbSO8tqECjPJKdX2jxmILefbVlXUKoQhfwsxCcLdJ/Ne9aMObik2dQVtszFaGg0T8RaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4+6E9+r6W21ATdcQZiCr9j7KbfcCOaFboUDEAdeSXwonI9rqp
	dvmXuyU7E4IvFM+1zYca3Ldk66nfcdPHoh1tMIPWUyJNxwUlL010k9XiUTr+uFhMBF/bhTHE/UA
	HyZkHprwLv6MVB9scP8hZBeLJpAPzoHg=
X-Gm-Gg: Acq92OFwjiMcAdzSjckY3oIbfy937tnnKp51uGfzLTpuhtvPiz/Bj6W1RKgF1eJZZrB
	PAGDumBujGn36Mg8nfPoP0lBpzcjeQ6SrF2c4hWHQgD4++QUvd9WYg8MxEgWtaJ7wpbMOeVv22U
	k1N27D0UyeErSOUWmSuseBDBO1xvg9GlbNmk7JyX+CceIz1mt/Z8PLkolCoRS/FlhwSxoW3tF3+
	eseaUFObVPg3K3dYI+JiwuU6SYbz7oQpmDAONSk5BkqWGkll77zJH767eXVbuoIwbbNI3gO8OrE
	+LlXW4fypwbFBPIG31A63+vp13cdrtngP7Vn4AuPK9GlYsqtjFS2Ty5K6VKP04U55n2XZrSoIsP
	SBGyNpXo=
X-Received: by 2002:a17:907:c1e:b0:bd5:de3:263 with SMTP id
 a640c23a62f3a-bd517ab9963mr145007366b.46.1778827545368; Thu, 14 May 2026
 23:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514165601.527883-3-thorsten.blum@linux.dev>
In-Reply-To: <20260514165601.527883-3-thorsten.blum@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 May 2026 09:45:08 +0300
X-Gm-Features: AVHnY4LokBu9aTHJUiy5qQKecG2hYDOoj_dBs1IOeUr2ER471FQQTYPOQ98P_1U
Message-ID: <CAHp75VfQNkqEYsO4Uup0c-uiYuVyAWit=tmCz2BsYLp-sjXsZw@mail.gmail.com>
Subject: Re: [PATCH] string: use min in sized_strscpy
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 7:56=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Use min() and drop the limit variable to simplify sized_strscpy().

...

> -       if ((long)src & (sizeof(long) - 1)) {
> -               size_t limit =3D PAGE_SIZE - ((long)src & (PAGE_SIZE - 1)=
);
> -               if (limit < max)
> -                       max =3D limit;
> -       }
> +       if ((long)src & (sizeof(long) - 1))
> +               max =3D min(PAGE_SIZE - ((long)src & (PAGE_SIZE - 1)), ma=
x);

Side note: Isn't simply
               max =3D min(PAGE_SIZE - offset_in_page(src), max);

? (One will need to include linux/mm.h for this, though.)

Moreover there are plenty of duplications to count the size in the
first page and even the similar min() as in
  fs/iomap/buffered-io.c:869
  arch/s390/kvm/gaccess.c:976
and many more...

Perhaps a new macro with a good (famous last words!) naming?

--=20
With Best Regards,
Andy Shevchenko
