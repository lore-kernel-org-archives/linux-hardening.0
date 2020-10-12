Return-Path: <SRS0=rEOn=DT=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB8AC43467
	for <linux-hardening@archiver.kernel.org>; Mon, 12 Oct 2020 19:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DC9214DB
	for <linux-hardening@archiver.kernel.org>; Mon, 12 Oct 2020 19:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NmUmPZg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390988AbgJLTGz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391192AbgJLTDv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 12 Oct 2020 15:03:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F21C0613D0
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2020 12:03:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id k8so14410415pfk.2
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2020 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QuVx9sAPms7htZv0saHN7NQDUb2yJw+Ga5qw85soIMU=;
        b=NmUmPZg9Idy7qVfkHwFPrkWRO7+IaMdKn+O81wwbBPAGCLOdlip6o6Z6qjN+yFiSlF
         NPzGraH0kimFmHLGUlTddXKmC3A+RqBHR7rXBgm90BX5CNq58BfBKuXC+ITmS68kUTCq
         59En7+OWY1GeSkZZ63PRBrf6Oea2CeZUYH364=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QuVx9sAPms7htZv0saHN7NQDUb2yJw+Ga5qw85soIMU=;
        b=NRq5m2ozc1BjHno75h3nHlOThWRp/Hhgk8GJLpaGwIOS8/RlnIvzTiCKLf3NM+6LkE
         CbXm24I097Z223oW/5AyxTMBKcJzWOBD4VRA9g19x695bOqOLW3yYLfXzbLy+XTeYhTi
         BLiJkohioS8e4hGiodMN0LODsqgyR7E+Fea3BVroUnsf9OIslWj/2W0OfdIVuHbvGl9c
         RiT733CO+5WoEaeRrewEXjNbY5XnW26ikr8QT9qcDhJMqqBvND3WYhlLSit+bzi96TSm
         MrokhDgqTe3u2AiNhJMlq3tHwxAXriNXynWCJJE+xULU2T7hbHhZpPZwcOjuiqOuO/fw
         Gytg==
X-Gm-Message-State: AOAM530HbNDfUqIVkU8Rl60hTAtDfznp5T2uekOdluiBCmht3oaeRWPG
        Lt8/CSeQbbHX7nWQF7ved6f4F5glabygFw==
X-Google-Smtp-Source: ABdhPJwD+wj3NS7cqdsTNAN7U+IBKOAjHZ8WgflFeaZM9/aZMmfaPdCV93WkwTOUnOqlY3Tqy9Io7Q==
X-Received: by 2002:a62:7cd4:0:b029:152:5198:3f19 with SMTP id x203-20020a627cd40000b029015251983f19mr24870595pfc.31.1602529430348;
        Mon, 12 Oct 2020 12:03:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm17802562pjz.51.2020.10.12.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:03:49 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:03:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Subject: Re: Remove all strlcpy() uses in favor of strscpy() (#89)
Message-ID: <202010121201.6ED466E1C7@keescook>
References: <CABgxDoJwP+5Z3qUKuv3Tr=P24eGidk2cjO+yq0y_NwNmSbvQKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgxDoJwP+5Z3qUKuv3Tr=P24eGidk2cjO+yq0y_NwNmSbvQKA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Oct 11, 2020 at 08:24:19AM +0200, Romain Perier wrote:
> That's just to let you know that I start to work on this task,
> I have also added a comment on the bugtracker.

Okay, great; thanks! I'll reply there; it looks like there are several
approaches that could be taken.

(For reference, this is https://github.com/KSPP/linux/issues/89 )

-- 
Kees Cook
