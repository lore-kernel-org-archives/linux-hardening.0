Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EABC43334
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Jun 2022 19:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiFPTTS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiFPTTR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Jun 2022 15:19:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AD55350
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 12:19:17 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h23so4516872ejj.12
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpcGuEMSHNtJO6AL8yUFZTbd1w1Zp8LDaZt4zG7HQg8=;
        b=egGfdeT+mpO40XdFqHUt/mNRkwROuAaGPwmvBbc9V8CKQtgzMIeJ5dydpj2F6YqAWD
         jWaLyXMYcKZAUkbCHTdiuA4JkddfCRJMKfg3Rr2z7QYsJo+0kuIs2gL8w23PGhI7/UU1
         zp0PY/UWDuWBbGaf5HZQqxyladpYTQRU+gj7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpcGuEMSHNtJO6AL8yUFZTbd1w1Zp8LDaZt4zG7HQg8=;
        b=QkRVuxIQ/6jh1fk8MGSj8iGhq6lmJZTN9l6expEXndUQA/pJtQXtNMtCFjQQ2eHR3j
         5Fte1JofCvv/9P7f/kTzU/9Y1s/lEM+QJJRk8inuuzOezOd9584pTij4jZhseB1B82FV
         c/APUAEPyc/RnGYdFitVjPIsoMnjlmRQRV5TKshi/yp2Nt3VgPblJO4e/jmIZm+zy4RE
         jfVXBmXushMZwx5ztS/Fcwxbd8VwBbpzOYcE6KKp/g7Y38WzG95qY6Pl8Cqa3YtkdXOG
         /YyIZlPIauN5+nHbPzHEpuAJt4AMn6w/Vof7lTPq4sAYnE0xIhCNxoFEj92jP2YPXpWY
         NWRQ==
X-Gm-Message-State: AJIora+pAp5fLp3wyXBuwi75BJVF/SS9L8ZAO2YnvF7/2uyOJiGHd1qA
        p7foyS3u7xo+nhbIUkPi5y7HSHSf4SNlF/hC
X-Google-Smtp-Source: AGRyM1uWgkLSTjEFCsWjgspabsxXP68V857mw7BRW0JRH5Ep6ocwSSjcz1qOBwkmtKdttZQyp73iag==
X-Received: by 2002:a17:907:2d92:b0:711:d229:4b7f with SMTP id gt18-20020a1709072d9200b00711d2294b7fmr5806714ejc.506.1655407155324;
        Thu, 16 Jun 2022 12:19:15 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906600700b006fe8ec44461sm1135885ejj.101.2022.06.16.12.19.14
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 12:19:14 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id x17so3058075wrg.6
        for <linux-hardening@vger.kernel.org>; Thu, 16 Jun 2022 12:19:14 -0700 (PDT)
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id
 10-20020a5d47aa000000b002185ac8f3a8mr6159072wrb.442.1655407153820; Thu, 16
 Jun 2022 12:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220616143617.449094-1-Jason@zx2c4.com> <YqtAShjjo1zC6EgO@casper.infradead.org>
 <YqtDXPWdFQ/fqgDo@zx2c4.com> <YqtKjAZRPBVjlE8S@casper.infradead.org>
 <CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com>
 <Yqtd6hTS52mbb9+q@casper.infradead.org> <CAHk-=wj_K2MnhC6N_LyY6ezmQyWzqBnfobXC354HJuKdqMePzA@mail.gmail.com>
 <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
In-Reply-To: <CAHk-=whS3xhJ=quD5bzDb6JsAhKd0vem4K-U=DhUGf-tDJUMHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Jun 2022 12:18:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi28vwsG-JNJEz_kc=qwPkYtYfh_14eHOUZsaGESDBDBA@mail.gmail.com>
Message-ID: <CAHk-=wi28vwsG-JNJEz_kc=qwPkYtYfh_14eHOUZsaGESDBDBA@mail.gmail.com>
Subject: Re: [PATCH] usercopy: use unsigned long instead of uintptr_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 16, 2022 at 12:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In that situation, we'd probably just see "long long" being 128-bit
> ("I32LP64LL128").

Looking around, it looks like people prefer "long long long" (or in
the kernel, just "u128") for this, because so many have already gotten
used to "long long" being 64-bit, and 32-bit architectures (where
"long" is 32-bit and "long long" is 64-bit) are still relevant enough
that people want to keep that.

             Linus
