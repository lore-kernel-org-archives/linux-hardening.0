Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B8EE14A9
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Sep 2023 23:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjIFXY4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjIFXYz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 6 Sep 2023 19:24:55 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E89173B
        for <linux-hardening@vger.kernel.org>; Wed,  6 Sep 2023 16:24:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c136ee106so32897466b.1
        for <linux-hardening@vger.kernel.org>; Wed, 06 Sep 2023 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694042690; x=1694647490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIy/S2GIHPrddAMkFG5TTxbNi1DEK6tKwQNJxNkWe38=;
        b=IIVbi4VkdLw7viVCAd8th7IKzDvLLzuKctsMeThCP4gWIxAw2ggnOrZE+/qoQEfwjP
         FE2fqm4Ut6Fbg7/rtv8jmYPTbW36gef5qDqLmwLEExJb9kMk9YFOvcNGfn2z//zox6O/
         bKfnP+8lF2EGONPAvloUO7q8b231L1tGsgIzbJKXPoVrNWW6gPnjqMf04QdEZ+Y+h8r2
         QF7pKiA2l/nePc49PLRXNaU05DutIY0RgQ/CPnRkNRRck55gHX0Tk8aS9l3WvJZWPbwF
         GeosVGfJ17vqxICcJ/GyEbVtNsnXBLtpw6tkcLsuolhnRGlq5EdtrpjcZkFEJTutE9se
         JZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694042690; x=1694647490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIy/S2GIHPrddAMkFG5TTxbNi1DEK6tKwQNJxNkWe38=;
        b=lvQwU5VgddE4Vd0aDuXea5xsSJjh9GBnUpaKMzIeftlzU43R9/2thWG4OS0HJ/LcRS
         i8nUldeJjKVOAZxzNOBcQkXA1nTFmh46/K4RPlYA5v9qKmjTu8+HSZXhGQTE1CzTPcPp
         zSgZeN9Oxnj26TYMTCs01II/gzIkj6uG35QH02wFXmmW6iCsddJOVePwAkW225Jr97lQ
         awRVjMNos+udb8e4LV9jE2xWiu+QL4OBtocfplY9KONnkB+rWvvWLCSCc5T75qwc9nSc
         uvWJHt5niB6PY8RYb90Mo6kADgbQyi6aS4ZydE1xz7Ox7o+QWiGqTvibHUuTGQ6GfOro
         kDTw==
X-Gm-Message-State: AOJu0YwUHI/ZUeQt64/GjUcRP9IuoEPgsRpFdjM2ZAYSQjdY8WnuvHoV
        ziCJYJT8mI3ENTkbdjmB6Cl3sEiufWCDZFFuUF/L9w==
X-Google-Smtp-Source: AGHT+IEZKgVhzYxiWAo3bdKKl4UyUlyaeu6fY9gq+pQ95E/bGNm66qdOOfJECF9YXi7Fzq8L9vZkeXF7WUvEl5qI8PI=
X-Received: by 2002:a17:907:2bed:b0:9a1:b6e1:c2e with SMTP id
 gv45-20020a1709072bed00b009a1b6e10c2emr3536524ejc.33.1694042690451; Wed, 06
 Sep 2023 16:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230905-strncpy-arch-arm64-v4-1-bc4b14ddfaef@google.com> <20230906184849.GB5021@willie-the-truck>
In-Reply-To: <20230906184849.GB5021@willie-the-truck>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 6 Sep 2023 16:24:37 -0700
Message-ID: <CAFhGd8qEYGvajC8jNCcMf1zy7A5hY0Cn767CC=XDgtoJsmQDhA@mail.gmail.com>
Subject: Re: [PATCH v4] arm64/sysreg: refactor deprecated strncpy
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mostafa Saleh <smostafa@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 6, 2023 at 11:48=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Sep 05, 2023 at 08:10:21PM +0000, Justin Stitt wrote:
> > strncpy is deprecated [1] and should not be used if the src string is
> > not NUL-terminated.
> >
> > When dealing with `cmdline` we are counting the number of characters
> > until a space then copying these over into `buf`. Let's not use any of
> > the str*() functions since the src string is not necessarily NUL-termin=
ated.
> >
> > Prefer `memcpy()` alongside a forced NUL-termination as it more
> > accurately describes what is going on within this function, i.e: copyin=
g
> > from non NUL-terminated buffer into a NUL-terminated buffer.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Changes in v4:
> > - rebase onto mainline (thanks Will)
> > - Link to v3: https://lore.kernel.org/r/20230831-strncpy-arch-arm64-v3-=
1-cdbb1e7ea5e1@google.com
>
> The original patch converting the strncpy() to strscpy() has already land=
ed
> upstream, so this doesn't apply as-is.
>
> Rather than go through a v5, I've reverted your original patch and squash=
ed
> this on top with a new commit message. I'll push it out tomorrow on to th=
e
> arm64 fixes branch.
Thanks! Sorry I hadn't noticed it go through -- especially with all
the reviews surrounding the patches.

>
> Thanks,
>
> Will
