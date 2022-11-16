Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C835C43217
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Nov 2022 16:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiKPQA5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiKPQA4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Nov 2022 11:00:56 -0500
X-Greylist: delayed 1069 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 08:00:54 PST
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4DE532CB
        for <linux-hardening@vger.kernel.org>; Wed, 16 Nov 2022 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uEp/AYkOd3P719eDIHWqZuulyir5i1Y+id7NNquZ33c=; b=pPb8Ko9dW6Kdj5ISZbtKCX2+86
        B9C6znqczRS8yDXYJfUYM8TH7FUzpqjn/69Yj1uFbALnKzxVb5xCOYWys/eZo4ayiyw/1BIl6fL3C
        Exce9kf7emcEPCntrEnuOpT6AAk4wkDHQ8RpwJ5eSgD7gYibaiymbGrZjP8zz5mekjeotaJ6ECG0l
        bnqoFYB3KVW6GKGUCgvche4ZVXK6joAzbO4nVJIVmd7G0aZ4+bt7Ktly7RyY6oYUMkBYbzwCy07y2
        TXERWWdFUBjvcT4y4Zuiq/ToetD7p2NSXDJz02bNw0CO9T9MmnICxFHUqhROl1IaAuWT0/MOq9F4A
        g6mSQ7Wg==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ovKZ0-001q51-Mu; Wed, 16 Nov 2022 16:42:58 +0100
Message-ID: <542aa83d-6227-ea7d-2150-a74293cbf59a@igalia.com>
Date:   Wed, 16 Nov 2022 12:42:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 5/5] MAINTAINERS: Update pstore maintainers
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-6-keescook@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221011200112.731334-6-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11/10/2022 17:01, Kees Cook wrote:
> Update pstore to better reflect reality of active contributors:
> 
> - Remove Anton and Colin (thank you for your help through the years!)
> - Move Tony to Reviewer
> - Add Guilherme as Reviewer
> - Add mailing list
> - Upgrade to Supported
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  MAINTAINERS | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Hi Kees, sorry to revamp this thread for a "tangential" topic, but it
feels a "kinda" proper thread.

Since I was added as a reviewer on pstore (in linux-next so far), I
started to receive a bunch of emails from ARM device-tree folks; they're
adding ramoops entries to their DTs and looping pstore folks.

Examples:

https://lore.kernel.org/linux-hardening/20221111120156.48040-1-angelogioacchino.delregno@collabora.com/

https://lore.kernel.org/linux-hardening/20221116145616.17884-1-luca@z3ntu.xyz/


Personally, I have no knowledge of these HW to evaluate if the ramoops
setting is appropriate, so they're nop from my side, I just delete them.
But that raises the question - are you/Tony reviewing this kind of
change? It's not related to pstore/ramoops code, it's just users setting
ramoops in their DTs, so seems to me a bit far from the purpose of the
pstore entry.

What do you/Tony think about that? Likely the DT folks are following
this entry in the MAINTAINERS to send these emails:

PSTORE FILESYSTEM
M:      Kees Cook <keescook@chromium.org>
[...]
F:      include/linux/pstore*
K:      \b(pstore|ramoops) <------

Should this be kept? Maybe only the ramoops entry could be removed?

Again, totally fine be me to keep'em, it's just that I'm receiving and
ignoring the emails, so if everybody else is doing the same, better to
just remove this entry from MAINTAINERS.

Thanks,


Guilherme
