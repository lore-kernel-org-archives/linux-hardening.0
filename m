Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BEAC43334
	for <linux-hardening@archiver.kernel.org>; Tue, 21 Jun 2022 18:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350140AbiFUShR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 21 Jun 2022 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiFUShM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 21 Jun 2022 14:37:12 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127C0286D2
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 11:37:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q140so13881162pgq.6
        for <linux-hardening@vger.kernel.org>; Tue, 21 Jun 2022 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KvvKVXW/sF3CCgvWzO1+UQmz9NmEwy7k+JxEktlPKl8=;
        b=FwpRd+C8VyHIxPh24qIERs0HBqkbRwgwAQ1Ey4vme53Ytq2+w68vEiELcbjlJ2O0/s
         K+WbmruN8UNedYbIOSixMbRPPXJYN9wydQ2qV4zEqKhsyH5hz1d/PPoWpX5o4YeefP5R
         2Q/hE/Z0aab8siAhwrREOJM7iGMClOUAz8PVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KvvKVXW/sF3CCgvWzO1+UQmz9NmEwy7k+JxEktlPKl8=;
        b=jXsK/caWLUd7NrsJbVWAQe/7T0933svF2amtDyM38Zz2wMeLJgwHYKGfN5WTZVA4OQ
         Y5FJqcUfiOth1xZWPRbLmBsYZZbQ/RRMG7uuch58YpyQCbvJ+QnqzLwzvMd+rgD8K+ad
         Rqo8c+J1Xwvvtj3RX9mDWKEtKJRHwHg8MFFItu0UNUXy385DqyUrMCMYCzBSsnXt+i10
         foF3WIiYHCLC4Xc4imRpkZsQZZeMqgDhNN8qfiz3Hd9PKPLUiYVrBGPbspRVQRlUXl7k
         1NPGOxl48QwQYZKYq7BbZ+LJfC5o9id7YWZDQgLsxsMHQka0Kkwh8vV0YdhEWQnRiKg5
         r62g==
X-Gm-Message-State: AJIora8kJM6nc6QZyDfla8dqqlDBZ1MX28YnNbqFHvGgR2lTiC7bWdyl
        2iOJjc25H5AZlgcP+vnYf526HIR4IKTQhQ==
X-Google-Smtp-Source: AGRyM1srLGlep08NO9PoP+87YsSoAqxHKnx4zVf03cylMh3SYux/yo24GWb/AKKf6LhMrwVc5XPphA==
X-Received: by 2002:a05:6a00:230d:b0:4f6:ec4f:35ff with SMTP id h13-20020a056a00230d00b004f6ec4f35ffmr31505048pfh.53.1655836631530;
        Tue, 21 Jun 2022 11:37:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902768600b0016196bd15f4sm3768060pll.15.2022.06.21.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:37:11 -0700 (PDT)
Date:   Tue, 21 Jun 2022 11:37:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Coccinelle <cocci@systeme.lip6.fr>
Cc:     linux-hardening@vger.kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: replacing memcpy() calls with direct assignment
Message-ID: <202206211109.A819E8118@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello Coccinelle gurus! :)

I recently spent way too long looking at a weird bug in Clang that I
eventually worked around by just replacing a memcpy() with a direct
assignment. It really was very mechanical, and seems like it might be a
common code pattern in the kernel. Swapping these would make the code
much more readable, I think. Here's the example:


https://lore.kernel.org/linux-hardening/20220616052312.292861-1-keescook@chromium.org/

-		memcpy(&host_image->image_section_info[i],
-		       &fw_image->fw_section_info[i],
-		       sizeof(struct fw_section_info_st));
+		host_image->image_section_info[i] = fw_image->fw_section_info[i];

Is there a way to reduce the size of this cocci rule? I had to
explicitly spell out each "address of" condition separately, though I'd
expect them to be internal aliases, but I'd get output like:

 *&dst = src;

etc

@direct_assignment@
type TYPE;
TYPE DST, SRC;
TYPE *DPTR;
TYPE *SPTR;
@@

(
- memcpy(&DST, &SRC, sizeof(TYPE))
+ DST = SRC
|
- memcpy(&DST, &SRC, sizeof(DST))
+ DST = SRC
|
- memcpy(&DST, &SRC, sizeof(SRC))
+ DST = SRC
|

- memcpy(&DST, SPTR, sizeof(TYPE))
+ DST = *SPTR
|
- memcpy(&DST, SPTR, sizeof(DST))
+ DST = *SPTR
|
- memcpy(&DST, SPTR, sizeof(*SPTR))
+ DST = *SPTR
|

- memcpy(DPTR, &SRC, sizeof(TYPE))
+ *DPTR = SRC
|
- memcpy(DPTR, &SRC, sizeof(DST))
+ *DPTR = SRC
|
- memcpy(DPTR, &SRC, sizeof(SRC))
+ *DPTR = SRC
|

- memcpy(DPTR, SPTR, sizeof(TYPE))
+ *DPTR = *SPTR
|
- memcpy(DPTR, SPTR, sizeof(*DST))
+ *DPTR = *SPTR
|
- memcpy(DPTR, SPTR, sizeof(*SRC))
+ *DPTR = *SPTR
)

-- 
Kees Cook
