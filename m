Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D91C61DB3
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 23:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjALXAp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 18:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjALXAn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 18:00:43 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634E5E661
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 15:00:42 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bj3so17436594pjb.0
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 15:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t81IaJAeVAS+TxjZCUSPdXxwgmlKOytFkJBR8yD/ovY=;
        b=bjOBCWWVWv7gYLHe2gpKpRRM70XQEz6CjFHyDUrnqFAFgxL3uvE4YjVesiTqwbb6Bq
         yo6FbDpGqvcTs4zNj9r29IQTUHI8pC1JPCd5nYT8oqvaHvlWXt9go3dWSQppzDsYtwPL
         awgQTlz7jXUwxPZLjyd4bsV7gBW8xFAjHB5ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t81IaJAeVAS+TxjZCUSPdXxwgmlKOytFkJBR8yD/ovY=;
        b=r3125Vocksfz1ac9m43STQ6WAuYhbn2adzjapHX5EelkpjVXQ2cGY0pS4Fxt2C3ZF5
         15jUlwJeW9gBGU/dbnCTUw9N2LQ7a4QlVAWlg/nPPmZswS9shLy2ZysDEyIalkkw7Khl
         yur4lfPXanYbMxODRjGeX/IEfLxfAIzlf7K5eiPZR0VbDMIxH2ch6auwyFN9mDcbj2qe
         wd/0mIPiX4iI1+lCE5sa+6OnkFkxkQgY5o2bOMIbrUkDPgO7Wggs7wiTb1PT6XAD/e9H
         5cN4572Yg1Pumj43FWL80sMVIbATE9KvgFr/T35XjA4BQf3t8SmHbrmC9Jyj5bY9H3Es
         ilUw==
X-Gm-Message-State: AFqh2krdUYrOSG7/r5vbdcMg2KXcUuRodPwKE6TmPlFcCYDPUcPigOMe
        6xb4z6Zwv9G5k7KNUY7jsEHYzwppqzWtk/xV
X-Google-Smtp-Source: AMrXdXv3NLjURBhWZIZRXmTT0Pq5NcaZEvbNnqwyvnrEX1v9Z9hIV8Sq2um6UN04kVyC4yTC2NRYjw==
X-Received: by 2002:a17:902:b10e:b0:194:6265:ba5f with SMTP id q14-20020a170902b10e00b001946265ba5fmr2869914plr.8.1673564440235;
        Thu, 12 Jan 2023 15:00:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u15-20020a1709026e0f00b00186c3af9644sm11878082plk.273.2023.01.12.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:00:39 -0800 (PST)
Date:   Thu, 12 Jan 2023 15:00:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] firmware: coreboot: Check size of table entry and
 split memcpy
Message-ID: <202301121458.865E4834C@keescook>
References: <20230107031406.gonna.761-kees@kernel.org>
 <CAODwPW9SaomZjWQvR1mmV7OzvQkq-_XoDgSmK04fO5rVMGHmpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODwPW9SaomZjWQvR1mmV7OzvQkq-_XoDgSmK04fO5rVMGHmpw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 09, 2023 at 04:02:26PM +0100, Julius Werner wrote:
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> 
> > -               memcpy(&device->entry, ptr_entry, entry->size);
> > +               memcpy(device->raw, entry, entry->size);
> 
> nit: It's a bit odd to change the source pointer from ptr_entry to
> entry here. Technically the static analyzer would be within its rights
> to give you a warning for that as well, because you're now
> "overrunning" the source struct instead of the destination one.

True. We've been focused on write overflows, but yeah, since the
location of the flex array changed, I'll switch this back to ptr_entry.

-- 
Kees Cook
