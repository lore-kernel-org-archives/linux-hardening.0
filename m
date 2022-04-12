Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05556C433EF
	for <linux-hardening@archiver.kernel.org>; Tue, 12 Apr 2022 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349180AbiDLR2a (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbiDLR21 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 12 Apr 2022 13:28:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FD51E60
        for <linux-hardening@vger.kernel.org>; Tue, 12 Apr 2022 10:26:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so3628862pjb.4
        for <linux-hardening@vger.kernel.org>; Tue, 12 Apr 2022 10:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVvKuYmXIsa9qahx409eDRhfKlF4vraPbVM4uLa0fmQ=;
        b=hdpkAq9aJidmb9mmOq0DjZrlkjc+sWw7doSwZu3Xg9C3ghnTPwU0n5q6LG2l4gVm8h
         PSWw8Ctere/ruqdtzP5yr+v5cPz2XIOsK78xnSWAj9fRC4zhtzswRvv8xmVrZM7BFqJb
         Joi0QaXGiDKFhq7k4LUEbecNqvJ89Im/GSkRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVvKuYmXIsa9qahx409eDRhfKlF4vraPbVM4uLa0fmQ=;
        b=aujA4AbL/n8/mygTQqgbIHXLmZZ3HtdsqDzNpPTXpucz5JHuCIToTBQVGcXW6stC6N
         6cFR0zDxHbJYFhx5yArUjvB59QmSvvH1kJmDdkGyXVe5UeUUBp8FdBlRVt1m4K2UoJW9
         9bSRC50HiVdb0/S6PmM0aAYikzoqxewx6t1cdgSWPMrzxWZ8Ld+KQWtiHZP2sGVmcfc9
         gMyt/WR1XDmYF7xMKkW8e/GUMFe71ESNMGGu9rm/+wQipfszQ1DBlt1sa7iBlGK0lS+s
         1QS51whGoZtbUec3g5cGVar/1azldAGU2HrT5rSj9YG4ZjvUqk/MUtE8kge+wSzHOrXF
         KNpA==
X-Gm-Message-State: AOAM530gsu3ofc6sOvhAJIbTOz++MygAIWIqC/96IAUKf4aaW3Lra1eC
        IOg4h2e0CAyyNulRLB3ymSbeKRTHZsCBFw==
X-Google-Smtp-Source: ABdhPJzZSMbWxUWddHHGVZsDw6uI2PwBLfss1TlhHC/JrPo2d6O8Fd7mX9TOQ0R5j0I3P74gCw8DAQ==
X-Received: by 2002:a17:90b:4b01:b0:1cb:a81a:dc4c with SMTP id lx1-20020a17090b4b0100b001cba81adc4cmr6207491pjb.193.1649784366611;
        Tue, 12 Apr 2022 10:26:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78712000000b005060755f2d9sm1523639pfo.139.2022.04.12.10.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 10:26:06 -0700 (PDT)
Date:   Tue, 12 Apr 2022 10:26:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: don't treat structure as an array of struct
 hlist_head
Message-ID: <202204121025.5D16102@keescook>
References: <20220407175930.471870-1-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407175930.471870-1-morbo@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Apr 07, 2022 at 10:59:30AM -0700, Bill Wendling wrote:
> The initialization of "security_hook_heads" is done by casting it to
> another structure pointer type, and treating it as an array of "struct
> hlist_head" objects. This requires an exception be made in "randstruct",
> because otherwise it will emit an error, reducing the effectiveness of
> the hardening technique.
> 
> Instead of using a cast, initialize the individual struct hlist_head
> elements in security_hook_heads explicitly. This removes the need for
> the cast and randstruct exception.
> 
> Signed-off-by: Bill Wendling <morbo@google.com>
> Cc: Kees Cook <keescook@chromium.org>

Ah! Yes, thanks. This is a good solution for this. I'd rather not have
any exceptions in the randstruct plugin. :) I'll take this via the
hardening tree unless anyone objects.

-Kees

-- 
Kees Cook
