Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199EAEE3F2A
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Sep 2023 20:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjILUJi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Sep 2023 16:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjILUJh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Sep 2023 16:09:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E9410D3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Sep 2023 13:09:33 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64f3ad95ec0so38314286d6.1
        for <linux-hardening@vger.kernel.org>; Tue, 12 Sep 2023 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694549372; x=1695154172; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8AmbzuBNjG3pvuD2vEMK+EvxK+MhEsb4d21jgaPxZbE=;
        b=Ga+eexPguoFoOmIE/wJutfdQjQ3YV1AHkxO/Cntys3UfJC9/uQa0bvI+8z3Y/QNDfY
         XHf/s0pSE4hf+qG5K23F9ZUvgtwfC8oosdkw8omD4AFHVOel7LGR83invPnUqlmdvQj2
         dq/Q/N1rVlY5YzHohgysyhKzFVf5osmg+KY0Ymr08SVqbRcjZgl9um2PBX+d+CuJB2QP
         tpE8xeIM2XNROPDmCAVuaIMj3/RLP5nGZDNamIQKHrBHc9nG4Y5B6LSAS74cD2gxmDeD
         k98V1xI4hsTA4oWrPm6JPRw8AN3Fa+l3W6Ydq7JohUe12Qf6vlckWWS7NnJeZCV5cP4o
         FZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694549372; x=1695154172;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8AmbzuBNjG3pvuD2vEMK+EvxK+MhEsb4d21jgaPxZbE=;
        b=oP3Xz1fna15N14czGND04pjT20j5gWTfemnzrssOcaaFQQ/t74vWMzZJ8uBYdE8dlM
         +63sMV81ZpE7uBhWXgDIy1zaDt6i93t2V+3W9awg+vKdOglyjtarkT+pH0PEqxOEoSkw
         3ArUuuOKQN1gtRfkUhdvb2Uz4ICeYXGhA8d//tHTrZYoz/1/wFC+kC/n2x7+naZkri3X
         H/3m0BjGdRDNRJuIfrkY/v7ZCjd9zMwTzOhNBSFhvdbMB+udpl/sHjBe5yttYkzZFW5S
         S7ncRoyKN8h7sOxgBAdl10fXJtkf33uXQ0lu9M+FWdSPspyENVon8vhvjeVG4dzaDk0G
         wUig==
X-Gm-Message-State: AOJu0YxJafZdhMdngkRCrAc/SpT/RawwkGCH7e881fYrhax8AQ4MxuGD
        81zhoK7N6Umk/YhxH/phWI/X
X-Google-Smtp-Source: AGHT+IHhm9amGITUC1dlWWjtweGnOTF6yopgBiECKzU9eaLYygbZQmkBEK0hqu7j/mCxHSZaWII3Vw==
X-Received: by 2002:a0c:f08e:0:b0:655:db86:6c95 with SMTP id g14-20020a0cf08e000000b00655db866c95mr379534qvk.37.1694549372344;
        Tue, 12 Sep 2023 13:09:32 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i3-20020ad44103000000b00655e2d0c268sm2354973qvp.15.2023.09.12.13.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 13:09:31 -0700 (PDT)
Date:   Tue, 12 Sep 2023 16:09:31 -0400
Message-ID: <16ef84059b3adaafd3bc2d43ba9c1ccd.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Paris <eparis@redhat.com>, audit@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] audit: Annotate struct audit_chunk with __counted_by
References: <20230817203501.never.279-kees@kernel.org>
In-Reply-To: <20230817203501.never.279-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Aug 17, 2023 Paul Moore <paul@paul-moore.com> wrote:
> 
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct audit_chunk.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: audit@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/audit_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks.

--
paul-moore.com
