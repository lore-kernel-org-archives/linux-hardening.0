Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F032C433E7
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B5A2223C
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603150455;
	bh=l9VhE0o7JvzRxRwI16WBN6mE3F5nk7sBwoo9Mfmg17Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d9/f8LmGSLBpnnojEiuPbs8hVN6SkgQwEs9SyEWLjvTdCCm6B1iGLR2aaraO8H5b3
	 uhfMrChzar7WD4Vea4AoOmsImnRjG3S8sbgBw8rI7bpwDJLsip5J3lydfzB2pRoYND
	 AzkvYt/NF8t7+lhDdFldJQ9gNrwGCkg7xbgmzT1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbgJSXeO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 19:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgJSXeO (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 19:34:14 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A582222F;
        Mon, 19 Oct 2020 23:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603150454;
        bh=l9VhE0o7JvzRxRwI16WBN6mE3F5nk7sBwoo9Mfmg17Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uArj5/KE63WyvFJlJYyTSvRxQ+jOWe/5AGGImzttDt2PLOphztjoRxG8ty6yspIfi
         Ykhn32N2B21qMpRx7E8R/5xhnPHoDtF5CihcMd9JPiPr9TqeXRu/39KT8oEKF78u6s
         mjlJfDbdXK45ZUcITjm0NQ89b0tZoxUMJqieFZ80=
Date:   Mon, 19 Oct 2020 16:34:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     laniel_francis@privacyrequired.com,
        linux-hardening@vger.kernel.org, davem@davemloft.net
Subject: Re: [RFC][PATCH v2 0/3] Fix inefficiences and rename nla_strlcpy
Message-ID: <20201019163412.28c81fc4@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202010191557.C2653B0A@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
        <20201019152331.20583-1-laniel_francis@privacyrequired.com>
        <20201019094515.46db8af1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <202010191557.C2653B0A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 19 Oct 2020 15:58:36 -0700 Kees Cook wrote:
> On Mon, Oct 19, 2020 at 09:45:15AM -0700, Jakub Kicinski wrote:
> > On Mon, 19 Oct 2020 17:23:28 +0200 laniel_francis@privacyrequired.com
> > wrote:  
> > > To sum up, the first patch fixes an inefficiency where some bytes in dst were
> > > written twice, one with 0 the other with src content.
> > > The second one modifies nla_strlcpy to return the same value as strscpy,
> > > i.e. number of bytes written or -E2BIG if src was truncated.
> > > The third rename nla_strlcpy to nla_strcpy.
> > > 
> > > Unfortunately, I did not find how to create struct nlattr objects so I tested
> > > my modifications on simple char*.
> > > This is why I tag this patch set as RFC.
> > > 
> > > If you see any way to improve the code or have any remark, feel free to comment.  
> > 
> > You follow semantics of strscpy, yet rename to strcpy. Wouldn't it be
> > more intuitive for developers to rename to nla_strscpy?  
> 
> It's closer to strscpy_pad() but that seems a long name. What's
> preferred from the NLA perspective?

I think the pad part is pretty much implied in the netlink world.
All this stuff goes to user space, so we can't have uninit memory. 
We may get more informed opinions once this hits netdev@.
