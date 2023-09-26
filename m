Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC87E570
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 08:36:09 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9775FC
	for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 01:36:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1012941066b.1
        for <linux-hardening@vger.kernel.org>; Tue, 26 Sep 2023 01:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695717362; x=1696322162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjnOqBYDIBukB8OfPAJ6Ctq72GgFY1Pbrxf/0XUTr0U=;
        b=RMWwc3FK1XzQMOtYTT5NXG/VxUD4MG+CKKlaThaj32zMhRNI6jWFMuCbLJvC7MaosK
         X3PqKNzwNp78NDljLsaXeVu6m5UkfGGoEhXA8Cyy6ukhBFLSNQKLfNnEi45HI8/mJkzr
         9cbh45p43dyYoJX2ukXDTG+jypVuos1XQ+Gdni6XD1ZjFcL8k0hIuml8FhEYoLe6hSx9
         geTD/7t/RnrM4cTNj5LABjbZQzDFlBg571mc/PJy+pVgboJlPZm8GJ5jDsWrBeaeceCK
         t48EQW/5POT/z9v/dTKStyppDrnCx13jC38kpsiR0cMkXGB+9+kGCCHys34ef19DPknA
         RZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695717362; x=1696322162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjnOqBYDIBukB8OfPAJ6Ctq72GgFY1Pbrxf/0XUTr0U=;
        b=GLY3nZ0JaLeshYFb/ppsg6noF/Jng1rMBFKaZEmdswz5IHtXznTT718b1kphf4EebB
         AqQPG1G1A74WIIssO45xQoujg+NB/xBtCN8ygwlvjYMRCHFNq8Ciim6VrsWycRUGPsHd
         W2YfvAQjga569lj47jbrSiCikzNxEZh//YYjrGteCEM8Wf10fe9/uiecXGvPoELEwlT3
         1qU+nD0q9ODUURKN9K5jssK1ZTHbbBGxWJKxQRbGgQMvJanq+jPjzIXTALuP/82Rb2VF
         p0k0cysmqhMhxv+OZcHIM2UrZpHiOrEPvwlDax6aqSRLRv5PrKbaGGxQOeThWgyovR8O
         8e5A==
X-Gm-Message-State: AOJu0Yy2GcChrQ6r+vq0oEixh7+l9SN2zPknmF3rLpe0W+klmZ8rrUwF
	4kXq/hyQClP5lpYZIsCfV0DDApTG6apTzkZAkH6r/A==
X-Google-Smtp-Source: AGHT+IE591DZVU2mJKfq33uK6SQBvR3uoWMKY6HLmrVDjaQ2l1qfraVqaMTyJdeqZwIRRA66fsONQh2x5kKbTHwP2xE=
X-Received: by 2002:a17:906:1ba1:b0:9a1:e233:e627 with SMTP id
 r1-20020a1709061ba100b009a1e233e627mr8324753ejg.42.1695717362060; Tue, 26 Sep
 2023 01:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925172037.work.853-kees@kernel.org> <20230926045721.GA3118@sol.localdomain>
In-Reply-To: <20230926045721.GA3118@sol.localdomain>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 26 Sep 2023 17:35:50 +0900
Message-ID: <CAFhGd8q_GsawVXmwft=2g8bU+9Z5sM-q2Siajk2geL6cPQUiQA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: hardening: Add __counted_by regex
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 1:57=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Hi Kees,
>
> On Mon, Sep 25, 2023 at 10:20:41AM -0700, Kees Cook wrote:
> > Since __counted_by annotations may also require that code be changed to
> > get initialization ordering correct, let's get an extra group of eyes o=
n
> > code that is working on these annotations.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 737dcc7a2155..741285b8246e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11405,6 +11405,7 @@ F:    kernel/configs/hardening.config
> >  F:   mm/usercopy.c
> >  K:   \b(add|choose)_random_kstack_offset\b
> >  K:   \b__check_(object_size|heap_object)\b
> > +K:   \b__counted_by\b
> >
>
> Are you sure you want to volunteer to maintain every file that contains
> "__counted_by"?  That's what "K" does; get_maintainer.pl will list you (a=
nd
> linux-hardening@vger.kernel.org) for every such file.

Do people call get_maintainer.pl on specific tree files as opposed to
invoking it against a .patch file? In the event of the .patch file
"K:" should only pick-up what's in the patch and not read into the
files outside of the context that the diff provides.

If needed, I could send a patch adding a "D:" which would only
consider patches and not tree files -- reducing noise.

>
> Other users of "K" have been surprised by this behavior.  It seems that m=
ost
> people expect it to only apply to patches, not to files.  Given that you'=
re
> interested in using this functionality, have you considered updating
> checkpatch.pl to handle it in the way that you probably expect that it wo=
rks?
>
> - Eric
>

Thanks
Justin
