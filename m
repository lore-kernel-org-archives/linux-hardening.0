Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701FAEB64DD
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Jul 2023 06:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjGMG7m (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Jul 2023 02:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjGMG7l (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Jul 2023 02:59:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA32119
        for <linux-hardening@vger.kernel.org>; Wed, 12 Jul 2023 23:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8D6461A14
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 06:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F19EC433C7;
        Thu, 13 Jul 2023 06:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689231579;
        bh=jNPRe9horA37iG5CpSIFKEizitTA6JnZZr1R883YAe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L419sehvxVai1TjYLsDBkxN/xFrxxvcxkIS8nVx1aehhEZUMXE+MW2fiBflruvEqv
         5URiHR0OXcjY+EpDTGpCeRf9/Q4ByMCDWKbw82as+OhTX6aMV3QRVEECf8Ivh1Nq7E
         ktyqQrtVvbaC2SntXvNbOs/JKqYTifusQKv41EeZeFrYJbPTJFMoK4ukeYg3xg7xUX
         y/IqyilgGUOwFaaPvqdwgIaSANIpu7LPJr/hSicJ3lq5O7lE4IQEiOLw4KG+CXEoni
         1b95PKL306kxJjj8lJh8Rfcd2qRM6UPRuvotUFE5Pl0f4Qez9nrB8clp3Vve7fZnn8
         PaaVXlLgWVzaw==
Date:   Wed, 12 Jul 2023 23:59:37 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v3 1/2] pstore: Remove worst-case compression size logic
Message-ID: <20230713065937.GA2199@sol.localdomain>
References: <20230712162332.2670437-1-ardb@kernel.org>
 <20230712162332.2670437-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712162332.2670437-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 12, 2023 at 06:23:31PM +0200, Ard Biesheuvel wrote:
> The worst case compression size used by pstore gives an upper bound for
> how much the data might inadvertently *grow* due to encapsulation
> overhead if the input is not compressible at all.
> 
> Given that pstore records have individual 'compressed' flags, we can
> simply store the uncompressed data if compressing it would end up using
> more space, making the worst case identical to the uncompressed case.
> 
> This means we can just drop all the elaborate logic that reasons about
> upper bounds for each individual compression algorithm, and just store
> the uncompressed data directly if compression fails for any reason.
> 
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  fs/pstore/platform.c | 206 ++------------------
>  1 file changed, 19 insertions(+), 187 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
