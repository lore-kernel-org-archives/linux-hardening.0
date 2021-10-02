Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABA5C433EF
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 10:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252F661A51
	for <linux-hardening@archiver.kernel.org>; Sat,  2 Oct 2021 10:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhJBKoi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 2 Oct 2021 06:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbhJBKoh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 2 Oct 2021 06:44:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6DBC061570;
        Sat,  2 Oct 2021 03:42:52 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id d18so14535755iof.13;
        Sat, 02 Oct 2021 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Osma+ZoY9LB956joAB5f2LyabZrBd+3JOYnpTaKn98=;
        b=AZA7gEItNhKh1XJTh7QZQayfq7PVl0xLGa5hb/b/laX+qbam8EDGNoMPJvHaHacnMI
         HtRA/Awer9UHEEvgs29F71U8AM4k1XU3kcKRUkspE30kG9CbUMnlKygqBg1ZzEQ2Fj9g
         +JiEqTvAViUTfW7JDbMcrBdMYB9l7gNaTLO8GwWFMET1BjWRNVcjSfULzdrU5gYLuV96
         a3ocG4kUSUSn+SKxAG9r10sDCQ+wS8zYEocdXb+lY645IKXxKXIZaOc3BxgQpJABmIlY
         wkuMfUSF/ii4JaayjcJqcw6JBTN3H8oKPi/h4xF1Doa3auF0JIJ1hMkJK/QjWU/vdvOG
         o8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Osma+ZoY9LB956joAB5f2LyabZrBd+3JOYnpTaKn98=;
        b=oTDY71MbNucIQLWgxOZUS7Wp49ixwnu+mLN8xlRulWyUmw1OMGhwzkPRp83kKuk3j6
         BxciGxg/fx2nQBUJbXL6yi3cAwZ6MdTXuO9izn3A6LFeFPhZkWk4amFyt5+8YzqBpb9o
         PgE5mCA9GkFKdflRWslFhyALK+3aEgOjr/Uc5h09ztGLkEIE6h55j4nTvwiPXhufttta
         HpRrRYUlMVb/9R9xV5wb+Q4wn9chun1Cuhbi/+eAX8/DYw/NUJVvKVYTsLztMNOkya4m
         FtL6xsc4ZJXTpg/Ez/QdjBDqxjgALdyXri4cVRXXm3YiaY3rmHeD50IPu/WlcVbJ68Yw
         A1tA==
X-Gm-Message-State: AOAM531bAXxXgfWu2OtD7Jua0ECaR7JoL90c7CBUkSb6Tzq7cFJFh4e2
        /c9qX0jSEpEOOxMYnI+iVlhnwOshhP08wfYW8pQ=
X-Google-Smtp-Source: ABdhPJxuEAK4ZOjYd7EF/1e7D6z07isVKPcr4xyWh9Zb1t1TyGx6rtYErz2wRSd6SNyRWmJ302ZOb1G+07YE0jGhgWk=
X-Received: by 2002:a05:6638:d89:: with SMTP id l9mr2376403jaj.46.1633171371734;
 Sat, 02 Oct 2021 03:42:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210930235754.2635912-1-keescook@chromium.org>
 <CAKwvOdm37zpJZkLvbHvVkXax=XGQ-Ym3iPfx7LtTUnZhADnYCA@mail.gmail.com> <YVf80rXg8Yd19Hmw@kroah.com>
In-Reply-To: <YVf80rXg8Yd19Hmw@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 2 Oct 2021 12:42:40 +0200
Message-ID: <CANiq72=T9b_RgZGHuKDjj=E46c0nB2CHH3+Wsdws2Wt9YWcHVw@mail.gmail.com>
Subject: Re: [PATCH v4] docs: Explain the desired position of function attributes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 2, 2021 at 8:31 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> Why would documenting the expected format have an affect on tools not
> being able to follow that exact expected format?  Are we defining a
> format that is somehow impossible for them to use?

From a quick test, clang-format-12 with our current config keeps
attributes in the same line and it does not seem to reorder them, so
it seems OK (the developer has to do it by hand, but that is fine)
except for the `__malloc` in the second example which is in a
different line (but not in the first). Is that intended?

> If anything I would think that now we have a format that the tools can
> actually follow, while before it was semi-random as to what to pick as
> the "one true way".

In the future, clang-format could have a configuration option to pass
a sort order, in which case, having the sort order already defined in
the kernel would definitely be helpful.

In fact, we could use the fact that the kernel has one as a way to
tell upstream that such a feature would be nice to have :)

Cheers,
Miguel
