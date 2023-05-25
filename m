Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A32AC77B7E
	for <linux-hardening@archiver.kernel.org>; Thu, 25 May 2023 19:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjEYTjd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 25 May 2023 15:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjEYTjd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 25 May 2023 15:39:33 -0400
X-Greylist: delayed 1188 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 12:39:03 PDT
Received: from smtp.outflux.net (mta.outflux.net [IPv6:2001:19d0:2:6:c0de:0:736d:7471])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9175101
        for <linux-hardening@vger.kernel.org>; Thu, 25 May 2023 12:39:03 -0700 (PDT)
Received: from serenity.outflux.net (serenity.outflux.net [10.2.0.2])
        by vinyl.outflux.net (8.15.2/8.15.2/Debian-10) with ESMTP id 34PIeYCD025811;
        Thu, 25 May 2023 11:40:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=outflux.net;
        s=2016010; t=1685040034;
        bh=9zwtAfyKF73stEa8mnj95uzHY/DupItIN7pSr8gdlHY=;
        h=Date:From:To:Cc:Subject:From;
        b=suyALfLFerSxQu4aHfUApIxWgxMlsLWM5WmEIEkT0K8HhWTgRglPKBLTfliOPAPrN
         fc5hQTEFRcL2pdtd0WMLEXv7KzrWwsDFM+Atw6y8DZwQQHKSCJHJZyzmJyI/1L426A
         GhG6BdUkNUAZ2UFL3AyaJPNo4uDErH9AcQWDFFmE=
Date:   Thu, 25 May 2023 11:40:34 -0700
From:   Kees Cook <kees@outflux.net>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-hardening@vger.kernel.org
Subject: Re: s390/defconfigs: set CONFIG_INIT_STACK_NONE=y
Message-ID: <ZG+rogQJO+U3kS4a@outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Outflux
X-MIMEDefang-Filter: outflux$Revision: 1.316 $
X-HELO: serenity.outflux.net
Envelope-To: linux-hardening@vger.kernel.org
Envelope-To: hca@linux.ibm.com
Envelope-To: agordeev@linux.ibm.com
X-Scanned-By: MIMEDefang 2.83
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Heiko,

I had this[1] patch pointed out to me, but I couldn't find any discussion
about it on public lists. Can you give me some background on this? There
haven't been any general workloads identified where this has been
a problem, so I'm curious why this was seen as globally an issue on
s390. The expectation was to use __uninitialized on any variables where
this was noticed as a performance issue, and where the memory safety of
the variable could be proven. Turning it off by default seems like
rather too much, but perhaps there is something unique to s390 I don't
know about. :)

Thanks,

-Kees

[1] https://git.kernel.org/linus/124acbe275040809abfa5fbe6e25790a53d5a161

-- 
Kees Cook                                            @outflux.net
