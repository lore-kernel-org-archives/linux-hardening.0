Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7211C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 12 Oct 2022 21:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJLVv5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJLVv4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 Oct 2022 17:51:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2510B780
        for <linux-hardening@vger.kernel.org>; Wed, 12 Oct 2022 14:51:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so3178130pjq.3
        for <linux-hardening@vger.kernel.org>; Wed, 12 Oct 2022 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMkdrM8a4Wm6Z/Kl7TEe3cCVNmmhtiA8aE9Kx1e3Q8s=;
        b=TUYKEN+G95sVztJY5CjEiECyR5GjIYpV5U9p0yjwdSyFEpYttm0RMi6Q0PWvQ6yFdV
         VRtvgxOp3uI3inCpGH3FOr6FjDyO2f7wwWJPI2kpYt73uTqjtQdh3KmhSMty8BRUfBl0
         N7ZuuYgqZ3MUCjC88KjYOmtJqPkmsSvqJyOCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMkdrM8a4Wm6Z/Kl7TEe3cCVNmmhtiA8aE9Kx1e3Q8s=;
        b=AjwWLgaKm6QWcYKZwrod2/um2nuWHDDP2ZTPnF6P+f42FpJknQTus3k8ae+pnpBWbI
         xyXI2b7ekh9JQLLxrbSxee80nSbotEJQokIxax47+lEkUyq3JwlutS/IyjiYIkbOKu8P
         hzN7RJ4DcyrXOXzEcPZRerKKsBO7wJYALb/7Ah2XUWiqSZPg2okV9SJiWPLnXWIEImzj
         tbwKmbxMmRdnBQ7dH9ACs0PopMIeW6dMDo4OQe06gVgT+WizwfTtruXjshHHS1ns6RWY
         YQl1I+af9MGg8mZ4h8knum7mOnv/tSa5AfM2K7Xx6JpZzkI/uDy93mg3EpMTOfG06DrK
         qkCw==
X-Gm-Message-State: ACrzQf1R9MRFcjr/+37Pps9vA7zFwttIvFXuKz1jenBSDK1CteNGTJqw
        E1XnmplxfPu92GCgHvWczkZ2mg==
X-Google-Smtp-Source: AMsMyM7iuF+bV6cq/p751ThV+63Wb/aSfEUUJyyZL5WMf3GxUkeQYQ2VDnLDDlLfuvl/Y+JZiAAuNg==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr7561080pjb.143.1665611514803;
        Wed, 12 Oct 2022 14:51:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n19-20020a170903405300b00177e5d83d3dsm11018291pla.170.2022.10.12.14.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 14:51:53 -0700 (PDT)
Date:   Wed, 12 Oct 2022 14:51:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-hardening@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] pstore/ram: Move internal definitions out of
 kernel-wide include
Message-ID: <202210121451.7CEC6637@keescook>
References: <20221011200112.731334-1-keescook@chromium.org>
 <20221011200112.731334-4-keescook@chromium.org>
 <5fdffa8b-04cb-b42f-e29a-03e9e9045424@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fdffa8b-04cb-b42f-e29a-03e9e9045424@igalia.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 12, 2022 at 04:46:44PM -0300, Guilherme G. Piccoli wrote:
> On 11/10/2022 17:01, Kees Cook wrote:
> > Most of the details of the ram backend are entirely internal to the
> > backend itself. Leave only what is needed to instantiate a ram backend
> > in the kernel-wide header.
> > 
> > Cc: Anton Vorontsov <anton@enomsg.org>
> > Cc: Colin Cross <ccross@android.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> Reviewed-and-tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> Tested by building and booting the kernel - since it's just header file
> rework, guess this is enough right?
> 
> BTW, let me know if you prefer me to respond on the series once or per
> patch Kees (as I'm doing here).

Thanks! Yeah, per-patch is good. :)

-- 
Kees Cook
