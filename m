Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CA7C433B4
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Apr 2021 15:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD116112E
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Apr 2021 15:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhDBPJO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Apr 2021 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbhDBPJO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Apr 2021 11:09:14 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C92C0613E6
        for <linux-hardening@vger.kernel.org>; Fri,  2 Apr 2021 08:09:12 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u29so2886185vsi.12
        for <linux-hardening@vger.kernel.org>; Fri, 02 Apr 2021 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgtLUE8tLw2Zk1N7ATFrtV7j3dv262lk75CYdDYHcbQ=;
        b=kd9SvTxYOWxn37TZiIkBotQfbjom6BmDGK0QVftHGDvVKbWOFqt4n8MYddo3K4uEPz
         GN/98Lwen7yHTB62wzUNAQz1jXtxtm1hMrk8ea95f9lVhuj6DLC0U+0fpRnyjZi/OVRe
         Dc7pnlam/2yWvqj/HepMcxqxki9N5cJoV/mXsLrGUlG0j2rwfDuJ9p6uuGK5erg4WmS7
         1GU5d7RE3sOtUkXxb6wpu9srfEvaZovXTqu3jIu1G3Jo26tk6ubAobk1V4hwM+GsJSm1
         Z/eMDJLpSTQW8Ihc+u/t9FXiP583UEEdRdmZD6kem8ORj6oIdrLSzqWc+RGmPhl7i6Fx
         psPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgtLUE8tLw2Zk1N7ATFrtV7j3dv262lk75CYdDYHcbQ=;
        b=FUmF9Gfvi3FOQKbWHEXLiHG7gz+Egjsnzk0EDbJCy+cuaiHFuAktwTMseV8kF6i0gm
         0CNcRNuNZ4rgWmbvEYyxWwLDFPWiTt3BAa49MXkwrMccUvuFWsQz/Ja9N7m5Tyx5wZwq
         Led4piKrArGzc46C5LtO8qGTBiaG0F/jOzHqXgCza2z1USjHiaVYFGVsU5/mlWL0ragm
         52E1GRo0KxwSlxyT7BICYHekynyq4KE1Wabs8dm6AKMNEd1ZlvC3pWTH7mNgm4TOf2vJ
         7Jxim76T6f/pIDPrs+0WPM2K75UxFsOnmMAAG08DRn16M+25WiA60e8D8q9VnjIs6tX7
         wFLQ==
X-Gm-Message-State: AOAM531jWxcuswEggKvbkrli4P+dUVEaSIgFNz81fj992/RbwkMlQ95s
        YqGL43HKS9sp9OuLPKL8ikuachG3WhEKORTzCzWV1w==
X-Google-Smtp-Source: ABdhPJyt+vRGIldfMsc/6SAnW/nT0tZKLkIVaHdFuQ9H9NOultOR42/DlIuLdW9oxY84oBB0Iuz0jwbWHMBtVzSTD74=
X-Received: by 2002:a67:3043:: with SMTP id w64mr9076775vsw.36.1617376151718;
 Fri, 02 Apr 2021 08:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210402123959.5143-1-alobakin@pm.me>
In-Reply-To: <20210402123959.5143-1-alobakin@pm.me>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 2 Apr 2021 08:09:00 -0700
Message-ID: <CABCJKufH262ki4FCQJxSO-v+gQzPBsVntQWnNZY7h-cvt1KYTA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: merge module sections under CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 too
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Apr 2, 2021 at 5:40 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> -fdata-sections and -ffunction-sections are being enabled by the
> top-level Makefile, and module section merging is also needed.
> Expand the ifdef (and the comment block) to cover that case too.
>
> Fixes: 6a3193cdd5e5 ("kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG is enabled")

Wouldn't this trigger the ld.bfd bug described in the commit message
when LD_DEAD_CODE_DATA_ELIMINATION is enabled? LTO_CLANG always uses
LLD, so it won't have this issue.

Sami
