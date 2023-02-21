Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB63C636D7
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Feb 2023 19:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjBUTRc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBUTRA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Feb 2023 14:17:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF592DE66
        for <linux-hardening@vger.kernel.org>; Tue, 21 Feb 2023 11:16:53 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x10so20646138edd.13
        for <linux-hardening@vger.kernel.org>; Tue, 21 Feb 2023 11:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ayM9JpW1yE32OZcyE9Bl9slBlfyuVWriu50vG7JoYY=;
        b=L3/v9ARQy8prPgHsE2w6q6n2R6+UafTI69txUo49ZhFuN8slMzaVBY5R/5YVbR+i0M
         cvu1xxUPWw4eQ+an2+JlAeGlA520l3W20zJreOS+YSOeNeYhmk9cJ1HOufILo+SAROp7
         BnlAfKASsWa7yVuCatugVAB1RmHpCf3clJfxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ayM9JpW1yE32OZcyE9Bl9slBlfyuVWriu50vG7JoYY=;
        b=gY97DdziNebwb5TYo/1EZTjUx+Bbit6TNSenpT5EOGwSARgmG62DCNRm4XleCAibng
         hlhGBUtMWRRxzxsU4ZVAAYAYFkRWZy6BNPrFjYVmCuPsEozVN3bKThK4fVoRq8PfQQd8
         QKGO7aTxTCbLhucClTUkdaQZ1LHY9CbAXIDpTOaFoRdo8GhVU1LlpHXdsv/Lz3MrXbQb
         ZqQC1Y7LKVUOiLYVTKa2vd9gWEbHIUEkK+4YxPg5BOAKbY3yaoEfx4+jtRQG9P66xHM0
         jNxqyECdlemAq7VTAVSaI6rZjsnSN+/MNbYo40ZJJmig8G0OxoGgJ6+FbkNyJ+BO4rPL
         4boQ==
X-Gm-Message-State: AO0yUKWjiPT2Xk/DOgm53YRIuEjb8UAWiTfH86jp4S0iZx1GB4uO60RV
        2MoUQ7b/8rAG6Pa8uLV2gLZ6FeoHJIznnHZsnZQ=
X-Google-Smtp-Source: AK7set+DOUat5mpNVvC0/iF07xzNAEapi3u4jU0VncYocai4+aHM0keFwSLapWxeIkZKjcUJpfVDsw==
X-Received: by 2002:a05:6402:34d:b0:4ac:c72b:5eb5 with SMTP id r13-20020a056402034d00b004acc72b5eb5mr6353120edw.40.1677007011777;
        Tue, 21 Feb 2023 11:16:51 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id y17-20020aa7ccd1000000b004ab1f97ca2csm3239172edt.60.2023.02.21.11.16.50
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 11:16:51 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id cq23so21189269edb.1
        for <linux-hardening@vger.kernel.org>; Tue, 21 Feb 2023 11:16:50 -0800 (PST)
X-Received: by 2002:a50:d614:0:b0:4ae:f144:2c8e with SMTP id
 x20-20020a50d614000000b004aef1442c8emr3490838edi.5.1677007010586; Tue, 21 Feb
 2023 11:16:50 -0800 (PST)
MIME-Version: 1.0
References: <63efd7ab.170a0220.3442b.6609@mx.google.com>
In-Reply-To: <63efd7ab.170a0220.3442b.6609@mx.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Feb 2023 11:16:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgw++ccN-Pd1npZsBSDD3z6EGUSKsWuAEh5YC-TmfJAug@mail.gmail.com>
Message-ID: <CAHk-=wgw++ccN-Pd1npZsBSDD3z6EGUSKsWuAEh5YC-TmfJAug@mail.gmail.com>
Subject: Re: [GIT PULL] hardening updates for v6.3-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Sam James <sam@gentoo.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 17, 2023 at 11:38 AM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull these hardening updates for v6.3-rc1.

So I've pulled this, but while looking at it, I see commit
5c0f220e1b2d ("Merge branch 'for-linus/hardening' into
for-next/hardening").

And that one-liner shortlog part is literally the whole commit message.

I've said this before, and apparently I need to say this again: if you
cannot be bothered to explain *WHY* a merge exists, then that merge is
buggy garbage by definition.

This really should be a rule that every single developer should take
to heart. I'm not just putting random words together in a random
order.

I repeat: if you cannot explain a merge, then JUST DON'T DO IT.

It's really that simple. There is absolutely *NEVER* an excuse for
merges without explaining why those merges exist.

In this case, I really think that merge should not have existed at
all, and the lack of explanation is because there *IS* no explanation
for it.

But if there was a reason for it, then just state it, dammit, and make
that merge commit look sensible.

Because right now it just looks entirely pointless. And I literally
*detest* pointless merges. They only make the history look worse and
harder to read.

                     Linus
