Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7280C433DF
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA2022200
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 23:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q3sNzTyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgJSXBa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 19:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgJSXB3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 19:01:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1653C0613CE
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 16:01:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t14so907203pgg.1
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 16:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v/YljE+Ce3SN3iE6yVHbcSIgeb6VI0fs6fUo4ycl7mE=;
        b=Q3sNzTyJ9mec4scU/zzTMnXQ+DnL+U8zHWHC3VPENv8vbuHJtddtm4T2rqo1kzVIPG
         GtnDdXtnb9zNksK7NtXGZfVUlGve+pvRq+8NK9XC8/nLb2rx6XXUXXerGzAE6qH9Eyje
         ung+S398PsDq7GMDYQ6aGPv1EkmqTi4rQgsSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v/YljE+Ce3SN3iE6yVHbcSIgeb6VI0fs6fUo4ycl7mE=;
        b=YfZbjO5QcXOKS7xMv0VPpVB31cHQP5ifeB/XAuojNjCQV1nZVvgRbKiZBRzqyNtgGi
         aq4FkRlSBLmWX5PJL1JwhByXOogzMLZY/ON4ofWyZPN8/CuYlPkbshNZiqhdTSmyVUH3
         Yxg6V+qfH5OmXdXAsVx3wh4J1RtUzd9LiTd3nWjJSxBNlMwAla2LT1VCYNty/ulNaN6g
         wHpHMSSsnN+BQWrcYOAEcmbG0RIFWIh/RlNerPqMlxnRqtUWpWmy83l3w3Te5EnWZanW
         ucPfbU5KhrFVAZkhtM13ocktDPdzizu6U6SMV9qTrwGQwgKyEJcQkMICDHgd9dUAA/5n
         FIVw==
X-Gm-Message-State: AOAM530DaIEZc4djHxhVRTTbHsFDaTvAFJeh9k0WnwX1e3rg6BRP8srm
        TaabOdZWcROW0KltlbxhYAEdwjVFXO62iA==
X-Google-Smtp-Source: ABdhPJw7cM1W5ARVdJ636mKIGw2rcHLWfNZLPuo18XTMQSN7XBTgFUGpHJawX65zRAI1W1hvgcjnfA==
X-Received: by 2002:a63:5f4d:: with SMTP id t74mr130005pgb.310.1603148489232;
        Mon, 19 Oct 2020 16:01:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x5sm40915pfr.83.2020.10.19.16.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 16:01:28 -0700 (PDT)
Date:   Mon, 19 Oct 2020 16:01:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match
 that of strscpy.
Message-ID: <202010191559.3AC2C3F97@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
 <20201019152331.20583-1-laniel_francis@privacyrequired.com>
 <20201019152331.20583-3-laniel_francis@privacyrequired.com>
 <20201019094355.4f6f3826@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019094355.4f6f3826@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 19, 2020 at 09:43:55AM -0700, Jakub Kicinski wrote:
> On Mon, 19 Oct 2020 17:23:30 +0200 laniel_francis@privacyrequired.com
> wrote:
> > -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> > +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> >  {
> > +	size_t len;
> > +	ssize_t ret;
> >  	size_t srclen = nla_len(nla);
> >  	char *src = nla_data(nla);
> 
> Sort local variables long to short.

Specifically, "reverse christmas tree":

 	size_t srclen = nla_len(nla);
 	char *src = nla_data(nla);
 	size_t len;
 	ssize_t ret;


> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index 41a55c6cbeb8..f0bf64393cbf 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -223,7 +223,7 @@ static inline u32 tcf_auto_prio(struct tcf_proto *tp)
> >  static bool tcf_proto_check_kind(struct nlattr *kind, char *name)
> >  {
> >  	if (kind)
> > -		return nla_strlcpy(name, kind, IFNAMSIZ) >= IFNAMSIZ;
> > +		return nla_strlcpy(name, kind, IFNAMSIZ) > 0;
> 
> Bug.
> 
> >  	memset(name, 0, IFNAMSIZ);
> >  	return false;
> >  }

Have you been able to exercise the changed code paths? (I would have
expected this to immediately fail, for example.)

-- 
Kees Cook
