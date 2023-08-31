Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB990C83F37
	for <linux-hardening@archiver.kernel.org>; Thu, 31 Aug 2023 21:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347485AbjHaVEy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjHaVEw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 31 Aug 2023 17:04:52 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CECE58
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 14:04:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a1af910e0so1006808b3a.2
        for <linux-hardening@vger.kernel.org>; Thu, 31 Aug 2023 14:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693515889; x=1694120689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIzo2LBD81agdqbnvG9Ei0Uuoz7hAbrfR7IL8DHvg8w=;
        b=Q1Yw6Zj1JzEnzXZMJcUIu0t2DHu4NoUGGo0U+bDlhOc7kg4wKBexQoh6OjEKcsrxVe
         uaQ2+DZwgYg2nT9nlmhLqu6gcx25k7oWbTraqbusAUxdwAtY7nOO8xGIY2Boak58ftKt
         /EebIsxGyAgyeZGEPN9tn38A88hUrvYTL6pRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515889; x=1694120689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZIzo2LBD81agdqbnvG9Ei0Uuoz7hAbrfR7IL8DHvg8w=;
        b=TiAQVrM6Qq8rTAjnf0bb2h87c91MQxjwUKMtKZnDRSAAwD/4JnwH8CtusTVAKBuEXU
         mXm0KCIk0zrHPmoc7+/LQFDZtLUwQeDWahT0hkwlIig9QW5M1bvnnvcRZdNX/verFfUI
         0DI00cL7N84/8DXQzWQEn0jlmQyj73nLGWjKs+ccN4qWHYZ6W14I07zI8dw3YRqLZGYx
         JbDgd7dxAz2bc27vsgOUeH8d8RYrI9Jb6zk8HEWXf8r9i7kBLBRifXnRJPIjH+hzR9T5
         45zFKz2VIg6SiRlLRtbRtH4zTowGX5WAPynZaDePQDWR/a13b8JqCHZZ8qtTXjBCibL6
         RtWQ==
X-Gm-Message-State: AOJu0YyJutN350YtjLy7JpMPy0GnFFDv2EE8rxuw2ZhDf8zKe/jkYq1t
        QohhZgVKCz74v5uw7f85MwVycw==
X-Google-Smtp-Source: AGHT+IG5mBlw3wr5PKsYkuEkTYsra3ZdB1aft7ZjlwjT5ZLwBCBmO/IK0On1ae0vgAiWOWG8dGIzpQ==
X-Received: by 2002:a05:6a00:1397:b0:67a:9208:87a with SMTP id t23-20020a056a00139700b0067a9208087amr815479pfg.23.1693515889173;
        Thu, 31 Aug 2023 14:04:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7928d000000b00689f8dc26c2sm1678614pfa.133.2023.08.31.14.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:04:48 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:04:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-hardening@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2] fs: ocfs2: Replace strlcpy with sysfs_emit
Message-ID: <202308311404.875ABB0A@keescook>
References: <20230831193827.1528867-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831193827.1528867-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 31, 2023 at 07:38:27PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with sysfs_emit().
> 
> Direct replacement is safe here since its ok for `kernel_param_ops.get()`
> to return -errno [3].
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> [3] https://elixir.bootlin.com/linux/v6.5/source/include/linux/moduleparam.h#L52
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
