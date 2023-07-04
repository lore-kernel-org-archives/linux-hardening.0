Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E6BEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 18:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjGDSaj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDSaj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 14:30:39 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D544010CA
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Dbugfi/kBFY/gFWCmpuNINGvrJ8ajP8rNSYYi9L8gvA=; b=iA+g3F+YoQQnFjMEEXvuQX/R7X
        8ZNTTB1X69QG7jQY+sH1If3s5LngsQrLDwGwvZYylPu7wuF5l0Rtn3zQUjzwfl+5Whi8h4SBLUTyB
        6kGZ0OXRyKt5J4MeO/hLQUnu+VP2TZq3d3mk1vhUa5kAdR/XkJZuJXGHGprnjORhuOUbiVctcstst
        GOvSllM0xmO8nTGoV2IyBE12cisMW4F6nGZqL5xvVNOTpHwNTo73Vj2urGYDQiW+A/XpQmknQmWY6
        vQ3lm+0ogTbmgMY59KwEmufrhX0eLrZnmFpcVE+1M41aen8/YV9BlWFiecdCL/3TXsuX5B8IU4Djo
        8ZdaYOow==;
Received: from [191.205.188.225] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qGknI-008LaM-Qq; Tue, 04 Jul 2023 20:30:33 +0200
Message-ID: <562d104e-a86b-b668-2d2c-06687304f705@igalia.com>
Date:   Tue, 4 Jul 2023 15:30:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] pstore: Replace crypto API compression with zlib
 calls
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
References: <20230704135211.2471371-1-ardb@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230704135211.2471371-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 04/07/2023 10:52, Ard Biesheuvel wrote:
> The pstore layer implements support for compression of kernel log
> output, using a variety of compressions algorithms provided by the
> [deprecated] crypto API 'comp' interface.
> 
> This appears to have been somebody's pet project rather than a solution
> to a real problem: the original deflate compression is reasonably fast,
> compressed well and is comparatively small in terms of code footprint,
> and so the flexibility that the crypto API integration provides does
> little more than complicate the code for no reason.
> 
> So let's get rid of this complexity, and switch back to zlib deflate
> using the library interface.

Thanks Ard, very nice stuff - makes total sense for me!

I'll test it in the Steam Deck - waiting a V2 (since there are some code
comments from Eric and Kees).

Cheers,


Guilherme
