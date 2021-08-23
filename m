Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA0C4338F
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 06:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4224611EF
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Aug 2021 06:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhHWGoC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Aug 2021 02:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhHWGoB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Aug 2021 02:44:01 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20BC061756
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 23:43:19 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so29586559lje.2
        for <linux-hardening@vger.kernel.org>; Sun, 22 Aug 2021 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X9FMR7iIGm8hwjI0Az1jlgXDZnDlEXK88Ri4nJkOnvk=;
        b=Ib8+qMiGcXJO6i+tGA0QmqhxNKex0iZSpxnHBbWhdc8YTalcCTQtXxGESavmAvSMiz
         LawPT0nO36Y8V8IW5DQHRJG7KMZT/g84kVe462xfXjK16NvgfoTNOwPk9UgMcNkgkw0N
         hyGP/X5KsS6NSbNy6vLDYdhz2Nz7P8vBB99nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9FMR7iIGm8hwjI0Az1jlgXDZnDlEXK88Ri4nJkOnvk=;
        b=pMyU0qhKWaQ6CD/0iOKmN6OLcO/N3xPmmmDKxYnd6cUS53lFT9eGFJOwZhC/rljU5/
         6N4kBIaILRXPIaDUn8BUnKd2dm0Qgx4B385xNnU47F75Lyn/32FyXWx+j6Hw7vDNnAvs
         gt7ENzQcLn9JGU+NjyW0f9k8hK7bCFFMPRmCwxPADd4qUUk9szChiJfhSdX7ygMfwMgC
         Veaj1z6yDGPUbBAn1pTL7pjyoFNdibe95RZfhlMBDJr7PCYckeYv81ijYNS1GAc9icBf
         ZX6eNOP+8rMRYSFRpvaLm+EfFFc95rbjLhjKTPg21oO6qV7EZ6nQTCc4UkPxgfIh7cz0
         vzGg==
X-Gm-Message-State: AOAM531AbT5eV6FuhTmz4+7IGqg9EInXoIihc7csajDLmjst6JSoMqXZ
        vFWxDlOzO+FebPwmgeOV6dAwLcepCmBRspDk
X-Google-Smtp-Source: ABdhPJxLCvVCTMjiT6xh9Cgw7aGYl/Ohc3/GyHUBoc2jnxiqiG5LQ/per7MxAtf+WsIn33ffeeTGNg==
X-Received: by 2002:a2e:9999:: with SMTP id w25mr26140028lji.359.1629700997604;
        Sun, 22 Aug 2021 23:43:17 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r20sm1359329lff.93.2021.08.22.23.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:43:17 -0700 (PDT)
Subject: Re: [PATCH for-next 13/25] compiler_types.h: Remove
 __compiletime_object_size()
To:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Bart Van Assche <bvanassche@acm.org>,
        David Gow <davidgow@google.com>, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com, linux-hardening@vger.kernel.org
References: <20210822075122.864511-1-keescook@chromium.org>
 <20210822075122.864511-14-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4fff1f46-ab10-317b-8cf0-05871e4a9d71@rasmusvillemoes.dk>
Date:   Mon, 23 Aug 2021 08:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210822075122.864511-14-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 22/08/2021 09.51, Kees Cook wrote:

> -	int sz = __compiletime_object_size(addr);
> +	int sz = __builtin_object_size(addr, 0);

Not directly related to this patch, but seeing this I wonder if there
would be some value in introducing names for those magic 0/1/2/3 that
are used with __b_o_s. Every time I stumble on code using that I have to
go to the gcc docs, and even then it takes me a while to grok what

     TYPE is an integer constant from 0 to 3.  If the least significant
     bit is clear, objects are whole variables, if it is set, a closest
     surrounding subobject is considered the object a pointer points to.
     The second bit determines if maximum or minimum of remaining bytes
     is computed.

means. The names don't need to be too verbose, just having a few
#defines in-tree with the above quoted above them makes it a lot easier
to figure out what they mean.

Rasmus
