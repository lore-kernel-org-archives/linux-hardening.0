Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E424C433B4
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6A360FDB
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 19:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhDATs6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhDATs6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 15:48:58 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6FC0613E6;
        Thu,  1 Apr 2021 12:48:57 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lS3Is-001ioH-1F; Thu, 01 Apr 2021 19:48:30 +0000
Date:   Thu, 1 Apr 2021 19:48:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Roy Yang <royyang@google.com>
Cc:     keescook@chromium.org, akpm@linux-foundation.org,
        alex.popov@linux.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, corbet@lwn.net, david@redhat.com,
        elena.reshetova@intel.com, glider@google.com, jannh@google.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@linux.ibm.com,
        tglx@linutronix.de, vbabka@suse.cz, will@kernel.org, x86@kernel.org
Subject: Re: [PATCH] Where we are for this patch?
Message-ID: <YGYjjpoj1uMn1VEd@zeniv-ca.linux.org.uk>
References: <20210330205750.428816-1-keescook@chromium.org>
 <20210401191744.1685896-1-royyang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401191744.1685896-1-royyang@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 01, 2021 at 12:17:44PM -0700, Roy Yang wrote:
> Both Android and Chrome OS really want this feature; For Container-Optimized OS, we have customers
> interested in the defense too.
> 
> Thank you very much.
> 
> Change-Id: I1eb1b726007aa8f9c374b934cc1c690fb4924aa3

	You forgot to tell what patch you are refering to.  Your
Change-Id (whatever the hell that is) doesn't help at all.  Don't
assume that keys in your internal database make sense for the
rest of the world, especially when they appear to contain a hash
of something...
