Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29492C433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7F560D42
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 18:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhKBSyf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhKBSye (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 14:54:34 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD72FC061714
        for <linux-hardening@vger.kernel.org>; Tue,  2 Nov 2021 11:51:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id g8so25469168iob.10
        for <linux-hardening@vger.kernel.org>; Tue, 02 Nov 2021 11:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXmbVhne2UP63vnqdjwO7CpPxujTq6ABNfI7UH2jJJo=;
        b=MBVMpXwCUd3YuMDRvR1mKrGDmFqhhYkmWopCieCx9KZE2omWb4aU5/LfNEZLNlm0tR
         Z805+Mq9aWYgBtJOIHMYDF+iw5+uha7XuSRC8rOmC2Q5Nd34hdyD2psAlA20F15NH51V
         g4G6KRmDmBfKlGB4h6TI0CqhDERHFONFrysNfedUDg20Uq11EsX98AJFNh2fEb2jAEuf
         fZzOQJVcxpn7L8i+Quy+68L0qVFADZaEzBGCq/EAZqaiJKl/zz3pSmEUQ9SAXNdpu7cd
         pWhRbilE6e/zAuoika0v9TlpibRVpU9eJvEtv+qR3XRX5QxlBFwXq7fOVcEyoKjbUecT
         BWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXmbVhne2UP63vnqdjwO7CpPxujTq6ABNfI7UH2jJJo=;
        b=acdwqyeQMNSohUxMAR5/a03eWIiMceu2jY0zWc36lvidQpdoZ5XV2UuTd2FwGUbrdK
         +0Py0Ar11a0riNYn+d6CoZOGZeve9K4DZN/jds6eNMmvp0NC57oHMLBKGLbWqttNyv0o
         kkpmLvx0URfZ1Ju/KaNTWrh75f9RzozaG4chUV6pkseLM3rl6WpuTL47vC92TBNtLSef
         gdA9MKHMvfniGMu4a+zYvUwzjcqeEfAYV+Hn9c4dLyjSNTW6nH5Eijy755EBA+wYH1TD
         7ie2pXJW1WDBm7XXshhidrr2cEqQKHPjht3vS2iYv4G00AkjVwfhmbG/yZ1WX/AQEswy
         G7AQ==
X-Gm-Message-State: AOAM530iUyayN/KeecfnYkVfy2SGdIPGEs8snEWABJPhdLX7lgcQoxyx
        oinwdTmxXhM2SpJq2MljGxthVbS8ihARJtgIh3s=
X-Google-Smtp-Source: ABdhPJzsX4sIWfjsunTm+6q4AOUoJyMC0eVezb86LcenZusCGaQJnNB0LWpTKTlAezFIG/k7+gQwsKz21G1Fw9ZCKiI=
X-Received: by 2002:a02:9990:: with SMTP id a16mr6546064jal.133.1635879119085;
 Tue, 02 Nov 2021 11:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211102075812.122715-1-ashimida@linux.alibaba.com>
 <CANiq72meBX1g6z2-vfNpMw2C8S-BavuA4CTyPLpD4zUcX193Sw@mail.gmail.com> <CAKwvOd=0GpX59U1ndzahJ8mh26C-Gb54pjwUk4eYigb0ZoCiwg@mail.gmail.com>
In-Reply-To: <CAKwvOd=0GpX59U1ndzahJ8mh26C-Gb54pjwUk4eYigb0ZoCiwg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 2 Nov 2021 19:51:48 +0100
Message-ID: <CANiq72=xQ4-bcm7csNJH2C9pfVqAdLypc8n_JTL2PBYr9vQgqA@mail.gmail.com>
Subject: Re: [PATCH] [RFC/RFT] AARCH64: Add gcc Shadow Call Stack support
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, frederic@kernel.org,
        yifeifz2@illinois.edu, Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, andreyknvl@gmail.com,
        Colin King <colin.king@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Marco Elver <elver@google.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 2, 2021 at 7:42 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Do we want to move this to include/linux/compiler_attributes.h?
> Respecifying these repeatedly in each include/linux/compiler-*.h feels
> excessively redundant.

Note that they are spelled differently, which is one of the reasons to
keep them separate (and why I invoked my hopes of Clang and GCC
agreeing).

I typically mention that we could start breaking this "rule" and it
would be also reasonable; but on the other hand, having it this way
makes the distinction clear and also gives an incentive for compilers
to agree ;)

For reference, the file explains this on the top:

```
* Any other "attributes" (i.e. those that depend on a configuration option,
* on a compiler, on an architecture, on plugins, on other attributes...)
* should be defined elsewhere (e.g. compiler_types.h or compiler-*.h).
* The intention is to keep this file as simple as possible, as well as
* compiler- and version-agnostic (e.g. avoiding GCC_VERSION checks).
```

Cheers,
Miguel
