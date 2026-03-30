Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B31A36492D
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903790; cv=pass; b=ZLH45t3Ay9a5X5WTEHSV/jKEBvH33zEHBuTTsipTLrzLHoC9SsrMNG9K4rUIriS6b18ss6m1sEsMA5w6RGd+pYZpnXjkOZhmJOb5hXXbubt5hHiCDTpOVd6rHZmglcC9+tD/PnTo8k9gQrdTLWaAOe/Gg+VUGeDZxwtiQNMKTIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903790; c=relaxed/simple;
	bh=7Uvyxu6dO2WjAV8JM3coYG64kde0G9aWlWGcKq+w6GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=floQ2Bh+/18LSrSgoVaw85ITgNhKXZ2r0Tvs0MzpOi7WRRGzZW3bC3M1FbAzhxdaRbTf8eSo1Y2VrGpvvrERgigOpLRkFxVWhmhWhLiCfRaN8haUMxx5LlQXEUXapbjWCFqAnQTSWNj0xNugTtlpD5OfyYn8Fcy69PiHqweCDmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JouUFRec; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JouUFRec"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66abe08cdf5so7464485a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 13:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774903787; cv=none;
        d=google.com; s=arc-20240605;
        b=P41WyesvQCLcissbRgaF0aTmrtkiBEWMnN/6HYlebde2+TVlr86X2iMd9844iR/Lnz
         wwzoRsiYoze2l8iag/zKe8aSJ1TaFKT3Qce4wnAYoDPij+znToWKqAd0u5LE1o9UDaVj
         7EOikQCbkKdUp4ese+BtKem42qyCsP5SESKzLIi9V1sANblRgoT91BP2Rz4HlWatiHPM
         UmJdZyVWfRIAonAOpc4Mlw6xFjAqx/cs1yzxNMet8ospQJB6yIDuyqcvhpnQ9aQ2AOjt
         Uk1HfMQhUaXDxtOVIt0pXOGkJS50J59FdSggmOGwRoshTz/ZxWUjCQYwUEksQ5YYQOwp
         rfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nBsfzZvqDoaxsyYBwg93l2/XbXx8XSN89/j4CI7HfEk=;
        fh=z47t3A0oJyEftpjkRk5bIk6Y59PNFAI6UBAwOWLWHhk=;
        b=jNqZrgtmUr6bqVV1KVKagQsDbq8ZuURkp9M22mqQJx2A5B3KBiazC+H+yPLiLvJu45
         /SAwA4P7PCtI0uzzg+6iuRwQMx5bIFVM1wCm2oxCuhGgPLVNAhcuoaPo8j0JcBLhbhv6
         f83MpEVqYeR9kKhdUuZ9Tqdpt5P61tuV7peSVtNYl2mhbso3m7wE9fSAdWgQAxUnKIqC
         UtR458v5YYEWBDdBKvFdyOtocyOIvPVw44Ux4HyaM4jOpri/OM9XtLkVbR8gWtiv2jAg
         e3gVl1C9ZiMpnyaj+gwHUyUl2YnUVVmWG+hOqKm1ELIXxJlDByQk/URg4jXF6BOWseU4
         G2Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774903787; x=1775508587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBsfzZvqDoaxsyYBwg93l2/XbXx8XSN89/j4CI7HfEk=;
        b=JouUFRecBZ/MiYmWJHq7Nn2WOmXHyVB8k6GzVBjE95lQCWKZdGccEm9n03s3Rhmo90
         aW6obfBZ0k6QM6UEfkSB7xGoHYt4cgNt+mdoTzvrgW6Glrvy0rHHYsXzIPcr6BXzpqR5
         X7+zYCt4n7OarlJAvO1KaQ1u/ojn3QTiwYhv7WX9Jh+HT68ZawR4YyFhpT4qbMef6Ntx
         U4mUIP+2Sdp0/R2J9AclNHL25jMB+6JvdEwOTvJCnCE5DHChRiHWosVTCA8ZfubsrMsd
         0LHcblDMD7q6wWjYhWLMuZ+L665KGfQWPijr4gaUU5Z5BQOrytpPTmB8q7PJmf/sEunl
         utQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903787; x=1775508587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nBsfzZvqDoaxsyYBwg93l2/XbXx8XSN89/j4CI7HfEk=;
        b=jaqe27iQi+tZ24TEBrZ1fiFq/C3PJgIZPE9efmRkBBB8w5tkYtymFuk/CPRjqHgD3b
         MQnXVNz3c/39doN/IhuAl+K3Pb8Eb9UE66HdMsoJWICAUi+FegQmdnZFnnyj5NQKA6/E
         190bUUef5PuVbtDZXHztq2n6Q6rXFh4MbWPrjf9Y7bLbGDBHUiS/xYwawOmY61povkCG
         2klAv8LGH2dfz1HKIMqnTlbBzYXfXNmFhhrlSXG7hRB9iPWvIk48PEq/PxRCc91AX+Mx
         c9242c4Q5y3Xqt37OcQZOiQhkVVDL+90gGxkpWNPhP+BV/zDkBdkDJylrzDoyJ8h+Iz6
         IphQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIGsGwG1ESOYHFK/ClT2wKA4YVJWFNJruv74eo3PSumAHI+i9wn98MVh6UUoevI/4mb5eEyAJ3u0EhIa09EfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzQjQt5F3N2ZEnwuDgb9epWImE/RdgDUOOQ6MJkSD9nvmOumu
	GG9BOiR8HTn+uwdB2fZvAWHNONz62KCuooo9/CG0DIBiS4nJkP87VZZc03XgFlbLW8hXG9AqshL
	oZUfoAsBV5SMsJz6FNTLCVkFdUkbXkA1d6w==
X-Gm-Gg: ATEYQzy0bKlc9RC1Y/kPYlWsd9YRvSyQ0qLJP/i0xByRK0q/UAq+CW15xebuLDu9d4k
	eMVHzjEaNr2kFZmmAOE1jhDlsXtdxA5CRnl6ON9AfBsssWRBiXOK7a1OriTseGkLea2Xi8wL55p
	a/we3QvAGS8Z3HQDTpOcTsl1Pj76ge0pjKfBuweF9bdmHt5ZY4UTuudZIVsGhExY/wisoC8J1g1
	4Ohe8ZaGOO2Xucq9pJfwHcl/2hLoIKuBHOB0dssKiMnS7d2Z2rkh3xAfxgGUHzFLwX2tvE4fMSv
	NB2kuJ/hMAKekZZxGa3Sc3UQWArZFbAp6r+uCrJEGhU8kQCPeI/66dmmC76ysABhpeT7TSYeaRO
	AMqRXgA==
X-Received: by 2002:aa7:d9d4:0:b0:66b:3dec:e8d5 with SMTP id
 4fb4d7f45d1cf-66b3decf4dcmr5222339a12.2.1774903787350; Mon, 30 Mar 2026
 13:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327024828.7377-1-rosenp@gmail.com> <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
In-Reply-To: <20260330151536.GDacqTmBlWRznyeoMG@fat_crate.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 13:49:36 -0700
X-Gm-Features: AQROBzAQRLuVcHgB3Qxt8IE08Jitj0rOszTyGILx96JimU4Uuu7Tkat2ssdZToU
Message-ID: <CAKxU2N8HqFRT+qb5ctCVckC6c=viR7u+xyUaHgm-87C5=yo1ig@mail.gmail.com>
Subject: Re: [PATCHv3] EDAC/mc: Use kzalloc_flex()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 8:15=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Thu, Mar 26, 2026 at 07:48:28PM -0700, Rosen Penev wrote:
> > Convert struct mem_ctl_info to use flex array and use the new flex
> > array helpers to simplify initialization.
>
> Meh, simplify... rather to teach an old dog like me new tricks... :)
>
> > Add __counted_by for extra runtime analysis when requested.
> >
> > Move counting assignment immediately after allocation as required by
> > __counted_by.
>
> So far so good.
>
> > Move memcpy to make it clear that this should have been kmemdup_array.
>
> But you lost me here. What do you mean with the "should have been
> kmemdup_array"?
kzalloc_flex =3D=3D kzalloc + kcalloc.
kmemdup =3D=3D kzalloc + memcpy.
kmemdup_array =3D=3D kcalloc + memcpy.

So all together,
kzalloc + kcalloc + memcpy.

Or

kzalloc_flex + memcpy.

Placing the memcpy right after counting variable assignment enables
coccinelle to transform this whole thing into a single

kmemdup_flex

call if such a thing were to eventually be introduced.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
