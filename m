Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053CEEEC00
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbjIOTPN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbjIOTPE (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:15:04 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573E12721
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:14:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c336f5b1ffso22325365ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694805292; x=1695410092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ulb4D/RfTw95NwPXZDQfJ0u+pE9nYsbQ05jt6iMwqE4=;
        b=nnJtlrrDiyLsUxqQcwXwtRhveq6PvNH2tZ+N3khizB4MYoCeT0zAjDdFRIk+hQKUAX
         IdnSxYtqQc25BLxyJrkt+2ieZVReQGSfhLKwuoSKmKIIAMxVu/E7zx1JL+QeWOxNgDwv
         iHp58KuVYRoW4bCLj4pPEnIMUzSweKV5UzGac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694805292; x=1695410092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulb4D/RfTw95NwPXZDQfJ0u+pE9nYsbQ05jt6iMwqE4=;
        b=tMQE/dXOKpJnSxSLmzf2bjWCyJpZ2smhNgMPJj5KZsimx5NLA0oUpejeE8RHwVMOFC
         P+Pi1LIiQEodffXif9I+WlHbidwTGJ5DyWQhyf1MQxvCi8KywSkMUD13K8AOYkZzcDrs
         lPy5/uAz5N5C/MNw9jNz6iUyR7LJm+E2EVbGdwOHR/nPzokDBeWZgkArn6sr3SWD6QmW
         tyqbkf4ZjFE4Vr3hHwOJDKXbt/glCOys1eiYjSpblKcr8NSuj7LYQnkcTQkZoHjx1DDt
         rWYX+mJUlXlialSMaJ3XOmnTy1u2v1wftQWvcabeX8sCmca/zG0Pluq4GRMuHg0vE0J1
         3nIw==
X-Gm-Message-State: AOJu0YxOePPuOCUVv0uzLPb/5VmPou+5DrQLbA6cEqogRNBdX/oE1HY3
        YPu9MLjz/Qp6sdcmG0FtVdFBTQ==
X-Google-Smtp-Source: AGHT+IH4N3+Xu1Uefg79mNbOwJYMqeiP7kEfkNp2+6B8KJWA9QuKAybdahEdCuad1CgiTtfKTAJcsQ==
X-Received: by 2002:a17:902:cec2:b0:1bc:7001:6e5e with SMTP id d2-20020a170902cec200b001bc70016e5emr2944191plg.32.1694805291925;
        Fri, 15 Sep 2023 12:14:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c9-20020a170903234900b001a5260a6e6csm3824381plh.206.2023.09.15.12.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:14:51 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:14:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: ipc4-topology: Use size_add() in call
 to struct_size()
Message-ID: <202309151214.0A0D6AA1F5@keescook>
References: <ZQSr15AYJpDpipg6@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSr15AYJpDpipg6@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 01:09:11PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: f9efae954905 ("ASoC: SOF: ipc4-topology: Add support for base config extension")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
