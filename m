Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892ADC2D0E4
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Nov 2020 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B949206E5
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Nov 2020 14:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGQGb0z7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbgKXOfR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388145AbgKXOfR (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Nov 2020 09:35:17 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A090206E5;
        Tue, 24 Nov 2020 14:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606228516;
        bh=isQiEB8EFf0FqYopKV0XEnYRE8rJelIWCuTMf5qpqFk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGQGb0z7Nm1IV5xC7kEmkvsXVkN1kS7MXvFzmxQ0R05R+LEiULuQU4FBIs8HLHvPN
         dFPaRQ1Y95sHq2IkgNuFZ9TdUFqjtY2MLLW9loZ7QIFYc3sdg6qRsKTLRATT9z+GIp
         XF6Knb/srvuMlvmgUrvvz0/gQD0DPi+j9YBfDheo=
Date:   Tue, 24 Nov 2020 08:35:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Marius Zachmann <mail@mariuszachmann.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 086/141] hwmon: (corsair-cpro) Fix fall-through warnings
 for Clang
Message-ID: <20201124143532.GD16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <be5c59f9bc4bac8c968bbd7443d08eaaf8a28ef8.1605896060.git.gustavoars@kernel.org>
 <20201121185010.GB114144@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121185010.GB114144@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Nov 21, 2020 at 10:50:10AM -0800, Guenter Roeck wrote:
> On Fri, Nov 20, 2020 at 12:36:04PM -0600, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks, Guenter.
--
Gustavo
