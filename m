Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9DDC433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 20:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E585A611C1
	for <linux-hardening@archiver.kernel.org>; Tue,  5 Oct 2021 20:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhJEUiz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236449AbhJEUix (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 16:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633466222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/2lg8os1dn3LeWQY69s6PgxMEZ7LguAFPcGthQmKdLc=;
        b=dU7exhJo0H9xHK1s/2bW9arXkc8GsghZ/EtTw3T34T+6wv/V+LLl+wBqpnAU7LTxwotQAk
        UmuYI/O1cvhjZdPFgSAPduPb+xlyRK5dn23utoxa8VWXkwJFVdoAfkGLxNMBd0a9xsRuu5
        n1rwUqJFNyaDnkfvD96+2DR7wNim84A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-g0YwQxYLP4CSm1qM8YkiUA-1; Tue, 05 Oct 2021 16:36:59 -0400
X-MC-Unique: g0YwQxYLP4CSm1qM8YkiUA-1
Received: by mail-qv1-f72.google.com with SMTP id fv11-20020a056214240b00b00382e9471ed6so642986qvb.4
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 13:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/2lg8os1dn3LeWQY69s6PgxMEZ7LguAFPcGthQmKdLc=;
        b=6KMCPdj7ppvI/xYC/zctARl8JoSpDZzzsRI/G69m3bL47Ut20NIHv5/hfo7tmjG1G4
         Vyki+fyoQsBRWGTjwfr0G+XY6Wj38Mct3VTSmR8AtJslR0JK9p+cbkVNvjTyjvjgJZp8
         2oHN2ZByx0SbT6JPc/5URZAPLfPSC8F9bz0A9qzAdfZYZrbjbkEf0twJ87Cx9rM0mLto
         09/bdJqfnP/SIJNKoLdNu5bG8n1/ezuKn33zxBFGdXKQVE3KVqox3/W9qpJkdy1u70Lx
         0jQQ4/es5nSvEpCyHipiEMu6ak2PRfQ+ZHkCBOlrnoc5Mf1StN3uWbtlma9jZVW5s7aO
         S8BQ==
X-Gm-Message-State: AOAM532X0PsqtlIyiUxoBEhf5+SIcphWKJHteTdrpWiNno0nBmQkk6EJ
        HdcqVdt/kV/hWnblPkuLDQmtMUBMJUpLM3rN66YYpFOe4LWA25c8dIJWIc9qMg4hRvnpAzSpWyd
        giEprZTKeQiKevUUwB48D2vTs02id
X-Received: by 2002:ac8:615c:: with SMTP id d28mr4325704qtm.103.1633466219387;
        Tue, 05 Oct 2021 13:36:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiUlDt7M96h8AoBqBLpXzaS3T7Kh4lNL7lZpOFg6AtZ305uLibjt9iiB/xDGibdlAu3aY9YQ==
X-Received: by 2002:ac8:615c:: with SMTP id d28mr4325678qtm.103.1633466219183;
        Tue, 05 Oct 2021 13:36:59 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 18sm11884045qtz.49.2021.10.05.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:36:58 -0700 (PDT)
Date:   Tue, 5 Oct 2021 13:36:55 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 00/15] x86: Add support for Clang CFI
Message-ID: <20211005203655.cvjfxmjvgx2knkuk@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
MIME-Version: 1.0
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:16AM -0700, Sami Tolvanen wrote:
> This series adds support for Clang's Control-Flow Integrity (CFI)
> checking to x86_64. With CFI, the compiler injects a runtime
> check before each indirect function call to ensure the target is
> a valid function with the correct static type. This restricts
> possible call targets and makes it more difficult for an attacker
> to exploit bugs that allow the modification of stored function
> pointers. For more details, see:
> 
>   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> 
> Note that v4 is based on tip/master. The first two patches contain
> objtool support for CFI, the remaining patches change function
> declarations to use opaque types, fix type mismatch issues that
> confuse the compiler, and disable CFI where it can't be used.
> 
> You can also pull this series from
> 
>   https://github.com/samitolvanen/linux.git x86-cfi-v4

Does this work for indirect calls made from alternatives?

I'm also wondering whether this works on CONFIG_RETPOLINE systems which
disable retpolines at runtime, combined with Peter's patch to use
objtool to replace retpoline thunk calls with indirect branches:

  9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")

Since presumably objtool runs after the CFI stuff is inserted.

-- 
Josh

