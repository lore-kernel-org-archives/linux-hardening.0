Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF7C46467
	for <linux-hardening@archiver.kernel.org>; Tue, 17 Jan 2023 03:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjAQDID (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 16 Jan 2023 22:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjAQDH5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 16 Jan 2023 22:07:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C822C233D7
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jan 2023 19:07:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jl4so32159181plb.8
        for <linux-hardening@vger.kernel.org>; Mon, 16 Jan 2023 19:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnJ9Zmocxu4Xq5ufmgMvMkKxKjqhgHcC/CXVZl3M6Kg=;
        b=VT/EEiv5boIzMV75DdA9/aJwFxF8Is84Rhw3/LYBmRMMYQpCUAgfOvntIelHvMClTW
         yMMYT/gArron1p5NI3ZWwNx7VwexbGk5nFEciNhajeDchErJns5L+5ncMt8OcUPsVqtQ
         jQb27l54t7AeQHJvNQXLmE7rhaplUy52bbmBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnJ9Zmocxu4Xq5ufmgMvMkKxKjqhgHcC/CXVZl3M6Kg=;
        b=V2Sj9arvMzXa7G72xaEYtybDa6lRi4TRacmLAkg6XhhLAj9CVSxBdMykR3/8+nV1NF
         Go2TFgb6Y+hQtOHDeApdypAvRhFnIhPEsjtFb+r1FE/S0tUJxhkwjWUItnn/1HjrTWDk
         Ac2+boHwU9ugR+Lu0zfQwAdK4GJGCeXzR+DjFjxmYFYodSIWME9IL27tN8LuV0nHtL6s
         6AaewoaUKJGvR36or1YZeq6oUXlpK7yTouCXZooORF9rNr4bLfJ7XoQuTg1S1BIH2c2D
         mCsjSTgBumxQE87tCs1FkX/BaUXZ+If1SH8kv6dAEOqeI3NBDOPpPWIWoDD8o691waj9
         g0NA==
X-Gm-Message-State: AFqh2kpVEPzEVxyhp8xM39CIHZWsde9fea35xRU2ND5bxDUpoyl/kO0l
        ufG+dKU2Zj3y7VcZWr1XP7qADw==
X-Google-Smtp-Source: AMrXdXtQj78NfF9qx+TabtfHmEG+hyBEpYjSaH0gM6kYOQE/gPWnG4sWnLISWWRe0lGgYM28aT9AHQ==
X-Received: by 2002:a17:903:54d:b0:193:a5b:ccf6 with SMTP id jo13-20020a170903054d00b001930a5bccf6mr808312plb.0.1673924875310;
        Mon, 16 Jan 2023 19:07:55 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b00189e1522982sm19987634plr.168.2023.01.16.19.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 19:07:54 -0800 (PST)
Date:   Tue, 17 Jan 2023 12:07:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        coverity-bot <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: console_prepend_dropped(): Memory - corruptions
Message-ID: <Y8YRBo7ZmtzWT4J1@google.com>
References: <202301131544.D9E804CCD@keescook>
 <Y8KAhaiZQOWTcfyF@google.com>
 <Y8V8tqMJeB7t+rcJ@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8V8tqMJeB7t+rcJ@alley>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On (23/01/16 17:35), Petr Mladek wrote:
> 
> I am going to send a patch.

Sure, sounds good.

> The code might be safe with the current size of the buffer and
> the string. But it is true that the following is wrong:
> 
> 	len = snprintf(scratchbuf, scratchbuf_sz,
> 		       "** %lu printk messages dropped **\n", dropped);

Wouldn't

	if (WARN_ON_ONCE(len + PRINTK_PREFIX_MAX >= outbuf_sz))
		return;

prevent us from doing something harmful?
