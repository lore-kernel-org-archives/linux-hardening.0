Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E80DC77B7A
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Jun 2023 23:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjFGXgQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjFGXgP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Jun 2023 19:36:15 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A92694
        for <linux-hardening@vger.kernel.org>; Wed,  7 Jun 2023 16:36:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d18d772bdso8775637b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 07 Jun 2023 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686180974; x=1688772974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bV+QBIRbd/x+WNmZHSjuCVNmS4EwLkVhDD4/QF5LwNk=;
        b=Ik88XCvI4hJ6a3p3dYxnf2+7ZugbODinVbcRE5BytxNEbbTTldgODWhxxfct3EDVl8
         OHla4HcW9Z0Xx9GrUV7HeHYZy4Ubu4XBdf3+GlqLzUfIZinEk8Nlf20AxB9Lvu8ugH2V
         NZbQ9Drkx0s7//LQf/au6HjQpueXauTefGqw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686180974; x=1688772974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV+QBIRbd/x+WNmZHSjuCVNmS4EwLkVhDD4/QF5LwNk=;
        b=OTUvn0Bff3RhSsmXL/Yc0oWjus4THNHSQbV3gLKhxcqwkLFq37Ifllyae1b7fPFO56
         jveFswRwyDo7lTmjro0tBUmcTmYTp5c7OMzc76l3xl9+wyKWkx1bz5Ge0RjHgea3hX4o
         suul5KTYE2CpR8/EHN7+NezjO/gG5A7kvqpYa5TlhWJqb6+6E78v9wU/aiI9KVMHsxl/
         RVw6Plz4EeM1+Li3sdBCKoSxNKnkjoJGEGC0iejiKuTGu8/te7WYiQFa6eOCbT7rnptZ
         SmMknUcYWZljFr6rV6vzNre46ecr8VxhlJzzA47S8/lVoRC1ST1Mx1vFuBYQY9FuXmf6
         MX0g==
X-Gm-Message-State: AC+VfDxyK8lm6SkFIjEYin81TwVCoOL+ikx0t9NOTfMUOXHR9xmJHaE/
        T39z0rnTjJLRPe9YNzQEggNFGg==
X-Google-Smtp-Source: ACHHUZ6rM0obypKwIxMkqC6ngq19+vr+asPTcSbdh7AN6aPYahbXFRlUpWTXGYmkl8ptSbEvkESl+A==
X-Received: by 2002:a05:6a20:4c8:b0:110:9b0b:71b6 with SMTP id 8-20020a056a2004c800b001109b0b71b6mr3691768pzd.37.1686180973830;
        Wed, 07 Jun 2023 16:36:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78152000000b00640e64aa9b7sm9148225pfn.10.2023.06.07.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:36:12 -0700 (PDT)
Date:   Wed, 7 Jun 2023 16:36:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC PATCH 0/1] Integer overflows while scanning for integers
Message-ID: <202306071634.51BBAFD14@keescook>
References: <20230607223755.1610-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607223755.1610-1-richard@nod.at>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 08, 2023 at 12:37:54AM +0200, Richard Weinberger wrote:
> Hi!
> 
> Lately I wondered whether users of integer scanning functions check
> for overflows.
> To detect such overflows around scanf I came up with the following
> patch. It simply triggers a WARN_ON_ONCE() upon an overflow.
> 
> After digging into various scanf users I found that the network device
> naming code can trigger an overflow.
> 
> e.g:
> $ ip link add 1 type veth peer name 9999999999
> $ ip link set name "%d" dev 1
> 
> It will trigger the following WARN_ON_ONCE():
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 433 at lib/vsprintf.c:3701 vsscanf+0x6ce/0x990

Hm, it's considered a bug if a WARN or BUG can be reached from
userspace, so this probably needs to be rearranged (or callers fixed).
Do we need to change the scanf API for sane use inside the kernel?

-Kees

-- 
Kees Cook
