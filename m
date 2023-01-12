Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FD5C63797
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 22:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjALWXk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbjALWW6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 17:22:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1FE321AD
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:17:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q23-20020a17090a065700b002290913a521so2833582pje.5
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=duA6Un7MMHsWwDUG6Y+g/Vg750sAKeltAfxhDAJWOzI=;
        b=esi4sIDLgCeEJk+u0yjNbzcOwnXIyrdFqNgIf/C/hPkZydzpXkwVQAN68jczLwo5Vy
         DjaWv1FKrmoOVsI/0IYwX7hEP8bcbjLX9gMOv2qJZ01Sb6xTbGwFMOr7weCr1vnx3hO8
         JxqhFjo+y4XHo7VkWAHe0Pp4x16s1XVBDAvHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duA6Un7MMHsWwDUG6Y+g/Vg750sAKeltAfxhDAJWOzI=;
        b=7KW4WD+8NgJcpH7ivC0HrvlGAXtSenNYe2ToqIHRgX7vkDZ0NkcahB5cSR5z0tjcFC
         xX9yyp9VzUWvvH3QasGw6i3qLTPajsQrFsRlBzmP8D4VvLQQO8ZiaQXBMH9kPq58eUUA
         OpuzQEEbe5kMJ0uAPhlgdcX0+9yO7y2aL/n69BDzQKzT2CKhfh9q5QFyAarN9pN5Q2j4
         qWAWYe9ym6vr/j60Bj68LOXhj6U940HfPiBWlmYwfC0nO8jB1UrSJbdxDFGUKZ+Fdv0q
         W1A5LEJgQAvLgDwhwBjjaE9RVgivl9jDq3QT/emJjCoxF9U69uStjEf9kw9sRSIwh7OX
         AKeQ==
X-Gm-Message-State: AFqh2kpx7JOQrgU60O9hup6xGS58p92q2FfzbYsl+Uck3aw8FBrWmoOZ
        lZO8VA0tBWGL0ql5Iq4OXEzPXQ==
X-Google-Smtp-Source: AMrXdXu4y1USXbmB33jWp7T1TGYvEnF6MOtrQLu8xzf4Ek5Cp8Os7yBkCc4yDy30ibdWeK8h+3oGNQ==
X-Received: by 2002:a17:902:9685:b0:192:f5a8:3099 with SMTP id n5-20020a170902968500b00192f5a83099mr26592237plp.5.1673561857844;
        Thu, 12 Jan 2023 14:17:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b00189db296776sm12808100plg.17.2023.01.12.14.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:17:37 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:17:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Neal Liu <neal_liu@aspeedtech.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] crypto: aspeed - Replace zero-length array with
 flexible-array member
Message-ID: <202301121417.EE86BDD5C@keescook>
References: <Y7zBxbEAvcEEJRie@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zBxbEAvcEEJRie@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 09, 2023 at 07:39:17PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> array declaration in struct aspeed_sham_ctx with flex-array
> member.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
