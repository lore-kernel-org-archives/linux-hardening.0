Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFBCC433EF
	for <linux-hardening@archiver.kernel.org>; Thu,  5 May 2022 00:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiEEAdN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 May 2022 20:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiEEAdM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 May 2022 20:33:12 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C442D54BC0
        for <linux-hardening@vger.kernel.org>; Wed,  4 May 2022 17:29:34 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f7c57ee6feso33421307b3.2
        for <linux-hardening@vger.kernel.org>; Wed, 04 May 2022 17:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DBZHgTgHhGifz1O+OvTLRL4mlr40VVe72aYyr9oFJs=;
        b=dufIc96PMUlxP7YcnxTZoMITLMW8Y8Vo05y80Fc6JcS6UdgaV0y+6VIGR01O9ZyAFn
         VzgCR2el/k9vlj/s3PNNu1ujfqQGw0o4JhuN6JoKakSGUfCC0EkykjyAuq+tQKFxgZZ/
         GVl99IrkhYo99EI/plVjYvWuSlliV2lt3vfymRAoKwa/Bw7ItBwDYrcO+AhCCmNWjzcz
         FaLAW5c/R6V6hjaS0RaO65IAFph/k2zU7r4m3tPSKtOLZmPJtVpDRegKLE9+pCML2Hkr
         6hV1zIFdE1SFEzA3r4ZR+kzUzCWEQBlKP1Dsw5QGGA9fC2MwHnt14Z2z4QLSXJN7nyDe
         i5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DBZHgTgHhGifz1O+OvTLRL4mlr40VVe72aYyr9oFJs=;
        b=fY2hjEKTROr6fURljZT723zeBFgVclkxouKKpmJjKVm87h8kUga/osNZjbCk/LnxXY
         iLcoFtxO62i3Y86aFOCacr8P3g+1NzwGcg7jEOhsF6js5c5Vs5htg6VufEp++Sbt5KFK
         n9CfoA4lyiThSgBXxZyygmRedhwJuyfwGuOOy9/7a0iDz3067O5AVeVEUG8piU2vj45X
         CLzUJyLmkq3imyqGyVCYytiBbr596HriLBpJXi6gmXCfR7h+GNVXmItV4wDxtuf6MkTf
         Po09kmM9TGjx/IQGOMMHJM8D8AnMSPGRv2qemmrABRl4GaGOSOsaAHmZJSMlB4BVs8ut
         QyrA==
X-Gm-Message-State: AOAM533x+sqVWdnK+IPcWqNkqgoLnAZnwIudG6QuMbXz4K2nkT/IVdmB
        PDMvzrUnkxbODpYMXmYmp/sKg7ivuk1pf5Ezq9W/rg==
X-Google-Smtp-Source: ABdhPJzxktpUG4Yp9bPU3HQqkPixfSm6UoQDjkuYNelP2+Ks74Aez5gQHsRBFtq1NoKFbP2TcO2lCR/gg4qL/ccgLHo=
X-Received: by 2002:a81:8d02:0:b0:2f8:c9f7:4041 with SMTP id
 d2-20020a818d02000000b002f8c9f74041mr21759476ywg.117.1651710573858; Wed, 04
 May 2022 17:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com> <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com> <20220503220244.vyz5flk3gg3y6rbw@treble>
 <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net> <YnKx5a9WvJ1UhWPm@google.com>
 <YnLDGcJGKfqi5+8w@hirez.programming.kicks-ass.net>
In-Reply-To: <YnLDGcJGKfqi5+8w@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 4 May 2022 17:28:57 -0700
Message-ID: <CABCJKueqqq-keiyE8tYJQtfitxQt08vQwEfG41C8t3aJC8AwKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org, andrew.cooper3@citrix.com,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 4, 2022 at 11:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
> __cfi_\sym:                                     __cfi_\sym:
>                                                         int3; int3                              # 2
>         endbr                   # 4                     mov     \hash, %eax                     # 5
>         call    __fineibt_\hash # 5                     int3; int3                              # 2
> \sym:                                           \sym:

OK, that looks reasonable to me.

> It seems to preserve the properties of the last one in that direct calls
> will already be correct and we don't need linker fixups, and objtool can
> simply parse the preamble as regular instructions without needing
> further help.

Wouldn't objtool still print out unreachable instruction warnings here?

Sami
