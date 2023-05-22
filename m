Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF8DC7EE33
	for <linux-hardening@archiver.kernel.org>; Mon, 22 May 2023 19:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjEVTkO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 22 May 2023 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjEVTj5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 22 May 2023 15:39:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757D132
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d57cd373fso1456233b3a.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 May 2023 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784390; x=1687376390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXaL9dlHiKAWAhbj1etQPCvf7dMzBz97/ah3yQwMB6g=;
        b=gpoq1bHzwlKS0iPW5k3t8e7bBhtTtRx0pYG/1AYIumv9bP7LU7vzTmv5vFfXH1drXd
         FdbjXVUfztD3qECHwfpWjSZLWiQONT4xGMAkugw9xTAzr1R+a3U5KuknPl9d5CFJidqr
         3IhLk1mlMqjJUkJkGq6L0ayNJXNAP3JA3bfdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784390; x=1687376390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXaL9dlHiKAWAhbj1etQPCvf7dMzBz97/ah3yQwMB6g=;
        b=LTVhD8tqlR3EspDoI89vxjgJ4bofl9Fwm4jUaAf2MyqT24jG8atASnBOgbJJyjJBGq
         lg+zo3WbVfaMMHoQbekK9kOglto5Np4wpNhwUGocNI9WEhAH0porI3azCJ8rs6dLJtXr
         DQ7gDP/hshtYcLkdg/DZsTZyqov9TEUerhbr1Ppu5/GkZkmJJMQyjWwVRBcRQptqD36o
         Z5ihvBZwNVj4n6X/HK4I85+g9qvJX1mW086TJNu/YZP4hrW3p3pvAgGa9aFW0/MQpQ0I
         /sXjGIlNVwwQigzYqSg3dn463SzrapvKToAuXsFVSIh0hAK2uwpugLhKsg9OAGYUnbl7
         DRTQ==
X-Gm-Message-State: AC+VfDzg+FpOcH6TZsT2BL3aT7KBf3lfzikYauEYtzJIbpRxTqT+weFk
        UE0/2bCXmD2drzQdnOvBEFlfBw==
X-Google-Smtp-Source: ACHHUZ5VIiMuHu+1y0eouyzj3q+4VKQ8xUtRKBhL4r1JwoLQxR5w8tpqBRw8gj/5ob3Z7R875tYTXg==
X-Received: by 2002:a17:903:452:b0:1af:cbdb:9772 with SMTP id iw18-20020a170903045200b001afcbdb9772mr34695plb.18.1684784390635;
        Mon, 22 May 2023 12:39:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bh12-20020a170902a98c00b001a6388ce38bsm5183579plb.240.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2i: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:39 -0700
Message-Id: <168478437625.244538.13691044123707581954.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517143130.1519941-1-azeemshaikh38@gmail.com>
References: <20230517143130.1519941-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 17 May 2023 14:31:30 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] scsi: bnx2i: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/91f1887a1420

-- 
Kees Cook

