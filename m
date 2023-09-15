Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97144EE3F01
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 05:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjIOFbY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 01:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOFbY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 01:31:24 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DE62710
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 22:31:19 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-573c62b3cd2so1326856a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 14 Sep 2023 22:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694755879; x=1695360679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2oy3JQ3Ym6wgzqkudmTJFBYwdewLlXjODtSzjwIDM4=;
        b=JJdUekjU0GgMaIO7VMrqB5psc+GOo9qj4+2YeeQ1E463ZuZKI8zCoLmp2J+1l2X1SZ
         sSnYQOWIWGOLCeo8R1kuFyBnGfz8PcrZC0u7u1mn4QZcIfZF21n94lYztF0K34pnUQ9C
         EjMyDY3TV5K6jSmuJ6WCfNCRc7a5lrjQ9Qqw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755879; x=1695360679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2oy3JQ3Ym6wgzqkudmTJFBYwdewLlXjODtSzjwIDM4=;
        b=xMh3n7D5DbyehZ2jU5Nh4h98UMDourVQ2SKD2JAPhmKq4a+i1mYQhsBEGLFFG6Zm2R
         WwBazTM7WzoSjegZGDbInG8L/JHPUkf11k56DQOltyadsvS7OmVEMV5iES3VQg+ghzwz
         swkwDJZ6N1uPKQzmaklxryiXJ42Yz/HMDcG+atzJR/mZHxDz7IdFGVQSgQF1q+B/Wri5
         EX2Y4+Gr3Ol2Goi6qb/nROnINwcFajIoC+Bh30rCXHQeKCmnX5QwA31Q0BJLR/QSLv2g
         o/JPl2F1nqXfQTioyicH97swUat/rfMynKLxehC4DaWIFJg8t420punDFqIsTUiUB0Xq
         s+hA==
X-Gm-Message-State: AOJu0Yz/h1sKLpJZ9EeIb1KM99t0ydu1bVbdZp3FCmfVffqbqniy7Enm
        Zw9taZ7JHLk5hP+8ldeqQMF26w==
X-Google-Smtp-Source: AGHT+IHMIAlMdBTZtgkSQiGvMYyOxImIq1zcFtS0+vkG+SJ/6YzW7skLyFbJxSwvmiQQW6dl/k/Pfw==
X-Received: by 2002:a05:6a21:4886:b0:14d:abc:73dc with SMTP id av6-20020a056a21488600b0014d0abc73dcmr801625pzc.32.1694755878761;
        Thu, 14 Sep 2023 22:31:18 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a1709029a4100b001bfd92ec592sm2511764plv.292.2023.09.14.22.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:31:18 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kobject: Replace strlcpy with strscpy
Date:   Thu, 14 Sep 2023 22:31:16 -0700
Message-Id: <169475587548.4081176.2268827529789172345.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831140104.207019-1-azeemshaikh38@gmail.com>
References: <20230831140104.207019-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 31 Aug 2023 14:01:04 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] kobject: Replace strlcpy with strscpy
      https://git.kernel.org/kees/c/68a39dfd6f94

Take care,

-- 
Kees Cook

