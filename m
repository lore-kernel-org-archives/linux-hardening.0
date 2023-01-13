Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412CEC54EBE
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 06:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjAMGxx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 01:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjAMGxM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 01:53:12 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E533280623
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 22:36:53 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id a3so4501009ilp.6
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 22:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbcvrpXLiOj2aVPZhpgGMF7fN4pxhgDC+epYNwB8PvM=;
        b=WJS7nPzUoIP8rbTag8GicEfltsmTxWO17BlAWGW0ciuWXa7IfF57AiTEvOoSxjW14F
         Dv1fAdWj11fSddcILv2UUb9JFamNwmbhM8RjPAZI8z+GQ3t+F9BGyT2yMdjxJX97Zaoj
         ayOITR/nx/0apCzJQvedDmzQ0WKwZv4GSdueo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbcvrpXLiOj2aVPZhpgGMF7fN4pxhgDC+epYNwB8PvM=;
        b=3xuPR6Yu3ZME74wayovX5kEmEMS0jNED9vjmKrbnV+p9ogGCeMOrrrIx6nCDmxUe+o
         cOW5rcNhDLMsEJQJqi30k3I0OqOHL63d5JYihi8OQZBgdi07lBCgq38kmpxMDkv7Iol1
         oDQNm60KXboghiyRG7gstBCrcL0TkfzRGemHzSKbXS1ObdJrWMedglDrjPqajjsTwQTe
         /uhOSFCCZMTkzwf18M5O9w3hizX/Bol/smPXCOnMBfF5HBwgMx4oWyGZbQS/dhXQ8pLq
         N9geMmr3vQhxLHnZqmPSMZLLfzCSspdjvVHwHA5oozSLIP5HIKSjs0L9k51NtSkcr6It
         E0tQ==
X-Gm-Message-State: AFqh2kr8KZ7g624Q9gOlKdeIeT1leKcjBxpIU61kpI8ExsKzQ9RVZ2df
        Er67IH8h+IFsu74EeHwRz9YE+w==
X-Google-Smtp-Source: AMrXdXuGaPBMtjduUpnSDSdiMpo7mxlCGHV+p3tlc6mEZ+7wnMH9hCy9Jnt6RWpsBUXuMUPhOhaD1A==
X-Received: by 2002:a92:c04b:0:b0:304:4481:2aad with SMTP id o11-20020a92c04b000000b0030444812aadmr52820937ilf.9.1673591510050;
        Thu, 12 Jan 2023 22:31:50 -0800 (PST)
Received: from chromium.org ([2601:285:8300:c23:d502:b79f:c908:7743])
        by smtp.gmail.com with ESMTPSA id b10-20020a92670a000000b00304ae88ebebsm2435002ilc.88.2023.01.12.22.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 22:31:49 -0800 (PST)
Date:   Thu, 12 Jan 2023 23:31:47 -0700
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] firmware: coreboot: Check size of table entry and
 split memcpy
Message-ID: <Y8D608sr+jhBQCXG@chromium.org>
References: <20230112230312.give.446-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112230312.give.446-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2023-01-12 at 15:03 -0800, Kees Cook wrote:
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

Reviewed-by: Jack Rosenthal <jrosenth@chromium.org>
