Return-Path: <SRS0=kTaS=D7=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDB3C2D0A3
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 05:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5F622254
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Oct 2020 05:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YGvos8Qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759600AbgJXF0N (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Oct 2020 01:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759599AbgJXF0N (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Oct 2020 01:26:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB96C0613CE
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2020 22:26:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so3015918pfa.9
        for <linux-hardening@vger.kernel.org>; Fri, 23 Oct 2020 22:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sswaZ6X47jjNNf3bPWEFfgWq7o9JJMoFAprSwjNjnJg=;
        b=YGvos8QwlMRJBZiIu8slxSHCQe/nFOY0v87ew9DShQv2XkstLWyh0ycCD7xwGxcv+E
         uNLGC+vOksfAJLXZdYBtrMsn+iJJV5sHGRFE2TcHQyec/a5C4tz6xb9MU74NLoBV56lV
         drxyezmKF7DoM1WM53+WM3jwirDoGooU3tzKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sswaZ6X47jjNNf3bPWEFfgWq7o9JJMoFAprSwjNjnJg=;
        b=B2KUx+MVrQ+O/D+nkyBWM+u/xmI0lQLh1zwkB8cFHn3Cb4z2HVETG9YUDaLGz0+6lW
         10hKAvil8Lc/eYbCM+/cRIXQ3kaX7v+MN5KKoO5BKQBuWrcEXaJ4NzMdi7fqa4bMEe9I
         UiUbF2nTwWI83QhoulwUE/+g1mGR4nkdQugTwFhNFIxUqosxGiIKeANAznUKOg2Q8qMI
         kdfikdw8XFeaDNZMf0JHd5syL+ersYJFjEoxFspLYsBI2fBljZZMXqrjJEC+Gh7qBRkH
         E06W5F4UJFyoYIi8clQFeXgfzoT0qBJ2fjbkMTDQ3yxdYLwz1YgJWPHGZIE3MD6MPqx4
         qKhA==
X-Gm-Message-State: AOAM5333anhJ9HXhcSwlqE9VVBsV6c8+sD9DAdKJsrareDgnK4gkYBi8
        UwxGjfd0Ahk083OMEPQDhLRoow==
X-Google-Smtp-Source: ABdhPJxMVuKmqPWKeHSKPfCjzJG22nPWWnlh0zkPUvvUp0Ph/K88XmjfqrTKkVKUnbj9QTWE1dwJRg==
X-Received: by 2002:a62:e70c:0:b029:155:dd3d:f349 with SMTP id s12-20020a62e70c0000b0290155dd3df349mr619611pfh.32.1603517173064;
        Fri, 23 Oct 2020 22:26:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f17sm4088831pfq.141.2020.10.23.22.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 22:26:12 -0700 (PDT)
Date:   Fri, 23 Oct 2020 22:26:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, dja@axtens.net
Subject: Re: [RFC][PATCH v3 5/5] Correct wrong filenames in comment.
Message-ID: <202010232226.163E2835D@keescook>
References: <20201021150608.16469-1-laniel_francis@privacyrequired.com>
 <20201021150608.16469-6-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021150608.16469-6-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 21, 2020 at 05:06:08PM +0200, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> In lkdtm.h, files targeted in comments are name "lkdtm_file.c" while there are
> named "file.c" in directory.
> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
