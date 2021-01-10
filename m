Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0D9C433E0
	for <linux-hardening@archiver.kernel.org>; Sun, 10 Jan 2021 20:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB36229C4
	for <linux-hardening@archiver.kernel.org>; Sun, 10 Jan 2021 20:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbhAJUtJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 10 Jan 2021 15:49:09 -0500
Received: from mother.openwall.net ([195.42.179.200]:51329 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726263AbhAJUtI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 10 Jan 2021 15:49:08 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2021 15:49:08 EST
Received: (qmail 31952 invoked from network); 10 Jan 2021 20:41:46 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 10 Jan 2021 20:41:46 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id CF145AB561; Sun, 10 Jan 2021 21:41:35 +0100 (CET)
Date:   Sun, 10 Jan 2021 21:41:35 +0100
From:   Solar Designer <solar@openwall.com>
To:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: linux-hardening list archive
Message-ID: <20210110204135.GA4399@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

I've just setup an alternative web archive of the linux-hardening list:

https://lists.openwall.net/linux-hardening/

This has messages from its very beginning (I had subscribed a separate
address to it for that purpose).

This is in addition to the below archives, which existed before:

https://lore.kernel.org/linux-hardening/

https://www.openwall.com/lists/kernel-hardening/
https://lore.kernel.org/kernel-hardening/

Alexander
