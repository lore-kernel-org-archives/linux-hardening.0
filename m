Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0905CC07E9D
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 21:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiIZVGZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiIZVGX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 17:06:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3412571982;
        Mon, 26 Sep 2022 14:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qv4UEE+Pyr8ehVevhFLE58aXkeNABKHzoh9oFlgTTYw=; b=SppmqS3ZhUXVl+RYJ7q6206ZU+
        vKNqbk2eVRIKNOONgdPST7jNpY4wWWsi4cGIXnfxAhr+3yvXLH/4PCfQDNekTPvbR9BUiEXk25p1g
        M/ZHTmmbXPFjsX++0DfRKXAzxM9kFqh7GQ1/YLWn+6XCajoh3RMMnSsdByXhzrhSZzDLaFJmV2ynw
        Hxj6e2xjpicpwwzhdRw629341j1YUj0m4ilvvAcgefYAUkaSk6jhyDcEXJt/kq1HRHtV2lx5hHOm+
        jdykHwW1tx4YaArtXnPKqkspaggycjdBKTKC+blXcPD0CyvZROv7RG+XsDXKlB/vvxjCO74WEQJUr
        GVexZtyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocvIx-00ApxK-Kn; Mon, 26 Sep 2022 21:06:19 +0000
Date:   Mon, 26 Sep 2022 22:06:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Fix kern-doc markup for functions
Message-ID: <YzIUS/+H2YA7RBvA@casper.infradead.org>
References: <20220926194713.1806917-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926194713.1806917-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 12:47:13PM -0700, Kees Cook wrote:
> -/** check_add_overflow() - Calculate addition with overflow checking
> +/**
> + * check_add_overflow - Calculate addition with overflow checking
>   *
>   * @a: first addend
>   * @b: second addend

Why did you remove the ()?  And why didn't you delete the blank line?
According to our documentation, the canonical form is:

  /**
   * function_name() - Brief description of function.
   * @arg1: Describe the first argument.
   * @arg2: Describe the second argument.
   *        One can provide multiple line descriptions
   *        for arguments.

I don't usually complain about people getting that wrong, but when
people correct it to be wrong ...

