Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B03D3B1
	for <linux-hardening@vger.kernel.org>; Thu, 11 Apr 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873473; cv=none; b=JQO0X3CdnqE37/bp3nf2M12mKFDYqWHq+9RSpWvhSrz0sdmEcI/GaM1nN6Jado1Kkm3YybtXODVHpQ98a7q8yoe1PKiBz9NvIjLdlAsIY+VKWa0lFq1nADSu/ymemzlX/F7QhHBUyxB75iDOVdDi5n67cRfQZXsYilzxuMUisDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873473; c=relaxed/simple;
	bh=FnX+ZaQMdazXyHUwAjsyIFZPxYO2MesLkHCsNTULegc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGJ08h3vZcB9MOV8M5b7mAug0/DxveZXxNYEBUq06hZKXVan3bhJO/bh7AajQsC9I5mpMXVXMTy1wVuI4HaE8JQ9d75mb9S+fmceP2EnejOdjhPlu72bsjt29TRNdDC9xuJQE57jNjmhO43cgK0bje2oqTsGs2XfajD/OZeC/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hV9ArLQ6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hV9ArLQ6"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so316324a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 11 Apr 2024 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712873470; x=1713478270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUxBq2p2MKqbSqHmXHdBK5t4v0sVp/NvWw9a6yoJVzk=;
        b=hV9ArLQ699yd/MVMzqdAOJBU4Oc373vlizyuYBxJqNSUXGxBAC4OkE8mDwmpWFjZim
         vpj50P07xYqbHvfumkS1nLdRMoulMWIsyrWC7USzS5fyu532DoUUOPO7CDOG/rhpGZFh
         1wG2179F1/X9Tzm6ThbmToVAVco6Gy/y0FMnoQeWLAb6eDSohJlBhdoKYggAqHpfcE3S
         sfgapOFRfkNYkr4mSS1Voo5BAhIc3Db8Ge2qRCcdWwCeOTq9sY/D/2j3DUnfVEsbzH3O
         PfvOJm5geoJojkRkHQwFdb+Zug91KgF5tSjt80qbiYmpyHpZD0aglFNI3XtuSWD/fe2f
         B2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873470; x=1713478270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUxBq2p2MKqbSqHmXHdBK5t4v0sVp/NvWw9a6yoJVzk=;
        b=BSIPE8lvc2lij0z/nWSHyyXZ0I+E25tS0zWojoLD7nK5JrUXk1d10vL6yZheGFvU2n
         kcgaTedWSPffvmtZdBD4JlaOx4irIVJA1e1LZXl/xmCLZNxlBYhRWn7TyAy7vvleLuQj
         MXWsbEUK8/V2+AXnEtqs1f6NgQWjbEosyPS6UKo1OHW1SEKGLIIhWSn3kuKp27RfFLD2
         C7EuvzBTOx/TOPbJP7mFIWYOH762d2CDqHt/lpzmPWp8KCAE8UOsVbcBrP5XLCaUpN38
         q+PuWo+wq3SZM0iZiYqWF2BWT2sYkXhWoER3/kNvdQYg/gu0zyR3apYa3S+Y6b6lh9xZ
         u87A==
X-Forwarded-Encrypted: i=1; AJvYcCVI1veIFEhFr9IBDrLYKq0Zyzc47dwnlIJqKyFe6swX0KZZ615I3otwmwBy5/wY+OKjNPu32/YCjZoywd6PUeiz8sqgyqECKjgRRZE4prfI
X-Gm-Message-State: AOJu0YyK6V1nIa4QUez3J4luuErRyUxOYucV6+7empJeJvamRCbvPRwf
	2pO3lhpV19hRD4oBZ00arivzhd0N9UqPvG52G/MvaDjZHAoflKGzqrWdnUcvxN8uQkSf0yHfGzk
	Wz8rfRwtdWTamryCrTJdkEDqiB37FuqCR1vfn
X-Google-Smtp-Source: AGHT+IFcZE6KZQ1GV1rCkfDRhHT+vuUZl1UyV0Sl62k7UOGuHiFip8l/8N57jxJEiT3IbnTfUjgTrxuelM1Oq3eVXLg=
X-Received: by 2002:a50:8acf:0:b0:56b:fd17:3522 with SMTP id
 k15-20020a508acf000000b0056bfd173522mr606015edk.14.1712873470089; Thu, 11 Apr
 2024 15:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-snprintf-checkpatch-v4-1-8697c96ac94b@google.com>
 <48d593c1-c706-4af3-aacf-d1329a8b0d4b@wanadoo.fr> <1a4554d39229c790c98bebb213bc9f2423cd32de.camel@perches.com>
In-Reply-To: <1a4554d39229c790c98bebb213bc9f2423cd32de.camel@perches.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 11 Apr 2024 15:10:57 -0700
Message-ID: <CAFhGd8rUz_wG+jkW=+17RpG2BQxaRMmZVk=g=G1FogMSeAD7jA@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: add check for snprintf to scnprintf
To: Joe Perches <joe@perches.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Andy Whitcroft <apw@canonical.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	Finn Thain <fthain@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:56=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
> It could.
>
> # {v}snprintf uses that should likely be {v}scnprintf
>                 if ($line =3D~ /\b((v?)snprintf)\s*\(/) {
>                         WARN("SNPRINTF",
>                              "Prefer ${2}scnprintf over $1 - see: https:/=
/github.com/KSPP/linux/issues/105\n" . $herecurr);
>                 }
>
>
>
> Though I also think it's better to use lore rather than github

I am fine with making the UX change in v5 regarding using ${2} and $1
but I wish someone could have said something about the Github links
earlier, we already have a pattern going with these string api
changes:

     "Prefer strscpy over strcpy - see:
https://github.com/KSPP/linux/issues/88\n" . $herecurr);
}

...
# strlcpy uses that should likely be strscpy
if ($line =3D~ /\bstrlcpy\s*\(/) {
WARN("STRLCPY",
     "Prefer strscpy over strlcpy - see:
https://github.com/KSPP/linux/issues/89\n" . $herecurr);
}

# strncpy uses that should likely be strscpy or strscpy_pad
if ($line =3D~ /\bstrncpy\s*\(/) {
WARN("STRNCPY",
     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see:
https://github.com/KSPP/linux/issues/90\n" . $herecurr);
}

# {v}snprintf uses that should likely be {v}scnprintf
if ($line =3D~ /\b(v|)snprintf\s*\(/) {
WARN("SNPRINTF",
     "Prefer ${2}scnprintf over $1 - see:
https://github.com/KSPP/linux/issues/105\n" . $herecurr);
...


It should be noted that nowhere else is a lore link or github link
provided during a warning, so there really is no precedence. Joe what
should we do?

>
