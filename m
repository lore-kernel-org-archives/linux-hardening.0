Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59261AB52C
	for <linux-hardening@vger.kernel.org>; Tue, 24 Sep 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193560; cv=none; b=aGuoEpTONrDBadPlQVxMEPwOZJzlaJNuyblwi3m+Xa1sRBAJSke2xFUJqkCtm41pERnJX/0SB01B829Qp5yIxArPstmW6Oc19zOKWNAKNcop/5Qfby7ScLr36uV9Qd1Y8k+XsVLe6PQyxcA6odS5Sb//ndb0mU27QVIH9WcEF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193560; c=relaxed/simple;
	bh=aRtGOp0MboaDPkeq36BwA/V4nvzdSVgC7CWzMmI7kPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvIw4xJ2UVsSg2PNC/+cXpRcCrq9fK1SCvJGHSxBlHNEG1niitnhSSeSelW34ULtZmf3nMV/QimrqQ6WsUvfxeoc6b4pr+omoPiqHNfbmWtnO2ZnfsJzozd0NdC5XkX7CpJKctMPtEneAfmkKlE19icsVr6njMEa6RhYiuH3cnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwuO+ikC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwuO+ikC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727193557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+S0wIYME8PmmnZGOe7mz6Cv0BjF3gAq3MOk8uH20clU=;
	b=ZwuO+ikCVNUOAupzru2dwL6mJQ05Iwf6EtchpYjAgj5gq5KqgOjtkMA6dKDK1hQSTSGZL2
	BDjagcwyXnOlhp/9BGmaGOqa0sPMCYS233EGEBXZF+5rN3YUJBXUlFafd1/jgyzyPC1ZzU
	nID7lgcc+IwqvnCGC5x4eLnXdO/ljDc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-xHM3xXLAMnadt5UhdLOsOA-1; Tue, 24 Sep 2024 11:59:13 -0400
X-MC-Unique: xHM3xXLAMnadt5UhdLOsOA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d889fc26e7so5954621a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 24 Sep 2024 08:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193550; x=1727798350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S0wIYME8PmmnZGOe7mz6Cv0BjF3gAq3MOk8uH20clU=;
        b=S6CcGOLLZUe+Iu92BDQSp6pWCnQyK4eSdfYYMBNZEEIg7KnU4HcFus+BLCblPMI4QY
         Q0rKaPfkqy394eibjnurJCXfFGtmSdWLZQpnoDe50sw/Qp3KANLDvGwIyhaNz/rE5Rfp
         H0sDSIf1QfLNARQhXNdHlDmP1lI06wSzXJEnTzIWsVZG3JPdUJzasUtkUq0LLBtaTHFl
         Zd86pSqUgVkSY+FRLgMAZmjXPCcDQcmfHxcd/lVjvUB7Odgfv5SJ3OTTxblE/UE9CM53
         za2r1xIMznI5OL9qDGO82e87OQgDkHznmfBRr1uHjSQ0QT9OlNUVjcIrRxljQ3Qa5lMq
         +U7A==
X-Gm-Message-State: AOJu0YyKPzD8qYy+MFIn8JNZ/pwp+Q7shmppv0q/ojAdaFSQA/dQ0zqF
	LC4B1HJHBt3X8YyJD9eMfk1PVtMsuGX+CtZcxZ0Dd6W7IGtEdFWDb2/eWGw3W2BRIHXZqNCWm0U
	6TKSo9NXJ+anipLvbikmySY63yLVvxc87D0UyU7ZZL0wySny+s+aGRA2xRyUzWtSJATnhaS5ccV
	0gOnklRnkYlMhKAojMZaC8AZKcpLUxzTPKV55PQhaFDO7PDwo6bjo=
X-Received: by 2002:a17:90b:4b04:b0:2c9:3370:56e3 with SMTP id 98e67ed59e1d1-2dd80e38b6emr17534380a91.34.1727193549561;
        Tue, 24 Sep 2024 08:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkR7hCExRN4dc958K/x9tQVNNIbvGe5xIdWwh1kAgb4AzafwKHNWeKF98H6OSv5ifeNMlvasI7rJFQ0xwQDsE=
X-Received: by 2002:a17:90b:4b04:b0:2c9:3370:56e3 with SMTP id
 98e67ed59e1d1-2dd80e38b6emr17534353a91.34.1727193549054; Tue, 24 Sep 2024
 08:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJD_bPJes4QhmXY5f63GHV9B9HFkSCoaZjk-qCT2NGS7Q9HODg@mail.gmail.com>
 <B2A62C7F-45BA-43E1-975F-5AF0197CD2C3@kernel.org> <CAJD_bP+43=XXD7p3fRfDxCbj=_YedgVLv38XO4iOAw94a+4PHg@mail.gmail.com>
 <202409221511.9AF49BD@keescook>
In-Reply-To: <202409221511.9AF49BD@keescook>
From: Jason Montleon <jmontleo@redhat.com>
Date: Tue, 24 Sep 2024 11:58:57 -0400
Message-ID: <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
To: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org, 
	Linux regressions mailing list <regressions@lists.linux.dev>, linux-riscv@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2024 at 6:38=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> Can you try this patch? It should avoid using the "WARN" infrastructure
> (if that is the source of blocking boot), but should still provide some
> detail about what tripped it up (via the "regular" pr_*() logging). And
> if it boots, can you look at the log to find what it reports for the
> "Wanted to write ..." line(s)?
>
> Thanks!
>
> -Kees
>
>
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-strin=
g.h
> index 0d99bf11d260..469a3439959d 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -549,7 +549,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_siz=
e_t size,
>                                          const size_t q_size,
>                                          const size_t p_size_field,
>                                          const size_t q_size_field,
> -                                        const u8 func)
> +                                        const u8 func,
> +                                        const char *field)
>  {
>         if (__builtin_constant_p(size)) {
>                 /*
> @@ -610,8 +611,13 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_si=
ze_t size,
>          * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D101832
>          */
>         if (p_size_field !=3D SIZE_MAX &&
> -           p_size !=3D p_size_field && p_size_field < size)
> -               return true;
> +           p_size !=3D p_size_field && p_size_field < size) {
> +               if (p_size_field =3D=3D 0)
> +                       pr_warn("Wanted to write %zu to a 0-sized destina=
tion: %s\n",
> +                               size, field);
> +               else
> +                       return true;
> +       }
>
>         return false;
>  }
> @@ -625,7 +631,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_siz=
e_t size,
>         const size_t __q_size_field =3D (q_size_field);                  =
 \
>         fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,  \
>                                      __q_size, __p_size_field,          \
> -                                    __q_size_field, FORTIFY_FUNC_ ##op),=
 \
> +                                    __q_size_field, FORTIFY_FUNC_ ##op,\
> +                                    #p " at " FILE_LINE), \
>                   #op ": detected field-spanning write (size %zu) of sing=
le %s (size %zu)\n", \
>                   __fortify_size,                                       \
>                   "field \"" #p "\" at " FILE_LINE,                     \
>
>
> --
> Kees Cook
>

Hi Kees,
Sorry for the delay in responding. Your patch also caused the system
to hang booting, but I took it as inspiration to try some things.
TL;DR I see these two print several times:

Wanted to write 8 to a 0-sized destination: oldptr at
arch/riscv/errata/thead/errata.c:185
Wanted to write 28 to a 0-sized destination: oldptr at
arch/riscv/errata/thead/errata.c:185

Since I suspected CONFIG_ERRATA_THEAD_MAE which relies on
CONFIG_RISCV_ALTERNATIVE_EARLY I suspected it is just too early for
pr_*, etc. I tried trace_printk but that didn't produce any traces,
and then I found a comment which makes me think we're too early for
that too.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/riscv/kernel/alternative.c?h=3Dv6.11#n214

I didn't want to give up so I wrote a simple module to figure out how
to use sbi_ecall and then incorporated that idea into your patch,
although even that was not straightforward:
https://gist.github.com/jmontleon/f3536ad70dc92bed992139ad5b266d5c

Full output: https://gist.github.com/jmontleon/823facff38e28b717f153e38adcf=
d7fe

Thank you again,
Jason Montleon

--=20
Jason Montleon        | email: jmontleo@redhat.com
Red Hat, Inc.         | gpg key: 0x069E3022
Cell: 508-496-0663    | irc: jmontleo / jmontleon

