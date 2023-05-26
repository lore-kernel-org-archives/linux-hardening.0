Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8058C77B73
	for <linux-hardening@archiver.kernel.org>; Fri, 26 May 2023 20:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbjEZUr1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 May 2023 16:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbjEZUr0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 May 2023 16:47:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2A8187
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 13:47:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae87bdc452so7876535ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 26 May 2023 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685134044; x=1687726044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lfp02npkh0h/YWUAgBDsalIo85iCBRV6d/ctWRGEdlM=;
        b=HWXQYRLK7ntwWtvuKa8oeGsD27iRIjXFFB3NKRgYTo6AbUXgLPeW3qK0kjBQERZ3A+
         hpLbk5UD6xB7CAzhW10l0+DRI1R3CwdWx4tRagyUtmf6xVPsqRG9KuB8vBWnMxVh0omE
         +Y+ZQrk4EVBT1bEzkphBCFItOUN81ElbIBCLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134044; x=1687726044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfp02npkh0h/YWUAgBDsalIo85iCBRV6d/ctWRGEdlM=;
        b=Wn2PdVdczB5fzQis8RoMrTIYlby/H0J5tT+RvtiC8US7zneHP2H9oL8rt/FGIxWZEq
         +3DhrXn4/vDJdLOytMtS8IYVCSIbTGvWvDVqlmHvzwFL2F/398nd2F1ZiRwFlXTKyYDH
         Kepo4X4DOztzWKMDiBoXthWoWTfP1e7rfZR/6BfQoHdnO4/gNxP3so1V5aIHlqL/MAdR
         6RH3MMIkL7YXIR3l6tIgFhYMS0DW65ivMJt/un0S5HzUY11DfNvBzvflShPY3IhZkL2d
         KzbPE6Sr9E1PQDgjSYPlHiIyvCDaBH0u+kDtYXNEVCnQPD7ROTHgdu/ulcbmFy1O34GY
         omQg==
X-Gm-Message-State: AC+VfDyzGua7DuuX2NqWEYWQO3mDqcFsc6F41FdeJjuNMS9m3P0dDp6t
        KMDudNo8pfS9hmGLWFUxK25mRg==
X-Google-Smtp-Source: ACHHUZ74jsM1296cY4bBvBCOf7HyRaDBLdiJgwSaoNdaJ9O57iSahTuW8wR3toOlGsGaHRgpudK/nQ==
X-Received: by 2002:a17:903:27c3:b0:1ac:a02f:c9a4 with SMTP id km3-20020a17090327c300b001aca02fc9a4mr3542847plb.4.1685134044683;
        Fri, 26 May 2023 13:47:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f54900b001ac7c725c1asm3650623plf.6.2023.05.26.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 13:47:24 -0700 (PDT)
Date:   Fri, 26 May 2023 13:47:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, ojeda@kernel.org,
        qing.zhao@oracle.com, morbo@google.com, llvm@lists.linux.dev,
        trix@redhat.com, linux-kernel@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, gustavoars@kernel.org,
        ndesaulniers@google.com
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
Message-ID: <202305261344.A938E07789@keescook>
References: <20230517190841.gonna.796-kees@kernel.org>
 <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
 <CANiq72=38mdTnJ3cicgwPB2xWqtbnGsL8Rtr4pwq7xGRr-m=Wg@mail.gmail.com>
 <202305261156.67CDEE933D@keescook>
 <CAFP8O3JO42CD2EXk+DJ5pci8ieHvRifAZpKg4iR_NiqTaYfLdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3JO42CD2EXk+DJ5pci8ieHvRifAZpKg4iR_NiqTaYfLdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 26, 2023 at 12:48:26PM -0700, Fangrui Song wrote:
> On Fri, May 26, 2023 at 11:56 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, May 26, 2023 at 07:47:03PM +0200, Miguel Ojeda wrote:
> > > On Fri, May 26, 2023 at 7:16 PM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > FYI, applied to for-next/hardening:
> > > >
> > > > [1/1] Compiler Attributes: Add __counted_by macro
> > > >       https://git.kernel.org/kees/c/86a76e91cbab
> > >
> > > Sorry, I was going to apply it soon -- in case you want it:
> > >
> > >     Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >
> > Thanks!
> >
> > > And thanks Nathan for resubmitting the `Reviewed-by` from v1!
> >
> > Yes, apologies for missing this in my v2 submission!
> >
> > --
> > Kees Cook
> >
> 
> https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safety/70854
> proposes a macro __counted_by as well.
> This patch uses the same name:
> 
> > # define __counted_by(member)          __attribute__((__element_count__(member)))
> 
> I wonder whether the two use cases are compatible so that using the
> same macro name will be fine.

Yeah, I have suggest the name change for the GCC proposal. However,
given that there is still no code to test for -fbounds-safety, I'm
sticking with __element_count for the moment, as there is code
implementing that name in both GCC and Clang today.

> #if defined(__has_feature) && __has_feature(bounds_safety)
> #define __counted_by(T) __attribute__((__counted_by__(T)))
> // ... other bounds annotations
> #else
> #define __counted_by(T) // defined as nothing // ... other bounds annotations
> #endif

Right. My main consideration for getting __counted_by defined by the
kernel at all is so that annotation can begin. We can adjust the
define's contents as needed. :)

-- 
Kees Cook
