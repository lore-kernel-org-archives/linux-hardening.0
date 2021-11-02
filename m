Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A41C433FE
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 11:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAEC561078
	for <linux-hardening@archiver.kernel.org>; Tue,  2 Nov 2021 11:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhKBLle (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 2 Nov 2021 07:41:34 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:53263 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhKBLlQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fr6kfZz4xdF;
        Tue,  2 Nov 2021 22:38:40 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211015050345.GA1161918@embeddedor>
References: <20211015050345.GA1161918@embeddedor>
Subject: Re: [PATCH][next] powerpc/vas: Fix potential NULL pointer dereference
Message-Id: <163584790218.1845480.3122470991665187851.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, 15 Oct 2021 00:03:45 -0500, Gustavo A. R. Silva wrote:
> (!ptr && !ptr->foo) strikes again. :)
> 
> The expression (!ptr && !ptr->foo) is bogus and in case ptr is NULL,
> it leads to a NULL pointer dereference: ptr->foo.
> 
> Fix this by converting && to ||
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/vas: Fix potential NULL pointer dereference
      https://git.kernel.org/powerpc/c/61cb9ac66b30374c7fd8a8b2a3c4f8f432c72e36

cheers
