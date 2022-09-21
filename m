Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6762DECAAD8
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Sep 2022 21:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiIUVBE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiIUVAx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Sep 2022 17:00:53 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40407A0271
        for <linux-hardening@vger.kernel.org>; Wed, 21 Sep 2022 14:00:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE8B3536;
        Wed, 21 Sep 2022 21:00:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BE8B3536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1663794039; bh=7isKC+YSrGaask6vUXhGDpDQnw8IL3toZv6gUCLE72s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rEOiBVfntAQvQ1GXrONqpjs813fenB0/n52jEVdwxQ1YknIczxpIKHAmyjezOCPxg
         o1aKp2E2GraujCxZmQ+hGhSFbda0QsqNhQOj0OpcfE3Qbjo7lUgAz34y0IzS14BEK7
         JOzPWrqIVvpVOHqYgJS270Gv5p1JcGSp7WT7anNLntwFeqjh23hk5glbEAWcAbXpOT
         cafgxu3hHWtRwGBV2u/aggSOC6rIoQO9ks5ckVyCCqXdL3qziATkQ+9qvqzAih1iVR
         DdkkTgrwNZzHDyrnHRnsjtc8qduw3CAYr8++oGI0UC0Ho/9Rp4XqnEFZW6psFNuCEL
         mDFM0l/VGvb7A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC] docs: Define c_paren_attributes for attributes with
 arguments
In-Reply-To: <20220902223507.2537469-1-keescook@chromium.org>
References: <20220902223507.2537469-1-keescook@chromium.org>
Date:   Wed, 21 Sep 2022 15:00:36 -0600
Message-ID: <87mtastpcb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> While Sphinx's "c_id_attributes" is needed for basic attributes, any
> attributes with arguments need to be defined in "c_paren_attributes"
> to avoid errors like:
>
> include/linux/fortify-string.h:116: warning: Function parameter or member '__builtin_strncpy' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '1' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '2' not described in '__diagnose_as'
> include/linux/fortify-string.h:116: warning: Function parameter or member '3' not described in '__diagnose_as'
>
> Move such attributes to "c_paren_attributes" and add __alloc_size
> and __diagnose_as to the list.

So which tree are those warnings coming from?  I can't reproduce them
with linux-next.

As Akira noted, the kernel-doc script is the source of those warnings,
so changing the Sphinx configuration is unlikely to help.  I think we
just need to teach kernel-doc to ignore those attributes.

Thanks,

jon
