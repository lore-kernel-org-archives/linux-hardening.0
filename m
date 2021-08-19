Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD73C4320A
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 00:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC91610D2
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 00:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhHSA3r (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 20:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhHSA3q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 20:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC4C061764;
        Wed, 18 Aug 2021 17:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SYTkN+XVkEdV/u+OxTKinuCFAobXZwOiwDBIdlXk06k=; b=YBhDgQ1p9IUPiv47d0MqLCASm4
        HJVkmYggSMFi4n3amj0hm596YZl1Jz+DdWH3wr2UuoPFm/UhZeIEK9CTEJ11Dheu63eZmE/WdWwNE
        GwEQr2+NVe5lvFuxRMgRDdBFBYUAHzU6PbAbxG9jk+7ErnCggEJzrv7qcIC5FEzxt+wgcz9/eT6E6
        /PZjZ4p5TpX6lf4no5VFR12kf0yMwgHcrOjiGHRwFmk13NmKCdNJ5bCiTy03H22L8OG0psiccHKqa
        RmFTzU6ZmbI8B5vEjW/VdMYuUTE+Pr0wyCwxB7VFsbxPVlTwXZw0q6PzN5N9ZxRKlI72+xvtTC17y
        vk84IU2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGVuF-004Qmy-PG; Thu, 19 Aug 2021 00:28:06 +0000
Date:   Thu, 19 Aug 2021 01:27:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Micay <danielmicay@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/5] slab: Add __alloc_size attributes for better bounds
 checking
Message-ID: <YR2lexDd9N0sWxIW@casper.infradead.org>
References: <20210818050841.2226600-1-keescook@chromium.org>
 <20210818050841.2226600-3-keescook@chromium.org>
 <f3e56f56c36b32dc76e174886008a2a1ecf3fefa.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e56f56c36b32dc76e174886008a2a1ecf3fefa.camel@perches.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 17, 2021 at 10:31:32PM -0700, Joe Perches wrote:
> Lastly __alloc_size should probably be added to checkpatch
> 
> Maybe:
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 161ce7fe5d1e5..1a166b5cf3447 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -489,7 +489,8 @@ our $Attribute	= qr{
>  			____cacheline_aligned|
>  			____cacheline_aligned_in_smp|
>  			____cacheline_internodealigned_in_smp|
> -			__weak
> +			__weak|
> +			__alloc_size\s*\(\s*\d+\s*(?:,\s*d+\s*){0,5}\)

Should probably be added to kernel-doc as well.  Any other awful regexes
that need to be changed to understand it?  And can we commonise the
regexes that do exist into a perl helper library?
