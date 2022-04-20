Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A5C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Apr 2022 15:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356530AbiDTPUJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Apr 2022 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351698AbiDTPUI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Apr 2022 11:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E899B44A2D
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650467841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tawPnIWWjQdoIazhl+r2801d/l1EXFGE8jMsnLNAlno=;
        b=bK1QPixNmnaVUm700PqFoV5qM4sXIHl7/U/Ocj3C/f/t2LMsjqXnXPm8jYBRCI60qjuPJ3
        hFLOF/y9lQ6T+0pPhonp9Ks4U4TDFYD422tWo0OrmxhfaxuKomNFR61FHWRJQiyN19rlQ4
        FgX8GQuSx9N7dZ71Kh0hNQLGx/W3Kww=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-uFA5pO5lMjaUveMUI0AG0w-1; Wed, 20 Apr 2022 11:17:20 -0400
X-MC-Unique: uFA5pO5lMjaUveMUI0AG0w-1
Received: by mail-qk1-f199.google.com with SMTP id x8-20020a05620a0ec800b0069ed368e475so1426841qkm.12
        for <linux-hardening@vger.kernel.org>; Wed, 20 Apr 2022 08:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tawPnIWWjQdoIazhl+r2801d/l1EXFGE8jMsnLNAlno=;
        b=Ujmejpq0q+T38+OLEmMzS6zf8elGRKkLx2b/U+Jf0w7vamOcsGpMajJKQ/q1DwY+0g
         pc8Gsb9FjewKRQ+2av/Ax24Q4TZXFNj1OB4FQxj0PHto3TyIa/T/RkDKiGHM4NCG2JtZ
         KYEqAe4Gcb1n29VojVcoqLKW1ZZwRuYRSKCF5lLZQiJ796TzQd6ua8qjgD0RPLzqARUQ
         ITEdDiEF7kiBvczQLLnRSjzWRBGWVMBTrxXMSk7e7q6qS7IXfuGcp1O2xCI28YUvmhpz
         D6nu5++7QARRVSWKVYtzwvcU2p+JiqWR0x4Oga+4E3eJv4FvihQBsoiiW1sR2ZxdXUN2
         buwA==
X-Gm-Message-State: AOAM530MsqBfjw8/wYcH36ppjZPfOjOhe7AN/OJpuOFIIFIFUfOG3S6N
        9bRNZSOYS420Ue4a4Ok2bToosGVNwENxnTXxMYXOcp9iUTrgIStd7pYCzoSh+sT5Qyi4dT9S6YC
        qwdD7xXUkJPINRFoe0TTTwAx8gD/Z
X-Received: by 2002:a37:b484:0:b0:69b:db47:69a8 with SMTP id d126-20020a37b484000000b0069bdb4769a8mr13172015qkf.460.1650467838560;
        Wed, 20 Apr 2022 08:17:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9Jr9LQASoZCUHBuMXCR9K/qCqPf0fDTpqGvGKtTblfg7LphaYZ397Zrar7j6Rf9EQRb7i+g==
X-Received: by 2002:a37:b484:0:b0:69b:db47:69a8 with SMTP id d126-20020a37b484000000b0069bdb4769a8mr13172004qkf.460.1650467838326;
        Wed, 20 Apr 2022 08:17:18 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id bm1-20020a05620a198100b0047bf910892bsm1767274qkb.65.2022.04.20.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:17:17 -0700 (PDT)
Date:   Wed, 20 Apr 2022 08:17:14 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     joao@overdrivepizza.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, andrew.cooper3@citrix.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
Message-ID: <20220420151714.fderdz4dzea75rvg@treble>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20220420074044.GC2731@worktop.programming.kicks-ass.net>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Apr 20, 2022 at 09:40:44AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 19, 2022 at 05:42:30PM -0700, joao@overdrivepizza.com wrote:
> > @PeterZ @JoshP
> > 
> > I'm a bit unaware of the details on why the objtool approach to bypass ENDBRs
> > was removed from the IBT series. Is this approach now sensible considering that
> > it is a requirement for a new/enhanced feature? If not, how extending the Linker
> > to emit already fixed offsets sounds like?
> 
> Josh hates objtool modifying actualy code. He much prefers objtool only
> emits out of band data.
> 
> Now, I did sneak in that jump_label nop'ing, and necessity (broken
> compilers) had us do the KCOV nop'ing in noinstr, but if you look at the
> recent objtool series here:
> 
>   https://lkml.kernel.org/r/cover.1650300597.git.jpoimboe@redhat.com
> 
> you'll see his thoughs on that :-)
> 
> Now, I obviously don't mind, it's easy enough to figure out what objtool
> actually does with something like:
> 
>   $ OBJTOOL_ARGS="--backup" make O=ibt-build/ -j$lots vmlinux
>   $ objdiff.sh ibt-build/vmlinux.o
> 
> Where objdiff.sh is the below crummy script.
> 
> Now, one compromise that I did get out of Josh was that he objected less
> to rewriting relocations than to rewriting the immediates. From my
> testing the relocations got us the vast majority of direct call sites,
> very few are immediates.
> 
> Josh, any way you might reconsider all that? :-)

If I remember correctly, the goal of --ibt-fix-direct was to avoid
hitting unnecessary ENDBRs, which basically decode to NOPs, so the
ghastly hack wasn't worth it.

If FineIBT needs it, I could reconsider.  But I think there's a strong
case to be made that the linker should be doing that instead.

-- 
Josh

