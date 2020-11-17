Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB0C63798
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Nov 2020 22:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD8422210
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Nov 2020 22:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lV3mhNUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgKQWEH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Nov 2020 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQWEG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Nov 2020 17:04:06 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588A5C0617A6
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2020 14:04:05 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id ei22so1321507pjb.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2020 14:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xkxgOlLMZv/mBA18RIBww2IQHFUe3xRNs8TjbDvkQ4I=;
        b=lV3mhNUanzdZGMsD9jHTT/dHxKx9Utu3wkgIXFkUSb2BLpcFUnW637CqWtmiC90PcD
         g9hoaxhu/Ft8znXxLZGKjE/iLkT6TUkjoQRaJOkebthXpOs5L2htShYa4Isl6A+CY3PD
         5WUaIy2o4fEUVa+u+vcsn+4pjSvoFGvvbQG9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkxgOlLMZv/mBA18RIBww2IQHFUe3xRNs8TjbDvkQ4I=;
        b=GYs/M68HYROSG2gApNzQ2KlazXOT7lx7BA9c8Xl+EQIqt+De79LKysUV3WCRKSxHMy
         fc3jsRL+9rQm9xtvN9kcm9d6WT0JbTffcf6G9seN2jI+BDQDfdP87y5JY3J8HPJ39KKa
         tkhGoAISq52R2UEH1xbUJDVap3hA6kTWgIt1hIhvJadOjcZ9x2oXp494cbrxoDWHMRfv
         vZLg9qnciMyTFydcWIkV+8Rh4lpSmjZgMA7DDjsHciuDBnx863K6uyAVzihRswGsCe0/
         UUpgaM53TtOtpdLuTypFBOV/jeoRCf0GxY1saLkVITd0+9+eWEhRYM/iGm+09L1eYogJ
         D59Q==
X-Gm-Message-State: AOAM531ZjUFuGCGfOumWhFf/hmP6KStfztoD9+91Lcyxwqhw6RwH6P9b
        jfhZL9Bmy01RTgul2hAyp4pEbIs5uQeYQsFN
X-Google-Smtp-Source: ABdhPJyohZgaVAYUdKDqvhhYQdby2vb0mA0oc9Jlf4eyYgbaE6wkBTD9m4fVND4RAXZfsyem5dpU1A==
X-Received: by 2002:a17:902:74c7:b029:d7:e593:fcb with SMTP id f7-20020a17090274c7b02900d7e5930fcbmr1582638plt.71.1605650644986;
        Tue, 17 Nov 2020 14:04:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10sm65821pjg.3.2020.11.17.14.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 14:04:04 -0800 (PST)
Date:   Tue, 17 Nov 2020 14:04:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC PATCH v4 4/5] Add new file in LKDTM to test fortified
 strscpy.
Message-ID: <202011171404.5E0F44C@keescook>
References: <20201116145012.24471-1-laniel_francis@privacyrequired.com>
 <20201116145012.24471-5-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116145012.24471-5-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Nov 16, 2020 at 03:50:11PM +0100, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> This new test ensures that fortified strscpy has the same behavior than vanilla
> strscpy (e.g. returning -E2BIG when src content is truncated).
> Finally, it generates a crash at runtime because there is a write overflow in
> destination string.
> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
