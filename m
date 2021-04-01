Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D2BC433B4
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 20:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA13610D0
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 20:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhDAUOa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:14:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35609 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235002AbhDAUO3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 16:14:29 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 131KDLnN028880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Apr 2021 16:13:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B235F15C3A90; Thu,  1 Apr 2021 16:13:21 -0400 (EDT)
Date:   Thu, 1 Apr 2021 16:13:21 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Roy Yang <royyang@google.com>, keescook@chromium.org,
        akpm@linux-foundation.org, alex.popov@linux.com,
        ard.biesheuvel@linaro.org, catalin.marinas@arm.com, corbet@lwn.net,
        david@redhat.com, elena.reshetova@intel.com, glider@google.com,
        jannh@google.com, kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@linux.ibm.com,
        tglx@linutronix.de, vbabka@suse.cz, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH] Where we are for this patch?
Message-ID: <YGYpYUqIf9rdJqRi@mit.edu>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210401191744.1685896-1-royyang@google.com>
 <YGYjjpoj1uMn1VEd@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGYjjpoj1uMn1VEd@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 01, 2021 at 07:48:30PM +0000, Al Viro wrote:
> On Thu, Apr 01, 2021 at 12:17:44PM -0700, Roy Yang wrote:
> > Both Android and Chrome OS really want this feature; For Container-Optimized OS, we have customers
> > interested in the defense too.
> > 
> > Thank you very much.
> > 
> > Change-Id: I1eb1b726007aa8f9c374b934cc1c690fb4924aa3
> 
> 	You forgot to tell what patch you are refering to.  Your
> Change-Id (whatever the hell that is) doesn't help at all.  Don't
> assume that keys in your internal database make sense for the
> rest of the world, especially when they appear to contain a hash
> of something...

The Change-Id fails to have any direct search hits at lore.kernel.org.
However, it turn up Roy's original patch, and clicking on the
message-Id in the "In-Reply-Field", it apperas Roy was replying to
this message:

https://lore.kernel.org/lkml/20210330205750.428816-1-keescook@chromium.org/

which is the head of this patch series:

Subject: [PATCH v8 0/6] Optionally randomize kernel stack offset each syscall

That being said, it would have been better if the original subject
line had been preserved, and it's yet another example of how the
lore.kernel.org URL is infinitely better than the Change-Id.  :-)

		       		  	      - Ted
