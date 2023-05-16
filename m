Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E757C77B7F
	for <linux-hardening@archiver.kernel.org>; Tue, 16 May 2023 20:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjEPUzZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 16:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEPUzY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 16:55:24 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E13559D3
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:55:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53033a0b473so7632189a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 13:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684270523; x=1686862523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ej71yRmPRu8z2W7e0T8QvzS/1x48yctizGgEV8AzVJw=;
        b=N1gLcB0OyN5P/6560cO03tcoXuunorDDRv8/T4ScocezDogLnisXjQRFXeEWIPaZNE
         stvLqWsvqikUbOXMJQGdbb3NxGCGiZHtczbS/auERzUjSFl53q5J/HNhyLHJpxCM2BXz
         KK9sMEAK94ZcYKUw4QSDoQUSsGVywLhBFCyDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684270523; x=1686862523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej71yRmPRu8z2W7e0T8QvzS/1x48yctizGgEV8AzVJw=;
        b=HQvtCz6gqIIAVAk/cmggH3CR7RG0T1Hk4/W/kyZT/K9tBKhp9XXPJ9YEmuo7gyFqDL
         nd9eTugWwnZ1o4wdUeXyL7gQMBUm2rOiETdQt+5mGGy9WbRWsCt413WrPOjINNwhu1yS
         56bmoWSqH/HZauKFzA3NERQTMmX/KO50q6VA9wQpJajdEkWQRn9V5W+kiJRAv5/wYkEX
         khmuzekoi/NXuiFS9/jNwuRoy48Fck1d+JEZeAy2BHcZEud2VRMadF6wswQ5TaGgxWM3
         su/YNPO7W1TM31Wou2tkhZ9dRZ5Z6LNqJvrGknXg1GxoeYMmPuFCzhbhKNOf9ypJZhCK
         20vg==
X-Gm-Message-State: AC+VfDwIHf+9VFQIIQ5Uw8sSJxgqOj9a852Ul7qoM7bfqej4p6+pFp2d
        d9P6jV5lYsqsgj7JjvRIxYv9Bt9g0fOeDgNPxFU=
X-Google-Smtp-Source: ACHHUZ6w9wbKEGcdydgn0Ey6n7k6IZJ4OF5ycSXaYOoNrr5tDJZEyh1wKJB0NUIZQbaSs10wq8HRmQ==
X-Received: by 2002:a05:6a20:9184:b0:100:d4ee:ba80 with SMTP id v4-20020a056a20918400b00100d4eeba80mr29367876pzd.27.1684270523147;
        Tue, 16 May 2023 13:55:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u17-20020a62ed11000000b00649ac17779csm9633763pfh.160.2023.05.16.13.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:55:22 -0700 (PDT)
Date:   Tue, 16 May 2023 13:55:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     gregkh@linuxfoundation.org, tony.luck@intel.com,
        gpiccoli@igalia.com, johannes@sipsolutions.net, rafael@kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_shashim@quicinc.com, quic_pkondeti@quicinc.com
Subject: Re: RFC design of device coredump collection on panic in Pstore
Message-ID: <202305161353.0F771E0@keescook>
References: <1683561060-2197-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683561060-2197-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 08, 2023 at 09:21:00PM +0530, Mukesh Ojha wrote:
> 1. Device_coredump allocates some configurable contigous memory that can be controlled
>    via CONFIG or bootargs and later registers for panic notifiers.
> 2. Notifier gets added.
> 3. Pstore adds device_coredump as its front-end via dumper registration similar
>    to kmsg being dump today.
> 4. Successful registration of dumper.
> 5. A device driver(A-Z) can register their buffer to be dumped as part of panic.
> 6. buffer gets added to the dump list.
> 7. Panic occurs.
> 8. iterate over registered drivers and copy their dump list to its own memory and if
>    it crosses device core dump memory log an error stop iterating.
> 9. Similar to devcore_dump() inline with kmsg_dump()
> 10.Copy the content to pstore region and this could be elf or raw binary that can be
>    discussed.

Yeah, I think having something like the panic dump handlers for
driver-specific data sounds like a fine idea (as long as we have actual
users of such an interface).

I think it would be easy to add another front-end to pstore (via the
enums, etc), and expose it via a new template filename in the pstorefs.

-- 
Kees Cook
