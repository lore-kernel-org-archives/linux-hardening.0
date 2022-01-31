Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2A7C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 19:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359085AbiAaTJn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 14:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357719AbiAaTJl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 14:09:41 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114CC061714
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 11:09:41 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id t9so20753467lji.12
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 11:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ok0BFBVUs/aGLvZ8hIj39mJA1z2SbFZGpjd3f3p7Vg=;
        b=hX0xetF3Nl2xlWjDIF6C04FvfYjWAUNtF9/XaoMWge4H3R+tddXnppQBiNsE0QcTf2
         H1VLpE42C+1XDt+SPkmPcrXc+e5QUUVrzLLDhqapMhQ0cidbmLUZZ/2vX3Wacu7dyBxV
         Lh8kF3a4RuCGstgCCYTqIB+JyzvN46ciBhUsVNy/FS8vcwjWfECmOJNm+wgYUCFefL1M
         XUAeYfLXSWd6OTzBH/X9ZmXihVo+k4wq0R9j+D7BO9kOyjrCttYyR+72q4YPJbkP9z5o
         fWAhJ2aD/U2rBALByHUFY/TdI3p24zf2WUC2OpgmsXuJaqrlVpDqUy/pQvlF7nYYsZWG
         vbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ok0BFBVUs/aGLvZ8hIj39mJA1z2SbFZGpjd3f3p7Vg=;
        b=1Gdz/EBU34yBpQIT95+TU1mjoEX26CiQCQUluM7hLzoVsj2Quq7vMmHUsFiRx/sXZh
         NvOZElqNrPCfF7H+Vdf0XuhWhDRDYrL1jFmLAb2KUwzl5osBlh+I99zJVYyXeESODEpg
         LbTJp2HOpppgNaL8O8HIC5XKgPsiVxDAFTFo0mtnMnek2iiS7izOO4/76eGPZhksrr07
         IB9+CeTDu339JpHkriuD/+2T9L+30Rgn2F/7yDLPQ4PG5f/076nIZe+dI7MKuwUpg1l6
         V+LFethuapd3keh2f/GH6DP6YWb5kosR+nTpmMCLwF9wE3WfozTr4aT05AImqHq9qm5W
         4nNQ==
X-Gm-Message-State: AOAM533frn6N8WL2wNIbm9BV0eU2OR4AnyzuDtffSCBJRbEIlBe16AWk
        Wklf+fwxUZmtbPEOvh+FyMgDnTTrUORfzfV0eIy/LQ==
X-Google-Smtp-Source: ABdhPJyfrhQq8UNHudmznONYOwVRAN5a2rNhHhfUuvRoigSmkENJcxC7SBSpqD9IcWpP8HXdLEAMEzjLZqVgJINMisE=
X-Received: by 2002:a05:651c:1253:: with SMTP id h19mr5956839ljh.338.1643656179244;
 Mon, 31 Jan 2022 11:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20220130181616.420092-1-keescook@chromium.org>
In-Reply-To: <20220130181616.420092-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Jan 2022 11:09:27 -0800
Message-ID: <CAKwvOdmETY-j9B9vms4d31kAc0xb1yE902KijiH2baY5-M=fLQ@mail.gmail.com>
Subject: Re: [PATCH] fortify: Update compile-time tests for Clang 14
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jan 30, 2022 at 10:16 AM Kees Cook <keescook@chromium.org> wrote:
>
> Clang 14 introduces support for compiletime_assert(). Update the
> compile-time warning regex to catch Clang's variant of the warning text
> in preparation for Clang supporting CONFIG_FORTIFY_SOURCE.

https://twitter.com/ifosteve/status/1190348262500421634?lang=en
error messages can change over time. More thoughts below.

>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I'm splitting this patch out of the main Clang FORTIFY enabling patch.
> ---
>  scripts/test_fortify.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/test_fortify.sh b/scripts/test_fortify.sh
> index a4da365508f0..c2688ab8281d 100644
> --- a/scripts/test_fortify.sh
> +++ b/scripts/test_fortify.sh
> @@ -46,8 +46,12 @@ if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
>                 status="warning: unsafe ${FUNC}() usage lacked '$WANT' symbol in $IN"
>         fi
>  else
> -       # If the build failed, check for the warning in the stderr (gcc).
> -       if ! grep -q -m1 "error: call to .\b${WANT}\b." "$TMP" ; then
> +       # If the build failed, check for the warning in the stderr.
> +       # GCC:
> +       # ./include/linux/fortify-string.h:316:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> +       # Clang 14:
> +       # ./include/linux/fortify-string.h:316:4: error: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> +       if ! grep -Eq -m1 "error: call to .?\b${WANT}\b.?" "$TMP" ; then

Doesn't this depend on -Werror being set? I guess it did so before
hand, too, but couldn't I unset CONFIG_WERROR then this check would
still fail (since instead of `error:` we'd have `warning:`)? If we
used __attribute__((error(""))) then this would always be an error.
Right now, it is only because -Werror is set promoting the warning
diagnostic to an error.

>                 status="warning: unsafe ${FUNC}() usage lacked '$WANT' warning in $IN"
>         fi
>  fi
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
