Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B49C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 13 Feb 2022 01:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiBMBDK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 12 Feb 2022 20:03:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiBMBDK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 12 Feb 2022 20:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32E2860054
        for <linux-hardening@vger.kernel.org>; Sat, 12 Feb 2022 17:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644714184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ins8sGNc9bHOmwljx/s1vxHKOLJy2EKsmlSrZVMjDnI=;
        b=KB/ayYPJwJXU9XV1XmcHWc4DXjLAo8ZmrHyNnwKJn6HlDhXVJzojxDqKWufIfIto+hvyAz
        y5qjgE+kKcM/uUp2VOGXQ2YQ5i7TuPVeEhOV1w1/wnkdGwhgbesvi4modnGUgC4iruA1D0
        DAESHYDlhvwBcEugmuWUZynSV8+KAkM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-bqA5_3yEOiKj18o6S1dfWA-1; Sat, 12 Feb 2022 20:03:02 -0500
X-MC-Unique: bqA5_3yEOiKj18o6S1dfWA-1
Received: by mail-ot1-f70.google.com with SMTP id l1-20020a9d7341000000b0059c2046f9edso7849027otk.3
        for <linux-hardening@vger.kernel.org>; Sat, 12 Feb 2022 17:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ins8sGNc9bHOmwljx/s1vxHKOLJy2EKsmlSrZVMjDnI=;
        b=Q4JSZtkWh5Ounpzx83T1phkOajnP5Ul0ovJ7jsEzI9ufWHuJz5glOmr+Jy6+ou2H39
         8QDEPmzdKLNiYujRuN+Knq4HclAId1Qgb3Bo//t+tMKG1xRv7GC49+daGVxjMF30/Uqb
         hTdrIOWMRCnotiUYhA22AGq+M/99Vdz7CUkxXV7wFEmaE7dOY91E8O9+m4OPzPnmRgP6
         k061EtQouRYfaHRENerA18CytORIrEW9mH5mQt1XKDKY61sL122GFDUFScb1ribUgIqA
         xjstMfdLTaUDVezN8Ggf7Qa+IDMIFpBocR2ClOD6/q2WYxX97KNG6F9jJ9ZklxHBY3ab
         HZmg==
X-Gm-Message-State: AOAM531PspSUX60Q+K6w0lbCygoNRh3MqE9ueVjdmZVKchS1DQCiY6RE
        GvEwweAxuMHRFJKAWQwDPLND5YYdEhxOjUK6AA02LqGFr8FkR8t5o5BaQ5keu3OmqbDOEUn5WOx
        qsgZPackjA8FLbwOdG6HrQAQPhDay
X-Received: by 2002:a05:6830:92:: with SMTP id a18mr2878494oto.373.1644714182191;
        Sat, 12 Feb 2022 17:03:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLlMZslbwgMVP9zAD5/X+Q5Yz8w5PDh7Q9JtMTWNAPu+5FtKAISWKRrI4EwXxFCANNDNkE1w==
X-Received: by 2002:a05:6830:92:: with SMTP id a18mr2878490oto.373.1644714181909;
        Sat, 12 Feb 2022 17:03:01 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id u5sm11273818ooo.46.2022.02.12.17.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 17:03:01 -0800 (PST)
Date:   Sat, 12 Feb 2022 17:02:57 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <20220213010257.yllouthdbjzawil2@treble>
References: <20220212181855.3460176-1-keescook@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20220212181855.3460176-1-keescook@chromium.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jpoimboe@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Feb 12, 2022 at 10:18:55AM -0800, Kees Cook wrote:
>  static inline void *xrealloc(void *ptr, size_t size)
>  {
> -	void *ret = realloc(ptr, size);
> -	if (!ret && !size)
> -		ret = realloc(ptr, 1);
> +	void *ret;
> +
> +	/*
> +	 * Convert a zero-sized allocation into 1 byte, since
> +	 * realloc(ptr, 0) means free(ptr), but we don't want
> +	 * to release the memory. For a new allocation (when
> +	 * ptr == NULL), avoid triggering NULL-checking error
> +	 * conditions for zero-sized allocations.
> +	 */
> +	if (!size)
> +		size = 1;
> +	ret = realloc(ptr, size);
>  	if (!ret) {
> -		ret = realloc(ptr, size);
> -		if (!ret && !size)
> -			ret = realloc(ptr, 1);
> -		if (!ret)
> -			die("Out of memory, realloc failed");
> +		/*
> +		 * If realloc() fails, the original block is left untouched;
> +		 * it is not freed or moved.
> +		 */
> +		die("Out of memory, realloc failed");

xrealloc() only has two uses -- both via ALLOC_GROW() -- and they don't
rely on the 'size == 0' freeing anyway.  How about simplifying this
further to just:

 	ret = realloc(ptr, size);
  	if (!ret)
		die("Out of memory, realloc failed");

Much easier to grok, and as a bonus, we don't need the long comments :-)

-- 
Josh

