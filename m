Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDEDEB64D9
	for <linux-hardening@archiver.kernel.org>; Tue,  4 Jul 2023 16:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGDQIQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjGDQIP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 Jul 2023 12:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB25E7A
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 09:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E48A612F0
        for <linux-hardening@vger.kernel.org>; Tue,  4 Jul 2023 16:08:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D738DC433C7;
        Tue,  4 Jul 2023 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688486893;
        bh=kDSRyRwIyyhudeuBtm/F3rADHi/tu1GxmaBbtqg6qBI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ZZcQ4djFfAgiVzo0Q9MEqHpLfBVyzPUMTBhR+m86dFKY22z0laxUiJWjoToYtBGN1
         Ihu+APRyqCWg1RxRZGSmzOaaabH2BkTxtfN4N8dkDGf37VkG9p2le1kESRUT82cjV8
         7yY86mSOifqn1XBailDVsA6g3UUuBe9bNW6MwAL2KHeODfQCpaI/6/C91w6sAb/w74
         Y6AYsGC4i5bEXaYAvE+Olg6sGTn59PKvXSQm0w/ei5HPY2qoo5suKffgMOzxFqvt3p
         itvT7Evqawh9XLwRI5DfRiOh1zNDtONUPWd66tKuot8nGUTtVHKJ+W/7bKGhzfHfXW
         zYFP/qeQw0sDQ==
Date:   Tue, 04 Jul 2023 09:08:03 -0700
From:   Kees Cook <kees@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org
CC:     Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_pstore=3A_Replace_cry?= =?US-ASCII?Q?pto_API_compression_with_zlib_calls?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230704135211.2471371-1-ardb@kernel.org>
References: <20230704135211.2471371-1-ardb@kernel.org>
Message-ID: <817D6DDD-EF26-492E-B411-295B9538DF54@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On July 4, 2023 6:52:09 AM PDT, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>The pstore layer implements support for compression of kernel log
>output, using a variety of compressions algorithms provided by the
>[deprecated] crypto API 'comp' interface=2E
>
>This appears to have been somebody's pet project rather than a solution
>to a real problem: the original deflate compression is reasonably fast,
>compressed well and is comparatively small in terms of code footprint,
>and so the flexibility that the crypto API integration provides does
>little more than complicate the code for no reason=2E
>
>So let's get rid of this complexity, and switch back to zlib deflate
>using the library interface=2E
>
>Cc: Kees Cook <keescook@chromium=2Eorg>
>Cc: "Guilherme G=2E Piccoli" <gpiccoli@igalia=2Ecom>

Thanks for picking this back up, it had fallen down on my to-do list=2E :)

>
>Ard Biesheuvel (1):
>  pstore: Replace crypto API compression with zlib_deflate library calls
>
>Kees Cook (1):
>  pstore: Remove worst-case compression size logic
>
> fs/pstore/Kconfig    | 100 +-------
> fs/pstore/platform=2Ec | 249 +++++---------------
> 2 files changed, 72 insertions(+), 277 deletions(-)

My favorite kind of patch ratio! :)


--=20
Kees Cook
