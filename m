Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BDAC4332F
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Dec 2022 21:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLNVtF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Dec 2022 16:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLNVtD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Dec 2022 16:49:03 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670CE40449
        for <linux-hardening@vger.kernel.org>; Wed, 14 Dec 2022 13:49:02 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w23so4770616ply.12
        for <linux-hardening@vger.kernel.org>; Wed, 14 Dec 2022 13:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+31TVcZbQVfkTbbiw5O9TBq3yKVpcplDaH8+a0gR/CM=;
        b=Efm0dbIKL/j9IJ0lYIGfx5YCAi57xWuL62QscFdjVcC+VEa+TDKuePOyXXBMb0phGV
         6HBMc7hy1r0pyD+pkeyJ52USB7IiiKuUECs50RyxqZnlJK/dedgdiCWrrTssYzhesZyE
         f5OKQ/kslON/oYUWCJ++K2F6LWKDOY4GlAJeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+31TVcZbQVfkTbbiw5O9TBq3yKVpcplDaH8+a0gR/CM=;
        b=PeQOf/v2rOatiAwk7+A4aK1AiOhUqJ6sT6lEVyq1zSBqJxjAVqcUFI2isxXcKV3blz
         CrK+Ru9hzC0sb0VNPctTSIDVgWaiBHeHtg3UBsHUE+xDK+2WTkFIaPeTodQ5ZIwfBGs4
         NZv8qnzWZ9MyNo0SwmqG+/E7FiIeuAY6NbqWcspHMZ0QMQ99yJTUpMCuRIAqORIf4DTm
         PC5NZMbNb9/YHkEcEQwhZKOo9aeELLOyWSLZecagkIziPgE8rY0LvIpGERpJl2IpZXlE
         84waKhovyL1zN3c0WtrSNpo1pbq1s1LtkBhSXZ/eMF1zN+HXSkF6blSyixYcH4Hp6ho1
         go+A==
X-Gm-Message-State: ANoB5plTMJ5m3A+8nnH3L+97wmzu2+Uzv+P0o6mPToWf8CkJ4IVdsDrv
        hhrjPjkCrrN6UhH6D3DzYAcXAw==
X-Google-Smtp-Source: AA0mqf4CevhzWpnsEH+YwSnhMAcIQAMxfeL7BLkWOMsUAnIgZZi+JoiUyR/RD9XAXkYybl5sC53aqw==
X-Received: by 2002:a17:903:2ca:b0:189:8329:dba8 with SMTP id s10-20020a17090302ca00b001898329dba8mr32167358plk.39.1671054541957;
        Wed, 14 Dec 2022 13:49:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b001897916be2bsm2290041plh.268.2022.12.14.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:49:01 -0800 (PST)
Date:   Wed, 14 Dec 2022 13:49:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [next] pcmcia: synclink_cs: replace 1-element array with
 flex-array member
Message-ID: <202212141347.9AD66DEBC8@keescook>
References: <Y5mMWEtHWKOiPVU+@mail.google.com>
 <202212141124.736E3DE2A8@keescook>
 <Y5otilaHc6HBPCAF@mail.google.com>
 <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdHU3g_t8u-hr1C=mttvEq-jWmMuCwaQqXToP-kH3xstQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Dec 14, 2022 at 10:39:52PM +0200, Andy Shevchenko wrote:
> Yes, and Try to make it work with __packed. As I said, the problem is
> that the code is relying on something which is architecture dependent
> strictly speaking. And hence I disagree with Kees that v2 is okay to
> go.

I meant that v2 is functionally identical to the existing code.

> The full change should be something like
> 
> check_add(sizeof(), max_frame_size)
> kcalloc(8, size)

Right -- this would fix the existing mistakes in size calculation (and
is certainly better).

-- 
Kees Cook
