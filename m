Return-Path: <SRS0=Tg6c=DY=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3565BC4363D
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 05:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000932076A
	for <linux-hardening@archiver.kernel.org>; Sat, 17 Oct 2020 05:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3N9s1Em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411691AbgJQFaD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 17 Oct 2020 01:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411649AbgJQF3p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 17 Oct 2020 01:29:45 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18569C0613E5
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 17:42:01 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a7so5462910lfk.9
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 17:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvjmWCja6FdDuet5XzS/XjhRRXvATgX1TP8z3+zrUt4=;
        b=d3N9s1Em0rnC5IYoYQp+zQy0h1rpGlt72tTp8+W8z5Os4OGuCTrkjxCDinz9WPa7+T
         0W+i0BhYVsmWUf42RGxGTGhgIse44ydw8o3RInlGLJXFqug4Ghmf1LshQgppcswKLBuo
         ghUYvMiseKDu/itdbBB1DF1DMx7mzM+uYFFq5R4ra3eXP2oFqjvxwnwAucTG+DzUr0Gm
         l9+wxALWzKf6UAim2/rd+RzAAXdHdj2XsnmOFWuSMUC5jR58+GSei5j58oclEJzzCK5U
         70e0L7GeseCmbwb1BVl1FF0zOD/67E4tBLN7ZrVtqAFI6YqdFOCF9rPeAbBskTl1P/oI
         EMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvjmWCja6FdDuet5XzS/XjhRRXvATgX1TP8z3+zrUt4=;
        b=kRS1dgRQtkY9BfDoaQHvirQqfkdQCHCtiEfd1XCQaWukUOEb3ZOo62Eyd/rTg55IIy
         7uPTwfGN7r/UA+hkJLZ7xNpKGN7e0jk9uXDjEs56IJu3+awEYfrSSLh27Fbkb0CIpXEI
         dLywzOStthG63HISFBHH1aGJIWNojXE+ad6VR95HE/9AzjEbscic8EZ35liPnOaGZMxD
         902kvVlreC1c++IGEkrJVtz/RSZMSE2BocKP4e/Ui6wViPnh5qPUIyPZboTbbj9uIpcD
         WBv+SzZ+o4x04RsnI7kCVXaqBdo8mexUiDswM2yLFc/ZifRDzescKhivH+GuTcf7Rebf
         nKDA==
X-Gm-Message-State: AOAM530xXTzRIQoJbn+ur9N+3QnPdteYEtamMKCLj6gXT14YSF0qDY4p
        QQojXHtzwlMFnS2ogf49NmUsIkboBZjEy6JM4Yt5O7utJoE=
X-Google-Smtp-Source: ABdhPJxp5Q6ZNk9SRHzV04uBxc9IjGdb3QnXMmq2G+AgXS12TtyScMMiYbVIALoWV7g0ohODn03wvbBjQUpm/y13cBs=
X-Received: by 2002:a05:6512:1089:: with SMTP id j9mr2420835lfg.576.1602895319296;
 Fri, 16 Oct 2020 17:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com> <20201016125216.10922-3-laniel_francis@privacyrequired.com>
In-Reply-To: <20201016125216.10922-3-laniel_francis@privacyrequired.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 17 Oct 2020 02:41:33 +0200
Message-ID: <CAG48ez2gpW-O9wQQ5u55jsr3PhQbPYPjyur=AfgP--5H==96uQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Modify return value of nla_strlcpy to match that
 of strscpy.
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 16, 2020 at 3:02 PM <laniel_francis@privacyrequired.com> wrote:
> This patch solves part 2 of issue: https://github.com/KSPP/linux/issues/110
>
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  include/net/netlink.h |  2 +-
>  include/net/pkt_cls.h |  3 ++-
>  lib/nlattr.c          | 31 ++++++++++++++++++++-----------
>  net/sched/act_api.c   |  2 +-
>  net/sched/sch_api.c   |  2 +-
>  5 files changed, 25 insertions(+), 15 deletions(-)
[...]
> diff --git a/lib/nlattr.c b/lib/nlattr.c
> index ab96a5f4b9b8..83dd233bbe3e 100644
> --- a/lib/nlattr.c
> +++ b/lib/nlattr.c
> @@ -713,29 +713,38 @@ EXPORT_SYMBOL(nla_find);
>   * @dst: where to copy the string to
>   * @nla: attribute to copy the string from
>   * @dstsize: size of destination buffer
> + * @returns: -E2BIG if @dstsize is 0 or source buffer length greater than
> + * @dstsize, otherwise it returns the number of copied characters (not
> + * including the trailing %NUL).
>   *
>   * Copies at most dstsize - 1 bytes into the destination buffer.
> - * The result is always a valid NUL-terminated string. Unlike
> - * strlcpy the destination buffer is always padded out.
> - *
> - * Returns the length of the source buffer.
> + * The result is always a valid NUL-terminated string.
>   */

What about tcf_proto_check_kind()?
