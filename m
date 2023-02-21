Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A9AC61DA3
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Feb 2023 19:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBUTtG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBUTtF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Feb 2023 14:49:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02F42D46;
        Tue, 21 Feb 2023 11:49:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA986119A;
        Tue, 21 Feb 2023 19:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FCFC433EF;
        Tue, 21 Feb 2023 19:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677008943;
        bh=RupYw2DGR5V306vxxYF2YLT8KFlxHxLPTkxqfdOg4gA=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=rtj4TWz4tw8KQOaANUPD4QAcyVf8cMOEtBOlk0RoMFLej/IVe9dW/etu+1jWqART7
         EcaCQu0LSkFsJ9Rjc30+4RoVuRdaQPQ9uRM2EVNrxHN8u2D8l3oRwwZyZkJ/xwTKxN
         Rb+f9iZ6GfhOlky5+V/bw0461ETn+85p3fzx5Scv3cMDJoLzHKZnAGq1RcoOjqeRzI
         DLENNP2bKQfkRiGnl0iuFSpotMukYQ3qCCbkF0k7SRiZCCs+uyXfhfmIuiDDPMAu/X
         m984Lb1QnQk+3Emni6IEaNnaRLQ6YvhRa+zoewb4QDrmWBSunYEr12L3AavYWxYSfV
         ZMcW78LArfl1g==
Date:   Tue, 21 Feb 2023 11:49:00 -0800
From:   Kees Cook <kees@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
CC:     linux-kernel@vger.kernel.org,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Sam James <sam@gentoo.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] hardening updates for v6.3-rc1
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgw++ccN-Pd1npZsBSDD3z6EGUSKsWuAEh5YC-TmfJAug@mail.gmail.com>
References: <63efd7ab.170a0220.3442b.6609@mx.google.com> <CAHk-=wgw++ccN-Pd1npZsBSDD3z6EGUSKsWuAEh5YC-TmfJAug@mail.gmail.com>
Message-ID: <F522EBF9-9BB9-4258-B614-1BB87455B4F5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On February 21, 2023 11:16:33 AM PST, Linus Torvalds <torvalds@linux-founda=
tion=2Eorg> wrote:
>On Fri, Feb 17, 2023 at 11:38 AM Kees Cook <keescook@chromium=2Eorg> wrot=
e:
>>
>> Please pull these hardening updates for v6=2E3-rc1=2E
>
>So I've pulled this, but while looking at it, I see commit
>5c0f220e1b2d ("Merge branch 'for-linus/hardening' into
>for-next/hardening")=2E
>
>And that one-liner shortlog part is literally the whole commit message=2E
>
>I've said this before, and apparently I need to say this again: if you
>cannot be bothered to explain *WHY* a merge exists, then that merge is
>buggy garbage by definition=2E

Okay, understood=2E This was a merge of the fixes for v6=2E2=2E I'll expla=
in that more clearly in the log from now on=2E :)

-Kees


--=20
Kees Cook
