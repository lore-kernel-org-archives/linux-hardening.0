Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A280C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 11 Oct 2022 22:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJKWSR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 11 Oct 2022 18:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJKWSQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 11 Oct 2022 18:18:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2DB804B4
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 15:18:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so14788441pfh.6
        for <linux-hardening@vger.kernel.org>; Tue, 11 Oct 2022 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOz+D3qN+D5XSjeZhjdEZw1Edyfh9x16KWqNTlE6IJw=;
        b=Aa/p5F9DamtX4hyjG7/mfBjsXWBhWtLfgJ3dAjOuAUZ3O+iUldUtQFsGg6WqSMXu8a
         4+uh+1HwwGH6E9Cpwy4+aptXNfuwe45Cq3ozyLW4VPrFHbTrSzKMSow3QHPc6zoSHeOP
         o0J6gK1GRjNWF2b/sVBVesfl6JM9CPEB4UAIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOz+D3qN+D5XSjeZhjdEZw1Edyfh9x16KWqNTlE6IJw=;
        b=4vFTczohgpHJ1xARZOzzFOA3SZ2ONBr1eZDnZTgP6nos9xR2FFPgSzjzABgaADYZdm
         6n1h4edr2JPOoRYPrsUhtvwU83PLYZQCXNQkCZR2XPF+JAebu9qSMc4EkGC8pQZfeFSw
         Rq+KdA+qMdvCKfr6lCYsiT2WZRwY5xYEtE89ml81DODPxvB7Dx7CiieUMC4bzduB0ZPW
         kW/8jm1WqvxLfNhiMdq35uaWBb4uFHtiGVPQ6J8NZuxGUBP+37RZRsWofScmjvZMf/tX
         c1d18az3HuHid9ZUe6bJqXwk882MrTPKfsxcnEWqHDS97OWHQfghqv8nrHBef9Gy+E5v
         Xqng==
X-Gm-Message-State: ACrzQf3UgEUmEw5+8prFYhYL/iWkqpT5To/fqwpVzMkGkff4eADJtCn+
        af32icXQMzxuJeV7kqjgutEQCw==
X-Google-Smtp-Source: AMsMyM7zgBTOsL0p7tJMXcEjncw8aWga9QOJV3/IxOX8GSssbmu2xYJXxhXT/zqSz6TG49A5FGiRPw==
X-Received: by 2002:a63:1a4c:0:b0:43b:e648:a7a4 with SMTP id a12-20020a631a4c000000b0043be648a7a4mr23134321pgm.7.1665526695285;
        Tue, 11 Oct 2022 15:18:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709027e0d00b00172973d3cd9sm9112009plm.55.2022.10.11.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 15:18:14 -0700 (PDT)
Date:   Tue, 11 Oct 2022 15:18:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <202210111518.A6E8A0FD@keescook>
References: <202210111305.743F591@keescook>
 <Y0XQsqdRzlrSpgOh@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0XQsqdRzlrSpgOh@mail.google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 12, 2022 at 09:23:14AM +1300, Paulo Miguel Almeida wrote:
> One-element arrays are deprecated. So, replace one-element array with
> fixed size array member in struct dlm_ls, and refactor the rest of the
> code, accordingly.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/228
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
> Link: https://lore.kernel.org/lkml/Y0W5jkiXUkpNl4ap@mail.google.com/
> 
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
