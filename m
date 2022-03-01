Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126E6C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Mar 2022 01:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiCABtV (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 28 Feb 2022 20:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiCABtU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 28 Feb 2022 20:49:20 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563655B880
        for <linux-hardening@vger.kernel.org>; Mon, 28 Feb 2022 17:48:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id d10so28442422eje.10
        for <linux-hardening@vger.kernel.org>; Mon, 28 Feb 2022 17:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qdaEKJNXyehKmI6OZeRutyAexvnsM0OhIQCRJEZlx28=;
        b=hk62M/2R3BtupGl5Pb4JIGG6SEHCrWhREvCKfHTYpMBQ4qyhyY+4bK5b+KJJU+prb9
         jw2/VkjB829+5rxjhC8YKv2FW83z6j482i2qwn1Sq0qRLTW3HOGlTLaPuCIa64sdQ81F
         6HHA+4u8A39L+cEhNKhWdNpr6HcBlGxPaSH4+wuVJU/yiAvPZT1x+P19RzP0NJiTSqqd
         HTvyvR1g9rOPUbgaKmcGVAAIMAxR6leD35by1icaadxC09XUfXdMOykTBR0JUJDXqzKP
         V6NnInEOsPCBEJBhms88PsDL+DOV7tlECL4waxonwf7rH2nwCSmbrvFe6JU9fiKYefHu
         I4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qdaEKJNXyehKmI6OZeRutyAexvnsM0OhIQCRJEZlx28=;
        b=qsyV4eYbJK/ikyIv1hFZLxbsjjF7z6cvQEy5ki81aOowGjfGjIncW0EB+6ckDBtuOV
         wXMW6FjvrZUpIzFF/RWfnw97P0StvOgod4WEBoS5y74KfhN9eWTMJxHUB3axLFHImEou
         JSHy5cJy3dlLyU7X6IueDFcsMT9GFpsVwPUkr5Ql1Wqup9RyCapoHVVma6YWDIkcX5Us
         EwZmhoDrYn2tEqqv6btgnv6Z9xwTK8srUftNgbUM7qBNLK+oeZKcOZUEvEK+kKM140lw
         oQFkHaOBEAaiedoOMjR48z6fJ72ZHZ1VFuIFgS/poJaFAu14GfzxXncbHZwUQCU/XdSE
         LsgQ==
X-Gm-Message-State: AOAM5330GCZK+mFTeTN9vqziH1F6NnInmbanuukwoD45trhIdNiYeoe8
        V/ZCQtp1XD3pbUckKOJ8fLglwuN0SiKn8CKDHhXXwA==
X-Google-Smtp-Source: ABdhPJyJnxStim8LcjtJqPLQfafGeXLVGaK+Vyh2JMgcZlT8OZOQfzz8aTwShCHtjtoXEwTHtyCJSy/5UpDO1v71xzI=
X-Received: by 2002:a17:906:6d0b:b0:6d1:d64e:3142 with SMTP id
 m11-20020a1709066d0b00b006d1d64e3142mr17304749ejr.631.1646099318663; Mon, 28
 Feb 2022 17:48:38 -0800 (PST)
MIME-Version: 1.0
References: <20220224054332.1852813-1-keescook@chromium.org>
 <CAGS_qxp8cjG5jCX-7ziqHcy2gq_MqL8kU01-joFD_W9iPG08EA@mail.gmail.com>
 <202202232208.B416701@keescook> <20220224091550.2b7e8784@gandalf.local.home>
In-Reply-To: <20220224091550.2b7e8784@gandalf.local.home>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 28 Feb 2022 17:48:27 -0800
Message-ID: <CAGS_qxoXXkp2rVGrwa4h7bem-sgHikpMufrPXQaSzOW2N==tQw@mail.gmail.com>
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWFnbnVzIEdyb8Of?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Feb 24, 2022 at 6:15 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 23 Feb 2022 22:13:25 -0800
> Kees Cook <keescook@chromium.org> wrote:
>
> > Steven, I want to do fancy live-patch kind or things to replace functions,
> > but it doesn't need to be particularly fancy because KUnit tests (usually)
> > run single-threaded, etc. It looks like kprobes could almost do it, but
> > I don't see a way to have it _avoid_ making a function call.
>
>
> // This is called just before the hijacked function is called
> static void notrace my_tramp(unsigned long ip, unsigned long parent_ip,
>                              struct ftrace_ops *ops,
>                              struct ftrace_regs *fregs)
> {
>         int bit;
>
>         bit = ftrace_test_recursion_trylock(ip, parent_ip);
>         if (WARN_ON_ONCE(bit < 0))
>                 return;
>
>         /*
>          * This uses the live kernel patching arch code to now return
>          * to new_function() instead of the one that was called.
>          * If you want to do a lookup, you can look at the "ip"
>          * which will give you the function you are about to replace.
>          * Note, it may not be equal to the function address,
>          * but for that, you can have this:
>          *   ip = ftrace_location(function_ip);
>          * which will give the ip that is passed here.
>          */
>         klp_arch_set_pc(fregs, new_function);

Ahah!
This was the missing bit.

David and I both got so excited by this we prototyped experimental
APIs around this over the weekend.
He also prototyped a more intrusive alternative to using ftrace and
kernel livepatch since they don't work on all arches, like UML.

We're splitting up responsibility and will each submit RFCs to the
list in the coming days.
I'll send the ftrace one based on this.
He'll send his alternative one as well.
I think we'll end up having both approaches as they both have their usecases.

It'll take some iteration to bikeshed stuff like names and make them
more consistent with each other.
I've posted my working copy on Gerrit for now, if people want to take
a look: https://kunit-review.googlesource.com/c/linux/+/5109

It should be visible publicly, but it will prompt you to sign in if
you try to post comments ;(
If anyone has comments before we send out the RFCs, feel free to email
me directly and CC kunit-dev@.

Thanks,
Daniel
