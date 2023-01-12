Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1817CC54EBE
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 23:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjALXZn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 18:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjALXZm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 18:25:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A1C625D6
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 15:25:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d30so25748831lfv.8
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 15:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzvQTLIl4IsQotVAdtAgGVmuDwl5Q4M7f6FylARn+9c=;
        b=Nr7Y/WhaVdcQbYBYZpdYD/bbkZMdH3A1fULa10XQvTpJcJ2Rd+q6iOILylAXcrvZ3W
         k1VWAbetLG8bycRtyxz2WigmGfmShkeg0a/1AYKtaaFgQG+ldxw+gUWxfNfXFV5ayAP1
         4hoOHp9cv2c5vAE3yc/2HIZgp8HSFfmy36gec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzvQTLIl4IsQotVAdtAgGVmuDwl5Q4M7f6FylARn+9c=;
        b=pFqveJNu3K6639J57OzdmiRUZTIP5Kqd87kivhKtzpq0NGeaA8bvRZR6suGufZKcsZ
         f9pcigb/gYpBDOYqtMRnNYEkoR+QesXkJMQGW2lOL5pcfqtdbbgBNAgc+woAtOvV3VvF
         n685U4y9ToeuQiokEyEOPLy4vM/dtmsN6vE/6PIUJzIec//96yW4zxthg1QfPeonXAFB
         x2sM5Dfnfd5dFqtVO9L4jNtkVDhqE3ohN6+/3JoOExISzbHoCGFI6rRZT+ThMh9fsuP6
         FLz0gE30ozy1sTFBDDe/uLB5ku8Rhw1wIiqsFeMpNj2RRk0RrSZUrsnnWOSffysycUBp
         KHWw==
X-Gm-Message-State: AFqh2kpxScVH/NgldM++FA+uBlAJNPztFr6EpyasGZxn3Wwr7+TtQ8r/
        kL3ayT0G9ljSaktjt9dsXuYAcnAHW0rqtg3rYfO6NQ==
X-Google-Smtp-Source: AMrXdXtLVJx13oVwu3/q5cMKJRaL1ovVk7o4qBGW++HpDOkIGmRjjudkGZ+iTKU/U2CUTzTrZVqV2pLQdHocHer/C1M=
X-Received: by 2002:a05:6512:2346:b0:4cc:6ce7:6614 with SMTP id
 p6-20020a056512234600b004cc6ce76614mr1205998lfu.83.1673565939472; Thu, 12 Jan
 2023 15:25:39 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Jan 2023 15:25:38 -0800
MIME-Version: 1.0
In-Reply-To: <20230112230312.give.446-kees@kernel.org>
References: <20230112230312.give.446-kees@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 12 Jan 2023 15:25:38 -0800
Message-ID: <CAE-0n52aQpFe4q47=3=dmozwgb375zuCt2um8PTpYScLkgBs8w@mail.gmail.com>
Subject: Re: [PATCH v3] firmware: coreboot: Check size of table entry and
 split memcpy
To:     Jack Rosenthal <jrosenth@chromium.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Quoting Kees Cook (2023-01-12 15:03:16)
> The memcpy() of the data following a coreboot_table_entry couldn't
> be evaluated by the compiler under CONFIG_FORTIFY_SOURCE. To make it
> easier to reason about, add an explicit flexible array member to struct
> coreboot_device so the entire entry can be copied at once. Additionally,
> validate the sizes before copying. Avoids this run-time false positive
> warning:
>
>   memcpy: detected field-spanning write (size 168) of single field "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/all/03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de/
> Cc: Jack Rosenthal <jrosenth@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Link: https://lore.kernel.org/r/20230107031406.gonna.761-kees@kernel.org
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
