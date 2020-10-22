Return-Path: <SRS0=c/1i=D5=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D43EC388F9
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Oct 2020 23:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CEB2245F
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Oct 2020 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603407955;
	bh=7B683fiZBdj0VRUX2fu8XxbR2rPaeo50RNyuPG3ILDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ybw+2mcvUTzsCUO8UGvV6Gy0nvkKtbA9mVsBbChhrizGUiUE22xq+k4D6G+SjqeGw
	 NChcces04HOYEgo5OdeS2gKbsC+VeA+ZCtnT6KT2809au1sxISpt/IZrwEHBeTISQ4
	 aRO2JGByf6/qwS1x6lwt37wObUXQAMb/h0JYuCLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373211AbgJVXFz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Oct 2020 19:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373210AbgJVXFy (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Oct 2020 19:05:54 -0400
Received: from kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7245223BF;
        Thu, 22 Oct 2020 23:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603407954;
        bh=7B683fiZBdj0VRUX2fu8XxbR2rPaeo50RNyuPG3ILDQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lBRUyGGkMZVPoln+2s7NvyR8jgq0jTEu+OoYJ0k9jgIzZT6fuKGUfNKt0G0AiDde/
         KT0oqsagXwIN2+TSLa6xrqDWeyIQuKGqDXnUgzm2guGg/G1BukDy89XK4Scmyf5XtW
         dOaOLdzJP2xe+rFuZMSexDBqkUlksCGciQsUetOM=
Date:   Thu, 22 Oct 2020 16:05:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC][PATCH v3 3/3] Rename nla_strlcpy to nla_strscpy.
Message-ID: <20201022160551.33d85912@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <202010221302.5BA047AC9@keescook>
References: <20201020164707.30402-1-laniel_francis@privacyrequired.com>
        <20201020164707.30402-4-laniel_francis@privacyrequired.com>
        <202010211649.ABD53841B@keescook>
        <2286512.66XcFyAlgq@machine>
        <202010221302.5BA047AC9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 22 Oct 2020 13:04:32 -0700 Kees Cook wrote:
> > > > From: Francis Laniel <laniel_francis@privacyrequired.com>
> > > > 
> > > > Calls to nla_strlcpy are now replaced by calls to nla_strscpy which is the
> > > > new name of this function.
> > > > 
> > > > Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>  
> > > 
> > > The Subject could also be: "treewide: Rename nla_strlcpy to nla_strscpy"
> > > 
> > > But otherwise, yup, easy mechanical change.  
> > 
> > Should I submit a v4 for this change?  
> 
> I'll say yes. :) Drop the RFC, bump to v4, and send it to netdev (along
> with all the other CCs you have here already), and add the Reviewed-bys
> from v3.

Maybe wait until next week, IIRC this doesn't fix any bugs, so it's
-next material. We don't apply anything to net-next during the merge
window.
