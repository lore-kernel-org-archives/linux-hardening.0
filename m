Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CCBC7EE24
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 22:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEPWRu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 18:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEPWRt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 18:17:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582D259E0
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 15:17:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-510a5a5cf79so182a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684275467; x=1686867467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFM3fAYlTPBxQGmteO/2uHFhqAyi1JN0aT26xTBpePY=;
        b=o2yls/45s0xkZRgXdYp9Llp5QvwSiw2Yins46NJBQ93VxSzpcVos6BkD9ZuzWFA6zU
         OLiA/M6Ocvy+P4BEWoZdomhusGCoMMqAFW61552mNjMRB4VeIol0mTshVg5jouXKuObl
         Qj7ybH1dkgrkD5EEkwaYEi3zN4P4l5qGIq5z9AwQNzUOGmyRuM62BwnbBdj6zPnZ0v4B
         gdKf2Eq2CjxCfpZB1geOeSvb6FtBgiO4ynAq+LDyuAWeuAucwu30IDaI3JRef9OAg43t
         m+dXn+w3YLkbCgdi1d7j3HJbtKxXGw15d65FITdPhLK6pSsk9JI6fdnBe39mHtctSmcS
         Shgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275467; x=1686867467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFM3fAYlTPBxQGmteO/2uHFhqAyi1JN0aT26xTBpePY=;
        b=JcpptNc9i1V5jusSb3WU3uRLqnKLHPGrAV8GkxNi4npG9RSZLEs0iyuQJg+xuj0j2v
         DWegPX9L9GVBh9QIWXT1I47pSjv1pNvzJju7LwCII3IGAsk7957DMutkqvBAjn+n/YlE
         QvMoUsAGA4i7KBSCBDoCWgeLYK5P4UwXCLwHTW15pmBjF/cEcH4JofWzruY0w0VQ9UWp
         X+w2RfiRLIwTqcswjcdbjt+gYjbEofS0qq5pHwHhfWGcqVF68Gp83uOe1duNvH/E3EuU
         7U4JHw9lw7aiFD6QBVRecqaAJ9XG///Hy4Hc8z3ydyCwyUYrmBL6m2e/YQ32AevcYh5d
         QrwQ==
X-Gm-Message-State: AC+VfDzkZnggbl2E+ucwxg8tllbFGzlEkuQPxVrIq4Qi5h0EoE4EvYEO
        dEgaB/pvSo0yubuI0CH+Ld87VtTQjjdpqSzVkWfL6g==
X-Google-Smtp-Source: ACHHUZ4kIdAG/+KEv1wYdz2uXbEvowoCYDRdQ98dgmPo2TYOqhB/KFXxkuuo4dMNQNDQo21ejrglf36AsKWL2Iuky8U=
X-Received: by 2002:a50:aadd:0:b0:50b:f6ce:2f3d with SMTP id
 r29-20020a50aadd000000b0050bf6ce2f3dmr51714edc.0.1684275466605; Tue, 16 May
 2023 15:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <202305161307.4A16BB6A47@keescook>
In-Reply-To: <202305161307.4A16BB6A47@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Tue, 16 May 2023 15:17:09 -0700
Message-ID: <CALmYWFteCd+h+tn+LmgTpN9Ld5=qAMMQ34=b1KCoE3OSBun+DQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Kees Cook <keescook@chromium.org>
Cc:     jeffxu@chromium.org, dave.hansen@intel.com, luto@kernel.org,
        jorgelo@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 1:08=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Mon, May 15, 2023 at 01:05:46PM +0000, jeffxu@chromium.org wrote:
> > This patch introduces a new flag, PKEY_ENFORCE_API, to the pkey_alloc()
> > function. When a PKEY is created with this flag, it is enforced that an=
y
> > thread that wants to make changes to the memory mapping (such as mprote=
ct)
> > of the memory must have write access to the PKEY. PKEYs created without
> > this flag will continue to work as they do now, for backwards
> > compatibility.
> >
> > Only PKEY created from user space can have the new flag set, the PKEY
> > allocated by the kernel internally will not have it. In other words,
> > ARCH_DEFAULT_PKEY(0) and execute_only_pkey won=E2=80=99t have this flag=
 set,
> > and continue work as today.
>
> Cool! Yeah, this looks like it could become quite useful. I assume
> V8 folks are on board with this API, etc?
>
> > This set of patch covers mprotect/munmap, I plan to work on other
> > syscalls after this.
>
> Which ones are on your list currently?
>
mprotect/mprotect_pkey/munmap
mmap/mremap
madvice,brk,sbrk

Thanks!
-Jeff Xu

> --
> Kees Cook
