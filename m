Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7101BC4320A
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 02:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5137E61100
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 02:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbhHSDAH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 23:00:07 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:39110 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235743AbhHSDAH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 23:00:07 -0400
Received: from omf13.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 27D8C1807B5ED;
        Thu, 19 Aug 2021 02:59:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 02F8C1124F4;
        Thu, 19 Aug 2021 02:59:24 +0000 (UTC)
Message-ID: <37db2c792732ac4b39ee338f0a7fa9f260aa3938.camel@perches.com>
Subject: Re: [PATCH 2/5] slab: Add __alloc_size attributes for better bounds
 checking
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
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
Date:   Wed, 18 Aug 2021 19:59:23 -0700
In-Reply-To: <YR2+/WBa9eVGn0bp@casper.infradead.org>
References: <20210818050841.2226600-1-keescook@chromium.org>
         <20210818050841.2226600-3-keescook@chromium.org>
         <f3e56f56c36b32dc76e174886008a2a1ecf3fefa.camel@perches.com>
         <YR2lexDd9N0sWxIW@casper.infradead.org>
         <3a0c55a3fabc57ce9771c93499ef19327f3b8621.camel@perches.com>
         <YR2+/WBa9eVGn0bp@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 02F8C1124F4
X-Stat-Signature: 8imkyfs9o9hb4zoqqhzpb5qqhrweadgb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19Z8/jFNjQzwHhz/5x2YN8pR4bXzCuTFpY=
X-HE-Tag: 1629341964-473567
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 2021-08-19 at 03:16 +0100, Matthew Wilcox wrote:

> kernel-doc is an awful example of perl gone wild.

And checkpatch isn't?


