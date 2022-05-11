Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85554C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 11 May 2022 22:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbiEKWPu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 May 2022 18:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiEKWPs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 May 2022 18:15:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD41DA49;
        Wed, 11 May 2022 15:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0376AB82407;
        Wed, 11 May 2022 22:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A821C34114;
        Wed, 11 May 2022 22:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652307343;
        bh=Jy+GNKoYXetk1xzhnIVDe4VbS9tRmYBZe7B0thR0kgA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a5qn8kuzw4AXMwZ0WhiQzdQ6N2N38UCH0NgsVxN48KAtEka1RiCCNanN+uJi4nq+m
         CbR0aLtp6SytpkY6ixhoWKT3/PABj2n3ZE5HAFujSLW0VNo9fLb+Jsy9DDcgduRbQF
         MHSiVp2FgYoA2wnLxk030YyMDocjyIpD1jQDe/0R8951GeryWu6FXsqG7TMEPrIl95
         S0OmpyKRyAzdWUDZunDYKNAK3Cpcam+jbRx1AQ+FVi3c/zCOnMLfPFhqfGgwf12+j4
         WGzqZv4L//x7kDr/f0ibLEIR6021v5buNwzL0d/w/MEAhHJ2aftiGrQ71oL9SbpxQQ
         vKREJ8RKG/Cxg==
Date:   Wed, 11 May 2022 15:15:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@infradead.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <cong.wang@bytedance.com>,
        Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] af_unix: Silence randstruct GCC plugin warning
Message-ID: <20220511151542.4cb3ff17@kernel.org>
In-Reply-To: <20220511000109.3628404-1-keescook@chromium.org>
References: <20220511000109.3628404-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 10 May 2022 17:01:09 -0700 Kees Cook wrote:
> While preparing for Clang randstruct support (which duplicated many of
> the warnings the randstruct GCC plugin warned about), one strange one
> remained only for the randstruct GCC plugin. Eliminating this rids
> the plugin of the last exception.
> 
> It seems the plugin is happy to dereference individual members of
> a cross-struct cast, but it is upset about casting to a whole object
> pointer. This only manifests in one place in the kernel, so just replace
> the variable with individual member accesses. There is no change in
> executable instruction output.
> 
> Drop the last exception from the randstruct GCC plugin.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.co.jp>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Cong Wang <cong.wang@bytedance.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: netdev@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> If someone can Ack this, I can carry it in the gcc-plugins tree,
> as I'm trying to remove all its exceptions so I can drop that code.

Acked-by: Jakub Kicinski <kuba@kernel.org>
