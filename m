Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60A4C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Oct 2022 23:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiJZXcp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Oct 2022 19:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233808AbiJZXco (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Oct 2022 19:32:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8201D836C3
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 16:32:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3712080pjc.5
        for <linux-hardening@vger.kernel.org>; Wed, 26 Oct 2022 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASNvt3YZA5URmImi9I7VajS1ONgiR7V+0imqEJ2tB40=;
        b=XXryU3Ajq0S/F4oMRkJQBOKdhp1zaWHobjAl9lt0O36OllcL/sZ9ErbE53FngsRRTI
         sPyH1gT2vnTcZQdDu5/XuNbKZFEQj3GHT59S/kjkcRGr2Ulo5fFfFwjGKJn8cF3QTGZr
         xK8TB+5QI28xW+uIaA80GBIA/O2GkzVcHJxsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASNvt3YZA5URmImi9I7VajS1ONgiR7V+0imqEJ2tB40=;
        b=muT2vhbWqFjKCVJoz+45L9d0Wuvj/X4pQs3mJbAMEL2gqCm44T7qTT1ZjKK4l+eel+
         oBZSVRYJtrQnMLGiRML5mzx/zyqjNEZWOPoSHX6MzVYnY/JaiWvzGJSdOVlNJIOViVZ6
         Usz0knL4M5qen+rP6wUeHw03r1JPFMAmJF49KJ3Q6Nrygbw81cz2OisGmklY7qtBY4SX
         vnt4Xj5gTfVSF7lnY8iLdHiIQbRQ4bv+45QkHb+0Y7bu+f5mkQnPONMciov2HnEcJEmC
         DGij7iVyaagzCr19FXMYNO/HOKJVeBOVs4hUCQVOpXS3vmL1WCKhpihVa3C/+CN8mqus
         a5dg==
X-Gm-Message-State: ACrzQf2mVE6FGCRr9Rhqr/6H083YSN7d6kMlBJZlJNDy2V8mfJ8i0iwb
        U0exPv2ntW+sKqVx9Fxfbb4QTr5VZxgwvg==
X-Google-Smtp-Source: AMsMyM5qsJkhUxULmVA6vqhL3AmD4D9tOiA7Gqkmft5jpW1wq0i2LYxDuO2aVrBlPHgOLrKj94F8vA==
X-Received: by 2002:a17:902:b101:b0:186:7067:3ea3 with SMTP id q1-20020a170902b10100b0018670673ea3mr33618100plr.59.1666827161964;
        Wed, 26 Oct 2022 16:32:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y76-20020a62644f000000b0056bc1a41209sm3514145pfb.33.2022.10.26.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 16:32:41 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:32:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        Dave Jones <davej@codemonkey.org.uk>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] NFS: Avoid memcpy() run-time warning for struct
 sockaddr overflows
Message-ID: <202210261631.DE7E4761E@keescook>
References: <20221017043107.never.457-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017043107.never.457-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 16, 2022 at 09:36:50PM -0700, Kees Cook wrote:
> The 'nfs_server' and 'mount_server' structures include a union of
> 'struct sockaddr' (with the older 16 bytes max address size) and
> 'struct sockaddr_storage' which is large enough to hold all the
> supported sa_family types (128 bytes max size). The runtime memcpy()
> buffer overflow checker is seeing attempts to write beyond the 16
> bytes as an overflow, but the actual expected size is that of 'struct
> sockaddr_storage'. Plumb the use of 'struct sockaddr_storage' more
> completely through-out NFS, which results in adjusting the memcpy()
> buffers to the correct union members. Avoids this false positive run-time
> warning under CONFIG_FORTIFY_SOURCE:
> 
>   memcpy: detected field-spanning write (size 28) of single field "&ctx->nfs_server.address" at fs/nfs/namespace.c:178 (size 16)
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Link: https://lore.kernel.org/all/202210110948.26b43120-yujie.liu@intel.com
> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> Cc: Anna Schumaker <anna@kernel.org>

Friendly ping -- this needs to land in v6.1 to avoid these warnings.
Should I carry this in the hardening tree instead?

Thanks!

-Kees

-- 
Kees Cook
