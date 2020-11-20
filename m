Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45AFC83013
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF19206B6
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 19:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NjicivzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgKTTwK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbgKTTwK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 14:52:10 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986EC0613CF
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2020 11:52:10 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so8889971pfa.4
        for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2020 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X8uKo4cphvUHXqX5JxQoRlUg2+q0bv7B3NpzE4jNXx4=;
        b=NjicivzP6e7SYMGkEBIyXRQXAuwbm0gtPM2k8GbKG+FXs5uMK6r45ZW9k43d90VPhz
         DEwlvk+hjPwAEmTwtOxx5b+TNVWu4eUMG/3N0D/8FspQpW3NT+b44HH9yfqn1UraPXHu
         F0SjPXkVaYltiU4GPMrXvii7LnjgTXN6SUtys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X8uKo4cphvUHXqX5JxQoRlUg2+q0bv7B3NpzE4jNXx4=;
        b=mcH9+lEk3KyTHt2naCYVB0yBZ2FXBf4TswXLVg8LYgRssAiziwfy2g85VwWGHc359f
         CykwS/ffKUjoJNr6atv8aZB/I+E0iAYcgyWGwqbetG0jGpkfBYSFRIsgHv7DCVw5ySWZ
         fGMLcsSAT/3Nu/C/T/Sg3q9d8HYGQpwPFfeINUcM6Ja0mkBiOCwbfmA27QqYNKnwKuHA
         aO/6MPmVopEWSr36QcJqc9/dPRv0OXOhN71ASXPbiTEEnf+3CnXAgKeenIxQyVZSaam9
         LT62TfUu+CP1Xetsqm/CoKVbm5/0ME6FpL5VdLWNh2msL521TDuesZtg85y8R9RaoJTL
         cRpA==
X-Gm-Message-State: AOAM532VM27sxzmXJcK9FRt6spxSQ7dGZjZAC3w27ZiLBK5nChirQ8QA
        cHUFA27JPz8Z0qHhkh/6xx4oAigCxJ/ZUYYW
X-Google-Smtp-Source: ABdhPJwmhNo/oa0SgoI9bFv2vw35wuYBJ8aIsma7B0R9UgFb9THn90BCMvVwZzJYilwrEanzKZdGvQ==
X-Received: by 2002:a65:56c8:: with SMTP id w8mr18436826pgs.383.1605901929516;
        Fri, 20 Nov 2020 11:52:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm2749417pgp.79.2020.11.20.11.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:52:08 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:52:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Francis Laniel <laniel_francis@privacyrequired.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net
Subject: Re: [PATCH v6 0/5] Fortify strscpy()
Message-ID: <202011201150.AE57F56EB@keescook>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
 <20201119173543.8821881942022fc4f39c4c73@linux-foundation.org>
 <5676804.6kI0aEeX2c@machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5676804.6kI0aEeX2c@machine>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 20, 2020 at 10:40:38AM +0100, Francis Laniel wrote:
> Le vendredi 20 novembre 2020, 02:35:43 CET Andrew Morton a écrit :
> > On Thu, 19 Nov 2020 17:49:10 +0100 laniel_francis@privacyrequired.com wrote:
> > > This patch set answers to this issue:
> > > https://github.com/KSPP/linux/issues/46
> > 
> > I fail to understand what this patchset has to do with that
> > one-element-array issue :(
>
> I think I linked another issue totally not related with that one...

This just looks like a typo. The URL should be:
https://github.com/KSPP/linux/issues/96

-- 
Kees Cook
