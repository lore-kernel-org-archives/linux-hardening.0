Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C5CEB64D9
	for <linux-hardening@archiver.kernel.org>; Fri,  7 Jul 2023 20:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGGUzj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jul 2023 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGGUzi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jul 2023 16:55:38 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46C2128
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P9IQXAgNwVfFxyS8Q6JnffV3W9POWffXwQc1bkN3M6g=; b=kBNc+p5BJ9ahXTjr3knANvxEUR
        0SV8xrF1PgqAw0FlgGmOg0FCYVAeOVUXHWQyqOG83auqUD6I9taeRHIXtrk4ZXABcajVED5eEEirB
        i8pnRcbtJ5jG2Nvxn9v3m2dGGz/EgNMkIwIeVeovtLO2GZ6iMB1f+HxriFnrCNxMf/NAVtKcea7ew
        d49DkXnoVg2AMTEHncD1wgAEOfI8H7WhFij5TcUcwnR4LT+OSJvz0vYRtUm4KIrYIHEgRW7K/JtpH
        Uh7RD5da9Rmr9pDEpWnWe+lrLA/Hbaozffk7zd1614P7bGW/Aujb8BzZTHyJJgy9C1EaAHxZMPmLp
        bVUEg1Dw==;
Received: from [191.205.188.225] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1qHsUF-00AMJG-Hr; Fri, 07 Jul 2023 22:55:31 +0200
Message-ID: <3123ba6b-b2ca-b181-7f0c-77d9b82e0671@igalia.com>
Date:   Fri, 7 Jul 2023 17:55:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/2] pstore: Replace crypto API compression with zlib
 calls
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-hardening@vger.kernel.org
References: <20230707083456.2501913-1-ardb@kernel.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230707083456.2501913-1-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 07/07/2023 05:34, Ard Biesheuvel wrote:
> The pstore layer implements support for compression of kernel log
> output, using a variety of compression algorithms provided by the
> [deprecated] crypto API 'comp' interface.
> 
> This appears to have been somebody's pet project rather than a solution
> to a real problem: the original deflate compression is reasonably fast,
> compresses well and is comparatively small in terms of code footprint,
> and so the flexibility that the crypto API integration provides does
> little more than complicate the code for no reason.
> 
> So let's get rid of this complexity, and switch back to zlib deflate
> using the library interface.
> 
> Changes since v1:
> - add missing vfree() of zlib compression workspace
> - implement improvements and simplifications suggested by Eric
> - add missing zlib_in/deflateEnd() calls
> - add code comment to document that the use of a library interface is
>   deliberate, and doesn't require a future 'upgrade' to the crypto API
> [...]

Thanks a lot Ard/Kees, quite a great improvement! I've tested on top of
6.4.0 in the Steam Deck and it's working perfectly fine - no noticeable
extra delay in the log collecting during panic compared to zstd.

Feel free to add (to the series):
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck

Cheers,


Guilherme
