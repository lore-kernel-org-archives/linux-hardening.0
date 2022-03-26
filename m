Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ECEC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 26 Mar 2022 19:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiCZTmR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 26 Mar 2022 15:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbiCZTmQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 26 Mar 2022 15:42:16 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EBB12E74B
        for <linux-hardening@vger.kernel.org>; Sat, 26 Mar 2022 12:40:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w7so18579755lfd.6
        for <linux-hardening@vger.kernel.org>; Sat, 26 Mar 2022 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eo+NI/ZY6vwsGX0YbjboRUexcl2mfDPwhfiG8UnYnwk=;
        b=BnS1v48fprKmSRXFjcrnsMCOkSZvYZQKHkA3LVRLp/DQnYYFla62uXIfXJRAbLMigi
         bFCZxlifzHg0dE0dAEH4xtBlMhLSpHZdPD89nlH9F7pdl3UwkeWWhnSQ/WTlG5C7cq9x
         p3SeW6+eqS57A/bUxi4swECZhDIttG9TD9X6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eo+NI/ZY6vwsGX0YbjboRUexcl2mfDPwhfiG8UnYnwk=;
        b=ZC+La8gftDAwTMNlFPg8rqyULoVJ5G6YAn+msLG6yZp71DKEAJnkx2U9FQ0uZfrA1K
         Yc3Or/BCWcx05pXd1jFpbSTbptR+gjd3xX7RzR+Lke81HBT/4Z+To0nlHDah21JZSkw9
         moNGkzA6uEszwcekjclstsrqszU/D55UcHNh5PbNump8+yAcaxqkhbvXyNn7EKkRy+7U
         HvTzi5beHiuKNqd6vx5P70nHxWq6iE1G8PE4DtfyLJC+of8gsINiHGzMT0fEWDSjQHB/
         gp1SE4bIS/X3Ij6xELiO0zSWF/xnL7e4lSAwTnB27yTDn7o+Mjua6L5MYNK+WvD8Xa3T
         ngTw==
X-Gm-Message-State: AOAM531Id6cPy1i5PSs8/o3+tcFc+EuY4Xj9P/eSDhfa5P8u/AVJsMoi
        PdWcMWfv/MuZcZM+UjTxfIWglQLNPfEH0mjpP2U=
X-Google-Smtp-Source: ABdhPJykXTW59aL1LzAyWkLAKc75yYk90BJRN7AMZm9yBMMadE43KRfVIwEIeGDpkZ4LTSo32NMYTw==
X-Received: by 2002:a05:6512:131a:b0:44a:35fd:993a with SMTP id x26-20020a056512131a00b0044a35fd993amr13013436lfu.652.1648323636855;
        Sat, 26 Mar 2022 12:40:36 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x16-20020a0565123f9000b0044839be14ddsm1146590lfa.76.2022.03.26.12.40.35
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 12:40:35 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id d5so18574747lfj.9
        for <linux-hardening@vger.kernel.org>; Sat, 26 Mar 2022 12:40:35 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr12881072lfh.687.1648323634830; Sat, 26
 Mar 2022 12:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <202203251443.9BBADFD98@keescook> <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
In-Reply-To: <CAHk-=wjeGc-BjkDWTYkXzyQu-vf9EEujuT-6=U7Od0DvCUfb8w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 12:40:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wid1da7CONOA4ia++vKe5pCFda6gwdafjFP4HXJQcjcsA@mail.gmail.com>
Message-ID: <CAHk-=wid1da7CONOA4ia++vKe5pCFda6gwdafjFP4HXJQcjcsA@mail.gmail.com>
Subject: Re: [GIT PULL] FORTIFY_SOURCE updates for v5.18-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        George Burgess IV <gbiv@google.com>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Mar 26, 2022 at 12:29 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because if all the compiler issues and warnings have been sorted out,
> it sounds to me like the compile-time side could/should be done
> unconditionally if there are no runtime downsides.

.. or do the existing compiler warnings for the builtins already cover
all cases, and the only reason the fortify-source code has
compile-time warnings is that the option takes over the builtins?

So maybe there's no upside to the fortify-source code for that case?

              Linus
