Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B96FC001DE
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Aug 2023 17:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjHDREe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Aug 2023 13:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHDREd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Aug 2023 13:04:33 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8551994
        for <linux-hardening@vger.kernel.org>; Fri,  4 Aug 2023 10:04:24 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686b643df5dso1777873b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 04 Aug 2023 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691168664; x=1691773464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1MmhfCyIZOMeEDhOtD79SfGRR9Q8WxTvEMHrGhC5Kc=;
        b=CQfAd66BEqD2M6IXbd0tb3aW2XwoH/AfR5J8Poz90mZ4Xnhz3x5iRLOf2f0tfg6Ru+
         2lJ4vxmAsSME+f3VvopAdVAiP2u5OjWYRF77D5lRyvyZuTn8zxhh6rHOjGP6lLzSWxhO
         1C6i9MiOzqrKnKSKXD2b2TM62n6LOQ3ZU11mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168664; x=1691773464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1MmhfCyIZOMeEDhOtD79SfGRR9Q8WxTvEMHrGhC5Kc=;
        b=ap/NOi0BmNBZT+JVBTtZ8bc+lPlVYoLxDnAnGOJ9ivQGIj4IgmGzf0IaMApwncXpjR
         doD+WDa4VJ7JkLMWIU6mou+SnKw8ca9oaHWvZwo80/KNJ6GRFHc5/KKoryG03Dnk2UNC
         0X+SImy8nlMG83zJN1aEYT+P+lISZtDFT9FLs/FU4iy/zCDJCoCCsBzEg3C0XIrV0F36
         8aDjjOMeIeMrIknbOLnZQCEn1ZDRl+rb6H/pD9WDSd40WXQhUhyjop+3RlQPk1wiSq5v
         39/MSz2aO6NeBEpHQ4EE7uG5TJKmediVxSPZb6KnjpSdd0iMxQ1WmAJoxtuMG1ugdfgl
         WbIw==
X-Gm-Message-State: AOJu0YxqOhMinAeYNd62ObWfwCC/Iw1VFZlUcBh5DC+I7X04duCX6WID
        lqQ47392bi3Jeievrx4mixvlLA==
X-Google-Smtp-Source: AGHT+IGFsLzjoZ8QgB27YeRUt3NtJPg5ijrZzMbtYVDLPRLF/WCsZUPMUzhTW05cNwdmyDgiIvR5vw==
X-Received: by 2002:a05:6a00:1a12:b0:687:472f:5150 with SMTP id g18-20020a056a001a1200b00687472f5150mr2614887pfv.8.1691168664306;
        Fri, 04 Aug 2023 10:04:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b00682562bf477sm1814165pfn.82.2023.08.04.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:04:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     tony.luck@intel.com, gpiccoli@igalia.com, joel@joelfernandes.org,
        enlin.mu@unisoc.com, Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, enlinmu@gmail.com,
        yunlong.xing23@gmail.com
Subject: Re: [PATCH 1/1] pstore/ram: Check member of buffers during the initialization phase of the pstore
Date:   Fri,  4 Aug 2023 10:04:14 -0700
Message-Id: <169116865197.3054577.11464864173886707392.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
References: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 01 Aug 2023 14:04:32 +0800, Yunlong Xing wrote:
> The commit 30696378f68a("pstore/ram: Do not treat empty buffers as valid")
> would introduce the following issue:
> 
> When finding the buffer_size is zero, it would return directly.However, at
> the same time, if the buffer's start is a illegal value, the others would
> panic if access the buffer.
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/ram: Check member of buffers during the initialization phase of the pstore
      https://git.kernel.org/kees/c/fe8c3623ab06

Take care,

-- 
Kees Cook

