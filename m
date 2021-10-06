Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144ACC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1106120F
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhJFDjf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:39:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhJFDje (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 23:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633491462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hQgwvO1joc+8xZdxI7msExSbMFXW62NaKXjYt60o60Y=;
        b=U5A5E/abZ52DkqLNsd7Wst4Rn2z2+b5DLNaAqhdMtlqizH6Ri1ptYQPPZYk7Zv1WzJGb35
        1iemU++N0qqWvvsrBeDBAxwP89C0YuzEp4E+/oGc44tB0mFOSG2v0wYEvtWGu6PhqAUGBR
        SeIZZYXNe0jLqJ9kG5YTDESy7vwUNyo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-g1-on7W1NIeMZh9Xogt8xA-1; Tue, 05 Oct 2021 23:37:41 -0400
X-MC-Unique: g1-on7W1NIeMZh9Xogt8xA-1
Received: by mail-qk1-f198.google.com with SMTP id q5-20020a05620a0d8500b0045edb4779dbso1225286qkl.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 20:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hQgwvO1joc+8xZdxI7msExSbMFXW62NaKXjYt60o60Y=;
        b=FlBHqd/bIu8/O+XHKpTlqONH52gbjeOj9bONEVA+2QwW6cAuFcvwCsH9UO6Hpmwlls
         JcTo6bKFCHKR315TQD5clpJgAfIB85znyeEIC0QJfL2zWjOqAc9DGNRWGeEsbrMiCPuL
         IAthN5M5WXlN0SlJraQcTaELGyX8uoIIBzi3AL3xEW+IGSLVdtm1i0AclJmMpNN25kCY
         gpaMr/J08CWhmXw0neqQyllOj2Dqvj9sHW+xFui4vaHTHc+0ASh0tntSMANwmSzYOSAc
         fzSmR/6T/8YqveiQKfGJOYXEndYwWbxP8mwR65nI8BwGmGyPtzRXb9sjWcthXtAqGRbs
         +bKQ==
X-Gm-Message-State: AOAM531DAA/nJFMhTT5BaPZ+eTgp/jLM+TAh3tTG/qyCXbfBGU6Gj5CS
        foEgVGkAU5Ct1KEUDCVTsk+vkrGgsNNjEVzxjK7cmPv7qXk7blsnpmdeL4ZlB+hK77nwLjj1BmD
        eor96V2CH+nnOIj0d7JhhqPVCE2vv
X-Received: by 2002:a05:622a:1cd:: with SMTP id t13mr24476054qtw.283.1633491461277;
        Tue, 05 Oct 2021 20:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1rqsQDW73oW5IpwjjqQp7qLI0RWKug5ueJvzxcJCbW+Uc/eOz0fUprINDj9JdXsUQ3ob9QQ==
X-Received: by 2002:a05:622a:1cd:: with SMTP id t13mr24476045qtw.283.1633491461113;
        Tue, 05 Oct 2021 20:37:41 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id d18sm1733576qkk.3.2021.10.05.20.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:37:40 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:37:37 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 02/15] objtool: Add ASM_STACK_FRAME_NON_STANDARD
Message-ID: <20211006033737.7duncwbqmporicer@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-3-samitolvanen@google.com>
MIME-Version: 1.0
In-Reply-To: <20210930180531.1190642-3-samitolvanen@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:18AM -0700, Sami Tolvanen wrote:
> To use the STACK_FRAME_NON_STANDARD macro for a static symbol
> defined in inline assembly, we need a C declaration that implies
> global visibility. This type mismatch confuses the compiler with
> CONFIG_CFI_CLANG. This change adds an inline assembly version of
> the macro to avoid the issue.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

