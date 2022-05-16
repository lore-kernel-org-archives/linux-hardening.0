Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B90C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 16:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbiEPQZ3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 12:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiEPQZ2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 12:25:28 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8554D3916B
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:25:27 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2fee010f509so43384887b3.11
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFls9zXfp5eTyiIQ+m2636iSt9xdwj1AtOgJeBph0LY=;
        b=YhXgB7NNVPD0yB1cDQg/SXVjUhX8SLXmuhEnMy8wBpqtJx2W1ubPNizgIU8zF85A9O
         4NabimscaxUtttPG7Gr13TcfobOte2BzOayOW/nlwMPCItIILzLtfLGgrw0uPqLvr1vN
         XhCPSDdmLiEtsD6yxSIRy5iwnZW/KIs5ZQCvm+r8msHjrgEmUHxjk2lQ6TIaPDXKbnYz
         sZhpeFcc2mDSmxSZpJ7TQKJHp4vjLedto83hHVkTNkoOpl6hYpxqNRN2G2PQWhl4aJCW
         EgK5oKNTRRk7HwbzJy09mdNldhGb4JoY04hsQgAJjG7sZFNeQ1kpT4ixGA+HzY9SOCsG
         1lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFls9zXfp5eTyiIQ+m2636iSt9xdwj1AtOgJeBph0LY=;
        b=h574VA4xisYxwnOBoaZZM6U71lmHyVdiC4TAUrVLKiMI2QQnzRf69cNm9IZLyT2dPn
         dBrj9gglWOIYiDkGKGj7Uwf5Ia+t0D4BR5qAHqab2tDUazi6l5VK8OBEzDBPpoTH2i4G
         1NgNbiR/4eI9fUeidqJdzDnkT0jYmt+ELAYuYcXPsfJPdTzfEmFJUZiqtdFY9YbF/b94
         AUUP3u211xAkW3S6nY3pcezEbryMuUM4mPLJ4tvtIvDnXtrmlzVF5HkrOEILeoRjcLRj
         FddAe/BrTE8ds4O+sSEGX3y/rct9w/hB5LJMiNUnGLx9rcNnqtOy4E3dOvSZrbw0z81R
         psew==
X-Gm-Message-State: AOAM530uICV90xCptk4bWwXD5gXKSrc0tshhJ4IfMF2kwCxxJr+SYmyR
        mSlH2edbq1bwfBHa0WwE7nNRHWhOifWKbAezJ5bOFg==
X-Google-Smtp-Source: ABdhPJze0FlbTm24mJB4UEHbsfYPEzROSnDu0xvZSbQCYGCBpmmty4Y0jTVl7jr510LqdmFqqvrpYIOVuhdO38wQmIQ=
X-Received: by 2002:a81:4ecf:0:b0:2fe:d9f2:15b3 with SMTP id
 c198-20020a814ecf000000b002fed9f215b3mr10961808ywb.305.1652718326620; Mon, 16
 May 2022 09:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-11-samitolvanen@google.com> <202205141451.AABEE8B@keescook>
In-Reply-To: <202205141451.AABEE8B@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 09:24:50 -0700
Message-ID: <CABCJKufbTGxjYg=vLwDUtxb06yues+yH9wV3J2hVa8uM+u1bvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/21] arm64: Add CFI error handling
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, May 14, 2022 at 2:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:48PM -0700, Sami Tolvanen wrote:
> > With -fsanitize=kcfi, CFI always traps. Add arm64 support for handling
> > CFI failures. The registers containing the target address and the
> > expected type are encoded in the first ten bits of the ESR as follows:
> >
> >  - 0-4: n, where the register Xn contains the target address
> >  - 5-9: m, where the register Wm contains the type hash
> >
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> It might be nice just to include an example exception Oops in this
> commit log.

Agreed, I'll add an example.

Sami
