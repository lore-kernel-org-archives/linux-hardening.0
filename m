Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0C0C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 24 Feb 2022 18:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiBXS24 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 24 Feb 2022 13:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiBXS24 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 24 Feb 2022 13:28:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5B12B771
        for <linux-hardening@vger.kernel.org>; Thu, 24 Feb 2022 10:28:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cm8so4113966edb.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Feb 2022 10:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A9fzDXY9Pawtti5sitNYgs0Fy4usPU844voMfn3IdBw=;
        b=dl6HDEGVlT4NNXS+IICLIyWUeJ4CPNtZVqt7karefHOT34m9SGbvzOBZnY4TRymU+P
         TkWhXBb6+tkuw3h4utWmhoNw6f+PwulSb7gpb+/NZejGPPxjEbaBMwIoyyP5tVnqrnQI
         NU8gttIl16ZIr9mhL9cMEXK7E0Q9RK3aACepd+i0T6ECmKr1Ko8jaU6MhGwU4USSGPfq
         z779HAe3Cr+BgKDZ8/CCe0NULpEw0jkPfilJrpWc4A+0mBtl4Dx5QXt15277Bov3kmLJ
         xxFcHR9V4DDznD/q4rB8pCa4mUrLkNRhFtkVse/rJeEVYV0SEw/kkggDHdHJ7xCbHjRr
         tYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A9fzDXY9Pawtti5sitNYgs0Fy4usPU844voMfn3IdBw=;
        b=RXkIBrIThRSDnMkwhqULWmakodELtHh4NUv0G+/6PRYYk88mUTFuU9i6g/swvofMJt
         gPlkuSUP3FO2BdN230o4FRTcUtA7Q3A3uVv5b8CwTPo3Fq19/3SUmaKcaJn+6Uv+m7vt
         B/WA9M/kejBJ2JhfXs642+Ivnt4fH3HP5DXda4K8FLIVQ8t9j0vuyGdl0To7H8n2xLVc
         DeSsKA0aVk+NFXzO3VSs6xJRQUp3xy3OxvVtjiyZR1pR2EvfGH0qKS9us+7DnBnSN2D5
         CX85VOfJRdmnEgtVkjPVKj205mTvMcK9I+vtOQ7b3A5OJk1Wfq3A5e7TWgZc7lBP8jg2
         0UXg==
X-Gm-Message-State: AOAM530xnhdoJ8wJYDLuQ8hoaptH5kpUNwIH3WwfHP2yEJakxbp97Ysa
        2rQvWrtW/5OwNlZTk/1wXKqvvfz0wLk4nWQguHYiPw==
X-Google-Smtp-Source: ABdhPJyd0J9YBYi7aXnqX6OwRKkx26kDeX3KMKqCXaMxU62hgxoaffTO84p3kE7edGocRELjW9JrDbnvnBAzeENlM9g=
X-Received: by 2002:aa7:d592:0:b0:410:b9f9:90f2 with SMTP id
 r18-20020aa7d592000000b00410b9f990f2mr3543452edq.327.1645727303752; Thu, 24
 Feb 2022 10:28:23 -0800 (PST)
MIME-Version: 1.0
References: <20220224055350.1854078-1-keescook@chromium.org>
In-Reply-To: <20220224055350.1854078-1-keescook@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 24 Feb 2022 10:28:12 -0800
Message-ID: <CAGS_qxo1UkRUbXnX7NkfDCLhqa2-_dn3poKBi=NyGJ4C0EhUmw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Do not colorize output when redirected
To:     Kees Cook <keescook@chromium.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 23, 2022 at 9:53 PM Kees Cook <keescook@chromium.org> wrote:
>
> Filling log files with color codes makes diffs and other comparisons
> difficult. Only emit vt100 codes when the stdout is a TTY.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/kunit/kunit_parser.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 05ff334761dd..807ed2bd6832 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -11,6 +11,7 @@
>
>  from __future__ import annotations
>  import re
> +import sys
>
>  import datetime
>  from enum import Enum, auto
> @@ -503,14 +504,20 @@ RESET = '\033[0;0m'
>
>  def red(text: str) -> str:
>         """Returns inputted string with red color code."""
> +       if not sys.stdout.isatty():
> +               return text

I'd been thinking about doing this for a while.
I'd just gotten used to removing them via sed, or ending pipes with less -R.
I totally agree it's for the best that colors be turned off by default
when piping.

My hesitation was whether we'd want to introduce a flag like grep et al have.
I.e. --color=auto/always/etc.

Pros:
* consistency with grep, maybe less surprise
* allows wrappers around kunit.py to redirect output and still show color
   * this is very niche and I know it. But I happen to own such a wrapper :)

Cons:
* an extra flag that's very niche
  * I'm likely the only person to have ever used `kunit.py run | ... | less -R`
* the logic to check for coloring becomes more complicated, need to add a helper

I'm fine if we just stick with this simpler approach or do it later.
My aforementioned wrapper only redirects stdout when necessary anyways.


>         return '\033[1;31m' + text + RESET
>
>  def yellow(text: str) -> str:
>         """Returns inputted string with yellow color code."""
> +       if not sys.stdout.isatty():
> +               return text
>         return '\033[1;33m' + text + RESET
>
>  def green(text: str) -> str:
>         """Returns inputted string with green color code."""
> +       if not sys.stdout.isatty():
> +               return text
>         return '\033[1;32m' + text + RESET
>
>  ANSI_LEN = len(red(''))
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220224055350.1854078-1-keescook%40chromium.org.
