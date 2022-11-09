Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992D7C433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Nov 2022 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKIP72 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Nov 2022 10:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKIP7Y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Nov 2022 10:59:24 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E01140CF
        for <linux-hardening@vger.kernel.org>; Wed,  9 Nov 2022 07:59:20 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f5so47907901ejc.5
        for <linux-hardening@vger.kernel.org>; Wed, 09 Nov 2022 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kMpz0htQ7/MGd5vuDayKM00Lvv56YDt4hT+zhs8g2Ss=;
        b=DxPii1rwpWX2KNM5w6aU83V4P3pvCEWJ+OmIRRU67Ed9ghnzy/dQxWPypq6nc8KYq2
         7z7ReF/5u/9goEHI9sjm6aqEfwD3Dm0+URnSHRERstVHqeWod2vS+lnqtEkfyWsAZKtk
         RbTK7hh0N0Re5P+xD3+fdpgA9OnxaGC2bHWncjxstBmqbtuEI1xxQ2WvdJ9Nde5cdEed
         OBTx0QZTjNsnnXcrsODJBHWQn5QAwF32qdWc5/k9Garax/RG6gxVZ/Irrcj3nPj4nBFR
         aUy7nvaFnOg+YVvqk+UtIGsHLPWWKo4Fup4GJZ7ULRJOzKiMKf68sAaaeC+jplrU44PQ
         LKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMpz0htQ7/MGd5vuDayKM00Lvv56YDt4hT+zhs8g2Ss=;
        b=2YsEPolTaHM4CWQqqIIHhPZr8ul9hIc7WHioJ3g1TlSNEq4HiN5b5597WYSRHNGig2
         UhVwN3tL372RCubiohiXkqeHnWyjbiAFQCiE7hNQUjOjTIIpZ6dEFYhUXG4c1+d+eXIb
         wDmeY673257x+PIedxmENtbxxqsgV9awZECk43Aefql3bQPh1P10v9KExcQjIBxbCfvo
         mVSS+5sCREPBUxxazRnTKLBqLw57aE2hE6dGMrmvg5oez8RsF91qSmYh5HHFOQXTGP4Z
         g5paKWdFy6MrG6sUyjFNkVWrLKecpjgwcfEionyCe63I7RDs5l+XJDByNMvDMjP9OY1i
         nceA==
X-Gm-Message-State: ACrzQf0W4Lh9G6hD26+PjvWX43Fik73MmPQowqCIzxcDQPP6gTZQGx9V
        WA4Ku0t+zSZOiqaw+KOQdJ6wNLcpU+4OzHcxM0kg0ccULyeoBw==
X-Google-Smtp-Source: AMsMyM6KcsdIruaq2XMS8h3WG9IGI3ifDSKwPpa34n/XxwnANIIvZR1obFMCRGMiLLfgo0+LTXJDaGAweOynKOsEtMc=
X-Received: by 2002:a17:906:7048:b0:7ae:db2:f10a with SMTP id
 r8-20020a170906704800b007ae0db2f10amr1136400ejj.709.1668009558671; Wed, 09
 Nov 2022 07:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20221107201317.324457-1-jannh@google.com> <3e2f7e2cb4f6451a9ef5d0fb9e1f6080@AcuMS.aculab.com>
 <CAG48ez3AGh-R+deQMbNPt6PCQazOz8a96skW+qP3_HmUaANmmQ@mail.gmail.com>
 <d88999d8e9ec486bb1a0f75911457985@AcuMS.aculab.com> <CAG48ez3UO03RRMxxj-ZAcw5vhjhPYeoN1DB82s2SAiYm-qWmYw@mail.gmail.com>
In-Reply-To: <CAG48ez3UO03RRMxxj-ZAcw5vhjhPYeoN1DB82s2SAiYm-qWmYw@mail.gmail.com>
From:   Seth Jenkins <sethjenkins@google.com>
Date:   Wed, 9 Nov 2022 10:59:07 -0500
Message-ID: <CALxfFW4RQmLf9QRdP8VUH0fZU_vUsCqXfxRtjeu6g7QvKAGOmQ@mail.gmail.com>
Subject: Re: [PATCH] exit: Put an upper limit on how often we can oops
To:     Jann Horn <jannh@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

I'll add to this by noting that it is highly oops dependent. Depending
on what locks and refcounts you had taken at the moment you oops'd, it
may not be possible to clean up the process e.g. if you're holding
your own mmap lock at the moment you oops you're liable to deadlock in
__mmput. But there are certainly empirical cases (not all too isolated
ones) where the kernel really *is* able to clean up the entire
process.
