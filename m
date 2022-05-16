Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9D2C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 16 May 2022 17:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiEPR5y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 May 2022 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiEPR5x (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 May 2022 13:57:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D04A39BB6
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 10:57:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2ebf4b91212so162267677b3.8
        for <linux-hardening@vger.kernel.org>; Mon, 16 May 2022 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L6QoMgtwgL3tJe4GB/Ih7yflwSG3aQ00OepOaXpJEe4=;
        b=Zc6rshDMluaKoextbWcKCqT45DJDCK0JaPZ3RS4WxflJ5a/2R1FtVZTwvZq/ZC+Hvw
         EfTgd2+B7ClPEcqSvU7y+b3GnV3yZWIyV0f1D6fXPWl0YrRfJlN8YBXVUZIakI1yYwgV
         W4b5WxKlmQsSVJR+9wPV9YQIYhgG0gWlW6dezlkbaCdnwmnqx3jrkWESEoyVo3pBP70l
         Qlwl1jFhJ0WQL2n/xxb4UQS1lDEFsNc2shbbjfcRimzgDljTstePWW/JNSIYVgBB78oh
         oE9ddI7QjLL2xzK+HSxXR23YnlhEVDKmwQwb9PS+RBv0cSQTk6RBLlYpJBELdGn4zXxI
         i1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L6QoMgtwgL3tJe4GB/Ih7yflwSG3aQ00OepOaXpJEe4=;
        b=G2C5d8Dv4ZN3bhzEddxfGVN109N9KHI0vN6MVSPLL0Gs9A6/Z63RlqD66oHTlxMRo/
         mvryBu7PWUi0LtGypS9YDlah61mPlTGfr+h7/zuR7yLtoOTx7H6mtNCR5xCKlme+7GlK
         9HCxM1DGAjVWxp/zR0MEb4vrEnOR5npaXKe/vMGQcTOj97Mp3uL78pC3F42OOQK37aM1
         FTEMqRS7jqDQJWetrAQ2M6Km+Ej3R1WgB1KtlvyJtzcDzstOZsDq5aTWeEaZL/0k6mX1
         QGxhRrT/gctL1lTzPS7bJkqaoiPDi7xymi9uNR+f+nZ4bZfYZwhD2fzjYPfxIFaiup7j
         2MCQ==
X-Gm-Message-State: AOAM532sduEI9mO5k7B9fV6HAKq53eclG7TdPQ2+3Wdc4JH36nuHIuNH
        OA4iQFWAzXl4w3+nVAKdqtkfVUN+zkWzkeLi6WaEBQ==
X-Google-Smtp-Source: ABdhPJyidyZ+9MInh37119ah6yTP6kCC84bdJzFaKW0zxyWyF1nd0YJqkrMB3Pbhc+Z/UFHH1FjJwSyi6hpdSvHXSCM=
X-Received: by 2002:a81:7953:0:b0:2fe:f8a9:7e45 with SMTP id
 u80-20020a817953000000b002fef8a97e45mr6834348ywc.23.1652723871208; Mon, 16
 May 2022 10:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com> <CA+icZUWr+-HjMvY1VZf+nqjTadxSTDciux0Y5Y-+p_j4o7CmXg@mail.gmail.com>
In-Reply-To: <CA+icZUWr+-HjMvY1VZf+nqjTadxSTDciux0Y5Y-+p_j4o7CmXg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 10:57:15 -0700
Message-ID: <CABCJKueVcwYishxSoEyn9b1vaGTXdoYWF7VyANPm7V=H+yyfhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] KCFI support
To:     sedat.dilek@gmail.com
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 16, 2022 at 10:31 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> Anything Like LLVM cmake Options to be condidered and Set?
>
>
> I activate Clang and LLD ad projects - OK - enough?

Clang and LLD should be sufficient.

>> This series is also available in GitHub:
>>
>>   https://github.com/samitolvanen/linux/commits/kcfi-rfc-v2
>>
>>
>>
>
>> Can you please add a history of what changed?

Oops, I forgot to include that.

Changes in v2:
- Changed the compiler patch to encode arm64 target and type details
in the ESR, and updated the kernel error handling patch accordingly.
- Changed the compiler patch to embed the x86_64 type hash in a valid
instruction to avoid special casing objtool instruction decoding, and
added a __cfi_ symbol for the preamble. Changed the kernel error
handling and manual type annotations to match.
- Dropped the .kcfi_types section as that=E2=80=99s no longer needed by
objtool, and changed the objtool patch to simply ignore the __cfi_
preambles falling through.
- Dropped the .kcfi_traps section on arm64 as it=E2=80=99s no longer needed=
,
and moved the trap look-up code behind CONFIG_ARCH_USES_CFI_TRAPS,
which is selected only for x86_64.
- Dropped __nocfi attributes from arm64 code where CFI was disabled
due to address space confusion issues, and added type annotations to
relevant assembly functions.
- Dropped __nocfi from __init.

> Nathan has a i915 cfi patch in His personal kernel.org Git.
> Is this relevant to kcfi?

It fixes a type mismatch, so in that sense it's relevant.

> To distinguish between clang-cfi we should use different kbuild variables=
 for kcfi.

The plan is to replace the current CFI implementation. Does reusing
the kbuild variable names cause a problem?

Sami
