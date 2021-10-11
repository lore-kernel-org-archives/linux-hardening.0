Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B370C433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Oct 2021 18:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BA860F11
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Oct 2021 18:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhJKSZh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Oct 2021 14:25:37 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:43086 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232165AbhJKSZh (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Oct 2021 14:25:37 -0400
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id EE257100E7B59;
        Mon, 11 Oct 2021 18:23:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 97EB42550F1;
        Mon, 11 Oct 2021 18:23:34 +0000 (UTC)
Message-ID: <2d6bf6a7413fafce51a7e1d80c959b57faeb4b75.camel@perches.com>
Subject: Re: [PATCH] scripts: kernel-doc: Ignore __alloc_size() attribute
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Date:   Mon, 11 Oct 2021 11:23:33 -0700
In-Reply-To: <20211011180650.3603988-1-keescook@chromium.org>
References: <20211011180650.3603988-1-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 97EB42550F1
X-Stat-Signature: chfeo6t9fsqd6ck4jrcnp4qfidbw6wj6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/XcxNNFly5dEc3mwylO5u/uBrBiKCxf2w=
X-HE-Tag: 1633976614-606409
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 2021-10-11 at 11:06 -0700, Kees Cook wrote:
> Fixes "Compiler Attributes: add __alloc_size() for better bounds checking"
> so that the __alloc_size() macro is ignored for function prototypes when
> generating kerndoc. Avoids warnings like:
> 
> ./include/linux/slab.h:662: warning: Function parameter or member '1' not described in '__alloc_size'
> ./include/linux/slab.h:662: warning: Function parameter or member '2' not described in '__alloc_size'
> ./include/linux/slab.h:662: warning: expecting prototype for kcalloc().  Prototype was for __alloc_size() instead
[]
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
[]
> @@ -1789,6 +1789,7 @@ sub dump_function($$) {
>      $prototype =~ s/__weak +//;
>      $prototype =~ s/__sched +//;
>      $prototype =~ s/__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +//;
> +    $prototype =~ s/__alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +//;
>      my $define = $prototype =~ s/^#\s*define\s+//; #ak added
>      $prototype =~ s/__attribute_const__ +//;
>      $prototype =~ s/__attribute__\s*\(\(

Perhaps all this would be more intelligible and a bit more future-proof
using a regex that consumes all the various __<foo> prefixed attributes.

Maybe:

	my $balanced_parens = qr/(\((?:[^\(\)]++|(?-1))*\))/;
	$prototype =~ s/\b__\w+\s*(?:$balanced_parens)?\s*//g;



