Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221CECAA27
	for <linux-hardening@archiver.kernel.org>; Thu, 25 Aug 2022 19:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiHYTmZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 25 Aug 2022 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiHYTmZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 25 Aug 2022 15:42:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C78FD71;
        Thu, 25 Aug 2022 12:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JMhm1+nDvrUGAMNd6dN9zEI9AWNo/oGVfkuEmcPtTh4=; b=fSzzJBEG5W5dJCIUU4qltwoDCP
        JhgPyWTu3bbw+qozGYx1LqrZRlNlCmfHboO5oW59SqUBCU72zGwX7CP/SLiKgNis3u7sPUn0Cxf9Y
        OIBz1mhqA8aPKe4DsLzrAyeFJAZ3It17hxUkG65KXW+3XeX+vdLriWEGUrZ29Yz+2czNKSiV89927
        hSd+zpEDu0MUgK1zs2tgeKXrGUW5IcFby2s7/eYQpgd7WgR7fbMinVGRM0UZnq5HM0f7NQYdN/O0c
        CGu1V4TZpSts9QpBdC5S4MQ1THptZi9bXv7ah32ugIhEZC6B8CW9UqkodjofSI4FBo0uTDEMrwKSt
        tek8O9Pw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRIk3-00HVjD-Pa; Thu, 25 Aug 2022 19:42:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 807549800E6; Thu, 25 Aug 2022 21:42:12 +0200 (CEST)
Date:   Thu, 25 Aug 2022 21:42:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Refuse W^X violations
Message-ID: <YwfQlDFKvN2pic7Y@worktop.programming.kicks-ass.net>
References: <YwdpwykpV9RB+4tL@worktop.programming.kicks-ass.net>
 <202208251113.B5AFA6D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208251113.B5AFA6D@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 25, 2022 at 11:16:12AM -0700, Kees Cook wrote:
> On Thu, Aug 25, 2022 at 02:23:31PM +0200, Peter Zijlstra wrote:
> > x86 has STRICT_*_RWX, but not even a warning when someone violates it.
> 
> Yes please. I assume this is only kernel pages? Doing this globally is
> nice too, but runs into annoying problems[1].

Yeah, this interface should only be used on kernel pages.
