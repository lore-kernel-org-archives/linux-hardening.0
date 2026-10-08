Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117574FC8FF
	for <linux-hardening@vger.kernel.org>; Thu,  8 Oct 2026 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791491361; cv=pass; b=prZPv6C4O6eLtbZ7kSxVOaSlzfbMuNN6WN+j08guJFhf18O9e7sHLmZfZj+LAIXqQtoxvzrn4eTk0SOIUDkDtCPzcGH//GwWgCUVUeY2KEnwndUV2FnBrYMfSg0vKr0B4IjFGCufT+ly+3D8fkhJkYMl+mUIChz3kplCmH9uHww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791491361; c=relaxed/simple;
	bh=7axkb603a82UmmO6yoTtFA4rswXUCvwHcAJzJKwVvkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcUHzYQgd+J5oXMQGMkbxgLpnsQ5aRIHts9uYXw7qHcS0OH4JI1T+ml4VaBOf8b6Du2fgLk3UpPNhYHFsyZ8VvVU5migHlBt9tArumA5AIA+U8X3hxpPi/dB/phqPxjfYlfYKhvRmXi/OaOMUzTx3JIEml3YTem+fDoRLJn5fRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubWwUgjm; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubWwUgjm"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7c33cc572e6so1109157137.1
        for <linux-hardening@vger.kernel.org>; Thu, 08 Oct 2026 13:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791491358; cv=none;
        d=google.com; s=arc-20260327;
        b=czWvuJt5UH8/MGBd6REAnx2AUUZbknQk56z+iv/bsjg6XaLGlUQWL8/5KEd+dwfv7Z
         eGclAqEUgE7Jn8AEGFftW7Z8DtpuqIXiyIWRuvSk7xWjAkcmiCDz5aljAP7m+u638tqA
         /aIHZxpVLWdoxZuGqJfKkuCtI5Axc58AN2VaXB0kzZxWvmBg94WjmaF0SSogY2TeXjah
         Y429myC7T6IYWEjcdCHHoJMYmPjVD4ycrlJQyfYkBAS5bBblPMZvh3udz4pQuTNeB+vQ
         5rnXViSVsmslb6zzpkqBQtZv5JT+jV4z8PighTOnX5YRChVeSeB+GrGiwriWIron3qZf
         P8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dEYO+uBmenzQsAKFWdFIK9tsQp7aIojLDDws7AJPz68=;
        fh=PT2Ehnab6PfyP4yNBLilSpobn+a4waMVDrCyterHvj8=;
        b=mRbAoEprjO9GRKcyC5FHLNXl4mBmTP2orSpMd49Wolhm2/Z5xQXcu3h+TuX1UaOiGA
         6YjE+zJ1wZgGM4aEW4mgK6d5u32lpgf1CT5p/RIHaRj/5xtQwmBkXeZTqwyiTxYhdfDM
         Y2CX1GLtttknqPJNvAMRovV9rgOD+JKzDHCNY0xfOcZ5LT1hajBNXV3EtjMzQwAg6IIN
         fzimbZj9JUZC6KLA0K0sHNmTiw15xIQZ8jGaAYJs+GJHDMlxtumpNuJgkQ+MGo8xi4WH
         Hb6NLSnTtUlUkYzYQpRXCImGC/8eNQPy9O/SaGv46tifEw+e4JGBXrTHdyVszKi+namI
         ozKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791491358; x=1792096158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dEYO+uBmenzQsAKFWdFIK9tsQp7aIojLDDws7AJPz68=;
        b=ubWwUgjmshpVIK6Kd3t6ndTPrLEDo6MEt7V1pvLj9dwg8zXctxTW8JArssRsunkw6S
         xRQV28sQWWsWjyqCvNJgq00uaXZCpeNW2UPyMhizeI45hBjNf8+OdfnjrFEUHHsIsWEt
         kXKaANlAscFQyZJt/88s/38XmOg8OpefiqIyfl3tTTpUdXF7ETTL+VrryhLUGUmr6v80
         V02Szye8l8s01Mw8d0L4wEc19Yiu5g/Z9eI6u2hPD8wRoU7DnhQJemDR660TngsrEers
         yVkIMQv6cdk3byciZkVBxiYpU+7EluwC5QBzyUcADrU8AnkmUOGplwXVlRimgpik6PVy
         kUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791491358; x=1792096158;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dEYO+uBmenzQsAKFWdFIK9tsQp7aIojLDDws7AJPz68=;
        b=fKIQlp2Su0re9TW1zWlXyqRVdV4TtDtp0sSn4gsoJyOeFMSPqLEpNtt13UJR4oAfzU
         zRmw+rM2+CoPojtQmnYxmG3Zd3lvFl9YJDAkoSLXenUXvfmsfshppF+aSLjvKI2mr9De
         YABW05pZSieQBjdwFCs++zt5ITG3flxSlpMa9MzJFoSzJjInKAFTx20ThYwjl5XpizFZ
         lRN8FIMBzDssXuITABf3BW1UiJd2zwgGw784UOcA9ieC7HK+s/ZhyCiTctfT5Q7PClqn
         9ZQiKch2M4fbhk6RNkk5n3K9tQYA90neUgdhn+MHWN/7D0higtSn4WCPBFJcgFuriT+m
         sjsw==
X-Forwarded-Encrypted: i=1; AKwUvBwTXhMgvjDPv3FgGZVm2WegPwS2DSb3zNufzdxvTK1bhZ2ozs9KwLI26np0RTluYp0ZtozLiTdfEIzbFLASsKA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaSvhF8Zha/x3ps6oI4S8RfRaPxvUmtafL+SF4DMOXWiMrf98a
	nHrqUUMUAw2L5uz3/u8cq7MBQmUgWlwN9yl8OIbrR1hj0wFqxLYOL1JKx383gt05cZSSXAYb5lF
	YaFCLKcN04riVvrl3fvvmWZFB6VAflgs6LqTKLTY=
X-Gm-Gg: AYBFou20WlrwYmGRU5+mTJG3liPzfu0B571dFeYBetngFtatjkbXHo6Cs5HYokmxutO
	PEJfeTQwsyJ0Q78oStX1txKDIoH7DEW0FVKzXa0/AHQZWAsY/r4PoO6iw+BX9H05Y06NJKXlsSq
	BdPFFzZ94g4uRcYDvOMJbJKl9UUMH9w4IYlIRRxWmTPC3ElgjXdUPDlaw0GF5ei9ehsYEmNQG/s
	rouZoM3Zw9EWZ8dgwXJi5GFX0AWW0r/rzEHNr+yzSaHJL95wV47g/cCwkD0CVYpR/gMCg/sK65h
	YI7GnCB/OA14BU1c3ali6a26j5B9kxNG8QO0vySLeFYMZ6JG6SnYw/U9P5wAy4Gog+F/di2N9iC
	n9YUt5wGPIgjynHE4o9W/WWzfKiq1Ti0=
X-Received: by 2002:a05:6102:22c2:b0:7ca:7226:b414 with SMTP id
 ada2fe7eead31-7cab8948919mr912611137.19.1791491357086; Thu, 08 Oct 2026
 13:29:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com> <20261006094358.2948476-1-morbo@google.com>
 <202610060642.7C4125F@keescook> <20261007090915.GA1504630@ax162>
 <CAGG=3QXPAa-i4r3Vv6-q25A6EvsxGb5RDLn02z1=a5zo7W-7Vw@mail.gmail.com>
 <20261007093641.GA1527653@ax162> <bc2e2ae7-02e7-4148-8ad2-ab3c1af3dd7a@app.fastmail.com>
 <20261008161724.GA459@ax162> <eb644465-0c41-431c-85a3-f7eb6bd86cf3@app.fastmail.com>
In-Reply-To: <eb644465-0c41-431c-85a3-f7eb6bd86cf3@app.fastmail.com>
From: Bill Wendling <morbo@google.com>
Date: Thu, 8 Oct 2026 13:29:00 -0700
X-Gm-Features: AclHuK-6rPfWZEe_Z-sw2qrJwskK3Nn8JlizxagKQ-WxeGZ-k4tgZG1nsqTiy3s
Message-ID: <CAGG=3QUvZ8k1qjT8jjo1Rft0omyQYAcRUWExKvJw7CGD5B7XeQ@mail.gmail.com>
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, Mark Brown <broonie@kernel.org>, 
	Marco Elver <elver@google.com>, alan.maguire@oracle.com, namjain@linux.microsoft.com, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 9:41=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
> On Thu, 8 Oct 2026, at 18:17, Nathan Chancellor wrote:
> > On Thu, Oct 08, 2026 at 04:50:44PM +0200, Ard Biesheuvel wrote:
> >> On Wed, 7 Oct 2026, at 11:36, Nathan Chancellor wrote:
> >> > On Wed, Oct 07, 2026 at 02:32:45AM -0700, Bill Wendling wrote:
> >> >> Ard,
> >> >>
> >> >> What's the reason why x86 doesn't need the KBUILD_CFLAGS flags? Is
> >> >> there something that breaks things?
> >> >
> >> > I think it is mostly historical. See Kees's series to address it:
> >> >
> >> >   https://lore.kernel.org/20261006204210.i.137-kees@kernel.org/
> >> >
> >>
> >> I've queued that up now in the EFI tree.
> >>
> >> Do we still need this patch then?
> >
> > I don't think so, since the efistub should now get
> > '-fexperimental-late-parse-attributes' from the main KBUILD_CFLAGS,
> > which is what prompted this patch in the first place:
> >
> >
> > https://lore.kernel.org/CAGG=3D3QWCmQ+LVvn2dtjEauj5WFwvx=3Dpvg4Q6man_A2=
imdjRe7A@mail.gmail.com/
> >
> > As I mentioned up thread and to Kees in person, we should still conside=
r
> > adding '-fexperimental-late-parse-attributes' into CC_FLAGS_DIALECT to
> > cover other areas that may see __counted_by_ptr use but it is probably
> > not as high priority.
> >
>
> Excellent.

What Nathan said about needing this patch. Once Kees's stuff is
integrated, all should be well and never break again. (very J/K) :-D

-bw
