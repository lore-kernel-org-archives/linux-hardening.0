Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C28C678DF
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 23:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244338AbjHQXri (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 19:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356335AbjHQXrX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 19:47:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACCE3A89
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 16:46:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-689f9576babso301793b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 16:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692315942; x=1692920742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5uC2JcHE9JS0c402i8ZIWy7dsF1n8BGwS1laDcefLsA=;
        b=O+1WPWEnTzQpTY+DGfPtB1ZW78qPJcUhAtsz1fyoeSxwO0YBhezQhhZV4OrVMgoXna
         /8U+/142TfXbfoDOXk7pdGwHMVRtbmkLk5NibSM3+ta3pI4Ip42jHoyuhhc331Pe8Sfa
         KtkJ2TLRvCcTwfLTi3fSl7+HhNc9onncFRl6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692315942; x=1692920742;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uC2JcHE9JS0c402i8ZIWy7dsF1n8BGwS1laDcefLsA=;
        b=R5G02qq9ceuMC3Zgb8DZIrOWvAcPzpNVNfv7F084s6Tt9csiFlbfAyOraq9lm7DtnC
         gzke31kQqnxJhcwBo+eD75KxBLn8unmJW2BzYvQQ+p7wO+pML0pNs6DYI4UnsoTEHscB
         rttOehwoB6HcoaSqIxWjzFcZZbNu4kwy2ub1gfg/X8Fgd8VntUIuLJykLBKPw4z9jMLS
         hWHSS6y7Vw/1kZn4LBXiOCGo1ztuoALkZkESW7rx5LYJ7d+4oOpvV87vJn20dxCa0T9Z
         ay2LzjwbIZ9BPrIAuaKq69J6x7aPEWXeqm62GfWtLk7zlRtOeHV1VuTOSBvXEgJEtSFq
         mGMA==
X-Gm-Message-State: AOJu0Yw5MCwSaqHB51dVeJ7UIQ5wzf3vAEQ+MjkGP1kM+VbP2uXU0gXj
        t5bcJNA4H2TKwD9iEFv9KIxoAA==
X-Google-Smtp-Source: AGHT+IHe89dMi3ZUn4C0h1cSLBafpmTmzM1zOOlc+5Q1brzsHi0/qSgClzIWnusxY0Snmv6vLwisjA==
X-Received: by 2002:a05:6a20:4a28:b0:13d:ea25:9656 with SMTP id fr40-20020a056a204a2800b0013dea259656mr944606pzb.60.1692315941870;
        Thu, 17 Aug 2023 16:45:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a20-20020aa78654000000b00689f8dc26c2sm299020pfo.133.2023.08.17.16.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:45:41 -0700 (PDT)
Date:   Thu, 17 Aug 2023 16:45:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: counted_by: Adjust name and
 identifier expansion
Message-ID: <202308171644.156176C@keescook>
References: <20230817200558.never.077-kees@kernel.org>
 <CANiq72=-DL0NV0zJrrzLmK77e6FALSupH4N-i-vfg8WrZdPDcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=-DL0NV0zJrrzLmK77e6FALSupH4N-i-vfg8WrZdPDcQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 18, 2023 at 12:06:15AM +0200, Miguel Ojeda wrote:
> On Thu, Aug 17, 2023 at 10:06 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > GCC and Clang's current RFCs name this attribute "counted_by", and have
> > moved away from using a string for the member name. Update the kernel's
> > macros to match. Additionally provide a UAPI no-op macro for UAPI structs
> > that will gain annotations.
> >
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Fixes: dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Looks good to me, thanks. Perhaps we should split the UAPI bit into a
> second patch.

I'd like to keep the UAPI part -- that was an oversight when I first
added it.

> I can take it into my tree; otherwise if you need this elsewhere:
> 
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks! It'd be slightly easier for me if it was is my tree, so I'll
grab your Ack. :) Let me know if you'd prefer it otherwise.

-Kees

-- 
Kees Cook
