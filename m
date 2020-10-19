Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E131AC433DF
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81368222EC
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603125838;
	bh=6n9Rin6ZW84+hgDShmYfLcODzdk++AItfFTmMW50Htg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sCusUYP9/HkiWUBC9OJHnEwM4G12nMkDf+3My5NB2eWaIg3Vn9P7m0mt1QcIpOM35
	 IJYDgusr9mfizP75MmXjQBuED8DqR9Qyd0PZIZcBbaJkY+oQnhLRRFxLXnUwQ8Ua2T
	 B7A4mJxHf2z4nVrWWv/EMGQFA70qz/uMkTrdVar4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgJSQn6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 12:43:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729879AbgJSQn5 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 12:43:57 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05BB1222EA;
        Mon, 19 Oct 2020 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603125837;
        bh=6n9Rin6ZW84+hgDShmYfLcODzdk++AItfFTmMW50Htg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JwGFD5/2DVnZQ1JxKH3AktJOU9zD4kKKQ6w4UAGzJGw5uE1lGusOttrbueWQRi+rR
         bUUY3r3i4FMfUHNiq7e+OidiwzUHLwcR3eXJVY5rjCKPAB8pQUmhZ9MJvErrvr6gOW
         Ow0WhxUZwdlzRLvAAk1GvaC8R59h/XIi/IDpPEho=
Date:   Mon, 19 Oct 2020 09:43:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, davem@davemloft.net
Subject: Re: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match
 that of strscpy.
Message-ID: <20201019094355.4f6f3826@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201019152331.20583-3-laniel_francis@privacyrequired.com>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
        <20201019152331.20583-1-laniel_francis@privacyrequired.com>
        <20201019152331.20583-3-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, 19 Oct 2020 17:23:30 +0200 laniel_francis@privacyrequired.com
wrote:
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index d4d461236351..85f4ac779399 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/pkt_cls.h>
>  #include <linux/workqueue.h>
> +#include <linux/errno.h>

Stray include.

>  #include <net/sch_generic.h>
>  #include <net/act_api.h>
>  #include <net/net_namespace.h>
> diff --git a/lib/nlattr.c b/lib/nlattr.c
> index 07156e581997..d692716bda78 100644
> --- a/lib/nlattr.c
> +++ b/lib/nlattr.c
> @@ -713,30 +713,39 @@ EXPORT_SYMBOL(nla_find);
>   * @dst: where to copy the string to
>   * @nla: attribute to copy the string from
>   * @dstsize: size of destination buffer
> + * @returns: -E2BIG if @dstsize is 0 or source buffer length greater than

I don't think this is correct format for kdoc.

> + * @dstsize, otherwise it returns the number of copied characters (not
> + * including the trailing %NUL).
>   *
>   * Copies at most dstsize - 1 bytes into the destination buffer.
> - * The result is always a valid NUL-terminated string. Unlike
> - * strlcpy the destination buffer is always padded out.
> - *
> - * Returns the length of the source buffer.
> + * Unlike strlcpy the destination buffer is always padded out.
>   */
> -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
>  {
> +	size_t len;
> +	ssize_t ret;
>  	size_t srclen = nla_len(nla);
>  	char *src = nla_data(nla);

Sort local variables long to short.

>  
> +	if (dstsize == 0 || WARN_ON_ONCE(dstsize > INT_MAX))

You can make it > U16_MAX, attr len is 16 bit.

> +		return -E2BIG;
> +
>  	if (srclen > 0 && src[srclen - 1] == '\0')
>  		srclen--;
>  
> -	if (dstsize > 0) {
> -		size_t len = (srclen >= dstsize) ? dstsize - 1 : srclen;
> -
> -		memcpy(dst, src, len);
> -		/* Zero pad end of dst. */
> -		memset(dst + len, 0, dstsize - len);
> +	if (srclen >= dstsize) {
> +		len = dstsize - 1;
> +		ret = -E2BIG;
> +	} else {
> +		len = srclen;
> +		ret = len;
>  	}
>  
> -	return srclen;
> +	memcpy(dst, src, len);
> +	/* Zero pad end of dst. */
> +	memset(dst + len, 0, dstsize - len);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(nla_strlcpy);
>  

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 41a55c6cbeb8..f0bf64393cbf 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -223,7 +223,7 @@ static inline u32 tcf_auto_prio(struct tcf_proto *tp)
>  static bool tcf_proto_check_kind(struct nlattr *kind, char *name)
>  {
>  	if (kind)
> -		return nla_strlcpy(name, kind, IFNAMSIZ) >= IFNAMSIZ;
> +		return nla_strlcpy(name, kind, IFNAMSIZ) > 0;

Bug.

>  	memset(name, 0, IFNAMSIZ);
>  	return false;
>  }
