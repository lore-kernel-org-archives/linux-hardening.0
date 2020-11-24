Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8606BC2D0E4
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Nov 2020 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3C9206E5
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Nov 2020 14:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfmYRBxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbgKXOh7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:37:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388014AbgKXOh7 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Nov 2020 09:37:59 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FF50206E5;
        Tue, 24 Nov 2020 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606228678;
        bh=DZ4t8E4hJBebskLtc50cMLhJTVX4QWJqNwDFEoEsSMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZfmYRBxI1pkz0ueSh58HJf3wOBec6adp94k1lRsoPysdoAAANWCXvOw6xmvRE+S2F
         1RcMjVZi4I5ucuKY8anVEg4fn8JoX2RltAlBj3K3nIvGs2oggt4n4mEkWX87/+jQwg
         +JEFGCv87pNixl7yxoXpOsxnwJmSdDwaivi/z89M=
Date:   Tue, 24 Nov 2020 08:38:14 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 126/141] slimbus: messaging: Fix fall-through warnings
 for Clang
Message-ID: <20201124143814.GG16084@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <08a882fa7a3145bc33bc02392df8319e95092dcf.1605896060.git.gustavoars@kernel.org>
 <794916c9-30fb-1202-ec26-9abf750886dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794916c9-30fb-1202-ec26-9abf750886dc@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Nov 24, 2020 at 10:48:04AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 20/11/2020 18:39, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> 
> 
> Applied thanks,

Thank you, Srini.
--
Gustavo
