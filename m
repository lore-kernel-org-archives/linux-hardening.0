Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FC9C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 15 May 2022 03:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiEODls (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 23:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiEODll (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 23:41:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3890865C8
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 20:41:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so11254680pjm.1
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 20:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTJ/JqBThBUULFI/eq0KMUagYlEy+U8Gm8DCXUOLqI4=;
        b=Nj4rFH2iGcDCRWm7En8MMB9PlgCsyGVxQAPs7BMHVclQ27z31PBw6Dxdm3IvfWzPAV
         L7mSdonC/7b1wN1otPDwe1wD51BlBkiLnb6TRuJ8hkgKwbPpocmSPsCRB/70parsHMgc
         4ME6hu5g6TfCBsYNyr2rW8AOj4lsDpFe7p17c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTJ/JqBThBUULFI/eq0KMUagYlEy+U8Gm8DCXUOLqI4=;
        b=7biV8RzGUDPFoEhtQb/fuvgjkt5QcVl/ItSYAddbTE8RniCmNAjCE8lTUlNnJCaS3I
         dxrwvk8qyIEYZzoLpkXbvGypHsKMUPlpNQFAcM5Uu2U7zS1PrmxNQQZL8YFjdzhAaNNY
         nFVp2y2/vvcMONDXHSGRjroFs9ZMxLi1yxfsXXq7rGhg3BDNzNxphkWIEQBnO62bfWfj
         1jLdSQCBmOILla38nKK7HR5O3zKqDPWpJY9BDTgjsjs14NNG+RBtrGmVluhwwdCoUFl3
         yhrgj7mJDUcJ+zN512yHYAQiN1/LIloEwZWUihgOY9n3mfdOTq7HTBugd0xCzZGOiXGn
         6HQA==
X-Gm-Message-State: AOAM531bCQ8JLwdEDNWW9wN0nc4G2qdaG/R082bdUfQYRmPU2erkEUkF
        XAcyBSstqmM1vGE8QiU9KunNNupL6zSLbg==
X-Google-Smtp-Source: ABdhPJzZ7tgR5pXn1XQv2q/TxKce2IqTRDTreHqkACR4UFVQZMe4HvU+Dngyrw5oYGEcUo13rmdg5w==
X-Received: by 2002:a17:90b:1251:b0:1d7:f7ae:9f1 with SMTP id gx17-20020a17090b125100b001d7f7ae09f1mr24122359pjb.65.1652586099705;
        Sat, 14 May 2022 20:41:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cu8-20020a056a00448800b0050dc76281b3sm4375942pfb.141.2022.05.14.20.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 20:41:39 -0700 (PDT)
Date:   Sat, 14 May 2022 20:41:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
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
Subject: Re: [RFC PATCH v2 06/21] cfi: Switch to -fsanitize=kcfi
Message-ID: <202205142031.A3322C75@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:44PM -0700, Sami Tolvanen wrote:
> Switch from Clang's original forward-edge control-flow integrity
> implementation to -fsanitize=kcfi, which is better suited for the
> kernel, as it doesn't require LTO, doesn't use a jump table that
> requires altering function references, and won't break cross-module
> function address equality.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Looks good on arm64 with LKDTM, too:

[   96.904483] lkdtm: Performing direct entry CFI_FORWARD_PROTO
[   96.904718] lkdtm: Calling matched prototype ...
[   96.904829] lkdtm: Calling mismatched prototype ...
[   96.905250] CFI failure at lkdtm_CFI_FORWARD_PROTO+0x54/0x94 [lkdtm] (target: lkdtm_increment_int+0x0/0x20 [lkdtm]; expected type: 0x7e0c52a5)

Tested-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
