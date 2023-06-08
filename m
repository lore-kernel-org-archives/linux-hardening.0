Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3131C7EE29
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Jun 2023 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjFHQYT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Jun 2023 12:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjFHQYC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Jun 2023 12:24:02 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F63AAE;
        Thu,  8 Jun 2023 09:23:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2D0DD605DED7;
        Thu,  8 Jun 2023 18:23:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zpbvNb15rfCI; Thu,  8 Jun 2023 18:23:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 306FB6081100;
        Thu,  8 Jun 2023 18:23:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xSVgNBinm5pl; Thu,  8 Jun 2023 18:23:33 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id ED077605DED7;
        Thu,  8 Jun 2023 18:23:32 +0200 (CEST)
Date:   Thu, 8 Jun 2023 18:23:32 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        davem <davem@davemloft.net>, edumazet <edumazet@google.com>,
        kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Message-ID: <447684945.3699459.1686241412894.JavaMail.zimbra@nod.at>
In-Reply-To: <2023060820-atom-doorstep-9442@gregkh>
References: <20230607223755.1610-1-richard@nod.at> <202306071634.51BBAFD14@keescook> <ZIHzbBXlxEz6As9N@alley> <2023060820-atom-doorstep-9442@gregkh>
Subject: Re: [RFC PATCH 0/1] Integer overflows while scanning for integers
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Integer overflows while scanning for integers
Thread-Index: 8Ta4XA3Xj4SCOt1cjsjdEFB0STxIxQ==
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
> "some users" == "most major cloud providers and a few billion Android
> phones"  So in pure numbers, the huge majority of Linux systems running
> in the world have that option enabled.
> 
> So please don't use WARN() to catch issues that can be triggered by
> userspace, that can cause data loss and worse at times.

Sorry for being unclear. My goal is not having the WARN patch immediately
applied without fixing known call sites which can trigger it.

Thanks,
//richard
