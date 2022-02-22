Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCF4C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 22 Feb 2022 16:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiBVRAG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 22 Feb 2022 12:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiBVRAG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 22 Feb 2022 12:00:06 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC3716C4F5;
        Tue, 22 Feb 2022 08:59:40 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r7so15596318iot.3;
        Tue, 22 Feb 2022 08:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kUhUIIyA9GUDM8KAXwt3EGlZrHMsIuoyJtppWvJlpD8=;
        b=CDa4MR96luDCq3/3+R1N8T0Pu1JW9iXOgvzqQpbn2Z14ilhGhdOncz7u8Dpe8sej6G
         9ri5Lc4CH1xQfBxDfaLGxR/knU8dI9COjumA2Ekkt4tJbfqAfDLX0R10dy1xTOAV129/
         x8WLL8ezTrhtbU7BPvTNOrR2fZOkPTvjZeyq3bF+x98VRTqC6B+i0zvS0VOKjbSeQspM
         UODPTZRrLHrVKjOwc7Evd3ajetOcKlAjfijWUq8bfAYEatcZLVZ5ReZAWQ6uxkwFfOPI
         2OfMKZS4h8nc/clDlpskPws0oHuNAbsIfBX/SK2ZQFFBPao8PU3yBmy2TTnzj2l1iSoy
         y48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kUhUIIyA9GUDM8KAXwt3EGlZrHMsIuoyJtppWvJlpD8=;
        b=IoLaZk5TzudpxyX34Ei0a3Bv+gmYW952ttK8s7pfzgPIifwJwAlQbMI57NHk7hUTDh
         bQNa/5mE9eEWG9vN2BhGDjxq/GOKncmYRvGBow8iN7voRlX2iGes1Eqa4vc1Q2cqJ0y/
         NdIbrASOSHx2NS6Mnkkoi0YDQ2ZxXopQoMuuxPzMfIxTF6n7fdbSfKpBnWEjFVcJrJB2
         +Q+a37QTegoSI0NcZDA8KAqXpaS7Igzdq9tokoRTijTFXIRCrW+VWXYYfRSNtHoj3Whl
         BnalcJYbysmhLLHrGuKE3Zx9Y9Aehfe8RdTVxFy30v9hI5UnQctGAQ29mmSvRvZe/Dkq
         wbQA==
X-Gm-Message-State: AOAM530X1W5WODtAnGE22ed0go82oyLdDvVphRhiG+0vyK6YvlNmNCfY
        kKEMVhneSPO0PHh1/PhXn0IlONgP1nlielVN/h8=
X-Google-Smtp-Source: ABdhPJyOix0MphY4qHD8XfOuBGs0S/4oSg4gAzztyQmn/MgeYmRbPXRpPA0Lye6W0eH522Agyz1bmc6W3MZDm7HoPEw=
X-Received: by 2002:a05:6638:204d:b0:314:a290:48c with SMTP id
 t13-20020a056638204d00b00314a290048cmr18055215jaj.264.1645549179943; Tue, 22
 Feb 2022 08:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20220222095736.24898-1-ashimida@linux.alibaba.com>
 <YhUMRoLDan7tJRiL@dev-arch.archlinux-ax161> <f44612ce-5bb1-da45-d6cb-39464898c4ff@roeck-us.net>
In-Reply-To: <f44612ce-5bb1-da45-d6cb-39464898c4ff@roeck-us.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 22 Feb 2022 17:59:29 +0100
Message-ID: <CANiq72nhu+CtYYNfWLYxf19OscoEEZj=TATM0SHNU8ic1iDhyQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] AARCH64: Add gcc Shadow Call Stack support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 22, 2022 at 5:48 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> The point here, I think, is to list the minimum gcc version.
> It is going to be a long time until gcc 12.0 is the minimum version,
> so I think it makes sense to list the minimum version number for
> each compiler here.

Yeah, please list the minimum version (ideally `>=` instead of `>`,
with the actual version where it first appeared). It makes it easy to
then remove things that are not needed anymore when the minimum GCC
version is upgraded.

Cheers,
Miguel
