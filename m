Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73798C54EBE
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 22:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjALWtD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbjALWtC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 17:49:02 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78F9C34
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:49:01 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so25166428pjj.2
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZfksTuFjoscMgLpeLPqh4N8gEWgn0z0z3v4P62lrqg=;
        b=OOtO5L5MXolhyRP8x0LwCnc0Zt/IaTZHakf9JxR0SpiN+raNaxR6ZRgDfTexKXYfhP
         NWpHQdZVlRLY+lKBziKXeKvu/IPTgXErVWLJLjnSE8HilfmJ/mHGqRKDLUaEaEiovSdM
         49FyiqBJZ/sWTzT9amSkx/BBvUxVoReJ7Dt5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZfksTuFjoscMgLpeLPqh4N8gEWgn0z0z3v4P62lrqg=;
        b=BYY+PkQ5Z/atPg3ylKgeibOh0HYPH/NzDhCuIk+sRIO3ZGkH+9bjZTxxQ0GUOoXrne
         L2MEERdjpt77gG5p3SmXvuwsdYzcvyc82cbnWtX571vYfNWtM6OMCbZmV/OaE7ecEaO6
         vEXom5KaBtCCIHPlUgQDLs/Xo05PZZ0Gkahxqv0/ywCpLJOcbiHCb5oW/5+N7GhZS0Kn
         BEvL8ZfKnzr8/CyAcZYmaWyIZfHuetJZ81YEHJOMWxePZVKaKUlbgPqFNYTaP/qDzK6Z
         0HiAGgGgcRQHURCdMurOo6b08xDgeJq7jBNMWfzrlptoaq9JabcH6jtz6MQkvCD9aG69
         GLdQ==
X-Gm-Message-State: AFqh2koOUbZqpYEjDRJSENATOyUwtbCMs/G9bJ4gZtSQDM+3fgte7ZqL
        MEwN1kGwMSwjL5VlKbrjRqVZucDLioMoQIJr
X-Google-Smtp-Source: AMrXdXsAJrytZC7RA8wdAMnUFaWk6Tfi5iZGRjX61dCPmw3ckLM4sS+INxWrMpZmIVGV0Ep1UePjUA==
X-Received: by 2002:a17:902:ebca:b0:191:117a:414f with SMTP id p10-20020a170902ebca00b00191117a414fmr90680365plg.27.1673563741418;
        Thu, 12 Jan 2023 14:49:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902f14d00b001873aa85e1fsm12613137plb.305.2023.01.12.14.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:49:00 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:49:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: HCI: Replace zero-length arrays with
 flexible-array members
Message-ID: <202301121448.59EDAA92FF@keescook>
References: <Y7zBcCkkuIIS4ueP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7zBcCkkuIIS4ueP@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 09, 2023 at 07:37:52PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated[1] and we are moving towards
> adopting C99 flexible-array members instead. So, replace zero-length
> arrays in a couple of structures with flex-array members.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [2].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
