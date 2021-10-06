Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDAFC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 00:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E52A161108
	for <linux-hardening@archiver.kernel.org>; Wed,  6 Oct 2021 00:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhJFAx2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 5 Oct 2021 20:53:28 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:39696 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230218AbhJFAx2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 5 Oct 2021 20:53:28 -0400
Received: from omf17.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8E2E1837F24A;
        Wed,  6 Oct 2021 00:51:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id AFB4F27DD2E;
        Wed,  6 Oct 2021 00:51:33 +0000 (UTC)
Message-ID: <b59c7f33ff9c8443cf08204ec37383d734fbbf60.camel@perches.com>
Subject: Re: [PATCH v5] docs: Explain the desired position of function
 attributes
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 05 Oct 2021 17:51:31 -0700
In-Reply-To: <742567f3-f043-6fab-235a-5835ca025f54@infradead.org>
References: <20211005152611.4120605-1-keescook@chromium.org>
         <7f6e53d04849daabd3e85c23f9974b2eb4a20c13.camel@perches.com>
         <202110051004.C4D9EBA0@keescook>
         <742567f3-f043-6fab-235a-5835ca025f54@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1prmcwyjmgygdxkfhijpkjwfsy6hinz9
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: AFB4F27DD2E
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19BpTF+UZGYfSoG/T6NSdvICE9NN8lR8bk=
X-HE-Tag: 1633481493-933631
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 2021-10-05 at 12:15 -0700, Randy Dunlap wrote:
> On 10/5/21 10:04 AM, Kees Cook wrote:
> > On Tue, Oct 05, 2021 at 08:39:14AM -0700, Joe Perches wrote:
> > > On Tue, 2021-10-05 at 08:26 -0700, Kees Cook wrote:
> > > > While discussing how to format the addition of various function
> > > > attributes, some "unwritten rules" of ordering surfaced[1]. Capture as
> > > > close as possible to Linus's preferences for future reference.
> > > > +For example, using this function declaration example::
> > > > +
> > > > + __init void * __must_check action(enum magic value, size_t size, u8 count,
> > > > +				   char *fmt, ...) __printf(4, 5) __malloc;
> > > 
> > > trivia: almost all fmt declarations should be const char *
> > 
> > Heh, good point!
> > 
> > > > +Note that for a function **definition** (i.e. the actual function body),
> > > > +the compiler does not allow function parameter attributes after the
> > > > +function parameters. In these cases, they should go after the storage
> > > > +class attributes (e.g. note the changed position of ``__printf(4, 5)``
> > > > +below, compared to the **declaration** example above)::
> > > > +
> > > > + static __always_inline __init __printf(4, 5) void * __must_check action(enum magic value,
> > > > +		size_t size, u8 count, char *fmt, ...) __malloc
> > > 
> > > here too, and 80 columns?
> > 
> > Kernel standard is now 100. *shrug*
> 
> That's more for exceptions, not the common rule.
> AFAIUI.

And for function definitions that are not static inline, when
separate function declarations exist, the function definition
does not need any attribute marking at all.


