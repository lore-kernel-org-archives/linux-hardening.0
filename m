Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF879C433DF
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733252223C
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603150491;
	bh=TsjKDxR0MRR6i13p6YOLPVvdpgdeCLMlmXgeZiiVDh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vLDisAU/ISWe29FGZiR30OSpybe4bL3iN32ynCmnJ8pd2lQTLkIr09y8g7sLxICqK
	 qQR4LioW1oyhI+490WYKRUCCTtX7kwxPA80gODUpnA2R31wv61c1HGpsnSSSTAmhtq
	 eqtdPM7vCHFzuo9sUzUt67TCuTIlgapW2q8AsWg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbgJSXev (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 19:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389089AbgJSXev (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 19:34:51 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A522222F;
        Mon, 19 Oct 2020 23:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603150490;
        bh=TsjKDxR0MRR6i13p6YOLPVvdpgdeCLMlmXgeZiiVDh4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZdFeAhYL7ZU3Yad5U8TuiL1YMJcXhHlrd8fj7vziA9lxddBjJll5rowUOq1mUhZ1r
         G6mE/5En5wdHLKzGI+UI+G5nbYxqBoptpbB89bvuOkXu4P8ilkhQBLwDenU8F/7eMD
         e5TEZhxP2Bl5x6E0ryEfOnSw3MBADG+Uwb8JHNVI=
Date:   Mon, 19 Oct 2020 16:34:49 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     laniel_francis@privacyrequired.com,
        linux-hardening@vger.kernel.org, davem@davemloft.net
Subject: Re: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match
 that of strscpy.
Message-ID: <20201019163449.0a3f4675@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <202010191559.3AC2C3F97@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
        <20201019152331.20583-1-laniel_francis@privacyrequired.com>
        <20201019152331.20583-3-laniel_francis@privacyrequired.com>
        <20201019094355.4f6f3826@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <202010191559.3AC2C3F97@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 19 Oct 2020 16:01:27 -0700 Kees Cook wrote:
> On Mon, Oct 19, 2020 at 09:43:55AM -0700, Jakub Kicinski wrote:
> > On Mon, 19 Oct 2020 17:23:30 +0200 laniel_francis@privacyrequired.com
> > wrote:  
> > > -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> > > +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> > >  {
> > > +	size_t len;
> > > +	ssize_t ret;
> > >  	size_t srclen = nla_len(nla);
> > >  	char *src = nla_data(nla);  
> > 
> > Sort local variables long to short.  
> 
> Specifically, "reverse christmas tree":
> 
>  	size_t srclen = nla_len(nla);
>  	char *src = nla_data(nla);
>  	size_t len;
>  	ssize_t ret;

Or even

 	size_t srclen = nla_len(nla);
 	char *src = nla_data(nla);
 	ssize_t ret;
 	size_t len;

;)
