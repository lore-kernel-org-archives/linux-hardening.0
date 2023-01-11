Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EC7C54EBC
	for <linux-hardening@archiver.kernel.org>; Wed, 11 Jan 2023 23:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjAKXLt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 Jan 2023 18:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjAKXLn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 Jan 2023 18:11:43 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BDA39F95
        for <linux-hardening@vger.kernel.org>; Wed, 11 Jan 2023 15:11:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2BCA85BF;
        Wed, 11 Jan 2023 23:11:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2BCA85BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673478702; bh=KK+xKV+L16O4zoDSNuftyg22iC+T8sFrp4ormOlTw0U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PvOigv8yMZhjIP/TJkL8hHCbJzToi0M9lp9xYKYcxa6VHURaM9spk9b+Ak70t6uxU
         7UuvuhgGB/STqn3rXjNgaOFfbWtX+rJUnImPjPTofD4H4tlg3SdesHFzPVnt6CzO1Z
         7SfaJnrGGZMCj0rSgDgcU6io5Lk/PN08t7QWhs/TEwLSTf4n76zEuuqP9+ki6DaP+7
         mVyfR1uDMpPETQCa8xSTXI0qFJ/VCSi8MeZygQ2dm3LLDlxySm1xwJiV0QQVmszNOI
         nltqMlm74SxgVZGTGC6jaeD9uJPYJlF6Ln63PqVdCvYPxGs3/K1Y2cs2wtO6zeGBLF
         mTaFY/Cteqwbg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Add note about
 DECLARE_FLEX_ARRAY() usage
In-Reply-To: <20230106200600.never.735-kees@kernel.org>
References: <20230106200600.never.735-kees@kernel.org>
Date:   Wed, 11 Jan 2023 16:11:41 -0700
Message-ID: <87r0w0vf82.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> There wasn't any mention of when/where DECLARE_FLEX_ARRAY() should be
> used, so add the rationale and an example to the deprecation docs.
>
> Suggested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/process/deprecated.rst | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

I've applied this, but couldn't resist making one tweak...

> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index c8fd53a11a20..fcac0a929efa 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -346,3 +346,29 @@ struct_size() and flex_array_size() helpers::
>          instance->count = count;
>  
>          memcpy(instance->items, source, flex_array_size(instance, items, instance->count));
> +
> +There are two special cases of replacement where the DECLARE_FLEX_ARRAY()
> +helper needs to be used. (Note that it is named __DECLARE_FLEX_ARRAY() for
> +use in UAPI headers.) When the flexible array is either alone in a struct,
> +or is part of a union. 

The pedant in me couldn't stand leaving that sentence fragment, so I
made a complete sentence out of it.

Thanks,

jon
