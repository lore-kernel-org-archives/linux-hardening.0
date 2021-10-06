Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40162C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195DF6120C
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 03:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbhJFDiX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237173AbhJFDiW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 23:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633491391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocTbFKq103vOIaZqsII4pq9sEvQMfjZwJU9h1aYvFtM=;
        b=fJW5ww9STcVBlZRftf8PfkFbyFd9sRK5r8oZ7J3RCtWMM1GaNLBLLrqbzezf50KR4yngM7
        Q8kBe++6ds+3eC/xwIaUaM4kQD5/OvqHWmas2Qne2VYGrqPsKNlvIpsWze2PILk0bGW0h4
        KGf8Iz4JrvF6/QfH5NEB9HezH3bkqGs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-LRsMV20FOdqOHUDUd6DMXA-1; Tue, 05 Oct 2021 23:36:29 -0400
X-MC-Unique: LRsMV20FOdqOHUDUd6DMXA-1
Received: by mail-ot1-f70.google.com with SMTP id c19-20020a056830001300b00546faa88f0cso769391otp.13
        for <linux-hardening@vger.kernel.org>; Tue, 05 Oct 2021 20:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocTbFKq103vOIaZqsII4pq9sEvQMfjZwJU9h1aYvFtM=;
        b=GM3kTBimJ58MVYEI+4DeAbc1SPP07BycG8WUcwnfhSfQH7Tmhk+KSuN45jgqQCD2i1
         ulPXsprfiIS6h/WUZzXIkAT5jJe/QAFeEyXE/u7TmSzlz9SXU1R2n3ApDdraLrUvDuXf
         01VCy3AH44cgy5Tv/oPiNkeA+oE0xGD5nmMida6T07FjXffITJNwT/84ar9aVii1bc4m
         3s7jf6MmYYJYiXPkqnOSxUEOF+tKDn9aZuqrRvfawOPs8wUblOp37jGaSEZxNpsXNXb0
         J0/FMVUuVKYdo/LMkuXhCQC53twpRI+4DmTUZMuXgdKagAw7x09l/i29RTrg6od9zrnc
         tscA==
X-Gm-Message-State: AOAM530O2n+K3oH6/A5s/ypafv+lCtaBv3r8AyT/60CzLzxaX+wmOfg0
        BeBAiGu5u3YCLNFh6sfjyDm7xcb5wFaJeGPYEFO0xe9O47QUtAfofeLJQqnDTWzMV8KIH6/b19h
        H2vZPM8fjdfGwOvS/0trqGacHdNdF
X-Received: by 2002:a9d:6f9a:: with SMTP id h26mr17536540otq.140.1633491389174;
        Tue, 05 Oct 2021 20:36:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKxtRBnxeTiOX8KiHZzT+dQc7fjHh0uxJjbeVdjRDFW+QbyWzR8kELBvGkFwZ2NPtqHJm7Ag==
X-Received: by 2002:a9d:6f9a:: with SMTP id h26mr17536525otq.140.1633491389011;
        Tue, 05 Oct 2021 20:36:29 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o8sm4008393otk.76.2021.10.05.20.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:36:28 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:36:26 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 01/15] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <20211006033626.hfjke5jrvvzxhc67@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-2-samitolvanen@google.com>
MIME-Version: 1.0
In-Reply-To: <20210930180531.1190642-2-samitolvanen@google.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 30, 2021 at 11:05:17AM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function references with
> references to the CFI jump table, which confuses objtool. This change,
> based on Josh's initial patch [1], goes through the list of relocations
> and replaces jump table symbols with the actual function symbols.
> 
> [1] https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/

I found the original patch description to be much more useful than this
one ;-)

-- 
Josh

