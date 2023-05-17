Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D5C77B7A
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 19:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjEQTQO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjEQTQM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 15:16:12 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762246BD
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:16:04 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6434e65d808so1108538b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350964; x=1686942964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=22zZeyTszsjqQtTw83l75e7nUiA2L7awbPYCIUtRXB0=;
        b=R+5FKA9lWBwBAjWxZizrbxxJQsMvb6eC/kdwD4dZeJd/QKFqTx9K9sjkZYUft/jmLq
         WAqr9S5Z9kk1HiSSE+dh9ErSRn2m9N+06Q7frDhjd5tgkLYPPZ+w2UiHUUbFnvQzbnx3
         er/ikALN2FBt/e69QO1vl3F/PoVbX9BsL3BGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350964; x=1686942964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22zZeyTszsjqQtTw83l75e7nUiA2L7awbPYCIUtRXB0=;
        b=jCT3jfQJlSlb97PViq/fhlCSbwdE9Ob6rZ1NSuVezJMY6JQAGgjsdxD7/oPp3UitXi
         9HJseg2Qf/3+t+6B9v8tvoBnjInD+bmU/xQA5qSqg3WDC+X78p0hh//bnlfgvuC9nKk0
         VcGgEJbVzPvmMyNcOOKHf9kQrj8EeQp13g8cqQcRclOn1lD3u9BmfBGXO0gcwCYDStlI
         iBDk6mKvfMVDHTQv3tB51mwW94jm8U5CnkzBbG00rRA5xMtnuyUqR2ud90298VzbO05q
         cYA+GaOqgFjl77jWzzZdvbkjR+q48Zu6WcEgYUSdF7n8xrY3x8uFJqo3FZu9KtNeLnnr
         qxXA==
X-Gm-Message-State: AC+VfDzmc2fw/ySlUBV056lXy86hulj3lxBSL0cjwwgjScASnY8gVUzP
        43CS691fzZBG24u0zAMsHfAGbg==
X-Google-Smtp-Source: ACHHUZ7wo9DU5XCta4a2NKOkf+gmQ1GpmgimtH/ciDRlJ6sKaw7P7QD+lZQK0Tn+WJdQjMpIfMpB0w==
X-Received: by 2002:a05:6a20:3c92:b0:104:e530:28d2 with SMTP id b18-20020a056a203c9200b00104e53028d2mr21730609pzj.46.1684350964108;
        Wed, 17 May 2023 12:16:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x47-20020a056a000bef00b0064b0326494asm7872817pfu.150.2023.05.17.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:16:03 -0700 (PDT)
Date:   Wed, 17 May 2023 12:16:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     ndesaulniers@google.com, masahiroy@kernel.org,
        linux-kbuild@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, jpoimboe@kernel.org,
        llvm@lists.linux.dev, mbenes@suse.cz, linux-kernel@vger.kernel.org,
        trix@redhat.com, peterz@infradead.org
Subject: Re: [PATCH] ubsan: remove cc-option test for UBSAN_TRAP
Message-ID: <202305171215.7C58897@keescook>
References: <20230407215406.768464-1-ndesaulniers@google.com>
 <168435014337.2056649.7592777028793700479.b4-ty@chromium.org>
 <CAFP8O3L_RsaTMJvT7hmjD6ON49uob9Fb4mWg8ZUav_Y-FCgTMA@mail.gmail.com>
 <CAFP8O3JivZh+AAV7N90Nk7U2BHRNST6MRP0zHtfQ-Vj0m4+pDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3JivZh+AAV7N90Nk7U2BHRNST6MRP0zHtfQ-Vj0m4+pDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 17, 2023 at 12:09:35PM -0700, Fangrui Song wrote:
> On Wed, May 17, 2023 at 12:08 PM Fangrui Song <maskray@google.com> wrote:
> >
> > On Wed, May 17, 2023 at 12:02 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, 7 Apr 2023 14:54:06 -0700, Nick Desaulniers wrote:
> > > > -fsanitize-undefined-trap-on-error has been supported since GCC 5.1 and
> > > > Clang 3.2.  The minimum supported version of these according to
> > > > Documentation/process/changes.rst is 5.1 and 11.0.0 respectively. Drop
> > > > this cc-option check.
> > > >
> > > >
> > >
> > > Applied to for-next/hardening, thanks!
> > >
> > > [1/1] ubsan: remove cc-option test for UBSAN_TRAP
> > >       https://git.kernel.org/kees/c/08e4044243a6
> > >
> > > --
> > > Kees Cook
> > >
> > >
> >
> > For this -fsanitize-undefined-trap-on-error, I think we need a v2 patch that
> > tries -fsanitize-trap=all as well.
> 
> Correction: -fsanitize-trap=undefined
> 
> > -fsanitize-undefined-trap-on-error has been deprecated in Clang for 8
> > years, and at some point we will remove the option.
> >
> > GCC implements -fsanitize-trap=all later, but
> > -fsanitize-undefined-trap-on-error is documented as deprecated as
> > well.

Right now all the compilers support the old way, and I'd rather remove a
cc-option call than add two. :)

-- 
Kees Cook
