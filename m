Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A426C4332B
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119F964F69
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhCDAv2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbhCCTg1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Mar 2021 14:36:27 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D452C061763
        for <linux-hardening@vger.kernel.org>; Wed,  3 Mar 2021 11:26:01 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t9so1037405ljt.8
        for <linux-hardening@vger.kernel.org>; Wed, 03 Mar 2021 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3A2O71ftuJfSYcOjzG8n0G0DSSbzV3fpd6bic7USUM=;
        b=fJlv4zH8GTkwLsBd+qX8OFR+earNuJHiLEuvYOwl3rNwh0Qticl4+a/PHzSKaRifKR
         wtUSTXlWKZe11OR4eXmAUXXnA4krJ07dpa0WsRUD7tFxvIxX3tWiNeIGVgjRkH9/OaAs
         dURJsQj/RGcwMDzmA+QLnZtjhPWSZpnRxGwpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3A2O71ftuJfSYcOjzG8n0G0DSSbzV3fpd6bic7USUM=;
        b=kacqfOGkwMSgkG4T/31mB5F3AOtk+6/geYiBxtN470G33g+7TTXpS1QYYkvEC27g+r
         9AS6wubKp7O2o+gmXyd1mnyCc8lN5jbMhTYpNZs6ZjoVZciB3+/PDU8ytHRk1i2KqR0J
         lMPaML3xEZwUh7Qtsab5Kz3PK5EF9Dh1R57bBbz6M+M4h5Gtiw2/d7U93/t6A/8outHv
         iItIQr9kIBISXtgNh3zSrTClJ0QBk/BWiV8mFWSNJ3VQI6TEAWibav1gEB1e9TL8B/Sz
         mnxLqC4Q89HRny9o7+KNiyJJE1QenIgyKjR5qIeUTUmmBp47VSLfYpKm/QH9MQcg+kMf
         Jgqg==
X-Gm-Message-State: AOAM533M40YeiU4AcRNPmATeRhshH8BGPvDy3ux6fsLe5alGWro1Tl96
        qEJ/8uVNnfvpICozm9Ao7A/m8/VNcJweZQ==
X-Google-Smtp-Source: ABdhPJzSGCMjM5DhKNl0HhwNFbPoqdg4o+iiXdf31Jsbu8ktFEwqBVQDR4alyaZIc4mm+QFyHb2bjw==
X-Received: by 2002:a2e:7f11:: with SMTP id a17mr257089ljd.468.1614799552539;
        Wed, 03 Mar 2021 11:25:52 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s23sm2595505ljm.50.2021.03.03.11.25.50
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 11:25:51 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 18so30401281lff.6
        for <linux-hardening@vger.kernel.org>; Wed, 03 Mar 2021 11:25:50 -0800 (PST)
X-Received: by 2002:a19:ed03:: with SMTP id y3mr121436lfy.377.1614799550613;
 Wed, 03 Mar 2021 11:25:50 -0800 (PST)
MIME-Version: 1.0
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <20210302232649.y2tutffhxsblwqlb@treble> <CAK7LNAReuB5zUq_7S8ZG25+tdQowECDOK1rApYvkPCpHhPjK5w@mail.gmail.com>
 <20210303191516.6ksxmng4pis7ue4p@treble>
In-Reply-To: <20210303191516.6ksxmng4pis7ue4p@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Mar 2021 11:25:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
Message-ID: <CAHk-=wjR0CyaKU=6mXW9W+65L8h8DQuBdA2ZY2CfrPe6qurz3A@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Frank Eigler <fche@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 3, 2021 at 11:15 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Adding Linus, who indicated in another thread that we shouldn't force
> exact GCC versions because there's no technical reason to do so.

I do not believe we should recompile everything just because the gcc
version changes.

But gcc _plugins_ certainly should depend on the kernel version.

Very few people should be enabling the gcc plugins in the first place.
Honestly, most of them are bad, and the people who really care about
those things have already moved to clang which does the important
parts natively without the need for a plugin. I'm personally waiting
for the day when we can just say "let's remove them". But in the
meantime, making the plugins depend on the gcc version some way is
certainly better than not doing so.

                  Linus
