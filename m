Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCA3C677F1
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 22:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjALWXl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjALWXA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 17:23:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA5632240
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:18:05 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w3so21619351ply.3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQuiKZTcysP+X0OflIm+diuT8xEgILcbwkQoyyI8+0o=;
        b=icewnOc84IIjF3zzON1xLWkC6RiMkayacySIOkPIsqmi6cQtvdd2hQxI3+R1O8RQDu
         6xssG6vq9iZNtd/vhg2VOo1//h0T38JpbGQGwQn3IyhXa/NsPMuhgLBnr/6c55KwHGD+
         kcXWnufqryq/ioVn+ogLnxmHf5hhSQx+6+rC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQuiKZTcysP+X0OflIm+diuT8xEgILcbwkQoyyI8+0o=;
        b=BBGI3Tmm/OleqWTRiU8jnLxBlM6XNMBQglWbQUsK7fVNlOAOnSAcJBPuHDD9uIJVxd
         ZMooPGB4nddcGE53hIx8FMS1vPaWvGNtfllcX+S6GdM7elNsceLT8788j9VY4OBRUIPa
         m615SUdt7VzSKfKWZZkhfQdIgFMrnsp/kyoWLx6JJAtoGSNWOuAipM3KmqsDUL2vigi2
         Y0gjO3MeJ9YeXOjYD9rvLA7m3++gXJTAuazjSu0GC/ukprgjyy49f7hiYlTq51WEnYTj
         bOazsVkFl9IsQbTQGWG0KEnFDasDL5fjdJzFs3VWIL5GswthY5y5ZvmyiZx8K3Deucpr
         1iEQ==
X-Gm-Message-State: AFqh2kqh/Tk3jTNClSpJv04urT8tkKgR/EvWqmgN9qfuoKsYa78PURIr
        c+Q4enY0QCEUEdOfO1/iTHZ0Hks+PyS0v/x3
X-Google-Smtp-Source: AMrXdXtXS1FFgjUUavPIWXAX+IH21ePUxx9ZCBLWfdePFzprzmAAeyLXPPq+TeOmmw8PlG9ERGp1IQ==
X-Received: by 2002:a17:902:db08:b0:194:5d2d:3c31 with SMTP id m8-20020a170902db0800b001945d2d3c31mr5929835plx.11.1673561885371;
        Thu, 12 Jan 2023 14:18:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ij18-20020a170902ab5200b00176e6f553efsm12621992plb.84.2023.01.12.14.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:18:04 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:18:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/erdma: Replace zero-length arrays with
 flexible-array members
Message-ID: <202301121418.4CCEA8115@keescook>
References: <Y7zCBqwC1LtabRJ9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zCBqwC1LtabRJ9@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 09, 2023 at 07:40:22PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> arrays, in a couple of structures, with flex-array members.
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
