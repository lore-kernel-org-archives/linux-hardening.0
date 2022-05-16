Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD8CC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 15:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245074AbiEPPpX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 11:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiEPPpV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 11:45:21 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA83E27CC5
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 08:45:20 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2fefb051547so29895917b3.5
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnKHIkN0TU++izapmIFi8Ty+LNPCPzgGOdIpl087eMA=;
        b=iTcoOlahc6mNkkH9KN1UbL8/FqrKWmwWC3yXua2GycFg92x6rtngNdWTVZd0vbWmvo
         IS31fC3vbQgVufrjL9knZDTJqUptFr2aaqDFIneUmpWLvFJa+Wu+UxrjhyP7Rgj7bYw6
         zGYLwfOJbeMXxZZo4hcNGWPwaUtzNrt3Su/koMOjF0/lJfcxtgYk49vf4uomzBQ/y5my
         1yNpaUl8mO2poMKwfULV989QV1N1BB5iZDEFJA+CXZ4MAPWqN9ygMf71IFgVuS2VYweH
         bgcJ++RWpGXf45WXPIGOJztqFDbRlw5pqIk7yfMCXeIH15TdPWKecQfiVFMacIT+G95P
         EkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnKHIkN0TU++izapmIFi8Ty+LNPCPzgGOdIpl087eMA=;
        b=PQ15bZ0TMOLU007BVQEywXyH4Q9EDSR0mTCQu5xtasqwTGLx462K778s1sxfyZ4Xta
         O0GW+w6Ipb4g3TtzedkEf3aVRWiaWeXhRYYMiN7RSpR8i1CXgFAUemgSpzx6NHpSXNaS
         P6+RPcacdAnDJzsL079u662K1tfzLB8es4x4hlK8y4+pSY4STfJ1wHS4Dog13rZ6DUde
         NKXdHMC4MIHtIBzeU0/mrl/DcnawMlQnBKhCiRh4PnffywkFzq6jufagjlpa/b4/byE5
         UCstbdjfmUC16E5Hii8WxGnLx0wQQFsLzmOByVcrQp/5qXSG4MLj1h63ukXVHktPxYJ4
         voeg==
X-Gm-Message-State: AOAM531QConV1NGPSUABnPdJ6ejl/29nwPXFcwTRUq84Qm+6b0HrNe3v
        x8AFSypMjpmLr3jAcgQDKvrnya1DSds4RPzDlhG1AA==
X-Google-Smtp-Source: ABdhPJwi/PDSBCPu8w13weeGP3GKG4Kc/dHnqpDwTulTE1xr8903vsYGeGb18xGWe7Di7/TDqqAZCDtrmcivBggYEX4=
X-Received: by 2002:a81:4ecf:0:b0:2fe:d9f2:15b3 with SMTP id
 c198-20020a814ecf000000b002fed9f215b3mr10749397ywb.305.1652715919792; Mon, 16
 May 2022 08:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-9-samitolvanen@google.com> <202205141449.87738FDF@keescook>
In-Reply-To: <202205141449.87738FDF@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 08:44:44 -0700
Message-ID: <CABCJKuc82+92BEjPU+5_7Y45cBAZ_J0Nyjvn_FtFroqsJjs_Gg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/21] psci: Fix the function type for psci_initcall_t
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

On Sat, May 14, 2022 at 2:50 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:46PM -0700, Sami Tolvanen wrote:
> > Functions called through a psci_initcall_t pointer all have
> > non-const arguments. Fix the type definition to avoid tripping
> > indirect call checks with CFI_CLANG.
> >
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> This could land separately from this series, too, yes?

Correct.

Sami
