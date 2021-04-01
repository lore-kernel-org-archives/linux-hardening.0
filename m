Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B25C433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 21:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851946108B
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 21:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhDAVA2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 17:00:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43723 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234047AbhDAVA2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 17:00:28 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 131KxKua015368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Apr 2021 16:59:21 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3E36F15C3A90; Thu,  1 Apr 2021 16:59:20 -0400 (EDT)
Date:   Thu, 1 Apr 2021 16:59:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Roy Yang <royyang@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org,
        akpm@linux-foundation.org, alex.popov@linux.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, corbet@lwn.net,
        david@redhat.com, elena.reshetova@intel.com,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@linux.ibm.com,
        tglx@linutronix.de, vbabka@suse.cz, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH v8 0/6] Optionally randomize kernel stack offset each
 syscall
Message-ID: <YGY0KAgMmm4XlaS8@mit.edu>
References: <CANemeMjOw4sOzMxjdjJcWKD315u+KRn19h687GMbkQdP5Jc_kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANemeMjOw4sOzMxjdjJcWKD315u+KRn19h687GMbkQdP5Jc_kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 01, 2021 at 01:49:17PM -0700, Roy Yang wrote:
> Thanks Ted, Casey and Al Viro. I am sorry for the inconvenience.
> 
> I tried to follow the instructions listed under
> https://lore.kernel.org/lkml/20210330205750.428816-1-keescook@chromium.org/
> using git-send-email
> 
> Thought that will reply to the original thread with the original
> subject . Let me know what I can do to correct this to avoid
> confusion.

It did chain to the original thread; that's how I was able to figure
out the context.  However, it looks like in your reply, you set the
subject to be:

[PATCH] Where we are for this patch?

And the problem is if someone had deleted the original e-mail chain
--- for example, optimizing the kernel stack is not one of the
subjects that I normally closely track, I had already deleted those
e-mail chains.  So all I saw (and I suspect all Al saw) was a message
with the above subject line, and no context.

If you had kept the original subject line, then those of us who mostly
focus on file system stuff would have known that it's an area which is
covered by other maintainers, and we wouldn't have deleted your query
and let someone else respond.

Cheers,

					- Ted

P.S.  I personally find the use "git-send-email" to reply to be so
much of a pain that I just use a non-google.com address to which I can
use a traditional threaded mail-reader (such as mutt) and I can send
e-mail without having to worry about the DMARC nonsense.  :-)

