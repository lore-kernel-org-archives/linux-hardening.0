Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23011ECAAA1
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Sep 2022 23:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIBXIJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Sep 2022 19:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIBXIF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Sep 2022 19:08:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3EBEA32F
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 16:08:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 78so3126198pgb.13
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 16:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2Y8DDYCQ2otafS/ANml07S73pAs/kgkgSqxooJ7MzEo=;
        b=gZymZsu4nzF/sx2Kz8zdZO31rMaivj6sqqslSfIi8ycb86aOj28XmAjpjIbdkCFQ7r
         1skyr/j6bBsNu89R3L78IRSsABgw3ZrAO6Vc19tV0nU8nt2luO9ZtwPs5x/v28CNEn/2
         k4161ORZTExXAnMbY7/dBGXpFV6cKkAhVn9Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2Y8DDYCQ2otafS/ANml07S73pAs/kgkgSqxooJ7MzEo=;
        b=two/JqHYQtYiCntjDwFmZBdKg7Cb6cwdVyJPoWcKDaX9YhwAINFeNsCYmTJw7g1zBR
         G+0FxsjuuQaDGrDbu14ZdT1ZKp4c4CwRccJYPSCeOnE5Z4XfT4ID3pqUG74ApGy6oIZR
         NlBxcIA9F9bNBZpZbnrn5N8UoxZRPAfE3GggtVRlqfWN1bJC3lSS6zAUtyglOXhrP8MG
         npDkZI2D/KitMe3WgLJ4O+8e02jyL4FZELSLXxDfdb2YbsEc/VDppLJtGXpOA81TRiWK
         sRVD3MiuwqxaGo/czpI4NijEipMXo7noX6EYwxI4/eHm+tPPCE0Byfe4zNO2vilxkq8d
         NfBA==
X-Gm-Message-State: ACgBeo1gA8H7Nb3K6NxFnQN/VdduvRdDejP6OR+BnAfZrNf6oh61kcYv
        Gs2BOilgi3E0/DlQg0dgGS2dmQ==
X-Google-Smtp-Source: AA6agR6G3F1xMyBZPBMpPkGlBoDBrXr4WjKwOB3BRE0dZXW8W2Nl66PYsdn9DsbS0atfylWEgULAbw==
X-Received: by 2002:a63:41c5:0:b0:42c:6b7f:6d95 with SMTP id o188-20020a6341c5000000b0042c6b7f6d95mr19124355pga.175.1662160084174;
        Fri, 02 Sep 2022 16:08:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b0016dbaf3ff2esm2207368pls.22.2022.09.02.16.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 16:08:03 -0700 (PDT)
Date:   Fri, 2 Sep 2022 16:08:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        syzbot <syzkaller@googlegroups.com>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] netlink: Bounds-check struct nlmsgerr creation
Message-ID: <202209021555.9EE2FBD3A@keescook>
References: <20220901071336.1418572-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901071336.1418572-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 01, 2022 at 12:13:36AM -0700, Kees Cook wrote:
> For 32-bit systems, it might be possible to wrap lnmsgerr content
> lengths beyond SIZE_MAX. Explicitly test for all overflows, and mark the
> memcpy() as being unable to internally diagnose overflows.
> 
> This also excludes netlink from the coming runtime bounds check on
> memcpy(), since it's an unusual case of open-coded sizing and
> allocation. Avoid this future run-time warning:
> 
>   memcpy: detected field-spanning write (size 32) of single field "&errmsg->msg" at net/netlink/af_netlink.c:2447 (size 16)

To get rid of the above warning...

> [...]
> -		memcpy(&errmsg->msg, nlh, nlh->nlmsg_len);
> +		unsafe_memcpy(&errmsg->msg, nlh, nlh->nlmsg_len,
> +			      /* "payload" was explicitly bounds-checked, based on
> +			       * the size of nlh->nlmsg_len.
> +			       */);

above is the "fix", since the compiler has no way to know how to bounds
check the arguments. But, to write that comment, I added all these
things:

> [...]
> -	if (extack->cookie_len)
> -		tlvlen += nla_total_size(extack->cookie_len);
> +	if (extack->_msg &&
> +	    check_add_overflow(*tlvlen, nla_total_size(strlen(extack->_msg) + 1), tlvlen))
> +		return false;

If that's not desirable, then I guess the question I want to ask is
"what can I put in the unsafe_memcpy() comment above that proves these
values have been sanity checked? In other words, how do we know that
tlvlen hasn't overflowed? (I don't know what other sanity checking may
have already happened, so I'm looking directly at the size calculations
here.)

I assume this isn't more desirable:

-	if (extack->cookie_len)
-		tlvlen += nla_total_size(extack->cookie_len);
+	if (extack->cookie_len) {
+		size_t len = nla_total_size(extack->cookie_len);
+
+		if (WARN_ON_ONCE(len > SIZE_MAX - tlvlen))
+			return 0;
+		tlvlen += len;
+	}

Or maybe wrap it nicely with a local macro and return 0 instead of
trying to pass an error up a layer?

+#define TLVADD(amount)	do { \
+	if (WARN_ON_ONCE(check_add_overflow(tlvlen, amount, &tlvlen))) \
+		return 0; \
+} while (0)

...
	if (extack->cookie_len)
-		tlvlen += nla_total_size(extack->cookie_len);
+		TLVADD(nla_total_size(extack->cookie_len));

-- 
Kees Cook
