Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34BEEE49B2
	for <linux-hardening@archiver.kernel.org>; Wed, 23 Aug 2023 12:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjHWMEo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 23 Aug 2023 08:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjHWMEX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 23 Aug 2023 08:04:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9C6171A;
        Wed, 23 Aug 2023 05:04:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cx3wK5z4x3F;
        Wed, 23 Aug 2023 22:04:01 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Geoff Levand <geoff@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Justin Stitt <justinstitt@google.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
In-Reply-To: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
References: <20230816-strncpy-arch-powerpc-platforms-ps3-repository-v1-1-88283b02fb09@google.com>
Subject: Re: [PATCH] powerpc/ps3: refactor strncpy usage
Message-Id: <169279175569.797584.351106709683075020.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 16 Aug 2023 21:39:24 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> `make_first_field()` should use similar implementation to `make_field()`
> due to memcpy having more obvious behavior here. The end result yields
> the same behavior as the previous `strncpy`-based implementation
> including the NUL-padding.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/ps3: refactor strncpy usage
      https://git.kernel.org/powerpc/c/f94a84a0914841d79a38df7cc75512d88b31a0dc

cheers
