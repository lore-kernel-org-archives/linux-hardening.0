Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A429C433EF
	for <linux-hardening@archiver.kernel.org>; Sat, 14 May 2022 21:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiENV5V (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 14 May 2022 17:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbiENV5G (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 14 May 2022 17:57:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A896531932
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:57:05 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a11so10764056pff.1
        for <linux-hardening@vger.kernel.org>; Sat, 14 May 2022 14:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bWmtBNTQalwT7E03B5wIEDiQ0eZQlPfefe0AXNq0tgc=;
        b=lodgp0daVjVAFrVuduK9x3FpGkyMWCC/6YW39rpLvhxCOkWvY4zZ/6+5Rv7fAL8Bn/
         fHdhIT+p7EljVcAqr24MkzageKig7La0PwlLxPvIxxezTK3uZxeoKWeTm3kcQ64tnVka
         rBDBytXX4Vo/T+/xsB2V/f2H87aTVSxZPsySs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bWmtBNTQalwT7E03B5wIEDiQ0eZQlPfefe0AXNq0tgc=;
        b=HFgkgJR58QC3l1qyVyJ6jwx0a161nGOw0XWTvSfGJgEdCtmG87dh2YUkqK+u2TPeZf
         WeNQuPoYP9lxftOb3PVqkRzreGosqigOKlb92JLM3T3IpI+7HdHksOaNR5jbt6texw/J
         QQxQLrwuxfG7pSXAeDzGcTFJm3atEB5rdFyvWkP3DbrZDbRDzpfv6SWTAtUTFS5RIjhk
         tKFnT6TDU/MXACmih8TWnH9JiqjaOBVoNqeq1m31xF2VpeC3kpTDOAqekd57z6pgUP4b
         sNf4M0mrrRnlK2AFu/FNkOBtSu2QMtPZzJ3kA3wThvdjKV8DRwR+6IvpBAjSRA56k3IU
         vfIQ==
X-Gm-Message-State: AOAM532ALrx5Pl0j5SWJQZr54cXbCnPvveagpqD7fxDFxE8MQmZYQ811
        YZd86Ke2u/2M5KciIWvIZYlQHw==
X-Google-Smtp-Source: ABdhPJwk0yE4XXGUlIDZlCRDV6CQzbYKn//JmrGMHGihO2a3kta7JYbfAvpqhpWeoOwljf3XaDTA3A==
X-Received: by 2002:a63:181c:0:b0:3da:fe5d:90f3 with SMTP id y28-20020a63181c000000b003dafe5d90f3mr9379364pgl.350.1652565424600;
        Sat, 14 May 2022 14:57:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fv7-20020a17090b0e8700b001cd4989fecfsm5696349pjb.27.2022.05.14.14.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:57:04 -0700 (PDT)
Date:   Sat, 14 May 2022 14:57:03 -0700
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
Subject: Re: [RFC PATCH v2 16/21] x86/tools/relocs: Ignore __kcfi_typeid_
 relocations
Message-ID: <202205141457.6BDD89F@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-17-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 13, 2022 at 01:21:54PM -0700, Sami Tolvanen wrote:
> Ignore __kcfi_typeid_ symbols. These are compiler-generated constants
> that contain CFI type identifiers.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
