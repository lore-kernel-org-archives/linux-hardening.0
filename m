Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAB4EB64D9
	for <linux-hardening@archiver.kernel.org>; Sat,  8 Jul 2023 02:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGHCSa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 7 Jul 2023 22:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGHCS3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 7 Jul 2023 22:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31EB113
        for <linux-hardening@vger.kernel.org>; Fri,  7 Jul 2023 19:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 783BF61ADE
        for <linux-hardening@vger.kernel.org>; Sat,  8 Jul 2023 02:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAED8C433C7;
        Sat,  8 Jul 2023 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688782688;
        bh=lc/FccCXqgHVjX25Cy9sXjMUh4mtssFWGjfpRoZfCC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5iVkJ7jugq4qW69uHDnYWmdyM+yLRsO/kTTTIJfI99ZEQpyD5mtfYURpmWhYm+yB
         rJGbGL0jHEReJXF352oD2EiCLSU3pyiYWloB5PBhzU0p/78B92rbx4YFbhwfg8MJ2G
         xU8h8DBOdBOA14g1mzd4bn6eA6oD20xaqMalAvi/cSw2BPU6Vf4AHjaZxf7J3QxCdY
         l44rEa1u1DPvRQmNORx9Qn18ez/Pu+RC3jl5dSGMMWVzEw25JYXhQMzqEUg3FOQB6V
         7vUOfYGWXJR35iE90UnZBM6lW6oahUjMAJdJJHuAYeCilAzubp8LbNFy5/j+VaTnuj
         BVuME4blUFAcA==
Date:   Fri, 7 Jul 2023 19:18:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v2 1/2] pstore: Remove worst-case compression size logic
Message-ID: <20230708021807.GB1731@sol.localdomain>
References: <20230707083456.2501913-1-ardb@kernel.org>
 <20230707083456.2501913-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707083456.2501913-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jul 07, 2023 at 10:34:55AM +0200, Ard Biesheuvel wrote:
> From: Kees Cook <keescook@chromium.org>

As was mentioned by others, you should reset the author.

> +	/* Worst-case compression should never be more than uncompressed. */
> +	buf = kmalloc(psinfo->bufsize, GFP_KERNEL);

I don't think the above comment really conveys the reasoning.  Maybe write
something along the lines of:

	/*
         * The compression buffer only needs to be as large as the maximum
         * uncompressed record size, since any record that would be expanded by
         * compression is just stored uncompressed.
	 */

- Eric
