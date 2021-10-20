Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208ADC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 22:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049A46115B
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 22:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhJTWra (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTWr3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 18:47:29 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78B5C06161C;
        Wed, 20 Oct 2021 15:45:13 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h196so26673729iof.2;
        Wed, 20 Oct 2021 15:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vzxjST9VYYskOzjypmiYVHx0fvZtSsG8PABlYBv/lo=;
        b=TpzToV6EG5NUMGvXt9S6KBsFTYzNG1TBuUj7D8E7KHRuTeoKxkz/1cLf9ok80ducUC
         rLnxwzxNRLFR9u+OTJDabjXniDjDaNj1IPessl3Zx5KNjj/vmwL1+14E0DSVC0G74AQv
         0l5l8723o4ZWIJp7ff+Ue7Dkli9FKp4w7K5PPsJbZHe2T083X5u6P6uPd1jsTsK3C779
         Z+wWqFbfItnh06U0SzgLfTdHOsh+jSQGM6UhB1OWLhYCBoCcsINdbmfdfUR9rp0hpf1L
         PxWAkqAyjM1iFZPjXlSnH3cCq+38EvDfdU34oX7/A/AF82ztBU72PQrOKv+k9grakUny
         Rdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vzxjST9VYYskOzjypmiYVHx0fvZtSsG8PABlYBv/lo=;
        b=iLptSO3cTDIWObKCfEclxBf/1XLFwx2BONJSzudUzxAztCe6g2kuBhXNPgU8OvJ0/Z
         yvvzEJE8oKaZ/kFTbjslO01M5yeiug34UmZEGOReEhaumi9jyY7upb7vKNIFM7hd991l
         KMQWc/VDocUA3bRkcbnM5tTOWuNzyufb6iWf5B63x4nXQjaqiNNJAj1uSM3mD+fCYk4r
         ExaeeyAz83II5IcnAJw7jF0PcHDoz8QYyZPNVS4wBv9CxksWB7EKtUluPSi+KeddgXSz
         +WkLoy1QOBq67hhP48y7pQjy8cWv4dzaVYFz/7DzNYqIr5BU/ziSE+kLNqYxqV7PKBDh
         OWhg==
X-Gm-Message-State: AOAM5300DKS1HKOdFFIhy+VO0cIrd72NUP6eqhOjFsQHmdZrEV17G7kD
        IoTwbB/LyAtWytPQRuN2L+C5phhXCxirG3jTCqk=
X-Google-Smtp-Source: ABdhPJzKe9Xa4H2Z7T3/fu3kurLNBai+i5fhrTTk8e89yITi5PcdWxHypOm7vYfTQCEx4PjAb85K5bGwKERsh6jHdrU=
X-Received: by 2002:a5d:9d56:: with SMTP id k22mr1299385iok.177.1634769913268;
 Wed, 20 Oct 2021 15:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211020200039.170424-1-keescook@chromium.org>
In-Reply-To: <20211020200039.170424-1-keescook@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 21 Oct 2021 00:45:02 +0200
Message-ID: <CANiq72ncBda6WE6ZTF9WDssHkMmM+JC5q8vkdNwiXFXTsSrnwA@mail.gmail.com>
Subject: Re: [PATCH] compiler-gcc.h: Define __SANITIZE_ADDRESS__ under
 hwaddress sanitizer
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 20, 2021 at 10:00 PM Kees Cook <keescook@chromium.org> wrote:
>
> I'm intending to take this via my overflow series, since that is what introduces
> the compile-test regression tests (which found this legitimate bug). :)

Not sure if there is a particular reason I was in the `To` field
(please let me know if so), but the patch sounds good to me!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
