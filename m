Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1BEC61DB3
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 22:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbjALWqY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 17:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbjALWqD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 17:46:03 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4C15EC33
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:45:42 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d15so21661971pls.6
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ooim2Wn4nxPzype/U3O2bg5SkJtVRY7qsQNtyTRmags=;
        b=YGaM1pN0C8twUIzQgGfKjkYks+VnXiObKg1aQaTkoY3olojecUD3RTItE7YfBzxsXQ
         ap49M0nIV5gwf/pkXPjh3bX8XHcHw2MqaSz2nwdIGfXeyGzq/xzLxr3Cigh1uBhm0PdQ
         xXPPrdT6WSBM60Mci5MPFJD/YztPmxYo5yMbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ooim2Wn4nxPzype/U3O2bg5SkJtVRY7qsQNtyTRmags=;
        b=mgrYxSVXdOUjrewOdsgR3Ii2ZOan6zzhQsTZmiXE6X4oDLOEwtuM+04QDhYbLpi9VH
         /YC0//tqsosfbK/yib8BXWfyRFAuJ/GwZCWYBQ5ZZBQhJf2t9xUEJA3m04zO2qehlro3
         7DeHuU7a4+msHBQrob/uidhNcwJDb8aYepPMQgaSzoaYDw7kEVUZdlJfj/gKCZDCrhPD
         7MD81RGn6QdfJwXYCWbqdaTxP/c8wL6an0G0z1uN6WF0oED/wWoLvbnrGpOkKXF+63Ur
         2o8/SYmjS3sLdjHNQQp4BsJRXKGnTYmAezs5ZIrOc+NeLJd1v7ch8SuhJ6fD7Ccn7ynQ
         eK4A==
X-Gm-Message-State: AFqh2kr9B/izMjK4Xvivm5nIUuUJuD09Akr//1mj4fprU+gEpWCZ5wuK
        VYu5hGm8m97Q/uuyu2xNAdcF2A==
X-Google-Smtp-Source: AMrXdXvGve+4kNjBvlBdmOxwGLXehsNBREHOMLlomMlydd2DdmmiiiqSkLXYqlPUtwZFaLbLOdvQUw==
X-Received: by 2002:a17:90b:2356:b0:226:e1a0:6596 with SMTP id ms22-20020a17090b235600b00226e1a06596mr8726077pjb.12.1673563541660;
        Thu, 12 Jan 2023 14:45:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090a474700b00219463262desm10980238pjg.39.2023.01.12.14.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:45:41 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:45:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Li, Roman" <Roman.Li@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: Coverity: dm_dmub_sw_init(): Incorrect expression
Message-ID: <202301121445.393EAD9B21@keescook>
References: <202301121425.FB249B61B4@keescook>
 <MN0PR12MB6101667DFB81967706C13111E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6101667DFB81967706C13111E2FD9@MN0PR12MB6101.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 12, 2023 at 10:39:20PM +0000, Limonciello, Mario wrote:
> This particular one was fixed already in https://patchwork.freedesktop.org/patch/518050/ which got applied today.

Ah-ha; thanks!

-- 
Kees Cook
