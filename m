Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C37C7EE25
	for <linux-hardening@archiver.kernel.org>; Fri,  9 Jun 2023 10:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbjFIKTD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Jun 2023 06:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241207AbjFIKSG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Jun 2023 06:18:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2E4EE6
        for <linux-hardening@vger.kernel.org>; Fri,  9 Jun 2023 03:10:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977d0ee1736so245430966b.0
        for <linux-hardening@vger.kernel.org>; Fri, 09 Jun 2023 03:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1686305434; x=1688897434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yS2aUgQCzMJ3EO5DLspaLc27pVQAPYGHdTdZhOt/Qbc=;
        b=i2R6OiNWJ812k7tEk8MFgXVAEgzGq9TX2uVlV/DmnnzCo8uf5O+u8PxJYF1fmmW7ge
         DiRg2DwX53b52ttYYql5uFw75qFj+mLMxZ1DBtC+j2Pp0/SnDniJ7txxwQbUhs340fZk
         3ogQVRYEmLTJypVD47DipsPJixUqtHjbgHr64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686305434; x=1688897434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yS2aUgQCzMJ3EO5DLspaLc27pVQAPYGHdTdZhOt/Qbc=;
        b=MO0MZ9R7b/vxnWYH4x+vCUxDQcj3ZZ99+NkxbCE3jXGHat37cYhEvgastw7S1WNsXe
         xcUtvoZ5BMDomJ964kIi4eULVigIbgGSdlrqvnBe21gBuC60jKdwymzmeg0ofECw6wbn
         K7e84NS1NX4WTb0B7X484xcmV/CkQEOzpMWC3YvQ+4gpcnVV4hmQV6nMXkNgsAo9mYqe
         la0mUxPuNUzqUDG0qMCSmL33cVGEKv3tuGrGP1VmX3S8U2iQaHqXCd0qvYQWtFUJV4Mc
         3QNOl+RXSBIuzpogmvtLJCC/CcpNqwZ7RCMxTg14KzHpwge8+KhcuFozIfDpiId2WDfJ
         7lrg==
X-Gm-Message-State: AC+VfDw3x2XN8owvF+p8he0zRJzbElGa493nfbvt6lA2ttdSRUpAhzxW
        +9m1j/xaVbZZLcGeGgCo37gSrw==
X-Google-Smtp-Source: ACHHUZ5Fe46ETKwHMoSP+LQWs15Qfo6lZe1H4HUoEyej75n5s0+5nCJkv8ITV8euuQFu5SOXfMwVqw==
X-Received: by 2002:a17:907:86a3:b0:974:5403:ebb with SMTP id qa35-20020a17090786a300b0097454030ebbmr1057697ejc.54.1686305433918;
        Fri, 09 Jun 2023 03:10:33 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b00977eec5bb2csm1088059ejb.156.2023.06.09.03.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 03:10:33 -0700 (PDT)
Message-ID: <9cd596d9-0ecb-29fc-fe18-f19b86a5ba44@rasmusvillemoes.dk>
Date:   Fri, 9 Jun 2023 12:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 0/1] Integer overflows while scanning for integers
Content-Language: en-US, da
To:     Petr Mladek <pmladek@suse.com>, Kees Cook <keescook@chromium.org>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20230607223755.1610-1-richard@nod.at>
 <202306071634.51BBAFD14@keescook> <ZIHzbBXlxEz6As9N@alley>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZIHzbBXlxEz6As9N@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 08/06/2023 17.27, Petr Mladek wrote:
> On Wed 2023-06-07 16:36:12, Kees Cook wrote:

> It seems that userspace implementation of sscanf() and vsscanf()
> returns -ERANGE in this case. It might be a reasonable solution.

Well. _Some_ userspace implementation does that. It's not in POSIX.
While "man scanf" lists that ERANGE error, it also explicitly says that:

CONFORMING TO
       The functions fscanf(), scanf(), and sscanf() conform to C89 and
C99 and POSIX.1-2001.  These standards do  not  specify  the
       ERANGE error.

I can't figure out what POSIX actually says should or could happen with
sscanf("99999999999999", "%i", &x);


> Well, there is a risk of introducing security problems. The error
> value might cause an underflow/overflow when the caller does not expect
> a negative value.

There is absolutely no way we can start letting sscanf() return a
negative err value, in exactly the same way we cannot possibly let
vsnprintf() do that. We can stop early, possibly with a WARNing if it's
the format string we're unhappy about ('cause that should be
compile-time constant or, e.g. in the netdevice name case, carefully
checked by the caller) and return "number of succesful conversions so
far" (scanf) / "number of bytes written to buffer" (printf).

> Alternative solution would be to update the "ip" code so that it
> reads the number separately and treat zero return value as
> -EINVAL.

The netdev naming code _could_ be updated to just not use scanf at all
or the bitmap of in-use numbers, just do the "sprintf(buf, fmt, i)" in a
loop and stop when the name is not in use. That's a win as long as there
are less than ~256 names already matching the pattern, but the
performance absolutely tanks if there are many more than that. So I
won't actually suggest that.

Rasmus

