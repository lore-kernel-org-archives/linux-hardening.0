Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AC6C433FE
	for <linux-hardening@archiver.kernel.org>; Thu,  6 Oct 2022 23:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiJFXqE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 6 Oct 2022 19:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiJFXqC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 6 Oct 2022 19:46:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6697EEA
        for <linux-hardening@vger.kernel.org>; Thu,  6 Oct 2022 16:46:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso5754719pjf.2
        for <linux-hardening@vger.kernel.org>; Thu, 06 Oct 2022 16:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SXIyK1qhAFzYku+XMAwTO5SsuTiW+z+CUM/bi0M+oVY=;
        b=cQNQsZN5V0cLpfD+qReSmh6yMS6vg9zkat2mnEwqEeL5JrMsu9LFdFPmp8KYq5kOQo
         xZQI0ZQNZ9gc1cT/DnIZQFHa9qVi4AXXJax/b4L633fAcfYqKCACD+sXvYyxY1pnh8tC
         d2vLw53KGHixXtXAm9YLsn9NJVGU/F0OrFNlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SXIyK1qhAFzYku+XMAwTO5SsuTiW+z+CUM/bi0M+oVY=;
        b=pmVKM/VdsWHN+IFmKH+m4Q+dK6lw/gVV+gVkknvRUZhzKU51kN93VEZaEcIHkW/0sD
         oGiVLWbkcnVC2S0RKbBAx/OlMgALe++WjJpUFF4RyzTxuVAVGqJtOstnqNtVpqVGMiL1
         b+EjP8uEUjhbHFlvkv0vFW8bvItKaqwBJuJO5uQxClePLn9DtY3Vl5OT3s21PLPFGSI8
         uCP66Arip8Ow4aIBaPIsjbj4g9kIj93gKyq7gdU/zcM6TuonASEdJ7SzYTDA3sC2+rkr
         B7YnNcc5yaoB6S8/8iRzLAe86RxgHIUy0Dgq7PsPyEBEbsaK1pyljM04pW/UzhGl/50K
         Iw+w==
X-Gm-Message-State: ACrzQf1IsI/3ZQNdWBK4BVYEkr1lFHqucOO6xn22CiXKV25xOKFjCHuw
        FGna4cte3qroK/BWtUUmw9g6tw==
X-Google-Smtp-Source: AMsMyM7S0DLXGaLHUTHuIwrz5s3/eHznEXFoLvCJF4JxofB+RnHtoNnvjhbdN1UqX7UB5q2C9Gctvg==
X-Received: by 2002:a17:903:110f:b0:178:a07e:e643 with SMTP id n15-20020a170903110f00b00178a07ee643mr1822628plh.41.1665099960119;
        Thu, 06 Oct 2022 16:46:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b00178b6ccc8a0sm196000pld.51.2022.10.06.16.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:45:59 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:45:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Message-ID: <202210061645.1BA58DED4D@keescook>
References: <20221006234138.1835739-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006234138.1835739-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 06, 2022 at 04:41:38PM -0700, Kees Cook wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The crypto 'compress' interface is deprecated, so before adding new
> features, migrate to the acomp interface. Note that we are only using
> synchronous implementations of acomp, so we don't have to deal with
> asynchronous completion.
> 
> [ Tweaked error paths to avoid memory leak, as pointed out byGuilherme
                                                              ^^
gah, I'll fix this typo locally. :P

-- 
Kees Cook
