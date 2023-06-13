Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4E1EB64DB
	for <linux-hardening@archiver.kernel.org>; Tue, 13 Jun 2023 20:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjFMUpG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjFMUpC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 13 Jun 2023 16:45:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA96EE55
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 13:45:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-513ea2990b8so3842a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 13 Jun 2023 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686689099; x=1689281099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3I43KAuJAocXaniTcVrq9SXL9Lvm/1crVtr2GDT8u8=;
        b=5Zm5sKRkHMVDZPW2Y1FNVHlOcAFdOb/jk3DvGjuiLGPssaDk+mymtYebDfdKQu0tkX
         adUO3QTRnBddXET8vlONIyHU/MHqu+0/pRYg2sjjepoS9aOvmJiG9nt2iJnRU8u8frvG
         CmDWTEpHuADJ6v39wAZvIgTNDyLw7VUYqpfOwtFnnnCZnBuxTUoMv2KmfdQdRVFOHAZm
         ynorB8ZtdBPyca8D3c3g0O1x9IlUfar31fSFerUJ2kAhNNKMe/z2fQW8WIG/6tR8EyJH
         VTMJqXMDMVAdiIlEIp8L0SGS9bq9pkPPNl92Mh71c3lz6DNxIhH6wLOLRe2f0EbC2rKn
         0fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686689099; x=1689281099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3I43KAuJAocXaniTcVrq9SXL9Lvm/1crVtr2GDT8u8=;
        b=cEQ2SLvC7jYtFAjWw6XcI4J3GaQ9W9ZsX/EsZXjvc8A2qn8esiY2VN/QPFDGfHzf+h
         /F/3CWYjt6Gf/qMoAGPMM2QDKIDszMCBprD07K53x8+JuJ4dgFCJL4RHJa8Jzbx0O+nc
         cO85miei6VqcLAPKZUMJvzCTCtiIzKTHpHRUXuAM6otPUZ0Uj7LMUA5bLyR/Mj2WfsGD
         glcJjeuPD7kyd7tZCj8RUymvbnsv5nAPLSe6bR8gO4ah2DlAZwaFBV5acs9rShxOKPNM
         VxUdLLSf2NbnrSeOKrt+hOcqno3d8fZ0YY5KgNXpxUsnfXewZQ1uw62gBmtwrzik16x9
         1txA==
X-Gm-Message-State: AC+VfDznJfB8A1iDYf5Wh8ncLgc7rtWizvGYiz/AVcieXpimcRdwrC9F
        P8loHJJcD+dawIV/Z2yEivBow1F0XJxG8vUtes0e6Q==
X-Google-Smtp-Source: ACHHUZ58WJEANk7OZrTLn1q96CvAJiH4uGdd3nBCTWwrgtjjdrmlkWJXrFAweZHcEfVBn8g33KV6l4BEWsYWZoALSi0=
X-Received: by 2002:a50:d0d1:0:b0:518:7076:74bc with SMTP id
 g17-20020a50d0d1000000b00518707674bcmr22868edf.1.1686689099093; Tue, 13 Jun
 2023 13:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com> <20230610005149.1145665-6-rmoar@google.com>
 <CABVgOSkKYzynFcAdSKbdbVjL0bYnXtgM8XbkkRc2+9mef1wCzQ@mail.gmail.com>
In-Reply-To: <CABVgOSkKYzynFcAdSKbdbVjL0bYnXtgM8XbkkRc2+9mef1wCzQ@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 13 Jun 2023 16:44:48 -0400
Message-ID: <CA+GJov5ug3DjXe4f0_G1emt7FPVZACqtyhoQtNmxZ81tLH_feA@mail.gmail.com>
Subject: Re: [RFC v1 5/6] kunit: memcpy: Mark tests as slow using test attributes
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Jun 10, 2023 at 4:29=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 10 Jun 2023 at 08:52, Rae Moar <rmoar@google.com> wrote:
> >
> > Mark slow memcpy KUnit tests using test attributes.
> >
> > Tests marked as slow are as follows: memcpy_large_test, memmove_test,
> > memmove_large_test, and memmove_overlap_test.
> >
> > These tests were the slowest of the memcpy tests and relatively slower =
to
> > most other KUnit tests. Most of these tests are already skipped when
> > CONFIG_MEMCPY_SLOW_KUNIT_TEST is not enabled.
>
> I assume the plan will be to eventually remove the
> CONFIG_MEMCPY_SLOW_KUNIT_TEST option and just rely on the "speed"
> attribute to filter these out. That has the disadvantage that the
> tests will still be built, but is probably the nicer long-term
> solution.
>
> I suppose we could remove it in this patch, too, but I suspect it
> makes more sense to have a deprecation period to make sure the
> attributes are working well. That being said, maybe add a note to the
> CONFIG_MEMCPY_SLOW_KUNIT_TEST help text to advertise this?
>

Yes that was the plan but I should definitely document that here and
then I like the idea for adding the note with
CONFIG_MEMCPY_SLOW_KUNIT_TEST.

Thanks!
-Rae


>
> >
> > These tests can now be filtered on using the KUnit test attribute filte=
ring
> > feature. Example: --filter "speed>slow". This will run only the tests t=
hat
> > have speeds faster than slow. The slow attribute will also be outputted=
 in
> > KTAP.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
> >  lib/memcpy_kunit.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
> > index 887926f04731..440aee705ccc 100644
> > --- a/lib/memcpy_kunit.c
> > +++ b/lib/memcpy_kunit.c
> > @@ -551,10 +551,10 @@ static void strtomem_test(struct kunit *test)
> >  static struct kunit_case memcpy_test_cases[] =3D {
> >         KUNIT_CASE(memset_test),
> >         KUNIT_CASE(memcpy_test),
> > -       KUNIT_CASE(memcpy_large_test),
> > -       KUNIT_CASE(memmove_test),
> > -       KUNIT_CASE(memmove_large_test),
> > -       KUNIT_CASE(memmove_overlap_test),
> > +       KUNIT_CASE_SLOW(memcpy_large_test),
> > +       KUNIT_CASE_SLOW(memmove_test),
> > +       KUNIT_CASE_SLOW(memmove_large_test),
> > +       KUNIT_CASE_SLOW(memmove_overlap_test),
> >         KUNIT_CASE(strtomem_test),
> >         {}
> >  };
> > --
> > 2.41.0.162.gfafddb0af9-goog
> >
