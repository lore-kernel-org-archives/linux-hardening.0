Return-Path: <SRS0=j6/H=DX=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB67C433DF
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 23:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7820878
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Oct 2020 23:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G63Hwl5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411025AbgJPXXN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Oct 2020 19:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410893AbgJPXW7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Oct 2020 19:22:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E08C061755
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 16:23:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e7so2335284pfn.12
        for <linux-hardening@vger.kernel.org>; Fri, 16 Oct 2020 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pLs09UMoDp9HrIDfkv4iPleSUZSO+smCz4Hc7irgDJc=;
        b=G63Hwl5rIXFRYhWx8AvknsilWxX30g5N4VJePSsWJ73+RjY059IJbEnC1f7od/ZJzI
         2Yy6LWbSErrPJY0WjUojY2hafxPULj8Ndmjf6NeNlgyG50AS2W9c7DyF503QkYWu/MJk
         OpeAe3iUpS0YPPXPqWpY3p44sB1Z691czo2MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pLs09UMoDp9HrIDfkv4iPleSUZSO+smCz4Hc7irgDJc=;
        b=NVqt/P45+DW29WNDD5iZUvHWbL7CKDOc1KNzTHv8mcxjd0dfiOEWCepO+u5wY2jnT4
         yX0C49SvNDareD33ofCizKKQxKJEEw3Az4CCfIucuxbuhEE1+V3z15q2Dx99OVZYcEid
         h2KwasjgD2LgmIrTdRXUWReF/PfD/Sb5VbZX8IuqRUVLMVzHc+ag1OxhHMCU5JhEabOt
         N4I91ldtQ1naJPqzoiyierocQzSjnxYswGQTuAkN+turySeyaCwr8wIadEJbjpASXL2H
         NZc+//SFKsFC+c/oHKfXRZsYcwfMKv7J6TmupUaKt+p9f9kFA+RGC5hoIBDUpvZn5NwS
         u2lw==
X-Gm-Message-State: AOAM532Ts/XpjhN5coRhEpaHIj9KT4Y54k4LSdNIMs7g5OfWEAItpdwS
        gL0AI20vgxRh1Rqbke/I/6JTMw==
X-Google-Smtp-Source: ABdhPJyv6ghvIWzrAyb/zjPWQj4sOhTSgCuPf5i2/uBbI5UVGEeAqAWP50uzQA8SEDZX2PjVQ7HWyQ==
X-Received: by 2002:a05:6a00:15d5:b029:155:cb6f:cfe3 with SMTP id o21-20020a056a0015d5b0290155cb6fcfe3mr5973952pfu.11.1602890592138;
        Fri, 16 Oct 2020 16:23:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm3834403pfq.141.2020.10.16.16.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 16:23:11 -0700 (PDT)
Date:   Fri, 16 Oct 2020 16:23:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 2/3] Modify return value of nla_strlcpy to match that
 of strscpy.
Message-ID: <202010161620.3B240DBCC1@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
 <20201016125216.10922-3-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016125216.10922-3-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Oct 16, 2020 at 02:52:15PM +0200, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> This patch solves part 2 of issue: https://github.com/KSPP/linux/issues/110

As with the others, this needs a full commit log (imagine someone
doesn't have access to read that issue, etc).

> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>
> ---
>  include/net/netlink.h |  2 +-
>  include/net/pkt_cls.h |  3 ++-
>  lib/nlattr.c          | 31 ++++++++++++++++++++-----------
>  net/sched/act_api.c   |  2 +-
>  net/sched/sch_api.c   |  2 +-
>  5 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/netlink.h b/include/net/netlink.h
> index 7356f41d23ba..446ca182e13d 100644
> --- a/include/net/netlink.h
> +++ b/include/net/netlink.h
> @@ -506,7 +506,7 @@ int __nla_parse(struct nlattr **tb, int maxtype, const struct nlattr *head,
>  		struct netlink_ext_ack *extack);
>  int nla_policy_len(const struct nla_policy *, int);
>  struct nlattr *nla_find(const struct nlattr *head, int len, int attrtype);
> -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize);
> +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize);
>  char *nla_strdup(const struct nlattr *nla, gfp_t flags);
>  int nla_memcpy(void *dest, const struct nlattr *src, int count);
>  int nla_memcmp(const struct nlattr *nla, const void *data, size_t size);
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index d4d461236351..f42db07c399b 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/pkt_cls.h>
>  #include <linux/workqueue.h>
> +#include <linux/errno.h>
>  #include <net/sch_generic.h>
>  #include <net/act_api.h>
>  #include <net/net_namespace.h>
> @@ -512,7 +513,7 @@ tcf_change_indev(struct net *net, struct nlattr *indev_tlv,
>  	char indev[IFNAMSIZ];
>  	struct net_device *dev;
>  
> -	if (nla_strlcpy(indev, indev_tlv, IFNAMSIZ) >= IFNAMSIZ) {
> +	if (nla_strlcpy(indev, indev_tlv, IFNAMSIZ) == -E2BIG) {

I would make these tests all be "< 0" rather than specifically -E2BIG.

>  		NL_SET_ERR_MSG_ATTR(extack, indev_tlv,
>  				    "Interface name too long");
>  		return -EINVAL;
> diff --git a/lib/nlattr.c b/lib/nlattr.c
> index ab96a5f4b9b8..83dd233bbe3e 100644
> --- a/lib/nlattr.c
> +++ b/lib/nlattr.c
> @@ -713,29 +713,38 @@ EXPORT_SYMBOL(nla_find);
>   * @dst: where to copy the string to
>   * @nla: attribute to copy the string from
>   * @dstsize: size of destination buffer
> + * @returns: -E2BIG if @dstsize is 0 or source buffer length greater than
> + * @dstsize, otherwise it returns the number of copied characters (not
> + * including the trailing %NUL).
>   *
>   * Copies at most dstsize - 1 bytes into the destination buffer.
> - * The result is always a valid NUL-terminated string. Unlike
> - * strlcpy the destination buffer is always padded out.
> - *
> - * Returns the length of the source buffer.
> + * The result is always a valid NUL-terminated string.
>   */
> -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
>  {
> +	size_t len;
> +	ssize_t ret;
>  	size_t srclen = nla_len(nla);
>  	char *src = nla_data(nla);
>  
> +	if (dstsize == 0 || WARN_ON_ONCE(dstsize > INT_MAX))
> +		return -E2BIG;

Cool, yeah, good to include.

> +
>  	if (srclen > 0 && src[srclen - 1] == '\0')
>  		srclen--;
>  
> -	if (dstsize > 0) {
> -		size_t len = (srclen >= dstsize) ? dstsize - 1 : srclen;
> -
> -		memcpy(dst, src, len);
> -		dst[len] = '\0';
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
> +	dst[len] = '\0';
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL(nla_strlcpy);

Otherwise, I think this looks good. (Though same note about
zero-padding.)

>  
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index f66417d5d2c3..ed411d6c29fc 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -935,7 +935,7 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
>  			NL_SET_ERR_MSG(extack, "TC action kind must be specified");
>  			goto err_out;
>  		}
> -		if (nla_strlcpy(act_name, kind, IFNAMSIZ) >= IFNAMSIZ) {
> +		if (nla_strlcpy(act_name, kind, IFNAMSIZ) == -E2BIG) {
>  			NL_SET_ERR_MSG(extack, "TC action name too long");
>  			goto err_out;
>  		}
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 2a76a2f5ed88..3e89c666d1e8 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1170,7 +1170,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  #ifdef CONFIG_MODULES
>  	if (ops == NULL && kind != NULL) {
>  		char name[IFNAMSIZ];
> -		if (nla_strlcpy(name, kind, IFNAMSIZ) < IFNAMSIZ) {
> +		if (nla_strlcpy(name, kind, IFNAMSIZ) != -E2BIG) {
>  			/* We dropped the RTNL semaphore in order to
>  			 * perform the module load.  So, even if we
>  			 * succeeded in loading the module we have to
> -- 
> 2.20.1
> 

-- 
Kees Cook
