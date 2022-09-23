Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D96C6FA90
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Sep 2022 11:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiIWLOT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Sep 2022 07:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiIWLOT (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Sep 2022 07:14:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F71280FE;
        Fri, 23 Sep 2022 04:14:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MYqKd2xLMz4wgr;
        Fri, 23 Sep 2022 21:14:13 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Scott Wood <oss@buserror.net>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hardening@vger.kernel.org
In-Reply-To: <Yxe8XTY5C9qJLd0Z@work>
References: <Yxe8XTY5C9qJLd0Z@work>
Subject: Re: [PATCH][next] powerpc: Fix fall-through warning for Clang
Message-Id: <166393161454.498456.8335142306216879652.b4-ty@ellerman.id.au>
Date:   Fri, 23 Sep 2022 21:13:34 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 6 Sep 2022 22:32:13 +0100, Gustavo A. R. Silva wrote:
> Fix the following fallthrough warning:
> 
> arch/powerpc/platforms/85xx/mpc85xx_cds.c:161:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
> 
> 

Applied to powerpc/next.

[1/1] powerpc: Fix fall-through warning for Clang
      https://git.kernel.org/powerpc/c/d4d944ff68cb1f896d3f3b1af0bc656949dc626a

cheers
