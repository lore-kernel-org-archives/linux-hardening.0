Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F521C4332F
	for <linux-hardening@archiver.kernel.org>; Thu,  8 Dec 2022 16:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiLHQNj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiLHQNi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 8 Dec 2022 11:13:38 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AA281D8E
        for <linux-hardening@vger.kernel.org>; Thu,  8 Dec 2022 08:13:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so5119388pje.5
        for <linux-hardening@vger.kernel.org>; Thu, 08 Dec 2022 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VEF5Kdoxdu+cKfk6R3ZwPWFH59dyZr5XNLc+TP4k1ZU=;
        b=M9dPq43pCEesdG1Pr73JFi78Hptyiq5VZqWgnsSr3kI1jPoUdQ4zxjiAhyNFqpFmZg
         njyxgcdxqgN0KzGHxmez3cz91qutsMd43bfVz+BmUEiqosyY0DbvL3iHrFX0td8dUCSY
         MTh3j9pe6XZs6CcLquyZVVbjRBXWFW2xIvWp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEF5Kdoxdu+cKfk6R3ZwPWFH59dyZr5XNLc+TP4k1ZU=;
        b=3/LhpKCPjWmEm2K/YQKvwgEA07pt2lUOL4J+FbwMfRhtYGl3kwVMtJAC+oIe7YFm02
         fLF0hODqwV05yOFrE5iIDrVH4LuuMpL9N84myIr/Bdu9+7eqHno8Y4smAT9Kfam6XzOX
         K+FPwbvgYHgGmDWutj9e3gPMDLn/cNsn3HHAQ8Q9nw23YDG6TuOkX/1+fFYlXmE97dJI
         JYDhKXxzWjDIVAPDH3vrbTjZyR9jqVr+VqlxtSIt3VDRYFnJqoLD8t6FCPQMlJlc/CKK
         JDxl0o5CQoeoRsOVEGrg3ygDiiTQJTuAeM+HyCNe11rn7qkH3yVhpUtRbs9xAAyLRGX2
         eA5Q==
X-Gm-Message-State: ANoB5pk7vfJmPTqB387ebdA6MxfNj4qx0PBm0qvL73W5EXX1cckngBQ2
        kEqnW9wCOc6CTILnWFKunCvEvA==
X-Google-Smtp-Source: AA0mqf54Uql+4I53tb1lC4yydY21faKQwOpWl2+BYX9Ds95kNuRBabF3SZQkBl8QR9ooQXG7EPr8Eg==
X-Received: by 2002:a17:903:22c2:b0:189:c47b:af22 with SMTP id y2-20020a17090322c200b00189c47baf22mr24668561plg.23.1670516016394;
        Thu, 08 Dec 2022 08:13:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik25-20020a170902ab1900b001869b988d93sm16661571plb.187.2022.12.08.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 08:13:35 -0800 (PST)
Date:   Thu, 8 Dec 2022 08:13:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     jeffxu@chromium.org
Cc:     skhan@linuxfoundation.org, akpm@linux-foundation.org,
        dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Message-ID: <202212080809.687CC8BC23@keescook>
References: <20221207154939.2532830-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207154939.2532830-1-jeffxu@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Dec 07, 2022 at 03:49:33PM +0000, jeffxu@chromium.org wrote:
> This is V6 version of patch: see [4] [5] [6] [7] for previous versions.

When sending a new version, can you include an overview of what changed
between this version and the prior version? This helps reviewers who are
following along, so it's easier to focus our attention on the
differences. Also, it's helpful to version the links:

> [4] https://lwn.net/Articles/890096/
> [5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
> [6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
> [7] https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/

e.g.:

v6:
- moved foo to bar
- improve comments for baz
v5: https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
v3: https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
v2: ...etc

-Kees

-- 
Kees Cook
