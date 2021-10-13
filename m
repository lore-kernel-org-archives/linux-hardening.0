Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1C1C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF5B610E5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhJMS6j (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhJMS6i (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:58:38 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E881C061746
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:56:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x4so2467445pln.5
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ye13OmZ3/WQ5cIUtbfVVB0LIxdrNFZJ8JAtfJOn6tSs=;
        b=ggwVdU/nM2n1VDwOUSzbDNh0n6tH68W7Y1MlizZeUdw5vOgv1Knlj+CukpD4B6DXrz
         xHxkyiCsubqCfhQNj5+NbdGOgs2hbfjZCsixQAm4QagFigeRHP/QXKqjs/A+dzDsd+Vl
         EmuIIytJ1MWGb89CZf8jCdbYbefJNpP5QVB4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ye13OmZ3/WQ5cIUtbfVVB0LIxdrNFZJ8JAtfJOn6tSs=;
        b=uzQyMwErZ2sP1nl+6OOhnxmNjzRtzbJ8j6C5KfVyPvwQADiS++aSI0N3f+0OV2bfCG
         MVvISsm+3Ov1Q97EponJVtZVQr9RYOtn6CPxfD209pylyrUKhp5ltvKmtQqu37KbJNrR
         r6cpDUN2j4rvBE3tMsjnDolf522Ui749usDCTJCyCNIldhAHWom1CCnfOl+X1CeenETs
         5aZEG4ntax1dwfJf08UTBwgNWqvSfbSLK8OsATO4SNJMSUpI+KjWqzLaYGWc81zICI54
         czExYcDgzdQ5HqUHaT6SZ4ivY9TXqSVK2f1fkv+RiMzRZqVbxyEBGuxy1gakkUWQ1+nD
         cMYQ==
X-Gm-Message-State: AOAM530+lK2W0HjR9D9LEm27b8x+dwJoxgH5ez1YppXhIapYXVeqKrf1
        QpfS9fTelxQ3EdlizzUNF4Mx2Q==
X-Google-Smtp-Source: ABdhPJyk4f8iBw/TbgCPI4nSRB9gGx/BtKbfKsMhla90ncq/wBhlkZHwwD0ojZQFgmLLAHQl988/gQ==
X-Received: by 2002:a17:902:6544:b0:13e:dd16:bd5b with SMTP id d4-20020a170902654400b0013edd16bd5bmr856440pln.61.1634151394760;
        Wed, 13 Oct 2021 11:56:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w19sm6949936pjy.9.2021.10.13.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 11:56:34 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:56:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 15/15] x86, build: Allow CONFIG_CFI_CLANG to be
 selected
Message-ID: <202110131156.C52C7F7CC@keescook>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-16-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013181658.1020262-16-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 13, 2021 at 11:16:58AM -0700, Sami Tolvanen wrote:
> Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled with
> Clang >= 13.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=51588
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
