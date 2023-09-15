Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71776EED61A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 18:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjIOSsB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 14:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjIOSrr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 14:47:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46076422F
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 11:44:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf1935f6c2so18213205ad.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694803482; x=1695408282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Itsw2lvjOF4d1lcaGatZ2lrxzNTInyFHU12iNAuhsa0=;
        b=UcohAoQAIsWWDIgI7BS4TdftP8BkbFCWvYnlnqDpaUUXHCH9eMK8yVInnUisQPL/nW
         A7oQQCsvjwu+RLSIEUvthKcMWY8iucOrVF5JVTBqvllmUOvFSIvU9CIqvhLQylqUJaqx
         Yp9nPC5lhePXZuKibzmoFKXut+dIY8LbYzvMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803482; x=1695408282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Itsw2lvjOF4d1lcaGatZ2lrxzNTInyFHU12iNAuhsa0=;
        b=gqfJUsGW7PTcjWKBIQFhQNfmEgYWvy6vfkRPG75yfMULdf/cRBKrYxb8WLD7KGwguu
         aY0NSQ7AJ7yt1YJ/JlKW1bgkl/ZQBjf5HtxmPz5jqoQoX17HJBHl4xHHUbGqTi6/BRDL
         NigJlCSSJfBPTrAd3MAiAn+aDWSAcOg7RjZ8HSdrcR6NZgvzzWcBztl8tNS0JhWZoqLC
         3VK6Lb3hYELTJl6bt7t8rFrEmldiqjNGcOU23kJwdOxQ5id2TiPVyJhE68umfy8RR2hL
         QAbj6ybmmj/ApbqzJ5rKkGXe+tCi6b6qkQtIKdd5iMhvk0NyFXywXcBv3WBVzXZCsxgN
         G5QA==
X-Gm-Message-State: AOJu0Yyqz/aa27iWFizCxUUxKcD7Gu2jkqtVLum9rgY2oEZ41iB6e82W
        JyM3nI9mATKqkTmjgWXTCvUpjg==
X-Google-Smtp-Source: AGHT+IGM/U9TMc9dhOkJaD9Q2LSMeEhEmfp04Mj+FcHBxuLYmJmp+99UA23YpkT+qqmkIf+jiqtkCQ==
X-Received: by 2002:a17:902:c213:b0:1c3:b0c7:38bf with SMTP id 19-20020a170902c21300b001c3b0c738bfmr6342438pll.12.1694803481936;
        Fri, 15 Sep 2023 11:44:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001bb9aadfb04sm3771453plr.220.2023.09.15.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:44:41 -0700 (PDT)
Date:   Fri, 15 Sep 2023 11:44:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] gve: Use size_add() in call to struct_size()
Message-ID: <202309151144.E420B9F8@keescook>
References: <ZQSfze9HgfLDkFPV@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSfze9HgfLDkFPV@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 12:17:49PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, `tx_stats_num + rx_stats_num` wraps around, the
> protection that struct_size() adds against potential integer overflows
> is defeated. Fix this by hardening call to struct_size() with size_add().
> 
> Fixes: 691f4077d560 ("gve: Replace zero-length array with flexible-array member")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, yes, this will maintain SIZE_MAX saturation if it happens.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
