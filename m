Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5736AC433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7CE61078
	for <linux-hardening@archiver.kernel.org>; Tue, 26 Oct 2021 15:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhJZPqk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 26 Oct 2021 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhJZPqj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 26 Oct 2021 11:46:39 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120D2C061745
        for <linux-hardening@vger.kernel.org>; Tue, 26 Oct 2021 08:44:16 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 38A2D4B9E;
        Tue, 26 Oct 2021 15:44:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 38A2D4B9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635263055; bh=u3wRb/WRpatv2o30nV9WkibJqKdsJBM1qCh5RGAn0jA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Jrkg71YorHHYh26hXr4eVVyGHyFzMKPYZi2bkV6lIlQPQ0u+KpdYHBLP2ASB/KQnG
         yOP8A6FddoqoHurDMwy0Z7CxYWzKtMaXEJT5rtNSXzCIlDBnPdXPc2ZaVI4TNM/bbx
         c+RlNTNsrUXmDJIeAOkEh3yy/YOdpv6eHi2ZayBlAIRqTdyKPpYpWxrvOAhKk543c1
         f6hykKdkEPeXZHxnZdHy7f5y2uhKf8B9XUwbbeL52KxFy9jYHdSIj8RE11mUw/ggI/
         VitMV5qGAj4x7vNQFgSQSfApLhXtUGR+mTrxGxWNBpwztDgWzLCUWm8L9qPi3+Gwe1
         xinkqpSJIxPuw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>
Cc:     Len Baker <len.baker@gmx.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] docs: deprecated.rst: Clarify open-coded arithmetic
 with literals
In-Reply-To: <20210925143455.21221-1-len.baker@gmx.com>
References: <20210925143455.21221-1-len.baker@gmx.com>
Date:   Tue, 26 Oct 2021 09:44:14 -0600
Message-ID: <871r47g59t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Len Baker <len.baker@gmx.com> writes:

> Although using literals for size calculation in allocator arguments may
> be harmless due to compiler warnings in case of overflows, it is better
> to refactor the code to avoid the use of open-coded arithmetic.
>
> So, clarify the preferred way in these cases.
>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
> Changelog v1 -> v2
>  - Clarify the sentence by changing "keep <foo> out" with "avoid <foo>"
>    (Joe Perches).
>
> Changelog v2 -> v3
>  - Reword the sentence to comunicate better (Jonathan Corbet).
>
> The previous version can be found here [1].
>
> [1] https://lore.kernel.org/linux-hardening/20210829144716.2931-1-len.baker@gmx.com/

Applied, thanks.

jon
