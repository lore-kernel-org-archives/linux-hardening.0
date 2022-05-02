Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F245C4332F
	for <linux-hardening@archiver.kernel.org>; Mon,  2 May 2022 15:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385783AbiEBPfk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 2 May 2022 11:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385812AbiEBPfi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 2 May 2022 11:35:38 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A063EBC02
        for <linux-hardening@vger.kernel.org>; Mon,  2 May 2022 08:32:08 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s30so26642952ybi.8
        for <linux-hardening@vger.kernel.org>; Mon, 02 May 2022 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hCGKNipS00tBX8rbB28dkiVg/BvdNz8E722on+AV5GE=;
        b=iJhBELUzXOr15YhTf0wF+a681aftQovvW35I2W0xmmMp8MntU2wDtF3J/uFXVkHeUI
         FFh10K8dP/kcvw5GV42gc2kKRsaEByU7ysTgBlBeGuBG8+jtAY9IAEIfWWsgn4nIJpbw
         bsd6Y41l2YVABLJQ92bJl0KYYuPYfpyYZI9eYjsmq+GzxKmgW0yHxGKt2ihtN9vq3ExH
         dBOuCATwLlUCWDwVviy4J4NRKpwr/ejONaiz5p0ymgLsXU8O6QPNTKF7w7usOFpdARND
         A5001AxyjOwcV5fpVk7WWUtsEuvWLCeK6kDaDgzQI8xbzzBrq2zM5i8zSaUPu8vITIUg
         4CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hCGKNipS00tBX8rbB28dkiVg/BvdNz8E722on+AV5GE=;
        b=H4AoLJ07dsSa8cQXyEvWBJ89JQhvlfHn7b32wAwLzSEzlLsvvL5E0phkRW6kFZqOYf
         HIszUVZYcRbV/+5VPaIQPjUmuEi6CEVG2KKJQuE0HaFKyb8BSaBlGgCVl3062B+wfix6
         4tO/0Vw7AgzE19SRD7Ec5918JkI0nrJiwnRo4n+plJ7shL1dZtG2ksChR4/Grdjv9PHW
         8I5/SfxMErf4RTMkgt5Qu97bUZU/9rNR5LcIgJGUDTfGhGoP1evdTwDkrGhTlRLb3zC0
         rxejj5d6cLdNrXnJFwPBeaHLgXi6WDEqauy54wQrJvLd3UDuhRbaW4L5Kw2pFCitbIi3
         zhiA==
X-Gm-Message-State: AOAM532mXFaLYKXm7G3zQNsl4YcqRyrE9LezDZ2DgBqpGy0BIw2hhbvE
        kmfckVYPRA2byupXTtuEv3eHK1RZHGJKwnriMLxgHA==
X-Google-Smtp-Source: ABdhPJwj3QrPFfxu2nyuN5kFPO+0frvF6GLCyRxUVFMu80sCrG1GMxBjBR97BxQia0hYHO5LXNrgaz0HEPZ7M14xL8o=
X-Received: by 2002:a5b:2c9:0:b0:644:b7c9:3766 with SMTP id
 h9-20020a5b02c9000000b00644b7c93766mr10147935ybp.428.1651505527625; Mon, 02
 May 2022 08:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com> <20220430160750.ov7ddsq2vzibwrju@bubbles>
In-Reply-To: <20220430160750.ov7ddsq2vzibwrju@bubbles>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 2 May 2022 08:31:35 -0700
Message-ID: <CABCJKufWFy0ShK49YAqk60mVApQ3qrfOj9R1nuLAWXiVtqbPJA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] KCFI support
To:     Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Apr 30, 2022 at 9:08 AM Kenton Groombridge <me@concord.sh> wrote:
> Many thanks for continuing to work on this! As a user who has been
> following the evolution of this patch series for a while now, I have a
> couple of burning questions:
>
> 1) The LLVM patch says that kCFI is not compatible with execute-only
> memory. Is there a plan ahead for kCFI if and when execute-only memory
> is implemented?

There's no plan for executable-only memory right now, that would
require type hashes to be moved somewhere else to read-only memory.

> 2) kCFI only checks indirect calls while Clang's traditional CFI has
> more schemes like bad cast checking and so on. Are there any major
> security tradeoffs as a result of this?

No, cfi-icall is only scheme that's relevant for the kernel. The other
schemes implemented in Clang are mostly useful for C++.

Sami
