Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C976C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 20:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4401361288
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 20:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhKRU2W (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Nov 2021 15:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbhKRU2V (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Nov 2021 15:28:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF3C06174A
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 12:25:21 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x5so7240974pfr.0
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 12:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DmOUcqBTfTwJf0imYr9PhDvqApkQ9EskRtnB2cooYQk=;
        b=mmuEGToIWYQyDJXdvCkb5egnftKAdKxWHNnjluSOz1AYCDoHc7VhUgg5R56XDiAca+
         GbZdxV6Cm+i4feHYppaF6xnSDA+gSWG5XqPgJKzN/UWvg1OkTIEKx6hRmEg5QQMPp9KK
         GSnAHLJky368YvZRx5GkuKUnZ4OLMBKO4gKJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DmOUcqBTfTwJf0imYr9PhDvqApkQ9EskRtnB2cooYQk=;
        b=P2VxgcsN9KD1++fMhU5B5npgWbgGa7abHByVMkrjowrpICT2RSkSlJrVI5JxbaBeZW
         lTVO2OVe6vkDYvfXwii5ew2k5Qxu2agQtvQpwV9T+uUG5FyBXuxfZkcMw7TdzkkD8+tz
         FCZyQ590liIp25+BkBG6DcBKcnUc4b/5zz4uDWbBuZKUwYFvkFh+G8/WgltkG0FEag9M
         4wQeST6jVQk1HYJDjDYdZy9nuPJh8lQ/geGQq3fFrOQtKOz258eCAy8oWahG1D3oEICH
         0AMVctTs3AiAlROt/C3H3syll4aOOz3osGBTfEfHW+LCw0ZMYRmjLLnfkv0EAR3zxWAd
         PQnQ==
X-Gm-Message-State: AOAM531xhgXa47KeLVvaYKwo3sQRKq0mCwFDzK5A8P17dO/mm6+UqTIe
        6BWVi/yTSN+as0q3ieIrrv10Xg==
X-Google-Smtp-Source: ABdhPJz8o7m8VkVNvWarBWqsLDSqI+0t1S2A22KnaRzhJK6QAcXNV7pv+4ZwjYk9dM90zC9JW/FDxA==
X-Received: by 2002:a63:30a:: with SMTP id 10mr12849060pgd.229.1637267120689;
        Thu, 18 Nov 2021 12:25:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm485919pfj.26.2021.11.18.12.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:25:20 -0800 (PST)
Date:   Thu, 18 Nov 2021 12:25:19 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] intersil: Use struct_group() for memcpy() region
Message-ID: <202111181224.088CD29@keescook>
References: <20211118184158.1284180-1-keescook@chromium.org>
 <c5d8c214b5df75b5b77450d71c7aec9f3bd97a67.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d8c214b5df75b5b77450d71c7aec9f3bd97a67.camel@sipsolutions.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 18, 2021 at 08:46:11PM +0100, Johannes Berg wrote:
> On Thu, 2021-11-18 at 10:41 -0800, Kees Cook wrote:
> > 
> >  	/* 802.11 */
> > -	__le16 frame_control; /* parts not used */
> > -	__le16 duration_id;
> > -	u8 addr1[ETH_ALEN];
> > -	u8 addr2[ETH_ALEN]; /* filled by firmware */
> > -	u8 addr3[ETH_ALEN];
> > -	__le16 seq_ctrl; /* filled by firmware */
> > +	struct_group(frame,
> 
> Arguably, that should be 'header' rather than 'frame' :)

Works for me. :) I will rename it. Thanks!

-- 
Kees Cook
