Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FF7C77B7D
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 19:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjEQTX0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 15:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjEQTXQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 15:23:16 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067AA2D4D
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:23:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f51ea3a062so37151cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684351389; x=1686943389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99WaBRQDUs3kb1dnzIG44mb1K4MZZ93giF8G4LLAmW8=;
        b=dC/JtS+CXoS3N4aXYIF6cSUebLVzJ7Tb65v5Kqkyjle341mL7a7aSc8Cj33QqRhHOM
         YkWvISnH+LhJSqB0OWz4QYFc4XCKPoCZGWjsI0eqFCsx4BoxL2c1z7DuOHVGoaE6UR55
         iCJoBY9KYYUHL6gLjCMLKhyd0LoDh5fZHTvpJ88bW+jcNBrl1fBZ4D6ooBVpzNELKZw7
         0KFLTQmN7Fn4dO3BAYhhDQQYBPjzVz7s2/2FfIvDwK7+cK0GCRIWrCNuB9a7UTlHYQBU
         BCkYU6X3gMVVhRnc+xjtl7wRsYrhEjA+5S4ch8p4sPJLOlLC1bis4Y8nQdqyZ3wuzUZ5
         3DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351389; x=1686943389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99WaBRQDUs3kb1dnzIG44mb1K4MZZ93giF8G4LLAmW8=;
        b=UywhMsO2dRkAvQO9kWyCW3XhvberRJ+8znQ5UgfqrznXAZDQ58dnFy82SdyPTr6tgq
         NP74c3WCpsHJvu0kQIF6/xiKftgRMTZnJsQ9PwAgKp4k5Vl5ZslYmZlU8BsEVBgAauNF
         AgFe852jkbD4XD5GlvnBDDoM1SFU4cOje5TDqqaZrhOET8So0HIo2x94Nwo1Zg8v7g2H
         1P8cX0KTHCNRcjUHURk3LsGbpvMnd1wA9AoAH+lUAgjFq47cqcn03e7yP46ScwnYIIgm
         FXDRdtugWZZx1/d4w/MUyYZ/skUxhmXqmRNfzLAnrS5UYp6ZovmqKkkMgRYL+mK+v6wQ
         5/IQ==
X-Gm-Message-State: AC+VfDxA2GELaoWMscyWWHOYEHhco2CnxZo6RO5kopOX7rVrdW2PbaQV
        0719IyLDIV/Rdtykn8dSEE4FPqc+lwglwinYr/E/dg==
X-Google-Smtp-Source: ACHHUZ7R+gC0bI/RsQjqW5ftAr/ftTU0NZgmcN4ZTqv8lHc3bxNUzCoZn8yuoEW6XLsEKxJ62Ukgubm/ICDjEdour/0=
X-Received: by 2002:ac8:5789:0:b0:3f3:75c2:7466 with SMTP id
 v9-20020ac85789000000b003f375c27466mr59103qta.8.1684351389019; Wed, 17 May
 2023 12:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230407215406.768464-1-ndesaulniers@google.com>
 <168435014337.2056649.7592777028793700479.b4-ty@chromium.org>
 <CAFP8O3L_RsaTMJvT7hmjD6ON49uob9Fb4mWg8ZUav_Y-FCgTMA@mail.gmail.com>
 <CAFP8O3JivZh+AAV7N90Nk7U2BHRNST6MRP0zHtfQ-Vj0m4+pDA@mail.gmail.com> <202305171215.7C58897@keescook>
In-Reply-To: <202305171215.7C58897@keescook>
From:   Fangrui Song <maskray@google.com>
Date:   Wed, 17 May 2023 12:22:57 -0700
Message-ID: <CAFP8O3JuPsCTgTXLkQpoy9WZG2jPxyisCjWhsB7yqJ-D9nA=OA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: remove cc-option test for UBSAN_TRAP
To:     Kees Cook <keescook@chromium.org>
Cc:     ndesaulniers@google.com, masahiroy@kernel.org,
        linux-kbuild@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, jpoimboe@kernel.org,
        llvm@lists.linux.dev, mbenes@suse.cz, linux-kernel@vger.kernel.org,
        trix@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 17, 2023 at 12:16=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Wed, May 17, 2023 at 12:09:35PM -0700, Fangrui Song wrote:
> > On Wed, May 17, 2023 at 12:08=E2=80=AFPM Fangrui Song <maskray@google.c=
om> wrote:
> > >
> > > On Wed, May 17, 2023 at 12:02=E2=80=AFPM Kees Cook <keescook@chromium=
.org> wrote:
> > > >
> > > > On Fri, 7 Apr 2023 14:54:06 -0700, Nick Desaulniers wrote:
> > > > > -fsanitize-undefined-trap-on-error has been supported since GCC 5=
.1 and
> > > > > Clang 3.2.  The minimum supported version of these according to
> > > > > Documentation/process/changes.rst is 5.1 and 11.0.0 respectively.=
 Drop
> > > > > this cc-option check.
> > > > >
> > > > >
> > > >
> > > > Applied to for-next/hardening, thanks!
> > > >
> > > > [1/1] ubsan: remove cc-option test for UBSAN_TRAP
> > > >       https://git.kernel.org/kees/c/08e4044243a6
> > > >
> > > > --
> > > > Kees Cook
> > > >
> > > >
> > >
> > > For this -fsanitize-undefined-trap-on-error, I think we need a v2 pat=
ch that
> > > tries -fsanitize-trap=3Dall as well.
> >
> > Correction: -fsanitize-trap=3Dundefined
> >
> > > -fsanitize-undefined-trap-on-error has been deprecated in Clang for 8
> > > years, and at some point we will remove the option.
> > >
> > > GCC implements -fsanitize-trap=3Dall later, but
> > > -fsanitize-undefined-trap-on-error is documented as deprecated as
> > > well.
>
> Right now all the compilers support the old way, and I'd rather remove a
> cc-option call than add two. :)
>
> --
> Kees Cook

Hmm, this gives Clang developers a disadvantage... Anyone who removes
Clang's -fsanitize-undefined-trap-on-error (or give it a warning
before removal) will probably face complaints from kernel
developers...



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
