Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845CDC433FE
	for <linux-hardening@archiver.kernel.org>; Wed,  4 May 2022 17:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346834AbiEDRga (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 May 2022 13:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359300AbiEDRf4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 May 2022 13:35:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9FB51590
        for <linux-hardening@vger.kernel.org>; Wed,  4 May 2022 10:04:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p6so1430166plr.12
        for <linux-hardening@vger.kernel.org>; Wed, 04 May 2022 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uj6YMBCZWAjWY8ro19VauUXc0fzSyeDEeGTwnyspmvk=;
        b=jFw/YtuAuY8zOu6CBZwrP8/qTS38T5FgjRy6M7i4aX08fnI6fVbU4nJp+GZWb2X/Oi
         5jA20ZVdF1pc2KkJPGk1ZQI0ASmLV2xvybvi+wq5eEX1tHfMhwWyCaaMegbUUXPvCMid
         XmP2uUvXaBb+17kdYgA8aF5HDIHfLFUmZvBEQbJmOVOQFNnEjIWtfcTF/0h2q0y9h7xv
         etMVkh8gaL5cLlgEAODxlKfUa9G8mG51A5Nu5ItKpNLHd9AyJ6QmM+CijTcIlU/TJt8/
         yDHWs26N40Nz6YMgWLFMJQ+5fI/lH5MVmOp0CMxNNdVYu/al9dbglBGJTaQ5ewqoYy9v
         J2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uj6YMBCZWAjWY8ro19VauUXc0fzSyeDEeGTwnyspmvk=;
        b=2go6zI+/Oi36KPV0dwJjDdHOatMNnP/3BYmEpAesbFbhwbiGISyEhxltIiJyfs2Xqh
         sVVuEA0j/5kr1kuqFPs0MAxCqHptrhQN9F0qqA6pJJFFCcEezTnanmWE30a6JMyydnOu
         Y4t7y7yOBllWatkG5ua1Ib9d8Iib46X1egCj0lQScxqxUGBOT4gxw4z35vZAaCAPQ3k4
         C1ujLVu4vJ21kvtVQWMAkdYVaaeU+hFPMX//5iAIvWg10nmiXLWHXYsR8mUJbNKkLWBv
         1Q4Wd1Cr4L8HosEV4B/Rh8IzXRHRYAOK08RW35rTlhbfhsUH/pWn/l3zY0WPHhRomF2w
         bLuw==
X-Gm-Message-State: AOAM530gqdjFPFUBVJvnppzFH4l3GUpD2v5GuK5R9TxGA3mNrdjksFI6
        3u77BVLzUyuRE4QiaYRldZNQ/A==
X-Google-Smtp-Source: ABdhPJwQhJX1Wntu7nztS9/CKxmjFCDWW3e5W7Ktqn6IS03XXkrCVf3vv40N8CYVtf+Hw6G24CphUQ==
X-Received: by 2002:a17:90b:1bc3:b0:1dc:61fd:7ea4 with SMTP id oa3-20020a17090b1bc300b001dc61fd7ea4mr473665pjb.31.1651683852263;
        Wed, 04 May 2022 10:04:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c1b7:7a5:89b8:a6c6])
        by smtp.gmail.com with ESMTPSA id t9-20020a17090340c900b0015e8d4eb222sm8437874pld.108.2022.05.04.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:04:11 -0700 (PDT)
Date:   Wed, 4 May 2022 10:04:02 -0700
From:   Peter Collingbourne <pcc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 01/11] x86: kernel FineIBT
Message-ID: <YnKx5a9WvJ1UhWPm@google.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420004241.2093-2-joao@overdrivepizza.com>
 <20220429013704.4n4lmadpstdioe7a@treble>
 <d82459b887bcaf9181ad836051e2d16b@overdrivepizza.com>
 <20220503220244.vyz5flk3gg3y6rbw@treble>
 <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnJTYzralOhGGmED@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, May 04, 2022 at 12:20:19PM +0200, Peter Zijlstra wrote:
> On Tue, May 03, 2022 at 03:02:44PM -0700, Josh Poimboeuf wrote:
> 
> > I'm not really qualified to comment on this too directly since I haven't
> > looked very much at the variations on FineIBT/CFI/KCFI, and what the
> > protections and drawbacks are for each approach, and when it might even
> > make sense to combine them for a "paranoid user".
> > 
> > Since we have multiple similar and possibly competing technologies being
> > discussed, one thing I do want to warn against is that we as kernel
> > developers tend to err on the side of giving people too many choices and
> > combinations which *never* get used.
> 
> So I don't think there's going to be a user choice here. If there's
> hardware support, FineIBT makes more sense. That also means that kCFI no
> longer needs to worry about IBT.
> 
> If we do something like:
> 
> 
>         kCFI                                            FineIBT
> 
> __cfi_\sym:                                     __cfi_\sym:
>         endbr                           # 4             endbr                   # 4
>         sub $hash, %r10                 # 7             sub $hash, %r10         # 7
>         je \sym                         # 2             je \sym                 # 2
>         ud2                             # 2             ud2                     # 2
> \sym:                                           \sym:
> 
> 
> caller:                                         caller:
>         cmpl $hash, -8(%r11)            # 8             movl $hash, %r10d       # 6
>         je 1f                           # 2             sub 15, %r11            # 4
>         ud2                             # 2             call *%r11              # 3
> 1:      call __x86_indirect_thunk_r11   # 5             .nop 4                  # 4 (could even fix up r11 again)
> 
> 
> Then, all that's required is a slight tweak to apply_retpolines() to
> rewrite a little more text.
> 
> Note that this also does away with having to fix up the linker, since
> all direct call will already point at \sym. It's just the IBT indirect
> calls that need to frob the pointer in order to hit the ENDBR.
> 
> On top of that, we no longer have to special case the objtool
> instruction decoder, the prelude are proper instructions now.

For kCFI this brings back the gadget problem that I mentioned here:
https://lore.kernel.org/all/Yh7fLRYl8KgMcOe5@google.com/

because the hash at the call site is 8 bytes before the call
instruction.

Peter
