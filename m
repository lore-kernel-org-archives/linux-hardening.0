Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60804EB64D8
	for <linux-hardening@archiver.kernel.org>; Wed, 14 Jun 2023 19:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFNTCf (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjFNTCd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 14 Jun 2023 15:02:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4311FC8
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 12:02:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3c4c1fbd7so26420885ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 14 Jun 2023 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686769348; x=1689361348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YCZowOEZlyDvPFb00vEd70o77BSACcS6VLpIzsJZfs=;
        b=UL1esWWehBszKXIe8ACxXGNCnSPB/ARM1o1PbG0kVkV4nemWgox+TZaJYs9cpXwBEG
         0h98gqsB4/z9r4Nw7DjfLdCbyHyqk+L7nxIJn3QAQY99DdH+dOzfYBYK9rBT6k2Bcm8r
         bYtdfgVnSA3wMgKBWkyV1x2vHFzdRyoIOMt0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686769348; x=1689361348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YCZowOEZlyDvPFb00vEd70o77BSACcS6VLpIzsJZfs=;
        b=K6b3E0rI+0AN60iHJE+1vah1sz3EG9WIqRjie4fyY/pjS2uvfby3FPKku5yLMzAip6
         d3PLEfFz/V1TdNiWnOsEzCxNkHAFeLRJSnpvrYi2agHQ9HSr3SL6YHGtidpTj3Q5g9F4
         hL2AvnlzW9uNxiC9FC8+dH6meebLHZ8yeL6ddgy45XmWXSq+cOXnkUJ6LfnoyhYuixxi
         yllYrNcHP+TKNDces/xrBxKMwmYfjzy8+F3nLjsQ15IyZHUuhhxcjFp2SIARYZG1SQbq
         sImaT4Z1iFFf46Bu3g+EYd98l9W7AEywCYFnFnNB6CEDJtp9AgPdQdev7VvGFNEge40I
         3yrg==
X-Gm-Message-State: AC+VfDx9oGyZ+iqJPMazvznfcCaTL8XJbH+DgwruprVaOPoY9N32PdwV
        wK0Kgw1LKap9hAkh50gtGfcMZA==
X-Google-Smtp-Source: ACHHUZ5iJkud3crTR0HfcCGIrOI7RlnMqsNoWMWE3yB+liApSlR7CMUhT1lB2PDhQl1Imd3thY8NHQ==
X-Received: by 2002:a17:902:900b:b0:1b1:787d:1e47 with SMTP id a11-20020a170902900b00b001b1787d1e47mr10405803plp.41.1686769347821;
        Wed, 14 Jun 2023 12:02:27 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902bd9100b001a6dc4f4a8csm6080516pls.73.2023.06.14.12.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:02:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tony Luck <tony.luck@intel.com>, gpiccoli@igalia.com,
        jiasheng@iscas.ac.cn
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/ram: Add check for kstrdup
Date:   Wed, 14 Jun 2023 12:02:22 -0700
Message-Id: <168676933413.1964902.10975046622666156359.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230614093733.36048-1-jiasheng@iscas.ac.cn>
References: <20230614093733.36048-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 14 Jun 2023 17:37:33 +0800, Jiasheng Jiang wrote:
> Add check for the return value of kstrdup() and return the error
> if it fails in order to avoid NULL pointer dereference.
> 
> 

Applied to for-next/pstore, thanks!

[1/1] pstore/ram: Add check for kstrdup
      https://git.kernel.org/kees/c/d97038d5ec20

-- 
Kees Cook

