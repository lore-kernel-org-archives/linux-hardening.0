Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF0BC05027
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 16:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjBCQgU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjBCQgP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 11:36:15 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE64BA8A04
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 08:36:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m11so5583903pji.0
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 08:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LZtc3hBezsFJ+JgXERdSrjKYkX6f+8fQELANbScmeYk=;
        b=mHrlZ7VUo1d79tXgLzaqxxG9hcdPrsDjmdvruc68JlP/BcPGX6egmlSPG7P7It0txU
         9dSU8O56fxinEmwWStz23VSXfaZYMa0GH4lpLKS7aLvcF5ojWn1K1ZD/aInbbKE8BbJ1
         hWhhJvJq4ELKM69xRklBE4mzVGrmH5qINRT1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZtc3hBezsFJ+JgXERdSrjKYkX6f+8fQELANbScmeYk=;
        b=OVBNm59ZOP63j8p5VuQBYpRbiRyntq1Qxzd2CbC7veL1yH5nlrkke77H8p9GBaW1dd
         GK3PvspWQ5QCDbyq+hmPSQQqwNkRs6D6DQWBMvKcUaN9x1W8FIeQ1a0PoBE4OC8NGejp
         Ha0QFNkPLqdi+zoM9nh03YnMu9JM2ykupUAVi4mAROCm9wbbsj4hBznaUDogiiS9DbNM
         7skEzL3pZmjErKfRl10kG8gLSVANOmEqcemRPWYAMTMzFxcOFCGvQpcsy0d6MEeZ5Q2e
         aYCI8TIF/kD2f/aC0nf3S0gq1iG0iQcS4LVAsMBYf/8iEMp7eYZsA+9Q3Vy1x6iBwEyz
         /T0g==
X-Gm-Message-State: AO0yUKVzxw6yevG3Vk3cgoOyx9y33PuvI8goNpYwGLoCzQEG5kLPsCPK
        G65yM+TQnTt6apM0sHZ+FxBveA==
X-Google-Smtp-Source: AK7set+3gOK3BkJ0vQrBWtI5HAPi2PUYKNh8e6pqdOUt0vJfLvEQUgDgdUfKrw4YniHqw5Fg1TUcIg==
X-Received: by 2002:a17:90b:38c2:b0:22c:15a4:62a0 with SMTP id nn2-20020a17090b38c200b0022c15a462a0mr10965335pjb.37.1675442165363;
        Fri, 03 Feb 2023 08:36:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gt21-20020a17090af2d500b0022c25153cf0sm1405689pjb.44.2023.02.03.08.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:36:04 -0800 (PST)
Message-ID: <63dd37f4.170a0220.9621b.27b3@mx.google.com>
X-Google-Original-Message-ID: <202302031632.@keescook>
Date:   Fri, 3 Feb 2023 16:36:04 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arm64: Support Clang UBSAN trap codes for better
 reporting
References: <20230202223653.never.473-kees@kernel.org>
 <CAMj1kXHa=jD_YNxymjd8zQo2_QHgh104RcmCY3gZs3rp24X_Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHa=jD_YNxymjd8zQo2_QHgh104RcmCY3gZs3rp24X_Zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 03, 2023 at 12:34:38PM +0100, Ard Biesheuvel wrote:
> [...]
> > +       switch (check_type) {
> > +       case ubsan_add_overflow:
> > +               return "UBSAN: addition overflow";
> 
> It would be nice if we could avoid duplicating this UBSAN: prefix 21x times.

Yeah, agreed. I didn't see a way around it without weirdness or loss of
details. die() takes a string not a format string, so without really
odd shenanigans (re-write a single string in memory?) this is the most
straight forward. One idea, though, is to drop all the strings that'll
never happen -- i.e. wrap individual case statements in the associated
CONFIG_UBSAN_foo. I already dropped several strings that were never
implemented in the kernel's UBSAN. I could be even more picky. I'll try
this in v2...

-- 
Kees Cook
